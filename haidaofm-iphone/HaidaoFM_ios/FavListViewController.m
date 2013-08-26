//
//  FavListViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/24/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "FavListViewController.h"
#import "ProgramFavCollectionsManager.h"
#import "ProgramCell.h"
#import "ProgramDownloadingCell.h"
#import "Program.h"
#import "PlayerViewController.h"

@interface FavListViewController () {
    NSInteger selectedSection;
    NSInteger selectedRow;
}

@property (nonatomic, strong) NSMutableArray *authors;
@property (nonatomic, strong) NSMutableArray *programs;
@end

@implementation FavListViewController
@synthesize programs = _programs;

- (NSMutableArray *)authors
{
    if (_authors == nil) {
        _authors = [NSMutableArray array];
    }

    return _authors;
}

- (NSMutableArray *)programs
{
    if (_programs == nil) {
        _programs = [NSMutableArray array];
    }
    return _programs;
}

- (void)generateProgramsAndAuthors
{
    ProgramFavCollectionsManager *mananger = [ProgramFavCollectionsManager shareInstance];
    NSMutableArray *userDefaultFavedPrograms = [mananger.userDefaultFavCollections copy];
    
    NSString *author;
    NSArray *array;
    NSMutableArray *programs = [NSMutableArray array];
    self.authors = [userDefaultFavedPrograms valueForKeyPath:@"@distinctUnionOfObjects.self.authorName"];
    for (author in self.authors) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(authorName == %@)", author];
        array = [userDefaultFavedPrograms filteredArrayUsingPredicate:predicate];
        [programs addObject:array];
    }
    
    self.programs = programs;
}

- (void)updatePlayingIndex
{
    Program *programOnPlaying = [PlayerViewController sharedInstance].programOnPlaying;
    selectedSection = NSNotFound;
    selectedRow = NSNotFound;
    
    for (NSInteger i = 0; i<self.programs.count; i++) {
        NSArray *array = [self.programs objectAtIndex:i];
        for (NSInteger j=0; j<array.count; j++) {
            Program *program = [array objectAtIndex:j];
            if ([programOnPlaying isEqualToProgram:program]) {
                selectedSection = i;
                selectedRow = j;
                break;
            }
        }
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedRow = NSNotFound;
    selectedSection = NSNotFound;
    self.title = NSLocalizedString(@"My Fav", @"My Fav");
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(playingProgramChanged:) name:kPlayingProgramChanged object:nil];
    [self generateProgramsAndAuthors];
    [self updatePlayingIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, 28.0f)];
    customView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-section.png"]];
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, 0.0f, tableView.bounds.size.width - 20.0f, 28.0f)];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:12];
	headerLabel.text = [NSString stringWithFormat:@"DJ: %@", [self.authors objectAtIndex:section], nil];
    
	[customView addSubview:headerLabel];
	
	return customView;
}

- (float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.authors.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [self.programs objectAtIndex:section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSArray *programs = [self.programs objectAtIndex:section];
    Program *program = (Program *)[programs objectAtIndex:row];
    
    DownloadStatus status = [[ProgramDownloadManager shareInstance] checkProgramDownloadStatus:program];
    if (status == KDownloading) {
        ProgramDownloadingCell *cell = [self.tableView dequeueReusableCellWithIdentifier:
                                        @"Program Downloading Cell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ProgramDownloadingCell" owner:self options:nil].lastObject;
        }

        ProgramFile *programFile = [[ProgramDownloadManager shareInstance] fetchDownloadingProgramFileBy:program.ID];
        cell.file = programFile;
        
        return cell;
    }
    
    else  {
        ProgramCell *cell = [self.tableView dequeueReusableCellWithIdentifier: @"Program Cell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ProgramCell" owner:self options:nil].lastObject;
        }
        
        if (status == KDownloadCompleted) {
            [(UIImageView *)[cell viewWithTag:101] setAlpha:1.0f];
            [(UILabel *)[cell viewWithTag:102] setAlpha:1.0f];
        }
        
        cell.isPlaying = (indexPath.section == selectedSection) && (indexPath.row == selectedRow);
        cell.program = program;
        
        return cell;
    }
}


- (void)presentPlayerViewController
{
    HDCustomNavigationViewController *navigationViewController = [[HDCustomNavigationViewController alloc] initWithRootViewController:[PlayerViewController sharedInstance]];
    [self presentModalViewController:navigationViewController withPushDirection: kCATransitionFromRight];
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    selectedSection = indexPath.section;
    
    [self presentPlayerViewController];
    
    PlayerViewController *controller = [PlayerViewController sharedInstance];
    controller.playMode = kPlayModeCycle;
    controller.playedContentType = kPlayedContentIsAllPrograms;
    
    NSMutableArray *programList = [NSMutableArray array];
    for (NSArray *items in self.programs) {
        [programList addObjectsFromArray: items];
    }
    
    NSInteger index = 0;
    for (NSInteger i = 0; i< selectedSection; i ++) {
        index = index + ((NSArray *)[self.programs objectAtIndex:i]).count;
    }
    index = index + selectedRow;
    [controller playPrograms:programList startFromIndex:index];
}

#pragma mark - PlayerViewControllerDelegate
- (void)playingProgramChanged:(NSDictionary *)program
{
    [self updatePlayingIndex];
}

@end
