//
//  ChannelViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@protocol ChannelViewDelegate;

@interface ChannelView : UIView <UIGestureRecognizerDelegate>

@property (nonatomic, strong) ChannelDetail *channelDetail;
@property (nonatomic, strong) id <ChannelViewDelegate> delegate;

@end


@protocol ChannelViewDelegate <NSObject>

@optional
- (void)showProgramList:(ChannelDetail *)channel;
//- (void)playChannel:(Channel *)channel;

@end