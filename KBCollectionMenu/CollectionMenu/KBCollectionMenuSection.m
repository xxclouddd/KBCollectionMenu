//
//  KBCollectionMenuSection.m
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCollectionMenuSection.h"

@interface KBCollectionMenuSection ()
{
    NSMutableArray *_items;
}

@end

@implementation KBCollectionMenuSection

- (instancetype)init
{
    return [self initWithItems:nil];
}

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super init];
    if (self != nil)
    {
        _insets = UIEdgeInsetsMake(0.0f, 0.0f, 35.0f, 0.0f);
        
        _items = [[NSMutableArray alloc] init];
        if (items != nil)
            [_items addObjectsFromArray:items];
    }
    return self;
}

- (NSArray *)items
{
    return _items;
}

- (void)insertItem:(KBCollectionItem *)item atIndex:(NSUInteger)index
{
    [_items insertObject:item atIndex:index];
}

- (void)addItem:(KBCollectionItem *)item {
    [_items addObject:item];
}

- (void)deleteItemAtIndex:(NSUInteger)index
{
    [_items removeObjectAtIndex:index];
}

- (BOOL)deleteItem:(KBCollectionItem *)item {
    if ([self indexOfItem:item] != NSNotFound) {
        [_items removeObject:item];
        return YES;
    }
    return NO;
}

- (void)replaceItems:(NSArray *)items {
    [_items removeAllObjects];
    [_items addObjectsFromArray:items];
}

- (NSUInteger)indexOfItem:(KBCollectionItem *)item {
    return [_items indexOfObject:item];
}

- (void)replaceItemAtIndex:(NSUInteger)index withItem:(KBCollectionItem *)item
{
    [_items replaceObjectAtIndex:index withObject:item];
}

- (KBCollectionItem *)itemAtIndex:(NSUInteger)index
{
    if (index < _items.count) {
        return _items[index];
    } else
        return nil;
}


@end
