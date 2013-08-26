//
//  Comment.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/25/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "Comment.h"

@implementation Comment
@synthesize ID, content, authorName, createAt, isFaved;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.content = [data objectForKey:@"content"];
        self.authorName = [data objectForKey:@"authorName"];
        self.createAt = [NSDate dateWithTimeIntervalSince1970:[[data valueForKey:@"createAt"] intValue]];
        self.isFaved = [[data     objectForKey:@"CreateAt"] boolValue];
    }
    return self;
}

- (BOOL)isEqualToComment:(Comment *)comment
{
    return [self.ID isEqualToString:comment.ID];
}

@end
