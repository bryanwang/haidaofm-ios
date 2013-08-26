//
//  NetworkErrorManager.h
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-24.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NetworkStatusManager.h"
#import "NetworkStatusViewController.h"
#import "AFHTTPRequestOperation.h"


@interface NetworkStatusManager : NSObject
@property (nonatomic, strong) NetworkStatusViewController *networkStatusViewControler;
@property (nonatomic) id<NetworkStatusRetryDelegate> delegete;
@property (nonatomic, weak) UIViewController *baseViewController;
@property (nonatomic, strong) AFHTTPRequestOperation *operation;

+ (NetworkStatusManager *)sharedInstance;
- (void)showLoadingWithBaseViewController:(UIViewController *)baseViewController;
- (void)changeToNetworkErrorStatusWithBaseViewController:(UIViewController *)baseViewController
                                        AndRetryDelegate:(id<NetworkStatusRetryDelegate>)delegate;
- (void)removeNetworkStatusViewControler;

@end
