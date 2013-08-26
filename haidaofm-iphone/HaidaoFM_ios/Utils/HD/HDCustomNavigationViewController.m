//
//  HDCustomNavigationViewController.m
//  haidaofm
//
//  Created by Bruce Yang on 10/6/12.
//
//

#import "HDCustomNavigationViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface HDCustomNavigationViewController ()

@end

@implementation HDCustomNavigationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //navigation bar
    [self.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      
      UITextAttributeTextColor,
      [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
      
      UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, 0)],
      
      UITextAttributeTextShadowOffset,
      
      [UIFont fontWithName:@"Arial-Bold"size:0.0],
      UITextAttributeFont,
      nil]];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg-nav.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setBarStyle:UIBarStyleBlackOpaque];
    
    //back button background image
//    UIImage *backButtonImage = [[UIImage imageNamed:@"btn-back.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 14.0f, 0.0f, 10.0f)];
//    UIImage *backButtonHighlightImage = [[UIImage imageNamed:@"btn-back-selected.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0.0f, 14.0f, 0.0f, 10.0f)];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHighlightImage forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:backButtonHighlightImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    // draw shadow
//    self.navigationBar.layer.masksToBounds = NO;
//    self.navigationBar.layer.shadowOffset = CGSizeMake(0, 3);
//    self.navigationBar.layer.shadowOpacity = 0.6;
//    self.navigationBar.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.navigationBar.bounds].CGPath;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
