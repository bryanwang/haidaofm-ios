//
//  ChannelHeaderView.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ChannelHeaderView.h"
#import "HDTitleLabel.h"
#import "NSString+QNImageURL.h"

@interface ChannelHeaderView()

//@property (weak, nonatomic) IBOutlet EGOImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
//@property (weak, nonatomic) IBOutlet HDTitleLabel *authorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *profileLabel;
@property (weak, nonatomic) IBOutlet UIButton *descriptionButton;

@end

@implementation ChannelHeaderView
@synthesize channel= _channel;
@synthesize author = _author;

- (void)setAuthor:(User *)author
{
    if (![_author isEqualToUser:author]) {
        _author = author;
        self.profileLabel.text = self.author.profile;
        [self.headerImageView setImageWithURL:[NSURL URLWithString:[self.author.headerPicURL imageUrlWithThumbnailType:@"3"]] placeholderImage:[UIImage imageNamed:DJ_AVATAR_PLACEHOLDER]];
    }
}

- (IBAction)showDJProfile:(UIButton *)sender
{
    [self.delegate showChannelProfile:self.author];
}

- (void)awakeFromNib
{
    self.profileLabel.textColor = CELL_SUBTITLE_COLOR;
}

@end
