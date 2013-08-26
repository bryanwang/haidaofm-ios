//
//  TopicHeaderView.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/25/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "TopicHeaderView.h"
#import "EGOImageView.h"
#import "HDTitleLabel.h"

@interface TopicHeaderView()

@property (weak, nonatomic) IBOutlet EGOImageView *coverImageView;
@property (weak, nonatomic) IBOutlet HDTitleLabel *topicTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *topicDescriptionLabel;

@end
@implementation TopicHeaderView
@synthesize topic = _topic;

- (void)setTopic:(NSDictionary *)topic
{
    _topic = topic;
    
    self.coverImageView.imageURL = [self.topic objectForKey:@"coverPic"];
    self.topicTitleLabel.text = [self.topic objectForKey:@"title"];
    self.topicDescriptionLabel.text = [self.topic objectForKey:@"description"];
}

- (IBAction)showTopicDescription:(id)sender {
    [self.delegate showTopicDescription:[self.topic objectForKey:@"description"]];
}

@end
