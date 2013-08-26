//
//  ProfileDesCell.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/24/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDesCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *desLabel;

- (void)setDesAndCalCellSizeWithDes: (NSString *)des;

@end
