//
//  HDTabButton.h
//  haidaofm
//
//  Created by Bruce Yang on 9/28/12.
//
//

#import <Foundation/Foundation.h>
@protocol HDTabBarDelegate;
@interface HDTabBar : UIView

@property (assign) id<HDTabBarDelegate> delegate;

@property (nonatomic) NSInteger selectedIndex;

-(id)initWithItems:(NSArray *)items;

@end

@protocol HDTabBarDelegate
-(void)switchViewController:(NSInteger )index;
@end
