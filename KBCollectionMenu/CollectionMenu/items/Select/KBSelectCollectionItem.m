//
//  KBSelectCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBSelectCollectionItem.h"
#import "KBSelectCollectionItemView.h"

@implementation KBSelectCollectionItem

- (instancetype)initWithTitle:(NSString *)title
{
    return [self initWithTitle:title action:NULL];
}

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action
{
    self = [super init];
    if (self)
    {
        self.deselectAutomatically = NO;
        
        _title = title;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBSelectCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 49);
}

- (void)itemSelected:(id)actionTarget
{
    if (_selectAction != NULL && [actionTarget respondsToSelector:_selectAction])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [actionTarget performSelector:_selectAction withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)itemDeselected:(id)actionTarget
{
    if (_deselectAction != NULL && [actionTarget respondsToSelector:_deselectAction])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [actionTarget performSelector:_deselectAction withObject:self];
#pragma clang diagnostic pop
    }
}

- (void)bindView:(KBSelectCollectionItemView *)view
{
    [super bindView:view];
    
    view.titleLabel.text = _title;
}

- (void)unbindView
{
    [super unbindView];
}

- (void)setLeftInset:(CGFloat)leftInset
{
    _leftInset = leftInset;
    
    [(KBSelectCollectionItemView *)self.view setLeftInset:leftInset];
}

- (void)setLeftInsetDuringEditing:(CGFloat)leftInsetDuringEditing
{
    _leftInsetDuringEditing = leftInsetDuringEditing;
    
    [(KBSelectCollectionItemView *)self.view setLeftInsetDuringEditing:leftInsetDuringEditing];
}

@end
