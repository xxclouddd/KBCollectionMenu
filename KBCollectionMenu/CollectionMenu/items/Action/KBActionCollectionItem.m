//
//  KBActionCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/28.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBActionCollectionItem.h"
#import "KBActionCollectionItemView.h"

@implementation KBActionCollectionItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self != nil)
    {
        self.transparent = YES;
        _normalBackgroundColor = [UIColor colorWithRed:57/255.0 green:181/255.0 blue:74/255.0 alpha:1.0];
        _disableBackgroundColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        _titleColor = [UIColor whiteColor];
        _borderColor = [UIColor clearColor];
        _borderWidth = 0;
        _title = title;
        _itemHeight = 40;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBActionCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, _itemHeight);
}

- (void)bindView:(KBActionCollectionItemView *)view
{
    [super bindView:view];
    
    [view setTitle:_title];
    [view setEnable:self.selectable];
    [view setNormalBtnBackgroundColor:_normalBackgroundColor];
    [view setDisableBtnBackgroundColor:_disableBackgroundColor];
    [view setBorderWidth:_borderWidth];
    [view setBorderColor:_borderColor];
    [view setTitleColor:_titleColor];
    if (_action && _target) {
        [view addTarget:_target action:_action];
    }
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (self.view != nil) {
        [(KBActionCollectionItemView *)self.view setTitle:title];
    }
}

- (void)setTitleColor:(UIColor *)titleColor {
    
    _titleColor = titleColor;
    
    if (self.view != nil) {
        
        [(KBActionCollectionItemView *)self.view setTitleColor:titleColor];
    }
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    _borderColor = borderColor;
    
    if (self.view != nil) {
        
        [(KBActionCollectionItemView *)self.view setBorderColor:borderColor];
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    _borderWidth = borderWidth;
    
    if (self.view != nil) {
        
        [(KBActionCollectionItemView *)self.view setBorderWidth:borderWidth];
    }
}

- (void)setNormalBackgroundColor:(UIColor *)normalBackgroundColor {
    
    _normalBackgroundColor = normalBackgroundColor;
    
    if (self.view != nil) {
        
        [(KBActionCollectionItemView *)self.view setNormalBtnBackgroundColor:normalBackgroundColor];
    }
}

- (void)setDisableBackgroundColor:(UIColor *)disableBackgroundColor {
    
    _disableBackgroundColor = disableBackgroundColor;
    
    if (self.view != nil) {
        
        [(KBActionCollectionItemView *)self.view setDisableBtnBackgroundColor:disableBackgroundColor];
    }
}

- (void)addTarget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
    
    if (self.view != nil) {
        [(KBActionCollectionItemView *)self.view addTarget:target action:action];
    }
}

- (void)setSelectable:(BOOL)selectable
{
    [super setSelectable:selectable];
    
    [(KBActionCollectionItemView *)self.view setEnable:selectable];
}


@end
