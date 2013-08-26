//
//  RecProgramView.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/24/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Program.h"

@protocol RecProgramViewDelegate <NSObject>

- (void)recommendedProgramSelected:(Program *)program;

@end

@interface RecProgramView : UIView
@property (strong, nonatomic) Program *program;
@property (strong, nonatomic) id <RecProgramViewDelegate> delegate;
@end
