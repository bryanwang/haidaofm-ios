//
//  HDTitleLabel.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/27/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "HDTitleLabel.h"

@implementation HDTitleLabel

- (void)awakeFromNib
{
    self.shadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.7f];
    self.shadowOffset = CGSizeMake(1.0f, 1.8f);
}

@end
