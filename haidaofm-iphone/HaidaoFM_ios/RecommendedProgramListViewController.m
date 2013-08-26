//
//  RecommenedProgramListViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/24/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "RecommendedProgramListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SpecialTopicView.h"
#import "RecProgramView.h"
#import "TopicProgramListViewController.h"
#import "PlayerViewController.h"
#import "Program.h"
#import "NetworkStatusManager.h"

@interface RecommendedProgramListViewController () <SpecialTopicViewDelegate, RecProgramViewDelegate, NetworkStatusRetryDelegate>

@property (nonatomic, strong) NSMutableArray *specialTopics;
@property (nonatomic, strong) Program *recommendedProgram;

@property (strong, nonatomic) RecProgramView *recProgramView;
@property (nonatomic, strong) UIView *tableHeaderView;
@end

@implementation RecommendedProgramListViewController
@synthesize specialTopics = _specialTopics;
@synthesize recommendedProgram = _recommendedProgram;
@synthesize recProgramView = _recProgramView;

- (RecProgramView *)recProgramView
{
    if (_recProgramView == nil) {
        _recProgramView = [[NSBundle mainBundle] loadNibNamed:@"RecProgramView" owner:self options:nil].lastObject;
        _recProgramView.frame = CGRectMake(SPACING, SPACING, _recProgramView.bounds.size.width, _recProgramView.bounds.size.height);
        _recProgramView.delegate = self;
    }
    return _recProgramView;
}

- (UIView *)tableHeaderView
{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.recProgramView.bounds.size.height + SPACING)];
        [_tableHeaderView addSubview:self.recProgramView];
    }
    return _tableHeaderView;
}

- (void)setRecommendedProgram:(Program *)recommendedProgram
{
    if (![_recommendedProgram isEqualToProgram:recommendedProgram]) {
        _recommendedProgram = recommendedProgram;
        self.recProgramView.program = self.recommendedProgram;
    }
}

- (void)setSpecialTopics:(NSMutableArray *)specialTopics
{
    if (![_specialTopics isEqualToArray:specialTopics]) {
        _specialTopics = specialTopics;
    }
}

- (void)fetchRecommendations
{
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   0, @"np",
                                   65535, @"ps",
                                   nil];
    
    [[HDHttpClient shareIntance] getPath:RECOMMANDATION_LIST_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];

        NSArray *recommdations = JSON;
        self.recommendedProgram = [[Program alloc] initWithData:[[recommdations objectAtIndex:0] objectForKey:@"program"]];
        self.specialTopics = [NSMutableArray array];
        for (NSInteger i = 1; i < recommdations.count; i++) {
            Program *program = [[Program alloc] initWithData:[[recommdations objectAtIndex:i] objectForKey:@"program"]];
            [self.specialTopics addObject:program];
        }
        self.tableView.tableHeaderView = self.tableHeaderView;
        [self.tableView reloadData];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addLeftLogoBarButtonItem];
    if (self.recommendedProgram == nil) {
        [self fetchRecommendations];
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

#pragma mark - Datasource delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TOPIC_VIEW_HEIGHT + SPACING;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (self.specialTopics.count + 1) / 2 ;
}

- (SpecialTopicView *)createTopicViewWith:(Program *)program
{
    SpecialTopicView *view = [[NSBundle mainBundle] loadNibNamed:@"SpecialTopicView" owner:self options:nil].lastObject;
    view.topic = program;
    view.delegate = self;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *indentifier = @"Topic Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    SpecialTopicView *leftTopicView = [self createTopicViewWith:[self.specialTopics objectAtIndex:indexPath.row * 2]];
    leftTopicView.frame = CGRectMake(SPACING, SPACING, leftTopicView.bounds.size.width, leftTopicView.bounds.size.height);
    [cell addSubview:leftTopicView];
    
    if ((indexPath.row + 1) * 2 <= self.specialTopics.count) {
        //right
        SpecialTopicView *rightTopicView = [self createTopicViewWith:[self.specialTopics objectAtIndex:indexPath.row * 2 + 1]];
        
        rightTopicView.frame = CGRectMake(SPACING * 2 + leftTopicView.bounds.size.width, SPACING, rightTopicView.bounds.size.width, rightTopicView.bounds.size.height);
        [cell addSubview:rightTopicView];
    } 

    return cell;
}


#pragma mark - topicview delegate
- (void)topicSelected:(Program *)topic
{
    [self recommendedProgramSelected:topic];
}

- (void)recommendedProgramSelected:(Program *)program
{    
    [self presentPlayerViewController];
    PlayerViewController *controller = [PlayerViewController sharedInstance];
    controller.playedContentType = kPlayedContentIsRecommendedProgram;
    controller.playMode = kPlayModeCycle;
    NSArray *programs = [[NSArray alloc] initWithObjects:program, nil];
    [controller playPrograms:programs startFromIndex:0];
}

#pragma mark - NetworkStatusRetryDelegate
- (void)retry
{
    [self fetchRecommendations];
}

@end
