//
//  AppDelegate.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CCUIViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "PlayerViewController.h"
#import "MobClick.h"
#import <ShareSDK/ShareSDK.h>


@implementation AppDelegate

- (void)setUpBasicSettings
{
    //status bar
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:YES];
    //audio backgroud
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    NSError *setCategoryError = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&setCategoryError];
    if (setCategoryError) {
        NSLog(@"%@", setCategoryError);
    }
    
    NSError *activationError = nil;
    [audioSession setActive:YES error:&activationError];
    if (activationError) {
        NSLog(@"%@", setCategoryError);
    }
    
    //background player
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void) setUpShareSDKInfo
{
    [ShareSDK registerApp:SHARESDK_APPKEY];
    NSLog(@"%@", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]);
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    [MobClick startWithAppkey:UMENG_APPKEY];
    [self setUpBasicSettings];
    [self setUpShareSDKInfo];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];

    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}


- (void)remoteControlReceivedWithEvent: (UIEvent *) receivedEvent {
    if (receivedEvent.type == UIEventTypeRemoteControl) {
        PlayerViewController *player = [PlayerViewController sharedInstance];
        switch (receivedEvent.subtype) {
            case UIEventSubtypeRemoteControlTogglePlayPause:
                NSLog(@"play..pause");
                [player playOrPause];
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                NSLog(@"prev");
                [player playPreviousProgram];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                NSLog(@"next");
                [player playNextProgram];
                break;
                
            default:
                break;
        }
    }
}



- (void)applicationDidEnterBackground:(UIApplication *)application
{
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
//    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
//    [self resignFirstResponder];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}

@end
