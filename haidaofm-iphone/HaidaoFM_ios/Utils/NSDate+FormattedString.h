//
//  NSDate+FormattedString.h
//  ezdesk
//
//  Created by 杨裕欣 on 12-2-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSDate(DateFormattedStrUtil)

- (NSString*) ToFullDate;
- (NSString*) ToFullDateTime;
- (NSString*) ToFullTime;
- (NSString*) ToShortDate;
- (NSString*) ToShortDateTime;
- (NSString*) ToShortTime;
- (NSString*) ToNiceTime;

@end