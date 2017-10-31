//
//  KBVariantCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBVariantCollectionItem.h"
#import "KBVariantCollectionItemView.h"

@implementation KBVariantCollectionItem

- (instancetype)init
{
    return [self initWithTitle:nil variant:nil action:nil];
}

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action
{
    return [self initWithTitle:title variant:nil action:action];
}

- (instancetype)initWithTitle:(NSString *)title variant:(NSString *)variant action:(SEL)action
{
    self = [super init];
    if (self != nil)
    {
        _title = title;
        _variant = variant;
        _action = action;
        _itemHeight = 49; //默认高度49
        
        _leftInset = 15;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBVariantCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, _itemHeight);
}

- (void)bindView:(KBCollectionItemView *)view
{
    [super bindView:view];
    
    [((KBVariantCollectionItemView *)view) setLeftInset:_leftInset];
    
    [((KBVariantCollectionItemView *)view) setTitle:_title];
    [((KBVariantCollectionItemView *)view) setTitleColor:_titleColor];
    [((KBVariantCollectionItemView *)view) setTitleFont:_titleFont];

    [((KBVariantCollectionItemView *)view) setVariant:_variant];
    [((KBVariantCollectionItemView *)view) setVariantFont:_variantFont];
    [((KBVariantCollectionItemView *)view) setVariantColor:_variantColor];

    [((KBVariantCollectionItemView *)view) setIcon:_icon];
}

- (void)itemSelected:(id)actionTarget
{
    if (_action != NULL && [actionTarget respondsToSelector:_action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [actionTarget performSelector:_action withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)setTitle:(NSString *)title
{
    if (!KBStringCompare(_title, title))
    {
        _title = title;
        
        [((KBVariantCollectionItemView *)[self boundView]) setTitle:title];
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;

    [((KBVariantCollectionItemView *)[self boundView]) setTitleFont:_titleFont];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    [((KBVariantCollectionItemView *)[self boundView]) setTitleColor:_titleColor];
}

- (void)setVariant:(NSString *)variant
{
    if (!KBStringCompare(_variant, variant))
    {
        _variant = variant;
        
        [((KBVariantCollectionItemView *)[self boundView]) setVariant:_variant];
    }
}

- (void)setVariantFont:(UIFont *)variantFont
{
    _variantFont = variantFont;
    
    [((KBVariantCollectionItemView *)[self boundView]) setVariantFont:variantFont];
}

- (void)setVariantColor:(UIColor *)variantColor
{
    _variantColor = variantColor;
    
    [((KBVariantCollectionItemView *)[self boundView]) setVariantColor:variantColor];
}

- (void)setIcon:(UIImage *)icon
{
    _icon = icon;
    
    [(KBVariantCollectionItemView *)self.view setIcon:icon];
}

- (void)setEnabled:(BOOL)enabled
{
    _enabled = enabled;
    
    [((KBVariantCollectionItemView *)[self boundView]) setEnabled:enabled];
}

- (void)setLeftInset:(CGFloat)leftInset
{
    _leftInset = leftInset;
    
    [(KBVariantCollectionItemView *)[self boundView] setLeftInset:_leftInset];
}

- (void)setAdditionalSeparatorInset:(CGFloat)additionalSeparatorInset {
    _additionalSeparatorInset = additionalSeparatorInset;
    
    [(KBVariantCollectionItemView *)[self boundView] setAdditionalSeparatorInset:_additionalSeparatorInset];
}


@end
