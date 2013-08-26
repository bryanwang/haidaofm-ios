//
//  SpecialTopicView.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/24/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "SpecialTopicView.h"
#import <QuartzCore/QuartzCore.h>
#import "VerticallyAlignedLabel.h"
#import "NSString+QNImageURL.h"

@interface SpecialTopicView() <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet VerticallyAlignedLabel *titleLabel;

@end

@implementation SpecialTopicView
@synthesize titleLabel, coverImageView;
@synthesize topic = _topic;
@synthesize delegate = _delegate;

// TODO: rewrite this class, and treat it as Recommended Program

- (void)setTopic:(Program *)topic
{
    if (![_topic isEqualToProgram:topic]) {
        _topic = topic;
        [self.coverImageView setImageWithURL:[NSURL URLWithString:[topic.coverPicURL imageUrlWithThumbnailType:@"4"]] placeholderImage:[UIImage imageNamed:SPE_REC_COVER_IMAGE_PLACEHOLDER]];
        self.titleLabel.text = topic.title;
    }
}

- (void)coverImageTouched
{
    [self.delegate topicSelected:self.topic];
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 4.0f;
    self.titleLabel.verticalAlignment = VerticalAlignmentTop;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverImageTouched)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
}

@end
