//
//  HDToolbar.m
//  haidaofm
//
//  Created by Bruce Yang on 10/6/12.
//
//
#import "HDToolbar.h"
#import <QuartzCore/QuartzCore.h>

@implementation HDToolbar


- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    [self setBackgroundImage:[UIImage imageNamed:@"bg-toolbar-white.png"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
}

//- (void)drawRect:(CGRect)rect
//{
////    self.layer.masksToBounds = NO;
////    self.layer.shadowOffset = CGSizeMake(0, -3);
////    self.layer.shadowOpacity = 0.6;
////    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
//}


@end
