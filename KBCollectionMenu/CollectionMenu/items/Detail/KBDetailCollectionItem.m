//
//  KBDetailCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/12/15.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBDetailCollectionItem.h"

@implementation KBDetailCollectionItem

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail
{
    return [self initWithTitle:title detail:detail icon:nil];
}

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon
{
    self = [super init];
    if (self)
    {
        _title = title;
        _detail = detail;
        _icon = icon;
        _accessoryType = KBDetailCollectionItemViewAccessoryNone;
        _titleFont = KBSystemFontOfSize(16);
        _titleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _detailFont = KBSystemFontOfSize(12);
        _detailColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBDetailCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 64);
}

- (void)bindView:(KBDetailCollectionItemView *)view
{
    [super bindView:view];
    
    [view setTitle:_title];
    [view setDetail:_detail];
    [view setIcon:_icon];
    [view setAccessoryType:_accessoryType];
    [view setTitleFont:_titleFont];
    [view setTitleColor:_titleColor];
    [view setDetailFont:_detailFont];
    [view setDetailColor:_detailColor];
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
    _title = title;
    [(KBDetailCollectionItemView *)self.view setTitle:title];
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [(KBDetailCollectionItemView *)self.view setDetail:detail];
}

- (void)setIcon:(UIImage *)icon
{
    _icon= icon;
    [(KBDetailCollectionItemView *)self.view setIcon:icon];
}

- (void)setAccessoryType:(KBDetailCollectionItemViewAccessoryType)accessoryType
{
    _accessoryType = accessoryType;
    [(KBDetailCollectionItemView *)self.view setAccessoryType:accessoryType];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [(KBDetailCollectionItemView *)self.view setTitleFont:titleFont];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [(KBDetailCollectionItemView *)self.view setTitleColor:titleColor];
}

- (void)setDetailFont:(UIFont *)detailFont
{
    _detailFont = detailFont;
    [(KBDetailCollectionItemView *)self.view setDetailFont:detailFont];
}

- (void)setDetailColor:(UIColor *)detailColor
{
    _detailColor = detailColor;
    [(KBDetailCollectionItemView *)self.view setDetailColor:detailColor];
}

@end
