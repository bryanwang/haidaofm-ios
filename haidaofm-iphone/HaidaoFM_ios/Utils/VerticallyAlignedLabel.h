//
//  VerticallyAlignedLabel.m
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-21.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum VerticalAlignment {
    VerticalAlignmentTop,
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticallyAlignedLabel : UILabel {
@private
    VerticalAlignment verticalAlignment_;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end