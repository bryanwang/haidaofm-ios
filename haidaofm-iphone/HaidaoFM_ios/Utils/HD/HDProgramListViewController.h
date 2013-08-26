//
//  HDProgramListViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDProgramListViewController : HDTableViewController

@property (nonatomic, strong) NSArray *programList;
@property NSInteger selectedRowIndex;


@end
