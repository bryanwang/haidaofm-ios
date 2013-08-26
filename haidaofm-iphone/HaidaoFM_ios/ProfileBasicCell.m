//
//  ProfileBasicCell.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/24/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "ProfileBasicCell.h"

@implementation ProfileBasicCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.userInteractionEnabled = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.tagNameLabel.textColor = CELL_TIME_COLOR;
    self.tagValueLabel.textColor = CELL_TITLE_COLOR;
}

@end
