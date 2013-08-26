//
//  FavViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/24/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "FavViewController.h"
#import "FavListViewController.h"

@interface FavViewController ()
@property (nonatomic, strong)FavListViewController *favListViewController;
@end

@implementation FavViewController
@synthesize favListViewController = _favListViewController;

- (FavListViewController *)favListViewController
{
    if (_favListViewController == nil) {
        _favListViewController = [[FavListViewController alloc]initWithNibName:@"FavListViewController" bundle:nil];
    }
    
    return _favListViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pushViewController:self.favListViewController animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
