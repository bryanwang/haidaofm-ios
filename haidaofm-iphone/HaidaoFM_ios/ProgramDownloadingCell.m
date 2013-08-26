//
//  ProgramDownloadingCell.m
//  HaidaoFM_ios
//
//  Created by Bruce Yang on 1/29/13.
//  Copyright (c) 2013 HaidaoFM. All rights reserved.
//

#import "ProgramDownloadingCell.h"
#import "HDProgressView.h"
#import "HDProgramActionSheet.h"

@interface ProgramDownloadingCell()
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet HDProgressView *progress;
@property (strong, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation ProgramDownloadingCell
@synthesize title = _title;
@synthesize file = _file;

- (void)setFile:(ProgramFile *)file
{
    if (![_file isEqual:file]) {
        _file = file;
        Program *program = file.program;
        self.title.text = program.title;
        self.progress.progress = 0.0f;
        
        file.progressCallback = ^(NSString *curSize, NSString *totalSize, float percentDone ) {
            self.progress.progress = percentDone;
            self.sizeLabel.text = [NSString stringWithFormat:@"%@/%@", curSize, totalSize, nil];
        };
        
        file.downloadFiniedback = ^() {
            [((UITableView *)self.superview) reloadData];
        };
    }
}

- (IBAction)showProgramActionSheet:(id)sender {
    UIViewController *c = [[UIApplication sharedApplication] keyWindow].rootViewController;
    HDProgramActionSheet *actionSheet = [HDProgramActionSheet shareInstance];
    actionSheet.callback = ^(void) {
        [((UITableView *)self.superview) reloadData];
    };
    [actionSheet showActionSheetForProgram:self.file.program InView:c.view];
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.title.textColor = CELL_TITLE_COLOR;
    self.title.highlightedTextColor = CELL_TITLE_SELECTED_COLOR;
    self.sizeLabel.textColor = CELL_TIME_COLOR;
    self.sizeLabel.highlightedTextColor = CELL_TITLE_COLOR;
    
    CGSize shadowOffset = CGSizeMake(0, 1);
    UIColor *shadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.75f];
    
    self.title.shadowOffset = shadowOffset;
    self.title.shadowColor = shadowColor;
}

@end
