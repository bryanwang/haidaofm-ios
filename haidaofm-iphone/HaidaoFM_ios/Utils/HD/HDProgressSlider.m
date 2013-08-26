//
//  HDProgressSlider.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/26/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "HDProgressSlider.h"

@implementation HDProgressSlider {
    UIView *shadowSlider;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)updateBuffer:(float)percentage
{
    [shadowSlider setWidth:self.frame.size.width * percentage];
    [shadowSlider setNeedsDisplay];
}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    self.backgroundColor = [UIColor clearColor];
    UIImage *maxTrack = [[UIImage imageNamed:@"bg-slider-progress-min.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *minTrack = [[UIImage imageNamed:@"bg-slider-progress-max.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-progress.png"] forState:UIControlStateNormal];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-progress.png"] forState:UIControlStateSelected];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-progress.png"] forState:UIControlStateHighlighted];
    
    [self setMinimumTrackImage:minTrack forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxTrack forState:UIControlStateNormal];
}

- (void)drawRect:(CGRect)rect
{
    shadowSlider = [[UIView alloc] init];
    shadowSlider.backgroundColor =[UIColor colorWithRed:88.0f/255.0f green:88.0f/255.0f blue:88.0f/255.0f alpha:1.0f];
    shadowSlider.frame = CGRectMake(0.0f, (self.frame.size.height - 8.0f) / 2, 0.0f , 8.0f);
    shadowSlider.layer.cornerRadius = 4.0f;
    shadowSlider.layer.masksToBounds = YES;
    [self addSubview:shadowSlider];
    [self sendSubviewToBack:shadowSlider];
}
@end
