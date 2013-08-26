//
//  TopicProgramListViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "TopicProgramListViewController.h"
#import "TopicDescriptionViewController.h"
#import "TopicHeaderView.h"

@interface TopicProgramListViewController () <TopicViewHeaderDelegate>
@property (nonatomic, strong) TopicHeaderView *tableHeaderView;
@end

@implementation TopicProgramListViewController
@synthesize topic = _topic;
@synthesize tableHeaderView = _tableHeaderView;

- (TopicHeaderView*)tableHeaderView
{
    if (_tableHeaderView == nil) {
        _tableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"TopicHeaderView" owner:self options:nil].lastObject ;
        _tableHeaderView.delegate = self;
    }
    return _tableHeaderView;
}

- (void)setTopic:(NSDictionary *)topic
{
    if (![_topic isEqualToDictionary:topic]) {
        _topic = topic;
        
        NSString *url = [NSString stringWithFormat:@"%@%@?puuid=%@&np=%d&ps=%d", BASE_URL, SUBJECT_PROGRAM_LIST_INTERFACE, [self.topic objectForKey:@"uuid"], 0, 65535];
        
        
        [self setDataSourceURLString:url withCallback:^(id result) {
            self.tableHeaderView.topic = topic;
            self.tableView.tableHeaderView = self.tableHeaderView;
            self.programList = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingMutableContainers error:nil];
        }];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Topic", @"");
    
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
                            
#pragma mark - TopicHeaderViewDelegate
- (void)showTopicDescription:(NSString *)description
{
    TopicDescriptionViewController *controller = [[TopicDescriptionViewController alloc] initWithNibName:@"TopicDescriptionViewController" bundle:nil];
    controller.description = description;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
