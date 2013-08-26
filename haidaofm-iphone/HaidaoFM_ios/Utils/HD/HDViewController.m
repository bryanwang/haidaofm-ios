//
//  HDViewController.m
//  haidaofm
//
//  Created by Bruce Yang on 9/30/12.
//
//

#import "HDViewController.h"
#import "PlayerViewController.h"

@interface HDViewController ()

@end

@implementation HDViewController

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-view.png"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    if ([PlayerViewController sharedInstance].programOnPlaying) {
        [self addPlayingRightBarButtonItem:NSLocalizedString(@"playing", @"")
                             controlEvents:UIControlEventTouchUpInside
                                    target:self action:@selector(presentPlayerViewController)];
    }
}

- (void)presentPlayerViewController
{
    HDCustomNavigationViewController *navigationViewController =[[HDCustomNavigationViewController alloc]initWithRootViewController:[PlayerViewController sharedInstance]];
    [self presentModalViewController:navigationViewController withPushDirection: kCATransitionFromRight];
}

@end
