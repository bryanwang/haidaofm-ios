//
//  Channel.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/22/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "Channel.h"

@implementation Channel
@synthesize title = _title;
@synthesize ID = _ID;
@synthesize coverPicURL = _coverPicURL;
@synthesize favCount = _favCount;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.ID = [data objectForKey:@"uuid"];
        self.title = [data objectForKey:@"title"];
        self.coverPicURL = [data objectForKey:@"coverPic"];
        self.favCount = [[data objectForKey:@"favCount"] integerValue];
    }
    return self;
}

- (BOOL)isEqualToChannel:(Channel *)channel
{
    return [self.ID isEqualToString:channel.ID];
}
@end

@implementation ChannelDetail
@synthesize channel = _channel;
@synthesize author = _author;

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.channel = [[Channel alloc] initWithData:[data objectForKey:@"channel"]];
        self.author = [[User alloc] initWithData:[data objectForKey:@"user"]];
    }
    return self;
}

- (BOOL)isEqualToChannelDetail:(ChannelDetail *)channelDetail
{
    return [self.channel isEqualToChannel:channelDetail.channel];
}
@end
