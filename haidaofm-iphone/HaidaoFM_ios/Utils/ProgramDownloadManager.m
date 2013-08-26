//
//  ProgramDownloadManager.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/28/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "ProgramDownloadManager.h"
#import "AFDownloadRequestOperation.h"
#import "ProgramFavCollectionsManager.h"

@implementation ProgramFile
@synthesize program = _program;

- (id)initWithProgram:(Program *)program
{
    self = [super init];
    if (self) {
        self.program = program;
    }
    
    return self;
}


- (id)initWithProgram:(Program *)program setProgressBlock:(DownloadProgressCallback)callback1 andFiniedBlock: (DownloadFiniedCallback)callback2 andCanceledBlock:(DownloadCancelback)callback3
{
    self = [super init];
    if (self) {
        self.program = program;
        self.progressCallback = callback1;
        self.downloadFiniedback = callback2;
        self.downloadCanceledCallback = callback3;
    }
    
    return self;
}


@end

@implementation ProgramDownloadManager
@synthesize downloadingList = _downloadingList;
@synthesize downloadedList = _downloadedList;


+ (ProgramDownloadManager *)shareInstance
{
    static ProgramDownloadManager* sharedInstance = nil;
    static dispatch_once_t onceToken =0;
    dispatch_once(&onceToken,^{
        sharedInstance =[[ProgramDownloadManager alloc] init];
    });
    return sharedInstance;
}

- (NSMutableArray *)downloadingList
{
    if (_downloadingList == nil) {
        _downloadingList = [NSMutableArray array];
    }
    return _downloadingList;
}

- (NSMutableArray *)downloadedList
{
    if (_downloadedList == nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableArray *downloadedList = [defaults objectForKey:USERDEFAULT_DOWNLOADED_COLLECTIIONS];
        if (downloadedList == nil) {
            downloadedList = [NSMutableArray array];
        }
        _downloadedList = downloadedList;
    }
    
    return _downloadedList;
}

- (void)setDownloadedList:(NSMutableArray *)downloadedList
{
    _downloadedList = downloadedList;
        
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:downloadedList forKey:USERDEFAULT_DOWNLOADED_COLLECTIIONS];
    [defaults synchronize];
}

- (ProgramFile *)beginDownloadProgram:(Program *)aProgram
{
    ProgramFile *file = [[ProgramFile alloc]initWithProgram:aProgram];
    //download
    NSString *urlStr = aProgram.fileURL;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:3600];
    NSString *fileUrl = [DOCUMENTSDIRETORY stringByAppendingPathComponent: [[file.program.fileURL componentsSeparatedByString:@"/"] lastObject]];
    
    AFDownloadRequestOperation *operation = [[AFDownloadRequestOperation alloc] initWithRequest:request targetPath:fileUrl shouldResume:YES];
    operation.shouldOverwrite = YES;
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        //下载完成 将ID 加入USERDEFAULT
        NSMutableArray *downloadedList = self.downloadedList;
        [downloadedList addObject:file.program.ID];
        self.downloadedList = downloadedList;
        
        //修改收藏列表中 对应节目的 播放地址
        [[ProgramFavCollectionsManager shareInstance]  updateProgramFileUrl:file.program.ID];
        
        //删除 正在下载
        [self.downloadingList removeObject:file];
        
        if (file.downloadFiniedback)
            file.downloadFiniedback();
        
        [[MTStatusBarOverlay sharedInstance] postFinishMessage:NSLocalizedString(@"download successful", @"") duration:2.0f animated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //删除 正在下载
        [self.downloadingList removeObject:file];

        if (file.downloadCanceledCallback)
            file.downloadCanceledCallback();
        
         [[MTStatusBarOverlay sharedInstance] postErrorMessage:NSLocalizedString(@"download failed", @"") duration:2.0f animated:YES];
    }];
    
    [operation setProgressiveDownloadProgressBlock:^(NSInteger bytesRead, long long totalBytesRead, long long totalBytesExpected, long long totalBytesReadForFile, long long totalBytesExpectedToReadForFile) {
        float percentDone = totalBytesReadForFile/(float)totalBytesExpectedToReadForFile;
        
        NSString *curSize = [NSString stringWithFormat:@"%.2lfm",(float)totalBytesReadForFile/1024/1024];
        NSString *totalSize = [NSString stringWithFormat:@"%.2lfm",(float)totalBytesExpectedToReadForFile/1024/1024];
        if (file.progressCallback) 
                file.progressCallback(curSize, totalSize, percentDone);
    }];
    
    [operation start];
    
    //开始下载 将program 加入 downloadingList
    [self.downloadingList addObject:file];
    [[MTStatusBarOverlay sharedInstance] postMessage:NSLocalizedString(@"start to download", "") duration:2.0f animated:YES];
    
    return file;
}

- (ProgramFile *)cancelDownloadProgram:(Program *)aProgram
{
    return nil;
}

- (DownloadStatus)checkProgramDownloadStatus:(Program *)aProgram
{
    NSMutableArray *downloadedList = self.downloadedList;
    NSMutableArray *downloadingList = self.downloadingList;
    
    if (downloadedList.count > 0){
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"(SELF == %@)", aProgram.ID];
        NSArray *discardedItems1 = [downloadedList filteredArrayUsingPredicate:predicate1];
        if (discardedItems1.count > 0)
            return KDownloadCompleted;
    }
    if (downloadingList.count > 0) {
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"(program.ID == %@)", aProgram.ID];
        NSArray *discardedItems2 = [downloadingList filteredArrayUsingPredicate:predicate2];
        if (discardedItems2.count > 0)
            return KDownloading;
    }
    
    return kDownloadDefault;
}

- (ProgramFile *)fetchDownloadingProgramFileBy: (NSString *)programID {
    NSMutableArray *downloadingList = self.downloadingList;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(program.ID == %@)", programID];
    NSArray *discardedItems = [downloadingList filteredArrayUsingPredicate:predicate];
    if (discardedItems.count == 0)
        return nil;
    else
        return discardedItems.lastObject;
}

@end
