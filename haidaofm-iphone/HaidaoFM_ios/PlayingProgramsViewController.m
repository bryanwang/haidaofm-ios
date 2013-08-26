//
//  PlayingProgramsViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 10/26/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "PlayingProgramsViewController.h"
#import "PlayerViewController.h"
#import "ProgramCell.h"

@interface PlayingProgramsViewController ()

@end

@implementation PlayingProgramsViewController

- (IBAction)dismiss:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"playing list", @"");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addCustomRightBarButtonItem:NSLocalizedString(@"close", @"") controlEvents:UIControlEventTouchUpInside target:self action:@selector(dismiss:)];
    
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRowIndex = indexPath.row;
    [self.tableView reloadData];

    PlayerViewController *player = [PlayerViewController sharedInstance];
    [player playPrograms:self.programList startFromIndex:self.selectedRowIndex];
    [self dismiss:nil];
}

@end
