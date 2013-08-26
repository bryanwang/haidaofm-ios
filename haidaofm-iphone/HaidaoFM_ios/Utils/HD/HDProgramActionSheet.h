//
//  HDProgramActionSheet.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@interface DimView : UIView
@property(nonatomic, strong) UIView *parentView;
- (id)initWithParent:(UIView *) aParentView;
@end


typedef void (^HideCallback)();

@interface HDProgramActionSheet : UIView 
@property (nonatomic, strong) Program *program;
@property (nonatomic, strong) DimView *dimView;
@property (nonatomic, strong) HideCallback callback;

- (void) hidePanel;
- (void)showActionSheetForProgram: (Program *)aProgram InView:(UIView*) view;
+ (HDProgramActionSheet *)shareInstance;

@end
