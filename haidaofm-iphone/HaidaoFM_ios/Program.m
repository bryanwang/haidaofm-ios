
//
//  ChannelInfo.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/22/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "Program.h"

@implementation Program
@synthesize ID = _ID;
@synthesize title = _title;
@synthesize subTitle = _subTitle;
@synthesize uploadAt = _uploadAt;
@synthesize coverPicURL = _coverPicURL;
@synthesize fileURL = _fileURL;
@synthesize authorID = _authorID;
@synthesize authorName = _authorName;

+ (NSArray *)parseProgramList:(NSArray *)programListData
{
    //NSLog(@"%@", programListData);
    NSMutableArray *programList = [[NSMutableArray alloc] initWithCapacity:programListData.count];

    [programListData enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [programList addObject:[[Program alloc] initWithData:obj]];
    }];
    return programList;
}

- (id)initWithData:(NSDictionary *)data
{
    self = [super init];
    if (self) {
        self.ID = [data objectForKey:@"uuid"];
        self.coverPicURL = [data objectForKey:@"coverPic"];
        self.title = [data objectForKey:@"title"];
        self.subTitle = [data objectForKey:@"subTitle"];
        self.uploadAt = [NSDate dateWithTimeIntervalSince1970:[[data valueForKey:@"uploadAt"] intValue]];
        self.fileURL = [data objectForKey:@"fileUrl"];
        self.favCount = [[data objectForKey:@"favCount"] integerValue];
        //author
        NSDictionary *author = [data objectForKey:@"author"];
        self.authorID = [author objectForKey:@"uuid"];
        self.authorName = [author objectForKey:@"nickname"];

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.ID = [aDecoder decodeObjectForKey:@"ID"];
        self.coverPicURL = [aDecoder decodeObjectForKey:@"coverPicURL"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.subTitle = [aDecoder decodeObjectForKey:@"subTitle"];
        self.uploadAt = [aDecoder decodeObjectForKey:@"uploadAt"];
        self.fileURL = [aDecoder decodeObjectForKey:@"fileURL"];
        self.favCount = [aDecoder decodeIntegerForKey: @"favCount"];
        self.authorID = [aDecoder decodeObjectForKey:@"authorID"];
        self.authorName = [aDecoder decodeObjectForKey:@"authorName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.ID forKey:@"ID"];
    [aCoder encodeObject:self.coverPicURL forKey:@"coverPicURL"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subTitle forKey:@"subTitle"];
    [aCoder encodeObject:self.uploadAt forKey:@"uploadAt"];
    [aCoder encodeObject:self.fileURL forKey:@"fileURL"];
    [aCoder encodeInteger:self.favCount forKey:@"favCount"];
    [aCoder encodeObject:self.authorID forKey:@"authorID"];
    [aCoder encodeObject:self.authorName forKey:@"authorName"];
}

- (BOOL)isEqualToProgram:(Program *)program
{
    return [self.ID isEqualToString:program.ID];
}

@end
