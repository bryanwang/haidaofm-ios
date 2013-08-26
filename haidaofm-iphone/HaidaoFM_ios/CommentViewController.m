//
//  CommentViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCell.h"
#import "Comment.h"
#import <ShareSDK/ShareSDK.h>

@interface CommentViewController ()

@property (strong, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITextField *commentField;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableview;

@property (strong, nonatomic) NSMutableArray *comments;

@end

@implementation CommentViewController
@synthesize programID = _programID;
@synthesize comments = _comments;

- (void)setComments:(NSMutableArray *)comments
{
    if (![_comments isEqualToArray:comments]) {
        _comments = comments;
        [self.tableview reloadData];
    }
}

- (NSMutableArray *)comments
{
    if (_comments == nil) {
        _comments = [NSMutableArray array];
    }
    return _comments;
}

- (IBAction)submitComment:(id)sender
{
    if (self.commentField.text.length > 0)
    {
        if([HDUserInfo hasSignIn]) {
            [self comment];
        }
        else {
            [HDUserInfo signInWithWeiboAccountBySuccessCallback:^(){
                [self comment];
            }];
        }
    }
}

- (void)comment
{
    [[MTStatusBarOverlay sharedInstance] postMessage:@"提交中.." duration:2.0f];
    
    NSString *content = self.commentField.text;
    NSString *uid = [[HDUserInfo fetchUserInfo] objectForKey:@"uid"];
    NSString *programID = self.programID;
    NSDictionary *params = @{@"uid": uid, @"content": content, @"programId": programID};
    
    [[HDHttpClient shareIntance] postPath:COMMENT_INTERFACE parameters: params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSInteger status = [[JSON objectForKey:@"status"] integerValue];
        if (status == 0) {
            [[MTStatusBarOverlay sharedInstance] postFinishMessage:@"评论成功!" duration:2.0f];
            //todo: 刷新评论列表 类似于WEICO            
            [self fecthComments];
        }
        else {
            [[MTStatusBarOverlay sharedInstance] postErrorMessage:@"评论失败.." duration:2.0f];
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[MTStatusBarOverlay sharedInstance] postErrorMessage:@"评论失败.." duration:2.0f];
    }];
    
    [self.commentField resignFirstResponder];
}

- (void)fecthProgramCommentsByProgramID:(NSString *)programID
{
    self.programID = programID;
    [self fecthComments];
}


- (void)fecthComments
{
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:self.programID, @"programId", [NSNumber numberWithInt:0], @"np", [NSNumber numberWithInt:65535], @"ns", nil];
    [[HDHttpClient shareIntance] getPath:COMMENT_LIST_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];
        
        self.comments = [JSON objectForKey:@"comment_list"];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}


- (void)registerForKeyboardNotifications
{
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NSNotificationCenter defaultCenterAddObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    #ifdef __IPHONE_5_0
//    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (version >= 5.0) {
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillChangeFrameNotification object:nil];
//    }
//    #endif
}

- (void) keyboardWillShow:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25f];
	CGRect frame = self.toolbar.frame;
    frame.origin.y = frame.origin.y - keyboardSize.height;
    self.toolbar.frame = frame;
	[UIView commitAnimations];
}

- (void) keyboardWillHide:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.25f];
	CGRect frame = self.toolbar.frame;
    frame.origin.y = frame.origin.y + keyboardSize.height;
    self.toolbar.frame = frame;
	[UIView commitAnimations];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"comment", @"comment");
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg-view.png"]];
    [self registerForKeyboardNotifications];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"")  controlEvents:UIControlEventTouchUpInside target:self action:nil];
    [self fecthComments];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.commentField resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%d", [self.comments count]);
    return [self.comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Comment Cell";
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil] lastObject];
    }
    
    cell.comment = [self.comments objectAtIndex:indexPath.row];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setToolbar:nil];
    [self setCommentField:nil];
    [self setSubmitBtn:nil];
    [self setTableview:nil];
    [super viewDidUnload];
}

#pragma Network delegate
- (void)retry
{
    [self fecthComments];
}

@end
