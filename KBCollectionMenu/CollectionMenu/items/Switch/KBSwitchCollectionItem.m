//
//  KBSwitchCollectionItem.m
//  test4
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBSwitchCollectionItem.h"
#import "KBSwitchCollectionItemView.h"

@interface KBSwitchCollectionItem ()<KBSwitchCollectionItemViewDelegate>

@end

@implementation KBSwitchCollectionItem

- (instancetype)init
{
    return [self initWithTitle:nil isOn:NO];
}

- (instancetype)initWithTitle:(NSString *)title isOn:(BOOL)isOn
{
    self = [super init];
    if (self != nil)
    {
        self.highlightable = NO;
        self.selectable = NO;
        
        _title = title;
        _isOn = isOn;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBSwitchCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 49);
}

- (void)bindView:(KBCollectionItemView *)view
{
    [super bindView:view];
    
    [((KBSwitchCollectionItemView *)view) setTitle:_title];
    [((KBSwitchCollectionItemView *)view) setTitleFont:_titleFont];
    [((KBSwitchCollectionItemView *)view) setTitleColor:_titleColor];
    [((KBSwitchCollectionItemView *)view) setIsOn:_isOn animated:false];
    ((KBSwitchCollectionItemView *)view).delegate = self;
}

- (void)unbindView
{
    ((KBSwitchCollectionItemView *)[self boundView]).delegate = self;
    
    [super unbindView];
}

- (void)setTitle:(NSString *)title
{
    if (!KBStringCompare(_title, title))
    {
        _title = title;
        
        if ([self boundView] != nil)
            [((KBSwitchCollectionItemView *)[self boundView]) setTitle:_title];
    }
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    if ([self boundView] != nil)
        [((KBSwitchCollectionItemView *)[self boundView]) setTitleColor:titleColor];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
 
    if ([self boundView] != nil)
        [((KBSwitchCollectionItemView *)[self boundView]) setTitleFont:titleFont];
}

- (void)setIsOn:(BOOL)isOn
{
    [self setIsOn:isOn animated:YES];
}

- (void)setIsOn:(BOOL)isOn animated:(BOOL)animated
{
    if (_isOn != isOn)
    {
        _isOn = isOn;
        
        if ([self boundView] != nil)
            [((KBSwitchCollectionItemView *)[self boundView]) setIsOn:_isOn animated:animated];
    }
}

- (void)switchCollectionItemViewChangedValue:(KBSwitchCollectionItemView *)switchItemView isOn:(BOOL)isOn
{
    if (switchItemView == [self boundView])
    {
        _isOn = isOn;
        
        if (_toggled)
            _toggled(isOn);
        
        
        if ([self.delegate respondsToSelector:@selector(switchCollectionItem:isOn:)]) {
            [self.delegate switchCollectionItem:self isOn:isOn];
        }
    }
}


@end
