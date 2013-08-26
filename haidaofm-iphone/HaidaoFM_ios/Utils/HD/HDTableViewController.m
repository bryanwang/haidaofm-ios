//
//  HDTableViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/21/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "HDTableViewController.h"
#import "PlayerViewController.h"

@interface HDTableViewController ()

@end

@implementation HDTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-view.png"]];
    
    //footer
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    [self.tableView setTableFooterView:v];
    
    //separator
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    HDCustomNavigationViewController *navigationViewController = [[HDCustomNavigationViewController alloc] initWithRootViewController:[PlayerViewController sharedInstance]];
    [self presentModalViewController:navigationViewController withPushDirection: kCATransitionFromRight];
}

@end
