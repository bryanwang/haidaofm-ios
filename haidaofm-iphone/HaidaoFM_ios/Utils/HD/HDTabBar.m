//
//  HDTabButton.m
//  haidaofm
//
//  Created by Bruce Yang on 9/28/12.
//
//

#import "HDTabBar.h"
#import "HDTabBarButton.h"
#import <QuartzCore/QuartzCore.h>

@interface HDTabBar()
@property (retain) NSMutableArray *buttons;
@end

@implementation HDTabBar
@synthesize buttons = _buttons;
@synthesize selectedIndex = _selectedIndex;
@synthesize delegate = _delegate;

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex && selectedIndex < self.buttons.count) {
        if (_selectedIndex < self.buttons.count)
            [self dimButton:[self.buttons objectAtIndex:_selectedIndex]];
        _selectedIndex = selectedIndex;
        
        [self.delegate switchViewController:selectedIndex];
        [self highlightButton:[self.buttons objectAtIndex:selectedIndex]];
    }
}

- (void)highlightButton:(UIButton *)button
{
    button.selected = YES;
    button.highlighted = NO;
}

- (void)dimButton:(UIButton *)button
{
    button.selected = NO;
    button.highlighted = NO;
}

-(id)initWithItems:(NSArray *)items {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0f, 460.0f - TABBAR_HEIGHT, 320.0f, TABBAR_HEIGHT);
        self.backgroundColor = [UIColor clearColor];
        
//        self.layer.masksToBounds = NO;
//        self.layer.shadowOffset = CGSizeMake(0, -3);
//        self.layer.shadowOpacity = 0.6;
//        self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
        
        [self setupButtons:items];
        _selectedIndex = NSNotFound;
    }
    return self;
}

-(void)setupButtons:(NSArray *)tabItems {
    NSInteger count = 0;

    CGFloat buttonSize = self.frame.size.width / tabItems.count;
    self.buttons = [[NSMutableArray alloc] init];
    for (HDTabBarButton *info in tabItems) {
        CGFloat buttonX = (count * buttonSize);

        UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
        b.frame = CGRectMake(buttonX, 0, buttonSize, self.frame.size.height);

        [b setImage:info.icon forState:UIControlStateNormal];
        [b setImage:info.highlightedIcon forState:UIControlStateHighlighted];
        [b setImage:info.highlightedIcon forState:UIControlStateSelected];

        b.adjustsImageWhenHighlighted = NO;
        [b setBackgroundImage:[UIImage imageNamed:@"bg-tab-btn.png"] forState:UIControlStateNormal];
        [b setBackgroundImage:[UIImage imageNamed:@"bg-tab-btn-selected.png"] forState:UIControlStateHighlighted];
        [b setBackgroundImage:[UIImage imageNamed:@"bg-tab-btn-selected.png"] forState:UIControlStateSelected];
        
        [b addTarget:self action:@selector(touchDownAction:) forControlEvents:UIControlEventTouchDown];
        [b addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpInside];
        [b addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchUpOutside];
        [b addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragOutside];
        [b addTarget:self action:@selector(otherTouchesAction:) forControlEvents:UIControlEventTouchDragInside];
        
        [self addSubview:b];
        [self.buttons addObject:b];
        count++;
    }
}

- (void)touchDownAction:(UIButton *)sender
{
    [self highlightButton:sender];
    self.selectedIndex = [self.buttons indexOfObject:sender];
}

- (void)otherTouchesAction:(UIButton *)sender
{
    [self highlightButton:sender];
}

@end
