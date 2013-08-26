//
//  ProgramFavCollectionsManager.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/27/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"

typedef enum FavStatus
{
    KHasNotAddToCollections,
    KHasAddToCollections,
} FavStatus;

typedef void (^AddToFavCollectionsSuccCallBack)();

@interface ProgramFavCollectionsManager : NSObject
@property (nonatomic, readonly) NSMutableArray *userDefaultFavCollections;

- (FavStatus)checkPorgramHasAddToColletions: (Program *)aProgram;
- (void)addProgramToCollections:(Program *)aProgram WithSuccCallback:(AddToFavCollectionsSuccCallBack)callback;
- (void)removeProgramoFromCollections: (Program *)aProgram WithSuccCallback:(AddToFavCollectionsSuccCallBack)callback;
- (void)updateProgramFileUrl: (NSString *)programID;

+ (ProgramFavCollectionsManager *)shareInstance;

@end
