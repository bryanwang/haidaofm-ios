//
//  ProgramViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ProgramViewController.h"
#import "AllProgramListViewController.h"

@interface ProgramViewController ()
@property (nonatomic, strong) AllProgramListViewController *allProgramListViewController;
@end

@implementation ProgramViewController
@synthesize allProgramListViewController = _allProgramListViewController;

- (AllProgramListViewController *)allProgramListViewController
{
    if (_allProgramListViewController == nil) {
        _allProgramListViewController = [[AllProgramListViewController alloc]initWithNibName:@"HDProgramListViewController" bundle:nil];
    }
    
    return _allProgramListViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self pushViewController:self.allProgramListViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
