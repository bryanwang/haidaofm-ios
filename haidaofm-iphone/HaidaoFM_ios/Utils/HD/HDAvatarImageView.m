//
//  HDAvatarImageView.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/27/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "HDAvatarImageView.h"

@implementation HDAvatarImageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.layer.cornerRadius = 4.0f;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.clipsToBounds = YES;
}

@end
