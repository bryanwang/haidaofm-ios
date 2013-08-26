//
//  ChannelViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ChannelView.h"
#import <QuartzCore/QuartzCore.h>
#import "HDTitleLabel.h"
#import "ProgramCell.h"
#import "NSDate+FormattedString.h"
#import "NSString+QNImageURL.h"
#import "HDAvatarImageView.h"

@interface ChannelView ()

@property (weak, nonatomic) IBOutlet HDAvatarImageView *DJPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *channelName;

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;

@property (weak, nonatomic) IBOutlet UILabel *programTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *programAuthorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *programUploadAtLabel;
@property (strong, nonatomic) IBOutlet UILabel *favCountLabel;

@end

@implementation ChannelView
@synthesize coverImageView, programUploadAtLabel, DJPhotoImageView;
@synthesize channelDetail = _channelDetail;

- (void)setChannelDetail:(ChannelDetail *)channelDetail
{
    if (![_channelDetail.channel.ID isEqual:channelDetail.channel.ID]) {
        _channelDetail = channelDetail;
        
        self.channelName.text = channelDetail.channel.title;
        self.programAuthorNameLabel.text = channelDetail.author.nickname;
//        self.DJPhotoImageView.imageURL = [NSURL URLWithString:[channelDetail.author.headerPicURL imageUrlWithThumbnailType:@"3"]];
//         self.coverImageView.imageURL = [NSURL URLWithString:[channelDetail.channel.coverPicURL imageUrlWithThumbnailType:@"2"]];
        [self.DJPhotoImageView setImageWithURL:[NSURL URLWithString:[channelDetail.author.headerPicURL imageUrlWithThumbnailType:@"3"]] placeholderImage:[UIImage imageNamed:DJ_AVATAR_PLACEHOLDER]];
        [self.coverImageView setImageWithURL:[NSURL URLWithString:[channelDetail.channel.coverPicURL imageUrlWithThumbnailType:@"2"]]];
        self.favCountLabel.text = [NSString stringWithFormat:@"%d", channelDetail.channel.favCount, nil];
    }
}


- (IBAction)tappedChannelCover:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(showProgramList:)]) {
        [self.delegate showProgramList:self.channelDetail];
    }
}
//
//- (IBAction)handleProgramButtonTapped:(id)sender
//{
//    if ([self.delegate respondsToSelector:@selector(playChannel:)]) {
//        [self.delegate playChannel:self.channelDetail.channel];
//    }
//}

- (void)awakeFromNib
{
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 4.0f;
    
//    self.programTitleLabel.textColor = CELL_TITLE_COLOR;
//    self.programUploadAtLabel.textColor = CELL_TIME_COLOR;

    self.coverImageView.userInteractionEnabled = YES;
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.coverImageView.clipsToBounds = YES;
}

@end
