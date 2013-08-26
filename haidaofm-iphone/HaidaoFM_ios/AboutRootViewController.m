//
//  AboutRootViewController.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 10/23/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "AboutRootViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "FeedbackViewController.h"
#import "ProfileBasicCell.h"
#import "CCUIAlertView.h"


@interface AboutRootViewController () {
    UIAlertView *weiboAlert;
    UIAlertView *cacheAlert;
}
@property (strong, nonatomic)FeedbackViewController *feedbackViewController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation AboutRootViewController
@synthesize feedbackViewController = _feedbackViewController;

- (FeedbackViewController *)feedbackViewController
{
    if (_feedbackViewController == nil) {
        _feedbackViewController = [[FeedbackViewController alloc]initWithNibName:@"FeedbackViewController" bundle:nil];
    }
    return _feedbackViewController;
}

- (void)feedback
{
    [self.navigationController pushViewController:self.feedbackViewController animated:YES];
}

- (void)score
{
    [AppUtil redirectToAppStoreCommentsPage];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"more", @"");
    self.view.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    
    UIImageView *footer = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg-about"]];
    footer.frame = CGRectMake(0.f, 20.0f, footer.frame.size.width, footer.frame.size.height);
    self.tableView.tableFooterView = footer;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 20.0f;
    return 5.0f;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2)
        return 60.0f;
    return 5.0;
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(UIView*)tableView:(UITableView*)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 1;
    }
    else {
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Profile Cell";
    ProfileBasicCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"ProfileBasicCell" owner:self options:nil].lastObject;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0) {
                cell.tagNameLabel.text = NSLocalizedString(@"sina weibo", "");
                //判断用户是否登录
                if([HDUserInfo hasSignIn]) {
                    NSDictionary *userInfo = [HDUserInfo fetchUserInfo];
                    cell.tagValueLabel.text = [userInfo objectForKey:@"weibo_name"];
                }
            }
            break;
        case 1:
            cell.tagNameLabel.textColor = CELL_TITLE_COLOR;
            if(indexPath.row == 0) {
                cell.tagNameLabel.text = NSLocalizedString(@"clear cache", "");
            }
            break;
        case 2:
            cell.tagNameLabel.textColor = CELL_TITLE_COLOR;
            if(indexPath.row == 0) {
                cell.tagNameLabel.text = NSLocalizedString(@"feedback", "");
            }
            else if(indexPath.row == 1) {
                cell.tagNameLabel.text = NSLocalizedString(@"score", "");
            }
            break;
        default:
            break;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                if([HDUserInfo hasSignIn]) {
                    //cancel weibo bind
                    weiboAlert = [UIAlertView showAlertView:NSLocalizedString(@"cancel weibo count", @"") msg:NSLocalizedString(@"cancel weibo count?", @"") delegate:self okBtnTitle:NSLocalizedString(@"sure", @"")];
                }
                else {
                    //bind weibo
                    [HDUserInfo signInWithWeiboAccountBySuccessCallback:^() {
                        [self.tableView reloadData];
                    }];
                }
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                //clear cache
                cacheAlert = [UIAlertView showAlertView:NSLocalizedString(@"clear cache", "") msg:NSLocalizedString(@"clear cache?", @"") delegate:self okBtnTitle:NSLocalizedString(@"sure", @"")];
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                //feedback
                [self feedback];
            }
            else if (indexPath.row == 1) {
                //score
                [self score];
            }
            break;
        default:
            break;
    }    
}


#pragma alert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView isEqual:weiboAlert]) {
        if (buttonIndex == 1) {
            [HDUserInfo logOutCurrentUser];
            [self.tableView reloadData];
        }
    }
    else if ([alertView isEqual:cacheAlert]) {
        if (buttonIndex == 1) {
            [UIImageView clearAFImageCache];
        }
    }
}
@end
