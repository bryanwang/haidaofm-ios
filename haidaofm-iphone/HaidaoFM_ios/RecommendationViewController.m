//
//  RecommendationViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "RecommendationViewController.h"
#import "RecommendedProgramListViewController.h"

@interface RecommendationViewController ()
@property (nonatomic, strong) RecommendedProgramListViewController *recommendedProgramListViewController;
@end

@implementation RecommendationViewController
@synthesize recommendedProgramListViewController = _recommendedProgramListViewController;

- (RecommendedProgramListViewController *)recommendedProgramListViewController
{
    if (_recommendedProgramListViewController == nil) {
        _recommendedProgramListViewController = [[RecommendedProgramListViewController alloc]initWithNibName:@"RecommendedProgramListViewController" bundle:nil];
    }
    return _recommendedProgramListViewController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self pushViewController:self.recommendedProgramListViewController animated:NO];
}

@end
