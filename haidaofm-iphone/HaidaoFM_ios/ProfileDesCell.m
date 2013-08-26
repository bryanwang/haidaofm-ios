//
//  ProfileDesCell.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/24/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "ProfileDesCell.h"

@implementation ProfileDesCell

- (void)setDesAndCalCellSizeWithDes: (NSString *)des {
    UIFont *font = [UIFont systemFontOfSize:14.0f];
    CGSize size = CGSizeMake(280,2000);
    CGSize labelsize = [des sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.desLabel.text = des;
    self.desLabel.frame = CGRectMake(10.0f, 10.0f, labelsize.width, labelsize.height);
    self.frame = CGRectMake(0.0f, 0.0f, 300.0f, labelsize.height + 20.f);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
    [self.desLabel setNumberOfLines:0];
    self.desLabel.lineBreakMode = UILineBreakModeWordWrap;
    self.desLabel.textColor = CELL_TITLE_COLOR;
}
@end
