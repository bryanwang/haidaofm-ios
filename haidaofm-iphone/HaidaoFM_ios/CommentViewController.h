//
//  CommentViewController.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetworkStatusManager.h"

@interface CommentViewController: UIViewController
<UITableViewDataSource, UITableViewDelegate, NetworkStatusRetryDelegate>

@property (nonatomic, strong)NSString *programID;

- (void)fecthProgramCommentsByProgramID: (NSString *)programID;

@end
