//
//  NetworkErrorManager.m
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-24.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

#import "NetworkStatusManager.h"
#import "NetworkStatusViewController.h"

@interface NetworkStatusManager() <NetworkStatusRetryDelegate>

@end

@implementation NetworkStatusManager
static NetworkStatusManager *instance = nil;

@synthesize networkStatusViewControler = _networkStatusViewControler;
@synthesize operation = _operation;

+ (NetworkStatusManager*)sharedInstance
{
    @synchronized(self) {
        if (instance == nil) {
            instance = [[self alloc] init]; // assignment not done here
        }
    }
    return instance;
}

- (NetworkStatusViewController*)networkStatusViewControler
{
    if (_networkStatusViewControler == nil) {
        _networkStatusViewControler = [[NetworkStatusViewController alloc] initWithNibName:@"NetworkStatusViewController" bundle:nil];
        _networkStatusViewControler.delegete = self;
    }
    return _networkStatusViewControler;
}

- (void)changeToNetworkErrorStatusWithBaseViewController:(UIViewController *)baseViewController
                                        AndRetryDelegate:(id<NetworkStatusRetryDelegate>)delegate
{
    NSLog(@"oh, network error..");
    [self.networkStatusViewControler changeToStatus:HDNetworkStatusError];
    self.delegete = delegate;
    self.baseViewController = baseViewController;
    [self.baseViewController.view addSubview: self.networkStatusViewControler.view];

}

- (void)showLoadingWithBaseViewController:(UIViewController *)baseViewController
{
    NSLog(@"here, let's loading..");
    [self.networkStatusViewControler changeToStatus:HDNetworkStatusLoading];
    self.baseViewController = baseViewController;    
    [self.baseViewController.view addSubview: self.networkStatusViewControler.view];
}

- (void)removeNetworkStatusViewControler
{
    if (self.networkStatusViewControler != nil) {
        [self.networkStatusViewControler.view removeFromSuperview];
        self.networkStatusViewControler = nil;
    }
}

- (void)retry
{
    NSLog(@"user wants to retry...");
    [self showLoadingWithBaseViewController:self.baseViewController];
    if (self.delegete != nil) {
        [(NSObject *)self.delegete performSelector:@selector(retry) withObject:nil afterDelay:1.0f];
    }
}

@end
