//
//  KBEditCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBEditCollectionItem.h"
#import "KBEditCollectionItemView.h"

@implementation KBEditCollectionItem

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.selectable = YES;

        _allowEditing = YES;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBEditCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 49);
}

- (void)bindView:(KBEditCollectionItemView *)view
{
    [super bindView:view];
    
    view.editingMode = KBCollectionItemViewEditingModeSelect;
    view.allowEditing = _allowEditing;
    view.selectable = self.selectable;
}

- (void)setEditing:(BOOL)editing
{
    [self setEditing:editing animated:NO];
}

- (BOOL)editing
{
    return [(KBEditCollectionItemView *)self.view editing];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [(KBEditCollectionItemView *)self.view setEditing:editing animated:animated];
}

- (void)setAllowEditing:(BOOL)allowEditing
{
    _allowEditing = allowEditing;
    
    [(KBEditCollectionItemView *)self.view setAllowEditing:allowEditing];
}

- (void)setSelectable:(BOOL)selectable
{
    [super setSelectable:selectable];
    
    [(KBEditCollectionItemView *)self.view setSelectable:selectable];
}

@end
