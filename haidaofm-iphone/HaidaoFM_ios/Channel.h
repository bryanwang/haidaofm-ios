//
//  Channel.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/22/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Program.h"

@interface Channel : NSObject

- (id) initWithData:(NSDictionary *)data;
- (BOOL)isEqualToChannel:(Channel *)channel;

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *title;
//@property (strong, nonatomic) NSString *description;
@property (strong, nonatomic) NSString *coverPicURL;
@property (nonatomic) NSInteger favCount;
@end

@interface ChannelDetail : NSObject

- (id)initWithData:(NSDictionary *)data;
- (BOOL)isEqualToChannelDetail:(ChannelDetail *)channelDetail;

@property (strong, nonatomic) Channel *channel;
@property (strong, nonatomic) User *author;
@end
