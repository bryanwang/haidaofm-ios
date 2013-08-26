//
//  ChannelHeaderView.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Channel.h"

@protocol ChannelHeaderViewDelegate <NSObject>

- (void)showChannelProfile:(User *)profile;

@end

@interface ChannelHeaderView : UIView

@property (nonatomic, strong) Channel *channel;
@property (nonatomic, strong) User *author;

@property (nonatomic, strong) id <ChannelHeaderViewDelegate> delegate;

@end
