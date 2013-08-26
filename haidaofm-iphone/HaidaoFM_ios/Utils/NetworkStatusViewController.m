//
//  NetworkErrorViewController.m
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-22.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

#import "NetworkStatusViewController.h"

@interface NetworkStatusViewController () 
@end

@implementation NetworkStatusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setErrorView:nil];
    [self setLoadingView:nil];
    [self setRetryTapGestureRecognizer:nil];
    [super viewDidUnload];
}

- (IBAction)tappedToRetry:(id)sender
{
    if (self.delegete != nil) {
        [self.delegete retry];
    }
}

- (void)changeToStatus:(HDNetworkStatusType)type
{
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    if (type == HDNetworkStatusError) {
        [self.view addSubview: self.errorView];
    } else if (type == HDNetworkStatusLoading) {
        [self.view addSubview: self.loadingView];
    }
}
@end
