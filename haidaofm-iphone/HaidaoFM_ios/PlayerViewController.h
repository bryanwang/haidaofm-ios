//
//  PlayerViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/21/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

#define kPlayingProgramChanged @"Playing Program Changed"

typedef enum _PlayMode
{
    kPlayModeNormal,
    kPlayModeCycle,
    kPlayModeShuffle
} PlayMode;

typedef enum _PlayedContentType
{
    kPlayedContentIsChannel,
    kPlayedContentIsAllPrograms,
    kPlayedContentIsTopic,
    kPlayedContentIsRecommendedProgram
} PlayedContentType;

@interface PlayerViewController : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) PlayMode playMode;
@property (nonatomic) PlayedContentType playedContentType;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic, strong, readonly) Program *programOnPlaying;

//- (void)playPrograms:(NSArray *)programs inChannel:(NSDictionary*)channel startFromIndex:(NSInteger)index;

- (void)playPrograms:(NSArray *)programs  startFromIndex:(NSInteger)index;

//- (void)playProgramsFromChannelURL:(NSURL *)url;

- (void)playOrPause;
- (void)playPreviousProgram;
- (void)playNextProgram;

+ (PlayerViewController *)sharedInstance;

@end
