//
//  PlayerViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/21/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "PlayerViewController.h"
#import "HDSlider.h"
#import "HDProgressSlider.h"
#import "HDProgressView.h"

#import "NSString+QNImageURL.h"
#import "MBProgressHUD.h"
#import "NSDate+FormattedString.h"

#import "PlayingProgramsViewController.h"
#import "DJProfileViewController.h"
#import "CommentViewController.h"
#import "ProgramFavCollectionsManager.h"
#import "ProgramDownloadManager.h"

#import <QuartzCore/QuartzCore.h>
#import <MediaPlayer/MediaPlayer.h>
#import <ShareSDK/ShareSDK.h>

@interface PlayerViewController () <MBProgressHUDDelegate> {
    NSTimer *playbackTimer;
    BOOL sliding;
    ProgramFavCollectionsManager *favManager;
    ProgramDownloadManager *downloadManger;
    FavStatus favStatus;
//    DownloadStatus downloadStatus;
}

@property (weak, nonatomic) IBOutlet UIView *volumeView;
@property (weak, nonatomic) IBOutlet HDSlider *volumeSlider;
@property (weak, nonatomic) IBOutlet UIView *overlay;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (strong, nonatomic) IBOutlet UITextView *infoTextView;
@property (strong, nonatomic) PlayingProgramsViewController *playingProgramsViewController;
@property (strong, nonatomic) DJProfileViewController *djProfileViewController;

//button
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIButton *forwardButton;
@property (strong, nonatomic) IBOutlet UIButton *backwardButton;

//player
@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;
@property (nonatomic, strong) NSArray *programs;
//@property (nonatomic, strong) NSDictionary *channel;
@property (nonatomic, strong, readwrite) Program *programOnPlaying;

@property (nonatomic) BOOL manuallyChangedProgram;

@property (nonatomic) NSInteger failCount;

@property (nonatomic, strong) MBProgressHUD *HUD;


//progress
@property (strong, nonatomic) IBOutlet UILabel *scheduleLabel;
@property (strong, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) IBOutlet HDProgressSlider *progressSlider;


@end

@implementation PlayerViewController
@synthesize moviePlayerController = _moviePlayerController;
@synthesize programs = _programs;
@synthesize currentIndex = _currentIndex;
//@synthesize channel = _channel;
@synthesize playMode = _playMode;
@synthesize programOnPlaying = _programOnPlaying;
@synthesize manuallyChangedProgram = _manuallyChangedProgram;
@synthesize HUD = _HUD;

@synthesize coverImageView, volumeSlider, overlay, volumeView;
@synthesize playButton, pauseButton, forwardButton, backwardButton;
@synthesize playingProgramsViewController = _playingProgramsViewController;
@synthesize djProfileViewController = _djProfileViewController;

- (MBProgressHUD *)HUD
{
    if (_HUD == nil) {
        _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        _HUD.dimBackground = YES;
        _HUD.delegate = self;
        _HUD.labelText = NSLocalizedString(@"loading..", @"");
    }
    return _HUD;
}


+ (PlayerViewController *)sharedInstance
{
    static PlayerViewController *controller = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        controller = [[PlayerViewController alloc] initWithNibName:@"PlayerViewController" bundle:nil];
    });
    return controller;
}

- (PlayingProgramsViewController *)playingProgramsViewController
{
    if (_playingProgramsViewController == nil) {
        _playingProgramsViewController = [[PlayingProgramsViewController alloc]initWithNibName:@"PlayingProgramsViewController" bundle:nil];
    }
    return _playingProgramsViewController;
}

- (DJProfileViewController *)djProfileViewController
{
    if (_djProfileViewController == nil) {
        _djProfileViewController = [[DJProfileViewController alloc]initWithNibName:@"DJProfileViewController" bundle:nil];
    }
    return _djProfileViewController;
}


//- (NSDictionary *)channelOnPlaying
//{
//    return self.channel;
//}

- (MPMoviePlayerController *)moviePlayerController
{
    if (_moviePlayerController == nil) {
        _moviePlayerController = [[MPMoviePlayerController alloc] init];
        [self applyUserSettingsToMoviePlayer];
        [self installMovieNotificationObservers];
    }
    return _moviePlayerController;
}


- (void) playOrPause
{
    switch (self.moviePlayerController.playbackState) {
        case MPMoviePlaybackStatePaused:
            [self.moviePlayerController play];
            break;
        case MPMoviePlaybackStatePlaying:
            [self.moviePlayerController pause];
            break;
        case MPMoviePlaybackStateStopped:
            // TODO:
            break;
        case MPMoviePlaybackStateInterrupted:
            // TODO:
            break;
        default:
            break;
    }
}


- (void)playProgramAtCurrentIndex
{
    [self playProgram:[self.programs objectAtIndex:self.currentIndex]];
    [[NSNotificationCenter defaultCenter] postNotificationName:kPlayingProgramChanged
                                                        object:self];
}

- (void)playPrograms:(NSArray *)programs  startFromIndex:(NSInteger)index
{
    [self.playButton setHidden:YES];
    [self.pauseButton setHidden:NO];
    
    self.programs = programs;
    self.currentIndex = index;
    
    Program *programToPlay = [programs objectAtIndex:index];
    if (![programToPlay isEqualToProgram:self.programOnPlaying]) {
        [self playProgram:programToPlay];
    }
}

//- (void)playPrograms:(NSArray *)programs
//           inChannel:(NSDictionary*)channel
//      startFromIndex:(NSInteger)index
//{
//    [self.playButton setHidden:YES];
//    [self.pauseButton setHidden:NO];
//    self.programs = programs;
//    self.currentIndex = index;
//    Program *programToPlay = [programs objectAtIndex:index];
//    if (![programToPlay isEqualToProgram:self.programOnPlaying]) {
//        [self playProgram:programToPlay];
//    }
//}


- (void)playProgram:(Program *)program
{
    [self.navigationController.view addSubview:self.HUD];
	[self.HUD show:YES];
    
    self.programOnPlaying = program;
    //program info
    self.title =  program.title;
    [self.coverImageView setImageWithURL:[NSURL URLWithString:[program.coverPicURL imageUrlWithThumbnailType:@"2"]] placeholderImage:[UIImage imageNamed:COVER_IMAGE_PLACEHOLDER]];
    //TODO..
    self.infoTextView.text = [NSString stringWithFormat:@"%@/上传于：%@", program.authorName, [program.uploadAt ToNiceTime]];
    
    //fav status
    favStatus = [favManager checkPorgramHasAddToColletions:program];
    [self changeFavButtonImageWithProgramFavStatus:favStatus];
    
    //download status
//    downloadStatus = [downloadManger checkProgramDownloadStatus:program];
//    [self changeDownloadButtonImageWithProgramFavStatus:downloadStatus];
    
    //player settings
    [NSNotificationCenter defaultCenterRemoveObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerController];

    MPMovieSourceType movieSourceType = MPMovieSourceTypeUnknown;
    NSURL *movieURL = [NSURL URLWithString:program.fileURL];
    if (movieURL == nil)
        movieURL = [[NSURL alloc]initFileURLWithPath:program.fileURL isDirectory:NO];
    if ([[movieURL pathExtension] compare:@"m3u8" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        movieSourceType = MPMovieSourceTypeStreaming;
    }
    self.moviePlayerController.movieSourceType = movieSourceType;
    [self.moviePlayerController stop];
    self.moviePlayerController.contentURL = movieURL;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self.moviePlayerController play];
    }
    else {
        [self showNetWorkLoadingStatus];
        [self.moviePlayerController prepareToPlay];
    }
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(moviePlayBackDidFinish:) name:
     MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerController];
}


//- (void)changeDownloadButtonImageWithProgramFavStatus: (DownloadStatus)theStatus
//{
//    UIButton *downloadButton = (UIButton*)[self.view viewWithTag:101];
//    if (theStatus == kDownloadDefault) {
//        [downloadButton setImage:[UIImage imageNamed:@"btn-download.png"] forState:UIControlStateNormal];
//    }
//    else {
//        [downloadButton setImage:nil forState:UIControlStateNormal];
////        [favButton setImage:[UIImage imageNamed:@"btn-fav.png"] forState:UIControlStateNormal];
//    }
//}

- (void)changeFavButtonImageWithProgramFavStatus: (FavStatus)theStatus
{
    UIButton *favButton = (UIButton*)[self.view viewWithTag:103];
    if (theStatus == KHasAddToCollections) {
        [favButton setImage:[UIImage imageNamed:@"btn-fav-faved.png"] forState:UIControlStateNormal];
    }
    else {
        [favButton setImage:[UIImage imageNamed:@"btn-fav.png"] forState:UIControlStateNormal];
    }
}

//user interface actions
- (void)back:(id)sender
{
    [self dismissModalViewControllerWithPushDirection:kCATransitionFromLeft];
}

- (void)showCommentList
{
    CommentViewController *cc = [[CommentViewController alloc]initWithNibName:@"CommentViewController" bundle:nil];
    [cc fecthProgramCommentsByProgramID:self.programOnPlaying.ID];
    [self.navigationController pushViewController:cc animated:YES];
}

- (IBAction)play:(id)sender
{
    switch (self.moviePlayerController.playbackState) {
        case MPMoviePlaybackStatePaused:
            [self.moviePlayerController play];
            break;
        case MPMoviePlaybackStateStopped:
            // TODO:
            break;
        case MPMoviePlaybackStateInterrupted:
            // TODO:
            break;
        default:
            break;
    }
}

- (IBAction)pause:(id)sender
{
    if (self.moviePlayerController.playbackState == MPMoviePlaybackStatePlaying) {
        [self.moviePlayerController pause];
    }
}

- (IBAction)backward:(id)sender
{
    [self playPreviousProgram];
}

- (IBAction)forward:(id)sender
{
    [self playNextProgram];
}

- (void)failToPlayCurrentProgram
{
    if (self.failCount == self.programs.count) return; // 所有节目，都连接失败
    self.failCount ++;
    [self playNextProgram];
}

- (void)playNextProgram
{
    self.currentIndex = (self.currentIndex + 1) % self.programs.count;
    [self playProgramAtCurrentIndex];
}

- (void)playPreviousProgram
{
    self.currentIndex = (self.currentIndex - 1 + self.programs.count) % self.programs.count;
    [self playProgramAtCurrentIndex];
}


- (IBAction)handleProgramListButtonTouched:(id)sender
{
    PlayingProgramsViewController *controller = self.playingProgramsViewController;
    controller.programList = self.programs;
    
    HDCustomNavigationViewController *navigationViewController = [[HDCustomNavigationViewController alloc]initWithRootViewController:controller];
    [self presentModalViewController:navigationViewController animated:YES];
}

- (IBAction)playbackSliderMoved:(UISlider *)sender
{
    MPMoviePlayerController *player = self.moviePlayerController;
    if (player.playbackState != MPMoviePlaybackStatePaused) {
        [player pause];
    }
    
    player.currentPlaybackTime = (NSTimeInterval)sender.value;
    self.scheduleLabel.text =  [self timeStringWithNumber:sender.value];
    sliding = YES;
}

- (IBAction)playbackSliderDone:(UISlider *)sender
{
    MPMoviePlayerController *player = self.moviePlayerController;
    sliding = NO;
    if (player.playbackState != MPMoviePlaybackStatePlaying) {
        [player play];
    }
}

- (IBAction)volumeChanged:(UISlider *)sender
{
    [[MPMusicPlayerController applicationMusicPlayer] setVolume:sender.value];
}

- (IBAction)handleShareButtonTouched:(id)sender
{
    Program *program = self.programOnPlaying;
    NSString *content =[NSString stringWithFormat:@"%@%@%@%@%@", @"我正在#海盗电台#收听", program.authorName, @"的《" ,program.title, @"》，赶紧也到AppStore下载一个海盗电台客户端跟我一起收听吧!", nil];
    NSNumber * weibo = [[NSNumber alloc]initWithInt:ShareTypeSinaWeibo];
    //    NSNumber * b = [[NSNumber alloc]initWithInt:ShareTypeDouBan];
    [ShareSDK showShareActionSheet:[[UIApplication sharedApplication] keyWindow].rootViewController
                         shareList:[NSArray arrayWithObjects:weibo,nil]
                           content:[ShareSDK publishContent:content
                                             defaultContent:@""
                                                      image:nil
                                               imageQuality:0.0f
                                                  mediaType:SSPublishContentMediaTypeNews
                                                      title:@"Share"
                                                        url:nil
                                               musicFileUrl:nil
                                                    extInfo:nil
                                                   fileData:nil]
                     statusBarTips:YES
                   oneKeyShareList:[NSArray arrayWithObjects:weibo,nil]
                    shareViewStyle:ShareViewStyleDefault
                    shareViewTitle:NSLocalizedString(@"share to friends", @"share to friends")
                            result:^(ShareType type, SSPublishContentState state, id<ISSStatusInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                if (state == SSPublishContentStateSuccess) {
                                    NSLog(@"suc!");
                                }
                                else if(state == SSPublishContentStateFail) {
                                    NSLog(@"failed!");
                                }
                            }];
}



- (void)downloadProgram
{
    Program *program = self.programOnPlaying;
    __block id pc = self;
    if (favStatus == KHasNotAddToCollections) {
        [favManager addProgramToCollections:program WithSuccCallback:^(){
            [pc changeFavButtonImageWithProgramFavStatus:(favStatus = KHasAddToCollections)];
            [downloadManger beginDownloadProgram:program];
        }];
    } else {
        [downloadManger beginDownloadProgram:program];
    }
}


- (IBAction)handleDownloadButtonTouched:(id)sender {
    if ([HDUserInfo hasSignIn]) {
        [self downloadProgram];
    }
    else {
        [HDUserInfo signInWithWeiboAccountBySuccessCallback:^(){
            [self downloadProgram];
        }];
    }
}


- (void)addProgramToFavCollections
{
    Program *program = self.programOnPlaying;
    __block id pc = self;
    if (favStatus == KHasNotAddToCollections) {
        [favManager addProgramToCollections:program WithSuccCallback:^(){
            [pc changeFavButtonImageWithProgramFavStatus:(favStatus = KHasAddToCollections)];
        }];
    }
    else {
        [favManager removeProgramoFromCollections:program WithSuccCallback:^(){
            [pc changeFavButtonImageWithProgramFavStatus:(favStatus = KHasNotAddToCollections)];
        }];
    }
}

- (IBAction)handleFavButtonTouched:(id)sender {
    if ([HDUserInfo hasSignIn]) {
        [self addProgramToFavCollections];
    }
    else {
        [HDUserInfo signInWithWeiboAccountBySuccessCallback:^(){
            [self addProgramToFavCollections];
        }];
    }
}

- (IBAction)handleAuthorProfileButtonTouched:(id)sender
{
    DJProfileViewController *controller = self.djProfileViewController;
    Program *program = self.programOnPlaying;
    controller.viewMode = KPresentMode;
    [controller fetchProfileByUserId:program.authorID];
    HDCustomNavigationViewController *navigationViewController = [[HDCustomNavigationViewController alloc]initWithRootViewController:controller];
    [self presentModalViewController:navigationViewController animated:YES];
}


- (void)handleCoverTouched
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.volumeView.alpha = 1.0f;
                         self.overlay.alpha = 0.8f;
                     }
                     completion:nil];
}

- (void)handleOverlayTouched
{
    [UIView animateWithDuration:0.6
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.volumeView.alpha = 0.0f;
                         self.overlay.alpha = 0.0f;
                     }
                     completion:nil];
}


- (void)setupGestureRecognizer
{
    self.coverImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCoverTouched)];
    coverTap.delegate = self;
    [self.coverImageView addGestureRecognizer:coverTap];
    
    self.coverImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *overlayTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleOverlayTouched)];
    overlayTap.delegate = self;
    [self.overlay addGestureRecognizer:overlayTap];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupGestureRecognizer];
    sliding = NO;
    favManager = [ProgramFavCollectionsManager shareInstance];
    downloadManger = [ProgramDownloadManager shareInstance];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"back")  controlEvents:UIControlEventTouchUpInside target:self action:@selector(back:)];
    [self addCustomRightBarButtonItem:NSLocalizedString(@"comment", @"comment")  controlEvents:UIControlEventTouchUpInside target:self action:@selector(showCommentList)];
    
    self.volumeSlider.value = ((MPMusicPlayerController *)[MPMusicPlayerController applicationMusicPlayer]).volume;
//    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;

    //默认不显示Overlay
    [self handleOverlayTouched];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setCoverImageView:nil];
    [self setPlayButton:nil];
    [self setOverlay:nil];
    [self setVolumeSlider:nil];
    [self setVolumeView:nil];
    [self setForwardButton:nil];
    [self setBackwardButton:nil];
    [self setPauseButton:nil];
    [self setInfoTextView:nil];
    [self setScheduleLabel:nil];
    [self setDurationLabel:nil];
    [self setProgressSlider:nil];
    [self setProgressSlider:nil];
    [super viewDidUnload];
}

#pragma mark Movie Notification Handlers

/*  Notification called when the movie finished playing. */
- (void)moviePlayBackDidFinish:(NSNotification*)notification
{
    NSNumber *reason = [[notification userInfo] objectForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey];

	switch ([reason integerValue])
	{
		case MPMovieFinishReasonPlaybackEnded:
            if (self.playMode == kPlayModeCycle) {
                [self playNextProgram];
            }
            break;
            /* An error was encountered during playback. */
		case MPMovieFinishReasonPlaybackError:
            [self showNetWorkErrorStatus];
            [self failToPlayCurrentProgram];
            break;
            /* The user stopped playback. */
		case MPMovieFinishReasonUserExited:
            NSLog(@"MPMovieFinishReasonUserExited");
            break;
            
        default:
            NSLog(@"other");
            break;
	}
}

/* Handle movie load state changes. */
- (void)loadStateDidChange:(NSNotification *)notification
{
	MPMoviePlayerController *player = notification.object;
	MPMovieLoadState loadState = player.loadState;    
	if (loadState & MPMovieLoadStateStalled) {
        [self showNetWorkLoadingStatus];
        [player pause];
        NSLog(@"[MP]MPMovieLoadStateStalled");
    } else if (loadState & MPMovieLoadStatePlayable) {
        [self hideNetWorkStatus];
        NSLog(@"[MP]MPMovieLoadStatePlayable");
    } else if (loadState & MPMovieLoadStatePlaythroughOK) {
        [self hideNetWorkStatus];
        [player play];
        NSLog(@"[MP]MPMovieLoadStatePlaythroughOK");        
    } else if (loadState & MPMovieLoadStateUnknown) {
        [self showNetWorkErrorStatus];
        [self failToPlayCurrentProgram];
        NSLog(@"[MP]MPMovieLoadStateUnknown");              
    }
}


/* Called when the movie playback state has changed. */
- (void)moviePlayBackStateDidChange:(NSNotification*)notification
{
	MPMoviePlayerController *player = notification.object;
	if (player.playbackState == MPMoviePlaybackStateStopped)
	{
        [self.playButton setHidden:NO];
        [self.pauseButton setHidden:YES];
        NSLog(@"[MP]MPMoviePlaybackStateStopped");
    }
	else if (player.playbackState == MPMoviePlaybackStatePlaying)
	{
        [self.playButton setHidden:YES];
        [self.pauseButton setHidden:NO];
        [self.HUD hide:YES];        
        NSLog(@"[MP]MPMoviePlaybackStatePlaying");               
    }
	else if (player.playbackState == MPMoviePlaybackStatePaused)
	{
        [self.playButton setHidden:NO];
        [self.pauseButton setHidden:YES];
        NSLog(@"[MP]MPMoviePlaybackStatePaused");
    }
	else if (player.playbackState == MPMoviePlaybackStateInterrupted)
	{
        [self failToPlayCurrentProgram];
        NSLog(@"[MP]MPMoviePlaybackStateInterrupted");          
	}
    else if (player.playbackState == MPMoviePlaybackStateSeekingBackward) {
        NSLog(@"MPMoviePlaybackStateSeekingBackward");
    }
    else if (player.playbackState == MPMoviePlaybackStateSeekingForward) {
        NSLog(@"MPMoviePlaybackStateSeekingForward");
    }

}

- (void)mediaIsPreparedToPlayDidChange:(NSNotification*)notification
{
	[self.HUD hide:YES afterDelay:1.0f];
    [self hideNetWorkStatus];
    [self.moviePlayerController play];
}

- (void)movieDurationAvailable:(NSNotification*)notification
{
    MPMoviePlayerController *player = notification.object;
    NSLog(@"%d", player.playbackState );
    if (playbackTimer == nil) {
        playbackTimer =
        [NSTimer scheduledTimerWithTimeInterval:1.0f
                                         target:self selector:@selector(updatePlaybackTime:) userInfo:nil
                                        repeats:YES];
    }
    self.progressSlider.minimumValue = 0.0;
    self.progressSlider.maximumValue = [player duration];
}

- (NSString*)timeStringWithNumber:(float)theTime
{
    NSString *minuteS = [NSString string];
    
    int minute = (theTime) / 60;
    if (theTime < 60) {
        minuteS = @"00";
    }
    else if (minute < 10) {
        minuteS = [NSString stringWithFormat:@"0%i", (minute)];
    }
    else {
        minuteS = [NSString stringWithFormat:@"%i", (minute)];
    }
    
    NSString *playTimeS = [NSString string];
    if (theTime - 60 * minute <= 10) {
        playTimeS = [NSString stringWithFormat:@"%@:0%0.0f",minuteS, theTime - 60 * minute];
    }
    else {
        playTimeS=[NSString stringWithFormat:@"%@:%0.0f",minuteS, theTime - 60 * minute];
    }
    return playTimeS;
}

- (void)updatePlaybackTime:(NSTimer*)theTimer
{
    MPMoviePlayerController *player = self.moviePlayerController;
    float playbackTime = player.currentPlaybackTime;
    float duration = player.duration;
    float playableDuration = player.playableDuration;
    
    if (duration <= 0) {
        self.progressSlider.value = 0;
        self.scheduleLabel.text = @"00:00";
        self.durationLabel.text = @"00:00";
    }
        
    if (!sliding && player.playbackState == MPMoviePlaybackStatePlaying) {
        [self.progressSlider updateBuffer:playableDuration / duration];
        self.progressSlider.value = playbackTime;
        self.scheduleLabel.text = [self timeStringWithNumber:playbackTime];
        self.durationLabel.text = [self timeStringWithNumber:duration];
    }
}

-(void)applyUserSettingsToMoviePlayer
{
    MPMoviePlayerController *player = self.moviePlayerController;
    player.scalingMode = MPMovieScalingModeNone;
    player.repeatMode = MPMovieRepeatModeNone;
    player.useApplicationAudioSession = YES;
    player.allowsAirPlay = YES;
}

-(void)installMovieNotificationObservers
{
    MPMoviePlayerController *player = [self moviePlayerController];
    
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(loadStateDidChange:) name:MPMoviePlayerLoadStateDidChangeNotification object:player];
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(mediaIsPreparedToPlayDidChange:) name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification object:player];
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(moviePlayBackStateDidChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:player];
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(movieDurationAvailable:) name:MPMovieDurationAvailableNotification object:player];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return YES;
}

@end
