//
//  SpecialTopicView.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/24/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@protocol SpecialTopicViewDelegate <NSObject>

- (void)topicSelected:(Program *)topic;

@end

@interface SpecialTopicView : UIView

@property (nonatomic, strong) Program *topic;

@property (nonatomic, strong) id <SpecialTopicViewDelegate> delegate;

@end
