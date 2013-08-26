//
//  CCUIViewController.m
//  CCFC
//
//  Created by xichen on 11-12-28.
//  Copyright 2011 ccteam. All rights reserved.
//

#import "CCUIViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIViewController(cc)


- (UIBarButtonItem *)addLeftLogoBarButtonItem
{
    UIImageView *view = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nav-logo.png"]];
    view.frame = CGRectMake(0.f, 0.0f, view.frame.size.width, view.frame.size.height);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:view];
    self.navigationItem.leftBarButtonItem = leftItem;

    return leftItem;
}

- (UIButton *)getCustomButtonWithImage: (NSString *)imageName withHighlightImage: (NSString *)highlightImageName withTitle: (NSString *)aTitle
{
    UIImage *image = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
    UIImage *highlightImage = [[UIImage imageNamed:highlightImageName] stretchableImageWithLeftCapWidth:CAP_WIDTH topCapHeight:0.0];
    
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, width, height);
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    button.titleLabel.textColor = [UIColor whiteColor];
    button.titleLabel.shadowOffset = CGSizeMake(0,-1);
    button.titleLabel.shadowColor = [UIColor blackColor];
    [button setTitle:aTitle forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:highlightImage forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    return button;
}

- (UIBarButtonItem *)addCustomBackBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    UIButton* button = [self getCustomButtonWithImage:@"btn-back.png" withHighlightImage:@"btn-back-selected.png" withTitle:aTitle];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 14.0f, 0.0f, 8.0f);
    [button addTarget:target action:sel==nil? @selector(pop:) : sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    
    return leftBarButtonItem;
}

- (UIBarButtonItem *)addCustomLeftBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    return nil;
}

- (UIBarButtonItem *)addCustomRightListBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    UIButton* button = [self getCustomButtonWithImage:@"btn-custom.png" withHighlightImage:@"btn-custom-selected.png" withTitle:aTitle];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    return rightBarButton;
}

- (UIBarButtonItem *)addCustomRightPlayBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    UIButton *button = [self getCustomButtonWithImage:@"nav-btn-play.png" withHighlightImage:@"nav-btn-play-selected.png" withTitle:aTitle];
    [button addTarget:target action:sel forControlEvents:events];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    return rightBarButton;
}

- (UIBarButtonItem *)addCustomRightBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    UIButton* button = [self getCustomButtonWithImage:@"btn-right-custom.png" withHighlightImage:@"btn-right-custom-selected.png" withTitle:aTitle];
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    return rightBarButton;
}

- (UIBarButtonItem *)addPlayingRightBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel
{
    UIButton* button = [self getCustomButtonWithImage:@"btn-playing.png" withHighlightImage:@"btn-playing-selected.png" withTitle:aTitle];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 0.0f);
    [button addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    self.navigationItem.rightBarButtonItem = rightBarButton;

    return rightBarButton;
}

- (UIBarButtonItem *)addLeftBarButtonItem:aTitle
									style:(UIBarButtonItemStyle)style
								   target:(id)target 
								   action:(SEL)sel 
{
	UIBarButtonItem *barButtonItem = 
			[[UIBarButtonItem alloc] initWithTitle:aTitle
											 style:style
											target:target
											action:sel];
	self.navigationItem.leftBarButtonItem = barButtonItem;
	[barButtonItem release];
	
	return barButtonItem;
}

- (UIBarButtonItem *)addRightBarButtonItem:aTitle
									 style:(UIBarButtonItemStyle)style
									target:(id)target 
									action:(SEL)sel
{
	UIBarButtonItem *barButtonItem =
			[[UIBarButtonItem alloc] initWithTitle:aTitle
											 style:style
											target:target
											action:sel];
	self.navigationItem.rightBarButtonItem = barButtonItem;
	[barButtonItem release];
	
	return barButtonItem;
}

- (UIBarButtonItem *)addBackBarButtonItem:aTitle
									 style:(UIBarButtonItemStyle)style
									target:(id)target
									action:(SEL)sel
{
	UIBarButtonItem *barButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:aTitle
                                     style:style
                                    target:target
                                    action:sel];
	self.navigationItem.backBarButtonItem = barButtonItem;
	[barButtonItem release];
	
	return barButtonItem;
}


- (UIView *)setLoadView
{
	CGRect rect = [[UIScreen mainScreen] applicationFrame];
	UIView *view = [[UIView alloc] initWithFrame:rect];
	self.view = view;
	return view;
}


//animation
- (void)pop:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) presentModalViewController:(UIViewController *)modalViewController withPushDirection: (NSString *) direction {
    
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = direction;
    transition.duration = kDuration;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    
    [self presentModalViewController:modalViewController animated:NO];
    
    [CATransaction commit];
    
}

- (void) dismissModalViewControllerWithPushDirection:(NSString *) direction {
    
    [CATransaction begin];
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionPush;
    transition.subtype = direction;
    transition.duration = kDuration;
    transition.fillMode = kCAFillModeForwards;
    transition.removedOnCompletion = YES;
    
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:transition forKey:@"transition"];
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    [CATransaction setCompletionBlock: ^ {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(transition.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^ {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        });
    }];
    
    [self dismissModalViewControllerAnimated:NO];
    
    [CATransaction commit];
    
}


//network status
- (void)showNetWorkCompletedStatus
{
    [[MTStatusBarOverlay sharedInstance] postImmediateFinishMessage:NSLocalizedString(@"completed", @"") duration:nDuration animated:NO];
}

- (void)showNetWorkErrorStatus
{
    [[MTStatusBarOverlay sharedInstance]postErrorMessage:NSLocalizedString(@"error", @"") duration:nDuration animated:NO];
}

- (void)showNetWorkLoadingStatus
{
    [[MTStatusBarOverlay sharedInstance]postImmediateMessage:NSLocalizedString(@"loading..", @"") animated:NO];
}

- (void)showNetWorkSubimtingStatus

{
    [[MTStatusBarOverlay sharedInstance]postImmediateMessage:NSLocalizedString(@"submiting..", @"") animated:NO];

}

- (void)hideNetWorkStatus
{
    [[MTStatusBarOverlay sharedInstance] hide];
}

@end
