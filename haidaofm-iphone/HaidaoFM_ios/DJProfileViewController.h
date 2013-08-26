//
//  DJProfileViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/21/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "NetworkStatusManager.h"
@interface DJProfileViewController : HDViewController <UITableViewDataSource, UITableViewDelegate, NetworkStatusRetryDelegate>

typedef enum _ViewMode
{
    KPushMode,
    KPresentMode
} ViewMode;

@property (nonatomic) ViewMode viewMode;

- (void)fetchProfileByUserId: (NSString *)UserId;

@end
