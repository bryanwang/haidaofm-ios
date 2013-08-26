//
//  HDProgramListViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "HDProgramListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CCNSNotificationCenter.h"

#import "ProgramCell.h"
#import "PlayerViewController.h"
#import "DJProfileViewController.h"


typedef void (^DataParser)(id);

@interface HDProgramListViewController () <UIGestureRecognizerDelegate>
@property (nonatomic) NSInteger pageNumber;
@property (nonatomic) NSInteger pageSize;
@property (strong, nonatomic) DataParser programListParser;
@property (strong, nonatomic) NSString *urlString;
@end

@implementation HDProgramListViewController
@synthesize programList = _programList;
@synthesize selectedRowIndex = _selectedRow;
@synthesize programListParser = _programListParser;
@synthesize urlString = _urlString;

- (void)updatePlayingIndex
{
    Program *programOnPlaying = [PlayerViewController sharedInstance].programOnPlaying;
    self.selectedRowIndex = NSNotFound;
    for (Program *item in self.programList){
        if ([programOnPlaying isEqualToProgram:item]) {
            self.selectedRowIndex = [self.programList indexOfObject:item];
            break;
        }
    }
    [self.tableView reloadData];
}


- (void)setProgramList:(NSArray *)programList
{
    if (![programList isEqualToArray:_programList]) {
        _programList = programList;
        [self updatePlayingIndex];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pageNumber = 0;
    self.pageSize = 20;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updatePlayingIndex];
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(playingProgramChanged:) name:kPlayingProgramChanged object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPlayingProgramChanged object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.tableView = nil;
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.programList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier = @"Program Cell";
    ProgramCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProgramCell" owner:self options:nil].lastObject;
    }
    
    cell.isPlaying = (indexPath.row == self.selectedRowIndex);
    
    cell.program = [self.programList objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PROGRAM_CELL_HEIGHT;
}


#pragma mark - tableView delgate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedRowIndex = indexPath.row;

    [self presentPlayerViewController];

    PlayerViewController *controller = [PlayerViewController sharedInstance];
    controller.playMode = kPlayModeCycle;
    controller.playedContentType = kPlayedContentIsAllPrograms;
    
    [controller playPrograms:self.programList startFromIndex:indexPath.row];
}


#pragma mark - PlayerViewControllerDelegate
- (void)playingProgramChanged:(NSDictionary *)program
{
    [self updatePlayingIndex];
}


@end
