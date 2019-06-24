//
//  KBHeaderCollectionItem.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBHeaderCollectionItem.h"
#import "KBHeaderCollectionItemView.h"

@interface KBHeaderCollectionItem ()
{
    NSString *_title;
}

@end

@implementation KBHeaderCollectionItem

- (instancetype)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self != nil)
    {
        self.transparent = true;
        self.highlightable = false;
        self.selectable = false;
        
        _title = title;
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBHeaderCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 22.0f);
}

- (void)bindView:(KBHeaderCollectionItemView *)view
{
    [super bindView:view];
    
    [view setTitle:_title];
}

- (void)setTitle:(NSString *)title
{
    if (![_title isEqualToString:title])
    {
        _title = title;
        
        [((KBHeaderCollectionItemView *)[self boundView]) setTitle:_title];
    }
}

@end
