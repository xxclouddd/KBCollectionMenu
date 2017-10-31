//
//  KBCollectionMenuSectionList.m
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionMenuSectionList.h"
#import "KBCollectionViewUpdateContext.h"
#import "KBCollectionItemView.h"

@interface KBCollectionMenuSectionList ()
{
    BOOL _recordingChanges;
    KBCollectionViewUpdateContext *_updateContext;
    
    NSMutableArray *_sections;
}

@end

@implementation KBCollectionMenuSectionList

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _sections = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSArray *)sections
{
    return _sections;
}

- (void)addSection:(KBCollectionMenuSection *)section
{
    [self insertSection:section atIndex:_sections.count];
}

- (void)insertSection:(KBCollectionMenuSection *)section atIndex:(NSUInteger)index
{
    if (section != nil)
    {
        [_sections insertObject:section atIndex:index];
        
        if (_recordingChanges)
            [_updateContext insertSectionAtIndex:index];
    }
}

- (void)deleteSection:(NSUInteger)section
{
    if (_recordingChanges)
        [_updateContext deleteSectionAtIndex:section];
    
    [_sections removeObjectAtIndex:section];
}

- (void)addItemToSection:(NSUInteger)section item:(KBCollectionItem *)item
{
    KBCollectionMenuSection *menuSection = _sections[section];
    
    if (_recordingChanges)
        [_updateContext insertItemAtIndex:menuSection.items.count inSection:section];
    
    [menuSection insertItem:item atIndex:menuSection.items.count];
}

- (void)insertItem:(KBCollectionItem *)item toSection:(NSUInteger)section atIndex:(NSUInteger)index
{
    KBCollectionMenuSection *menuSection = _sections[section];
    
    if (_recordingChanges)
        [_updateContext insertItemAtIndex:index inSection:section];
    
    [menuSection insertItem:item atIndex:index];
}

- (void)deleteItemFromSection:(NSUInteger)section atIndex:(NSUInteger)index
{
    KBCollectionMenuSection *menuSection = _sections[section];
    
    if (_recordingChanges)
        [_updateContext deleteItemAtIndex:index inSection:section];
    
    [menuSection deleteItemAtIndex:index];
}

- (void)replaceItemInSection:(NSUInteger)section atIndex:(NSUInteger)index withItem:(KBCollectionItem *)item
{
    KBCollectionMenuSection *menuSection = _sections[section];
    
    if (_recordingChanges)
        [_updateContext replaceItemAtIndex:index inSection:section];
    
    [menuSection replaceItemAtIndex:index withItem:item];
}

- (NSUInteger)indexOfSection:(KBCollectionMenuSection *)section
{    
    return [_sections indexOfObject:section];
}

- (KBCollectionMenuSection *)sectionAtIndex:(NSUInteger)index
{
    if (index < _sections.count) {
        return _sections[index];
    } else
        return nil;
}

- (void)beginRecordingChanges
{
    if (!_recordingChanges)
    {
        _recordingChanges = true;
        _updateContext = [[KBCollectionViewUpdateContext alloc] init];
    }
}

- (BOOL)commitRecordedChanges:(UICollectionView *)collectionView
{
    return [self commitRecordedChanges:collectionView additionalActions:nil];
}

- (BOOL)commitRecordedChanges:(UICollectionView *)collectionView additionalActions:(void (^)())additionalActions
{
    if (_recordingChanges)
    {
        _recordingChanges = false;
        
        KBCollectionViewUpdateContext *updateContext = _updateContext;
        _updateContext = nil;
        
        @try
        {
            [collectionView performBatchUpdates:^
             {
                 [updateContext commit:collectionView];
                 
                 if (additionalActions != nil)
                     additionalActions();
             } completion:nil];
            
            for (NSIndexPath *indexPath in [collectionView indexPathsForVisibleItems])
            {
                id itemView = [collectionView cellForItemAtIndexPath:indexPath];
                
                if ([itemView isKindOfClass:[KBCollectionItemView class]])
                {
                    KBCollectionItem *item = ((KBCollectionMenuSection *)_sections[indexPath.section]).items[indexPath.item];
                    
                    KBCollectionItem *previousItem = nil;
                    if (indexPath.item > 0)
                        previousItem = ((KBCollectionMenuSection *)_sections[indexPath.section]).items[indexPath.item - 1];
                    
                    KBCollectionItem *nextItem = nil;
                    if (indexPath.item < (NSInteger)((KBCollectionMenuSection *)_sections[indexPath.section]).items.count - 1)
                        nextItem = ((KBCollectionMenuSection *)_sections[indexPath.section]).items[indexPath.item + 1];
                    
                    int itemPositionMask = 0;
                    if (!item.transparent)
                    {
                        if (previousItem == nil || previousItem.transparent)
                            itemPositionMask |= KBCollectionItemViewPositionFirstInBlock;
                        
                        if (nextItem == nil || nextItem.transparent)
                            itemPositionMask |= KBCollectionItemViewPositionLastInBlock;
                        
                        if (itemPositionMask == 0)
                            itemPositionMask = KBCollectionItemViewPositionMiddleInBlock;
                    }
                    
                    [itemView setItemPosition:itemPositionMask];
                }
            }
        }
        @catch (NSException *e)
        {
            NSLog(@"%@", e);
            
            return false;
        }
    }
    
    return true;
}


@end
