//
//  ProgramInfo.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/22/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgramInfo : NSObject
- (void)initWithDictionary:(NSDictionary *)programInfo;

@property (nonatomic, strong) NSString *Id;
@end
