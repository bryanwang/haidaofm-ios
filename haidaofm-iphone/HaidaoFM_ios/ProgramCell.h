//
//  ProgramCell.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@interface ProgramCell : HDCell

@property (strong, nonatomic) Program *program;
@property (nonatomic) BOOL isPlaying;

+ (void)rearrangeLabels:(NSArray *)labels forText:(NSString *)text forCellHeight:(CGFloat)CellHeight;

@end
