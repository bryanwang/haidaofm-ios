//
//  CommentCell.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "CommentCell.h"
#import "NSDate+FormattedString.h"

@implementation CommentCell

- (void)setComment:(Comment *)comment
{
    if (![comment isEqualToComment:_comment]) {
        _comment = comment;
        if (!comment.isFaved)
            self.favIcon.alpha = 0.0f;
        else
            self.favIcon.alpha = 1.0f;
        
        self.contentLabel.text = comment.content;
        self.userLabel.text = comment.authorName;
        self.dateTimeLabel.text = [comment.createAt ToFullDate];
    }
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.userInteractionEnabled = NO;
}

@end
