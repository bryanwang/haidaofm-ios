//
//  ChannelInfo.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/22/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Program : NSObject <NSCoding>

+ (NSArray *)parseProgramList:(NSArray *)programListData;

- (id)initWithData:(NSDictionary *)data;

- (BOOL)isEqualToProgram:(Program *)program;

@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *coverPicURL;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subTitle;
@property (strong, nonatomic) NSDate *uploadAt;
@property (strong, nonatomic) NSString *fileURL;
@property (strong, nonatomic) NSString *authorID;
@property (strong, nonatomic) NSString *authorName;
@property (nonatomic) NSInteger favCount;

@end
