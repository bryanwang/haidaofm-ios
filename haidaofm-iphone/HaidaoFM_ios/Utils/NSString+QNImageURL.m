//
//  NSString+QNImageURL.m
//  HaidaoFM_ios
//
//  Created by YANG Yuxin on 12-11-25.
//  Copyright (c) 2012年 HaidaoFM. All rights reserved.
//

#import "NSString+QNImageURL.h"

@implementation NSString(QNImageURL)
- (NSString *)imageUrlWithThumbnailType:(NSString *)thumbnailType
{
    return [NSString stringWithFormat:@"%@!%@", self, thumbnailType];
}
@end
