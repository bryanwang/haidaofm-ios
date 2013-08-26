//
//  HDCell.m
//  haidaofm
//
//  Created by Bruce Yang on 10/18/12.
//
//

#import "HDCell.h"

@implementation HDCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    self.selectedBackgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-cell-selected.png"]];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-cell.png"]];
}

@end
