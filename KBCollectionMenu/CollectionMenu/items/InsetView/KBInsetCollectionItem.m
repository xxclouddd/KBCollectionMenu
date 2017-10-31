//
//  KBInsetCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/13.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBInsetCollectionItem.h"
#import "KBInsetCollectionItemView.h"

@implementation KBInsetCollectionItem

- (instancetype)init
{
    return [self initWithInsetView:nil];
}

- (instancetype)initWithInsetView:(UIView *)insetView
{
    self = [super init];
    if (self) {
        _insetView = insetView;
        _presetsHeight = 49;
        _insets = UIEdgeInsetsMake(1, 0, 1, 0);
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBInsetCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, _presetsHeight);
}

- (void)bindView:(KBInsetCollectionItemView *)view
{
    [super bindView:view];
    
    view.additionalSeparatorInset = _additionalSeparatorInset;
    view.insets = _insets;
    view.view = _insetView;
}

- (void)unbindView
{
    [super unbindView];
}

- (void)setInsetView:(UIView *)insetView
{
    _insetView = insetView;
    [(KBInsetCollectionItemView *)self.view setView:insetView];
}

- (void)setInsets:(UIEdgeInsets)insets
{
    _insets = insets;
    [(KBInsetCollectionItemView *)self.view setInsets:insets];
}

@end
