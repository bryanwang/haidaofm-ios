//
//  ChannelListViewController.h
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"
#import "ChannelView.h"

@interface ChannelListViewController : HDViewController <iCarouselDataSource, iCarouselDelegate, ChannelViewDelegate>

@end
