//
//  HDTabBarButton.h
//  haidaofm
//
//  Created by Bruce Yang on 9/28/12.
//
//

#import <Foundation/Foundation.h>

@interface HDTabBarButton : NSObject
@property (strong, nonatomic) UIImage *icon;
@property (strong, nonatomic) UIImage *highlightedIcon;


- (id)initWithIcon:(UIImage *)icon withHightlightedIcon:(UIImage *)highlightedIcon;

@end
