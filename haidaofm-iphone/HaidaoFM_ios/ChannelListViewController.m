//
//  ChannelListViewController.m
//  HaidaoFM_ios
//
//  Created by Aldrich Huang on 10/20/12.
//  Copyright (c) 2012 HaidaoFM. All rights reserved.
//

#import "ChannelListViewController.h"
#import "iCarousel.h"
#import "ProgramListViewController.h"
#import "PlayerViewController.h"
#import "NetworkStatusManager.h"

#define ITEM_WIDTH 294.0f
#define VISIBLE_ITEM_COUNT 25

@interface ChannelListViewController () <NetworkStatusRetryDelegate>
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *channels;

@end

@implementation ChannelListViewController
@synthesize carousel = _carousel;
@synthesize channels = _channels;

- (NSMutableArray *)parseChannels:(NSArray *)rawChannels
{
    NSMutableArray *channels = [[NSMutableArray alloc] initWithCapacity:rawChannels.count];
    [rawChannels enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [channels addObject:[[ChannelDetail alloc] initWithData:obj]];
    }];
    return channels;
}

- (void)fetchChannels {
    [[NetworkStatusManager sharedInstance] showLoadingWithBaseViewController:self.navigationController.topViewController];

    [[HDHttpClient shareIntance] getPath:CHANNEL_DETAIL_INTERFACE parameters:nil success:^(AFHTTPRequestOperation *operation, id JSON) {
        [[NetworkStatusManager sharedInstance] removeNetworkStatusViewControler];
        
        self.channels = [self parseChannels:JSON];
        [self.carousel reloadData];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        [[NetworkStatusManager sharedInstance] changeToNetworkErrorStatusWithBaseViewController:self.navigationController.topViewController AndRetryDelegate: self];
    }];
}


- (void)setupCarousel
{
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.decelerationRate = 0.5;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //left logo
    [self addLeftLogoBarButtonItem];

    [self setupCarousel];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.channels == nil)
    {
        [self fetchChannels];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setCarousel:nil];
    [super viewDidUnload];
}

#pragma mark - iCarouselDelegate

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.channels.count;
}


- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        ChannelView *channelView = [[NSBundle mainBundle]loadNibNamed:@"ChannelView" owner:self options:nil][0];
        channelView.delegate = self;
        channelView.channelDetail = [self.channels objectAtIndex:index];
        return channelView;
    }    
    return view;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    return nil;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
    return 0;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    return VISIBLE_ITEM_COUNT;
}


- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return ITEM_WIDTH;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * carousel.itemWidth);}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return YES;
}

#pragma mark - ChannelViewDelegate

- (void)showProgramList:(ChannelDetail *)channelDetail
{
    ProgramListViewController *controller = [[ProgramListViewController alloc] initWithNibName:@"HDProgramListViewController" bundle:nil];
    
    controller.channel = channelDetail.channel;
    controller.author = channelDetail.author;

    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -- NetworkStatusRetryDelegate
- (void)retry
{
    [self fetchChannels];
}



@end
