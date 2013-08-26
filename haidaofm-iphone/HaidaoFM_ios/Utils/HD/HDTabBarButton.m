//
//  HDTabBarButton.m
//  haidaofm
//
//  Created by Bruce Yang on 9/28/12.
//
//

#import "HDTabBarButton.h"

@implementation HDTabBarButton
@synthesize icon = _icon;
@synthesize highlightedIcon = _highlightedIcon;

- (id)initWithIcon:(UIImage *)icon withHightlightedIcon:(UIImage *)highlightedIcon 
{
    self = [super init];
    if (self) {
        self.icon = icon;
        self.highlightedIcon = highlightedIcon;
    }
    return self;
}
@end
