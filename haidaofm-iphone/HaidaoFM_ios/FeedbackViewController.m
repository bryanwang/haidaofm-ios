//
//  FeedbackViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 10/23/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "FeedbackViewController.h"
#import "UMFeedback.h"
#import "HDTextView.h"

@interface FeedbackViewController () <UMFeedbackDataDelegate>

@property (strong, nonatomic) IBOutlet HDTextView *textView;
@property (weak, nonatomic) IBOutlet HDTextField *nameTextField;

@end

@implementation FeedbackViewController

- (void)submit:(id)sender
{
    UMFeedback *umFeedback = [UMFeedback sharedInstance];
    [umFeedback setAppkey:UMENG_APPKEY delegate:self];
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:self.textView.text forKey:@"content"];
    [dictionary setObject:@"2" forKey:@"age_group"];
    [dictionary setObject:@"female" forKey:@"gender"];
    NSDictionary *remark = [NSDictionary dictionaryWithObject:self.nameTextField.text forKey:@"name"];
    [dictionary setObject:remark forKey:@"remark"];
    [umFeedback post:dictionary];
    
    [self.navigationController popViewControllerAnimated:YES];
    [[MTStatusBarOverlay sharedInstance] postImmediateFinishMessage:NSLocalizedString(@"feedback success", @"") duration:nDuration animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"feedback", @"");
    self.view.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self.textView.placeholder = NSLocalizedString(@"here you can leave your comments", @"");
    self.nameTextField.placeholder = NSLocalizedString(@"here you can leave your contact", @"");
    self.textView.textColor = CELL_SUBTITLE_COLOR;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
//    [self.textView becomeFirstResponder];
    
    [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"")  controlEvents:UIControlEventTouchUpInside target:self action:nil];
    [self addCustomRightBarButtonItem:NSLocalizedString(@"submit", @"") controlEvents:UIControlEventTouchUpInside target:self action:@selector(submit:)];
}

- (void)viewDidUnload {
    [self setTextView:nil];
    [self setNameTextField:nil];
    [super viewDidUnload];
}
@end
