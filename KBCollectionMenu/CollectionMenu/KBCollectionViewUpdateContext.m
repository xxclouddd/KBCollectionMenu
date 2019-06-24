//
//  KBCollectionViewUpdateContext.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCollectionViewUpdateContext.h"
#import <UIKit/UIKit.h>

typedef enum {
    KBCollectionViewUpdateContextUpdateInsertSection = 0,
    KBCollectionViewUpdateContextUpdateDeleteSection = 1,
    KBCollectionViewUpdateContextUpdateInsertItem = 2,
    KBCollectionViewUpdateContextUpdateDeleteItem = 3,
    KBCollectionViewUpdateContextUpdateReplaceItem = 4
} KBCollectionViewUpdateContextUpdateType;

typedef struct
{
    KBCollectionViewUpdateContextUpdateType type;
    int section;
    int index;
} KBCollectionViewUpdateContextUpdate;

@interface KBCollectionViewUpdateContext ()
{
    NSMutableArray *_updates;
}

@end

@implementation KBCollectionViewUpdateContext

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _updates = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)insertSectionAtIndex:(NSUInteger)index
{
    KBCollectionViewUpdateContextUpdate update = {.type = KBCollectionViewUpdateContextUpdateInsertSection, .section = (int)index, .index = 0};
    [_updates addObject:[NSValue valueWithBytes:&update objCType:@encode(KBCollectionViewUpdateContextUpdate)]];
}

- (void)deleteSectionAtIndex:(NSUInteger)index
{
    KBCollectionViewUpdateContextUpdate update = {.type = KBCollectionViewUpdateContextUpdateDeleteSection, .section = (int)index, .index = 0};
    [_updates addObject:[NSValue valueWithBytes:&update objCType:@encode(KBCollectionViewUpdateContextUpdate)]];
}

- (void)insertItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    KBCollectionViewUpdateContextUpdate update = {.type = KBCollectionViewUpdateContextUpdateInsertItem, .section = (int)section, .index = (int)index};
    [_updates addObject:[NSValue valueWithBytes:&update objCType:@encode(KBCollectionViewUpdateContextUpdate)]];
}

- (void)deleteItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    KBCollectionViewUpdateContextUpdate update = {.type = KBCollectionViewUpdateContextUpdateDeleteItem, .section = (int)section, .index = (int)index};
    [_updates addObject:[NSValue valueWithBytes:&update objCType:@encode(KBCollectionViewUpdateContextUpdate)]];
}

- (void)replaceItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    KBCollectionViewUpdateContextUpdate update = {.type = KBCollectionViewUpdateContextUpdateReplaceItem, .section = (int)section, .index = (int)index};
    [_updates addObject:[NSValue valueWithBytes:&update objCType:@encode(KBCollectionViewUpdateContextUpdate)]];
}

- (void)commit:(UICollectionView *)collectionView
{
    for (NSValue *updateValue in _updates)
    {
        KBCollectionViewUpdateContextUpdate update;
        [updateValue getValue:&update];
        
        switch (update.type)
        {
            case KBCollectionViewUpdateContextUpdateInsertSection:
                [collectionView insertSections:[NSIndexSet indexSetWithIndex:update.section]];
                break;
            case KBCollectionViewUpdateContextUpdateDeleteSection:
                [collectionView deleteSections:[NSIndexSet indexSetWithIndex:update.section]];
                break;
            case KBCollectionViewUpdateContextUpdateInsertItem:
                [collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:update.index inSection:update.section]]];
                break;
            case KBCollectionViewUpdateContextUpdateDeleteItem:
                [collectionView deleteItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:update.index inSection:update.section]]];
                break;
            case KBCollectionViewUpdateContextUpdateReplaceItem:
                [collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:update.index inSection:update.section]]];
                break;
            default:
                break;
        }
    }
}



@end
