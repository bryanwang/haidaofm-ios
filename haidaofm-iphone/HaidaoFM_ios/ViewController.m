//
//  ViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ViewController.h"
#import "HDTabBarController.h"
#import "NetworkStatusViewController.h"
#import "NetworkStatusManager.h"

@interface ViewController () <UITabBarControllerDelegate>
@property (strong, nonatomic) IBOutlet HDTabBarController *tabBarController;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tabBarController.view];
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
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NetworkStatusManager *manager = [NetworkStatusManager sharedInstance];
    if (manager.operation != nil) {
        [manager.operation cancel];
        manager.operation = nil;
    }
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}


@end
