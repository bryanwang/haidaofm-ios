//
//  TopicListViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDProgramListViewController.h"
#import "Channel.h"

@interface ProgramListViewController : HDProgramListViewController

@property (nonatomic, strong) Channel *channel;

@property (strong, nonatomic) User *author;

@end
