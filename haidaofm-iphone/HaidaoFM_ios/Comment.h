//
//  Comment.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

- (id) initWithData:(NSDictionary *)data;
- (BOOL)isEqualToComment:(Comment *)comment;

@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *content;
@property (nonatomic) BOOL isFaved;
@property (nonatomic) NSString *authorName;
@property (strong, nonatomic) NSDate *createAt;

@end
