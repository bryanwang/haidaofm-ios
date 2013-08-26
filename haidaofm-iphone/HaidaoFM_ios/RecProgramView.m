//
//  RecProgramView.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/24/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "RecProgramView.h"
#import "HDTitleLabel.h"
#import "HDAvatarImageView.h"
#import "NSString+QNImageURL.h"

@interface RecProgramView() <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet HDTitleLabel *programNameLabel;
@end

@implementation RecProgramView

@synthesize coverImageView, programNameLabel;
@synthesize program = _program;
@synthesize delegate = _delegate;

- (void)setProgram:(Program *)program
{
    if (![_program isEqualToProgram:program]) {
        _program = program;
        self.programNameLabel.text = program.title;
        [self.coverImageView setImageWithURL:[NSURL URLWithString: [program.coverPicURL imageUrlWithThumbnailType:@"5"]] placeholderImage:[UIImage imageNamed:REC_COVER_IMAGE_PLACEHOLDER]];
    }
}

- (void)coverImageTouched
{
    [self.delegate recommendedProgramSelected:self.program];
}

- (void)awakeFromNib
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTouched)];
    tap.delegate = self;
    self.coverImageView.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
