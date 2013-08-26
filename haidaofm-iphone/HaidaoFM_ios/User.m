//
//  User.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 11/7/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "User.h"

@implementation User
@synthesize ID = _ID;
@synthesize headerPicURL = _headerPicURL;
@synthesize profile = _profile;
@synthesize email = _email;
@synthesize nickname = _nickname;
@synthesize userCode = _userCode;
@synthesize weiboAccount = _weiboAccount;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.ID = [data objectForKey:@"uuid"];
        self.nickname = [data objectForKey:@"nickname"];
        self.headerPicURL = [data objectForKey:@"coverPic"];
        self.profile = [data objectForKey:@"profile"];
        self.email = [data objectForKey:@"email"];
        self.userCode = [data objectForKey:@"userCode"];
        self.weiboAccount = [data objectForKey:@"weiboAccount"];
    }
    
    return self;
}

- (BOOL)isEqualToUser:(User *)user
{
    return [self.ID isEqualToString:user.ID];
}

@end
