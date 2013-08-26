//
//  HDProgramActionSheet.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "HDProgramActionSheet.h"
#import <ShareSDK/ShareSDK.h>
#import "ProgramFavCollectionsManager.h"
#import "ProgramDownloadManager.h" 

@implementation DimView
@synthesize parentView;


- (id)initWithParent:(UIView*) aParentView
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        self.parentView = aParentView;
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.0;
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [((HDProgramActionSheet *)self.parentView) hidePanel];
}

@end

@interface HDProgramActionSheet() {
    FavStatus favStatus;
    DownloadStatus downloadStatus;
}

@end


@implementation HDProgramActionSheet
@synthesize dimView = _dimView;
@synthesize program = _program;
@synthesize callback = _callback;


+ (HDProgramActionSheet *)shareInstance
{
    static HDProgramActionSheet* sharedInstance = nil;
    static dispatch_once_t onceToken =0;
    dispatch_once(&onceToken,^{
        sharedInstance =  (HDProgramActionSheet*) [[[UINib nibWithNibName:@"HDProgramActionSheet" bundle:nil]
                                                                       instantiateWithOwner:self options:nil] objectAtIndex:0];
        CATransition *transition = [CATransition animation];
        transition.duration = kDuration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromTop;
        [sharedInstance.layer addAnimation:transition forKey:nil];

    });
    return sharedInstance;
}

- (void)showActionSheetForProgram: (Program *)aProgram InView:(UIView*) view
{
    self.program = aProgram;
    
    [self checkProgramFavedStatus];
    [self checkProgramDownloadStatus];
    
    self.dimView = [[DimView alloc] initWithParent:self];
    CATransition *transition = [CATransition animation];
	transition.duration = kDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	[self.dimView.layer addAnimation:transition forKey:nil];
    self.dimView.alpha = 0.7f;
    CGRect r2 = self.frame;
    self.frame = CGRectMake(0.0f, UI_SCREEN_HEIGHT-r2.size.height -20.0f, r2.size.width, r2.size.height);
    [view addSubview:self.dimView];
    [view addSubview:self];
}


- (void)checkProgramFavedStatus
{
    favStatus = [[ProgramFavCollectionsManager shareInstance] checkPorgramHasAddToColletions:self.program];
    UIImageView *favIcon = (UIImageView *)[self viewWithTag:103];
    UILabel *favLabel = (UILabel *)[self viewWithTag:104];
    if (favStatus == KHasNotAddToCollections) {
        favIcon.image = [UIImage imageNamed:@"icon-ac-fav.png"];
        favLabel.text = NSLocalizedString(@"add to fav collections", @"");
    }
    else if (favStatus == KHasAddToCollections) {
        favIcon.image = [UIImage imageNamed:@"icon-ac-faved.png"];
        favLabel.text = NSLocalizedString(@"remove from fav collections", @"");
    }
}

- (void)checkProgramDownloadStatus
{
    downloadStatus = [[ProgramDownloadManager shareInstance]checkProgramDownloadStatus:self.program];
    UIImageView *downloadIcon = (UIImageView *)[self viewWithTag:105];
    UILabel *downloadLabel = (UILabel *)[self viewWithTag:106];
    if (downloadStatus == kDownloadDefault) {
        downloadIcon.image = [UIImage imageNamed:@"icon-ac-download.png"];
        downloadLabel.text = NSLocalizedString(@"download", @"");
    }
    else if (downloadStatus == KDownloadCompleted) {
        downloadIcon.image = [UIImage imageNamed:@"icon-ac-downloaded.png"];
        downloadLabel.text = NSLocalizedString(@"downloaded", @"");
    }
    else if (downloadStatus == KDownloading) {
        downloadIcon.image = [UIImage imageNamed:@"icon-ac-downloaded.png"];
        downloadLabel.text = NSLocalizedString(@"downloading", @"");
    }
}


- (void) hidePanel
{
    CATransition *transition = [CATransition animation];
	transition.duration = kDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromBottom;
	[self.layer addAnimation:transition forKey:nil];
    self.frame = CGRectMake(0, UI_SCREEN_HEIGHT, self.frame.size.width, self.frame.size.height);
    
    transition = [CATransition animation];
	transition.duration = kDuration;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionFade;
	self.dimView.alpha = 0.0;
    [self.dimView.layer addAnimation:transition forKey:nil];
    
    if (self.callback) self.callback();
    
    [self.dimView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.40];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.45];
}


- (IBAction)handleShareSheetTouched
{
    NSString *content =[NSString stringWithFormat:@"%@%@%@", @"我正在#海盗电台#收听", self.program.title, @"，赶紧也到AppStore下载一个海盗电台客户端跟我一起收听吧!", nil];
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
                                    NSLog(@"succ!");
                                }
                                else if(state == SSPublishContentStateFail) {
                                    NSLog(@"failed!");
                                }
                                
                                [self hidePanel];
                            }];
}


- (void)addProgramToFavCollections
{
    if (favStatus == KHasNotAddToCollections) {
        [[ProgramFavCollectionsManager shareInstance] addProgramToCollections:self.program WithSuccCallback:^(){
                [self checkProgramFavedStatus];
        }];
    }
    else if (favStatus == KHasAddToCollections){
        [[ProgramFavCollectionsManager shareInstance] removeProgramoFromCollections:self.program WithSuccCallback:^(){
                [self checkProgramFavedStatus];
        }];
    }
}

- (IBAction)handleFavSheetTouched
{
    if ([HDUserInfo hasSignIn]) {
        [self addProgramToFavCollections];
    }
    else {
        [HDUserInfo signInWithWeiboAccountBySuccessCallback:^(){
            [self addProgramToFavCollections];
        }];
    }
}

- (void)downloadProgram
{
    if (favStatus == KHasNotAddToCollections) {
        [[ProgramFavCollectionsManager shareInstance] addProgramToCollections:self.program WithSuccCallback:^(){
                if (downloadStatus == kDownloadDefault) {
                    ProgramFile *file = [[ProgramDownloadManager shareInstance] beginDownloadProgram:self.program];
                    file.downloadFiniedback = ^() {
                        [self checkProgramDownloadStatus];
                    };
                }
                
                [self checkProgramFavedStatus];
                [self checkProgramDownloadStatus];
        }];
    } else {
        if (downloadStatus == kDownloadDefault) {
            ProgramFile *file = [[ProgramDownloadManager shareInstance] beginDownloadProgram:self.program];
            file.downloadFiniedback = ^() {
                [self checkProgramDownloadStatus];
            };
        }
        
        [self checkProgramDownloadStatus];
    }
}

- (IBAction)handleDownloadSheetTouched
{
    if ([HDUserInfo hasSignIn]) {
        [self downloadProgram];
    }
    else {
        [HDUserInfo signInWithWeiboAccountBySuccessCallback:^(){
            [self downloadProgram];
        }];
    }
}


@end
