//
//  HDTabBarController.m
//  haidaofm
//
//  Created by Bruce Yang on 9/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HDTabBarController.h"
#import "CCNSNotificationCenter.h"
#import "HDTabBarButton.h"
#import <QuartzCore/QuartzCore.h>

@interface HDTabBarController ()
@property (strong, nonatomic) HDTabBar *tabBarView;
@end

@implementation HDTabBarController
@synthesize tabBarView = _tabBarView;

- (HDTabBar *)tabBarView
{
    if (_tabBarView == nil) {
        HDTabBarButton *t1 = [[HDTabBarButton alloc] initWithIcon:[UIImage imageNamed:@"icon-tab-home.png"]withHightlightedIcon:[UIImage imageNamed:@"icon-tab-home-selected.png"]];
        HDTabBarButton *t2 = [[HDTabBarButton alloc] initWithIcon:[UIImage imageNamed:@"icon-tab-rec.png"]withHightlightedIcon:[UIImage imageNamed:@"icon-tab-rec-selected.png"]];
//        HDTabBarButton *t3 = [[HDTabBarButton alloc] initWithIcon:[UIImage imageNamed:@"icon-tab-pro.png"]withHightlightedIcon:[UIImage imageNamed:@"icon-tab-pro-selected.png"]];
        HDTabBarButton *t3 = [[HDTabBarButton alloc] initWithIcon:[UIImage imageNamed:@"icon-tab-fav.png"]withHightlightedIcon:[UIImage imageNamed:@"icon-tab-fav-selected.png"]];
        HDTabBarButton *t4 = [[HDTabBarButton alloc] initWithIcon:[UIImage imageNamed:@"icon-tab-more.png"]withHightlightedIcon:[UIImage imageNamed:@"icon-tab-more-selected.png"]];
        
        NSArray *items = [NSArray arrayWithObjects:t1, t2,t3, t4, nil];

        CGFloat screenHeight = [[[UIScreen screens] lastObject] bounds].size.height;
        _tabBarView = [[HDTabBar alloc]initWithItems:items];
        
        _tabBarView.frame = CGRectMake(0, screenHeight - 20.0f - TABBAR_HEIGHT, self.view.frame.size.width, TABBAR_HEIGHT);
        _tabBarView.delegate = self;
    }
    
    return _tabBarView;
}

- (void)hideTabBar
{
    [self hideExistingTabBar];
    self.tabBarView.hidden = YES;
}

- (void)showTabBar
{
    [self hideExistingTabBar];
    self.tabBarView.hidden = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    //todo..
    self.view.backgroundColor = [UIColor clearColor];

    [self hideExistingTabBar];
    
    //notification
    [NSNotificationCenter defaultCenterAddObserverCommon:self selector:@selector(hideTabBar) name:@"hideTabBar"];
    [NSNotificationCenter defaultCenterAddObserverCommon:self selector:@selector(showTabBar) name:@"showTabBar"];
    
    //tab
    [self.view addSubview:self.tabBarView];
    self.tabBarView.selectedIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)hideExistingTabBar
{
    self.tabBar.hidden = YES;
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)viewDidUnload
{
    [super viewDidUnload];

}

#pragma mark - HDTabbar delegate
- (void)switchViewController:(NSInteger)index
{
    if ([self.delegate tabBarController:self shouldSelectViewController:self.selectedViewController] ) {
        self.selectedIndex = index;
        [self.delegate tabBarController:self didSelectViewController:self.selectedViewController];
    }

}

@end
