//
//  NetworkErrorViewController.h
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-22.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

@protocol NetworkStatusRetryDelegate <NSObject>
- (void)retry;
@end

typedef enum
{
    HDNetworkStatusError,
    HDNetworkStatusLoading,
} HDNetworkStatusType;

#import <UIKit/UIKit.h>

@interface NetworkStatusViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *errorView;
@property (strong, nonatomic) IBOutlet UIView *loadingView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *retryTapGestureRecognizer;
@property (nonatomic) id<NetworkStatusRetryDelegate> delegete;

- (void)changeToStatus:(HDNetworkStatusType)type;
@end
