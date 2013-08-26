//
//  CommentCell.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment.h"

@interface CommentCell : HDCell
@property (strong, nonatomic) IBOutlet UIImageView *favIcon;
@property (strong, nonatomic) IBOutlet UILabel *contentLabel;
@property (strong, nonatomic) IBOutlet UILabel *userLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateTimeLabel;

@property (strong, nonatomic) Comment *comment;

@end
