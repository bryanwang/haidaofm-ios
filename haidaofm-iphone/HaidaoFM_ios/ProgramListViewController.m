//
//  ProgramListViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ProgramListViewController.h"
#import "ProgramCell.h"
#import "PlayerViewController.h"
#import "DJProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ChannelHeaderView.h"
#import "NetworkStatusManager.h"

@interface ProgramListViewController () <ChannelHeaderViewDelegate, NetworkStatusRetryDelegate>

@property (weak, nonatomic) ChannelHeaderView *tableHeaderView;

@end

@implementation ProgramListViewController

@synthesize channel = _channel;
@synthesize author = _author;

- (void)fetchChannelInfo
{
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];

    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.channel.ID forKey:@"puuid"];
    [[HDHttpClient shareIntance] getPath:PROGRAM_LIST_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];
        
        NSDictionary *programPageList = [JSON objectForKey:@"programPageList"];
        self.programList = [Program parseProgramList:[programPageList objectForKey:@"programList"]];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}

- (void)setChannel:(Channel *)channel
{
    if (![_channel isEqualToChannel:channel]) {
        _channel = channel;
    }
}

- (void)setAuthor:(User *)author
{
    if (![_author isEqualToUser:author]) {
        _author = author;
        self.tableHeaderView.author = author;
    }
}

- (ChannelHeaderView *)tableHeaderView
{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ChannelHeaderView" owner:self options:nil].lastObject;
        _tableHeaderView.delegate = self;
    }
    return _tableHeaderView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.channel.title;
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableHeaderView.channel = self.channel;
    [self fetchChannelInfo];
    [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"")  controlEvents:UIControlEventTouchUpInside target:self action:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableHeaderView = nil;
}

#pragma mark - ChannelHeaderViewDelegate
- (void)showChannelProfile:(User *)profile
{
    DJProfileViewController *controller = [[DJProfileViewController alloc] initWithNibName:@"DJProfileViewController" bundle:nil];
    [controller fetchProfileByUserId:profile.ID];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - NetworkStatusDelegate
- (void)retry
{
    [self fetchChannelInfo];
}

@end
