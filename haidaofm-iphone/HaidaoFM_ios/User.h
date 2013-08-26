//
//  User.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 11/7/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

- (id)initWithData:(NSDictionary *)data;
- (BOOL)isEqualToUser:(User *)user;

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *profile;
@property (strong, nonatomic) NSString *headerPicURL;
@property (strong, nonatomic) NSString *email;
@property (strong, nonatomic) NSString *nickname;
@property (strong, nonatomic) NSString *userCode;
@property (strong, nonatomic) NSString *weiboAccount;
@end
