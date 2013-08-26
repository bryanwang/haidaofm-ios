//
//  TopicHeaderView.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopicViewHeaderDelegate <NSObject>

- (void)showTopicDescription:(NSString *)description;

@end

@interface TopicHeaderView : UIView

@property (nonatomic, strong) NSDictionary *topic;
@property (nonatomic, strong) id <TopicViewHeaderDelegate> delegate;

@end
