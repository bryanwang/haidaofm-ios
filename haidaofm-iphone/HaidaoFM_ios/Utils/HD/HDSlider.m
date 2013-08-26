//
//  HDSlider.m
//  haidaofm
//
//  Created by Bruce Yang on 10/18/12.
//
//

#import "HDSlider.h"

@implementation HDSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)willMoveToWindow:(UIWindow *)newWindow
{
    [super willMoveToWindow:newWindow];
    
    self.backgroundColor = [UIColor clearColor];
    UIImage *maxTrack = [[UIImage imageNamed:@"bg-slider-max.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *minTrack = [[UIImage imageNamed:@"bg-slider-bar.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-key.png"] forState:UIControlStateNormal];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-key.png"] forState:UIControlStateSelected];
    [self setThumbImage: [UIImage imageNamed:@"icon-slider-key.png"] forState:UIControlStateHighlighted];
    
    [self setMinimumTrackImage:minTrack forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxTrack forState:UIControlStateNormal];
    
}

@end
