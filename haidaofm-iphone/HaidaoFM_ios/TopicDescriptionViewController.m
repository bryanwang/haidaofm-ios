//
//  TopicDescriptionViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "TopicDescriptionViewController.h"

@interface TopicDescriptionViewController ()
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end

@implementation TopicDescriptionViewController
@synthesize descriptionTextView;
@synthesize description = _description;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Topic description", @"");
    self.descriptionTextView.textColor = CELL_TITLE_COLOR;
    self.view.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"")  controlEvents:UIControlEventTouchUpInside target:self action:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDescriptionTextView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.descriptionTextView.text = self.description;
}
@end
