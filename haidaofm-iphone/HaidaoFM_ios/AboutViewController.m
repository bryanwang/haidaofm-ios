//
//  AboutViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "AboutViewController.h"
#import "AboutRootViewController.h"

@interface AboutViewController ()
@property (nonatomic, strong) AboutRootViewController *aboutRootViewController;
@end

@implementation AboutViewController
@synthesize aboutRootViewController = _aboutRootViewController;

- (AboutRootViewController *)aboutRootViewController
{
    if (_aboutRootViewController == nil) {
        _aboutRootViewController = [[AboutRootViewController alloc]initWithNibName:@"AboutRootViewController" bundle:nil];
    }
    
    return _aboutRootViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pushViewController:self.aboutRootViewController animated:YES];
}


@end
