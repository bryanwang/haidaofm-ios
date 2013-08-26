//
//  DJProfileViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/21/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "DJProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UILabel+Size.h"
#import "NSString+QNImageURL.h"
#import "ProfileBasicCell.h"
#import "ProfileDesCell.h"
#import "HDAvatarImageView.h"


@interface DJProfileViewController ()
@property (strong, nonatomic) IBOutlet UILabel *DJNameLabel;
@property (strong, nonatomic) IBOutlet HDAvatarImageView *DJAvatarImageView;
@property (strong, nonatomic) IBOutlet UIImageView *DJCoverImageView;
@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) User *profile;
@property (nonatomic, strong) NSString *userid;
@end

@implementation DJProfileViewController
@synthesize userid = _userid;
@synthesize profile = _profile;


- (void)displayUserChannleCovers: (NSDictionary *)channelInfo
{
    [self.DJCoverImageView setImageWithURL:[NSURL URLWithString:[[channelInfo objectForKey:@"cover_pic"] imageUrlWithThumbnailType:@"2"]] placeholderImage:[UIImage imageNamed:COVER_IMAGE_PLACEHOLDER]];
}

- (void)setProfile:(User *)profile
{
    if (![_profile isEqualToUser:profile]) {
        _profile = profile;
        
        self.DJNameLabel.text = profile.nickname;
        [self.DJAvatarImageView setImageWithURL:[NSURL URLWithString:[profile.headerPicURL imageUrlWithThumbnailType:@"3"]] placeholderImage:[UIImage imageNamed:DJ_AVATAR_PLACEHOLDER]];

        [self.tableView reloadData];
    }
}

- (void)fetchProfileByUserId:(NSString *)UserId
{
    self.userid = UserId;
 
    [self fetchProfile];
}

- (void) fetchProfile
{
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:self.userid forKey:@"uid"];
    [[HDHttpClient shareIntance] getPath:USER_DETIAL_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];
        
        NSDictionary *userdetail = [JSON objectForKey:@"userdetail"];
        NSDictionary *channelInfo = [userdetail objectForKey:@"channel"];
        [self displayUserChannleCovers:channelInfo];
        self.profile = [[User alloc]initWithData:userdetail];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}


- (IBAction)dismiss:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"DJ Profile", @"DJ Profile");
    self.tableView.tableHeaderView = self.tableHeaderView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
   
    self.tableView.backgroundColor = [UIColor colorWithRed:227.0f/255.0f green:227.0f/255.0f blue:232.0f/255.0f alpha:1.0f];
    self.DJNameLabel.shadowColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f];
    
    if (self.viewMode == KPushMode)
        [self addCustomBackBarButtonItem:NSLocalizedString(@"back", @"")  controlEvents:UIControlEventTouchUpInside target:self action:nil];
    else
        [self addCustomRightBarButtonItem:NSLocalizedString(@"close", @"")  controlEvents:UIControlEventTouchUpInside target:self action:@selector(dismiss:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [self setTableHeaderView:nil];
    [self setDJCoverImageView:nil];
    [self setDJAvatarImageView:nil];
    [self setDJNameLabel:nil];
    [super viewDidUnload];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return nil;
    }
    
	UIView* customView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, tableView.bounds.size.width, 28.0f)];
    customView.backgroundColor = [UIColor clearColor];
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20.0f, 0.0f, tableView.bounds.size.width - 40.0f, 28.0f)];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = CELL_TITLE_COLOR;
	headerLabel.font = [UIFont boldSystemFontOfSize:14];
	
    if (section == 1){
        headerLabel.text = NSLocalizedString(@"SNS", @"SNS");
    }
    else {
        headerLabel.text = NSLocalizedString(@"DJ Profile", @"DJ Profile");
    }
    
	[customView addSubview:headerLabel];
	
	return customView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 28.0f;
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
        return 2;
    }
    else {
        return 1;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        if (indexPath.section == 2) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ProfileDesCell" owner:self options:nil].lastObject;
        }
        else {
            cell = [[NSBundle mainBundle]loadNibNamed:@"ProfileBasicCell" owner:self options:nil].lastObject;
            [cell setHeight:44.0f];
        }
    }
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                ((ProfileBasicCell *)cell).tagNameLabel.text = NSLocalizedString(@"DJ Num", @"DJ Num");
                ((ProfileBasicCell *)cell).tagValueLabel.text = self.profile.userCode;
            }
            break;
            
        case 1:
            if (indexPath.row == 0) {
                ((ProfileBasicCell *)cell).tagNameLabel.text = NSLocalizedString(@"DJ Email", @"DJ Email");
                ((ProfileBasicCell *)cell).tagValueLabel.text = self.profile.email;
                
            }
            else if (indexPath.row == 1) {
                ((ProfileBasicCell *)cell).tagNameLabel.text = NSLocalizedString(@"DJ Sina Weibo", @"DJ Sina Weibo");
                ((ProfileBasicCell *)cell).tagValueLabel.text = self.profile.weiboAccount;
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                [((ProfileDesCell *)cell) setDesAndCalCellSizeWithDes: self.profile.profile];
            }
            break;
        default:
            break;
    }
        
    return cell;
}

#pragma Networkmanager Delegate
- (void)retry
{
    [self fetchProfile];
}

@end
