//
//  CCUIViewController.h
//  CCFC
//
//  Created by xichen on 11-12-28.
//  Copyright 2011 ccteam. All rights reserved.
//

#import <Foundation/Foundation.h>

#define	MACRO_COMMON_LOAD_VIEW		\
		- (void)loadView			\
		{							\
			[super loadView];		\
			CGRect rect = [[UIScreen mainScreen] applicationFrame];		\
			UIView *view = [[UIView alloc] initWithFrame:rect];			\
			self.view = view;	\
		}

@interface UIViewController(cc)

//add logo
- (UIBarButtonItem *)addLeftLogoBarButtonItem;

//add custom button
- (UIBarButtonItem *)addCustomBackBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

- (UIBarButtonItem *)addCustomRightBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

- (UIBarButtonItem *)addCustomLeftBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

- (UIBarButtonItem *)addCustomRightListBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

- (UIBarButtonItem *)addCustomRightPlayBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

- (UIBarButtonItem *)addPlayingRightBarButtonItem: aTitle controlEvents:(UIControlEvents)events target:(id)target action:(SEL)sel;

//add navi button
- (UIBarButtonItem *)addLeftBarButtonItem:aTitle
									style:(UIBarButtonItemStyle)style
								   target:(id)target 
								   action:(SEL)sel;

- (UIBarButtonItem *)addRightBarButtonItem:aTitle
									 style:(UIBarButtonItemStyle)style
									target:(id)target 
									action:(SEL)sel;

- (UIBarButtonItem *)addBackBarButtonItem:aTitle
                                    style:(UIBarButtonItemStyle)style
                                   target:(id)target
                                   action:(SEL)sel;


//animation
- (void) presentModalViewController:(UIViewController *)modalViewController withPushDirection: (NSString *) direction;

- (void) dismissModalViewControllerWithPushDirection:(NSString *) direction;

- (UIView *)setLoadView;

//net work
- (void)showNetWorkLoadingStatus;
- (void)showNetWorkErrorStatus;
- (void)showNetWorkCompletedStatus;
- (void)hideNetWorkStatus;
- (void)showNetWorkSubimtingStatus;

@end
