//
//  HDProgressView.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/28/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "HDProgressView.h"

@implementation HDProgressView

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToSuperview:newWindow];
    
    [self setTransform:CGAffineTransformMakeScale(1.0, 0.5)];
    UIImage *trackImage = [[UIImage imageNamed:@"bg-progress.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *progressImage = [[UIImage imageNamed:@"bg-progress-max.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    
    [self setProgressImage:progressImage];
    [self setTrackImage:trackImage];
}


@end
