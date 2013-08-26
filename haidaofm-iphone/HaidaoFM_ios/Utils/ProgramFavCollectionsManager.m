//
//  ProgramFavCollectionsManager.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/27/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "ProgramFavCollectionsManager.h"

@implementation ProgramFavCollectionsManager
@synthesize userDefaultFavCollections = _userDefaultFavCollections;

- (NSMutableArray *)userDefaultFavCollections
{
    NSMutableArray *array = [self fecthUserDefaultFavCollections];
    return array;
}


+ (ProgramFavCollectionsManager *) shareInstance
{
    static ProgramFavCollectionsManager* sharedInstance = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken,^{
        sharedInstance =[[ProgramFavCollectionsManager alloc] init];
    });
    return sharedInstance;
}

- (void)addProgramToCollections:(Program *)aProgram WithSuccCallback:(AddToFavCollectionsSuccCallBack)callback
{
    NSDictionary *user = [HDUserInfo fetchUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:aProgram.ID, @"program_id", [user objectForKey:@"uid"], @"uid", [NSNumber numberWithBool:YES], @"isFaved", nil];
    [[HDHttpClient shareIntance] postPath:FAV_UPDATE_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSInteger status = [[JSON objectForKey:@"status"] integerValue];
        if (status == 0) {
            NSMutableArray *collections = [self fecthUserDefaultFavCollections];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ID == %@)", aProgram.ID];
            NSArray *discardedItems = [collections filteredArrayUsingPredicate:predicate];
            if (discardedItems.count == 0) {
                [collections addObject:aProgram];
                [self syncProgramCollections:collections];
                
                callback();
                
                [[MTStatusBarOverlay sharedInstance]postFinishMessage:@"收藏成功!" duration:2.0f];
            }
        }
        else {
            [[MTStatusBarOverlay sharedInstance]postErrorMessage:@"收藏失败.." duration:2.0f];
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[MTStatusBarOverlay sharedInstance]postErrorMessage:@"收藏失败.." duration:2.0f];
    }];
}

- (void)removeProgramoFromCollections:(Program *)aProgram WithSuccCallback:(AddToFavCollectionsSuccCallBack)callback
{
    NSDictionary *user = [HDUserInfo fetchUserInfo];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:aProgram.ID, @"program_id", [user objectForKey:@"uid"], @"uid", [NSNumber numberWithBool:NO], @"isFaved", nil];
    [[HDHttpClient shareIntance] postPath:FAV_UPDATE_INTERFACE parameters:params success:^(AFHTTPRequestOperation *operation, id JSON) {
        NSInteger status = [[JSON objectForKey:@"status"] integerValue];
        if (status == 0) {
            NSMutableArray *collections = [self fecthUserDefaultFavCollections];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ID == %@)", aProgram.ID];
            NSArray *discardedItems = [collections filteredArrayUsingPredicate:predicate];
            if (discardedItems.count > 0) {
                [collections removeObjectsInArray:discardedItems];
                [self syncProgramCollections: collections];
                
                callback();
                
                [[MTStatusBarOverlay sharedInstance]postFinishMessage:@"取消收藏成功!" duration:2.0f];
            }
        }
        else {
            [[MTStatusBarOverlay sharedInstance]postErrorMessage:@"取消收藏失败.." duration:2.0f];
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[MTStatusBarOverlay sharedInstance]postErrorMessage:@"取消收藏失败.." duration:2.0f];
    }];
}

- (FavStatus)checkPorgramHasAddToColletions:(Program *)aProgram
{
    NSMutableArray *colletcions = [self fecthUserDefaultFavCollections];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ID == %@)", aProgram.ID];
    NSArray *discardedItems = [colletcions filteredArrayUsingPredicate:predicate];
    if (discardedItems.count > 0)
        return KHasAddToCollections;
    return KHasNotAddToCollections;
}


- (void)syncProgramCollections: (NSMutableArray *)collections
{
    Program *item;
    NSMutableArray *array = [NSMutableArray array];
    for (item in collections) {
        NSData *encodedItem = [NSKeyedArchiver archivedDataWithRootObject:item];
        [array addObject:encodedItem];
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:array forKey:USERDEFAULT_FAV_COLLECTIONS];
    [defaults synchronize];
}

- (NSMutableArray *)fecthUserDefaultFavCollections
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *collections = [defaults objectForKey:USERDEFAULT_FAV_COLLECTIONS];
    
    NSData *item;
    NSMutableArray *array = [NSMutableArray array];
    for (item in collections) {
        Program *decodedItem = (Program *)[NSKeyedUnarchiver unarchiveObjectWithData:item];
        [array addObject:decodedItem];
    }
    
    return array;
}

- (void)updateProgramFileUrl:(NSString *)programID
{
    NSMutableArray *collections = [self userDefaultFavCollections];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(ID == %@)", programID];
    NSArray *discardedItems = [collections filteredArrayUsingPredicate:predicate];
    if (discardedItems.count > 0) {
        for (Program *program in discardedItems) {
            NSString *fileUrl = [DOCUMENTSDIRETORY stringByAppendingPathComponent: [[program.fileURL componentsSeparatedByString:@"/"] lastObject]];
            
            program.fileURL = fileUrl;
        }
    }
    
    [self syncProgramCollections:collections];
}

@end
