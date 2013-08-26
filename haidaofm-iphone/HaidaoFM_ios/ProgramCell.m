//
//  ProgramCell.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ProgramCell.h"
#import "NSDate+FormattedString.h"
#import "NSString+QNImageURL.h"
#import "HDProgramActionSheet.h"


@interface ProgramCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *uploadAtLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorNameLabel;
@property (strong, nonatomic) IBOutlet UIView *statusView;


@property (strong, nonatomic) IBOutlet UILabel *favCountLabel;

@end

@implementation ProgramCell
@synthesize program = _program;
@synthesize isPlaying = _isPlaying;

@synthesize titleLabel, uploadAtLabel, authorNameLabel, statusView;

+ (void)rearrangeLabels:(NSArray *)labels forText:(NSString *)text forCellHeight:(CGFloat)CellHeight
{
//    assert(labels.count == 2);
    UILabel *titleLabel = [labels objectAtIndex:0];
    UILabel *uploadAtLabel = [labels objectAtIndex:1];
    
//    assert(titleLabel.numberOfLines <= 2);
    CGSize contraintSize = titleLabel.frame.size;
    if (titleLabel.numberOfLines == 2) contraintSize.height /= 2;
    contraintSize.width = 9999;
    
    CGSize titleSize = [text sizeWithFont:titleLabel.font constrainedToSize:contraintSize lineBreakMode:titleLabel.lineBreakMode];
    
    if (titleSize.width > titleLabel.frame.size.width && titleLabel.numberOfLines == 1) {
        // make two row title
        CGRect frame = titleLabel.frame;
        
        frame.size.height = contraintSize.height * 2;
        frame.origin.y = (CellHeight - (frame.size.height + uploadAtLabel.frame.size.height)) / 2;
        
        titleLabel.frame = frame;
        titleLabel.numberOfLines = 2;
        
        frame = uploadAtLabel.frame;
        frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height;
        uploadAtLabel.frame = frame;
    }
    else if (titleSize.width < titleLabel.frame.size.width && titleLabel.numberOfLines == 2) {
        // make one row title
        CGRect frame = titleLabel.frame;
        frame.size.height = contraintSize.height;
        frame.origin.y = (CellHeight - (frame.size.height + uploadAtLabel.frame.size.height)) / 2;
        
        titleLabel.frame = frame;
        titleLabel.numberOfLines = 1;
        
        frame = uploadAtLabel.frame;
        frame.origin.y = titleLabel.frame.origin.y + titleLabel.frame.size.height;
        uploadAtLabel.frame = frame;
    }
}

- (void)setIsPlaying:(BOOL)isPlaying
{
    if (_isPlaying != isPlaying) {
        _isPlaying = isPlaying;
        if (isPlaying) {
            self.statusView.backgroundColor = [UIColor colorWithRed:215.0f/255.0f green:42.0f/255.0f blue:28.0f/255.0f alpha:1.0f];
        }
        else {
            self.statusView.backgroundColor = [UIColor clearColor];
        }
    }
}

- (void)setProgram:(Program *)program
{
    if (![_program isEqual:program]) {
        _program = program;
        
        [ProgramCell rearrangeLabels:@[self.titleLabel, self.uploadAtLabel] forText:program.title forCellHeight:PROGRAM_CELL_HEIGHT];
        self.titleLabel.text = program.title;
        self.authorNameLabel.text = program.subTitle;
        self.uploadAtLabel.text = [program.uploadAt ToFullDate];
        self.favCountLabel.text = [NSString stringWithFormat:@"%d", program.favCount, nil];
    }
}

- (IBAction)showPorgramActionSheet:(id)sender {
    UIViewController *c = [[UIApplication sharedApplication] keyWindow].rootViewController;
    HDProgramActionSheet *actionSheet = [HDProgramActionSheet shareInstance];
    actionSheet.callback = ^(void) {
        [((UITableView *)self.superview) reloadData];
    };
    [actionSheet showActionSheetForProgram:self.program InView:c.view];
}


- (void)awakeFromNib
{
    self.titleLabel.textColor = CELL_TITLE_COLOR;
    self.titleLabel.highlightedTextColor = CELL_TITLE_SELECTED_COLOR;
    self.favCountLabel.textColor = CELL_TIME_COLOR;
    self.favCountLabel.highlightedTextColor = CELL_TIME_COLOR;
    self.uploadAtLabel.textColor = CELL_TIME_COLOR;
    self.uploadAtLabel.highlightedTextColor = CELL_TIME_COLOR;

    CGSize shadowOffset = CGSizeMake(0, 1);
    UIColor *shadowColor = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:0.75f];
    self.titleLabel.shadowOffset = shadowOffset;
    self.titleLabel.shadowColor = shadowColor;
    self.uploadAtLabel.shadowColor = shadowColor;
    self.uploadAtLabel.shadowOffset = shadowOffset;
    self.favCountLabel.shadowColor = shadowColor;
    self.favCountLabel.shadowOffset = shadowOffset;
}


@end
