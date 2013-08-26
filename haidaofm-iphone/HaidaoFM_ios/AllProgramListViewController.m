//
//  AllProgramListViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 10/23/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "AllProgramListViewController.h"
#import "ProgramCell.h"
#import "PlayerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NetworkStatusManager.h"

@interface AllProgramListViewController () <NetworkStatusRetryDelegate>
@end

@implementation AllProgramListViewController

- (void)fetchProgramList
{
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];
    
    [[HDHttpClient shareIntance] getPath:PROGRAM_LIST_INTERFACE parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];
        
        NSDictionary *programPageList = [JSON objectForKey:@"programPageList"];
        self.programList = [Program parseProgramList:[programPageList objectForKey:@"programList"]];    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}

#pragma mark -- NetworkStatusRetryDelegate
- (void)retry
{
    [self fetchProgramList];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addLeftLogoBarButtonItem];
    if (self.programList == nil) {
        [self fetchProgramList];
    }
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
