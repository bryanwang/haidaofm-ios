//
//  ProgramDownloadManager.h
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/28/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Program.h"

typedef enum DownloadStatus
{
    kDownloadDefault,
    KDownloading,
    KDownloadCompleted,
    KDownError
} DownloadStatus;


typedef void (^DownloadProgressCallback)(NSString *curSize, NSString *totalSize, float percentDone);
typedef void (^DownloadFiniedCallback)();
typedef void (^DownloadCancelback)();


@interface ProgramFile : NSObject

@property (nonatomic, strong) Program *program;
@property (nonatomic, strong) DownloadProgressCallback progressCallback;
@property (nonatomic, strong) DownloadFiniedCallback downloadFiniedback;
@property (nonatomic, strong) DownloadCancelback downloadCanceledCallback;

- (id)initWithProgram: (Program *)program;

@end


@interface ProgramDownloadManager : NSObject

@property (nonatomic, strong) NSMutableArray *downloadingList;
@property (nonatomic, strong) NSMutableArray *downloadedList;

+ (ProgramDownloadManager *)shareInstance;
- (ProgramFile *)beginDownloadProgram: (Program *)aProgram;
- (ProgramFile *)cancelDownloadProgram: (Program *)aProgram;
- (DownloadStatus)checkProgramDownloadStatus: (Program *)aProgram;
- (ProgramFile *)fetchDownloadingProgramFileBy: (NSString *)programID;

@end
