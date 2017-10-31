//
//  KBCollectionMenuController.m
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionMenuController.h"
#import "KBEditCollectionItemView.h"

@interface KBCollectionMenuController ()
{
    bool _editingMode;
    
    NSMutableSet *_collectionRegisteredIdentifiers;
}

@end

@implementation KBCollectionMenuController

- (id)init
{
    self = [super init];
    if (self)
    {
        _editingMode = YES;
        _menuSections = [[KBCollectionMenuSectionList alloc] init];
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self resetCollectionView];
}

- (Class)collectionLayoutClass
{
    return [KBCollectionMenuLayout class];
}

- (void)dealloc
{
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    for (NSIndexPath *indexPath in [_collectionView indexPathsForSelectedItems])
    {
        [_collectionView deselectItemAtIndexPath:indexPath animated:animated];
    }
    
    [super viewWillAppear:animated];
}

- (void)enterEditingMode:(BOOL)animated
{
    if (!_editingMode)
    {
        _editingMode = true;
        
        [_collectionView setEditing:YES animated:animated];
        
        [self didEnterEditingMode:animated];
    }
}

- (void)leaveEditingMode:(BOOL)animated
{
    if (_editingMode)
    {
        _editingMode = false;
        
        [_collectionView setEditing:false animated:animated];
        
        [self didLeaveEditingMode:animated];
    }
}

- (void)didEnterEditingMode:(BOOL)animated
{
}

- (void)didLeaveEditingMode:(BOOL)animated
{
}

#pragma mark -
- (void)resetCollectionView
{
    if (_collectionView != nil)
    {
        _collectionView.delegate = nil;
        _collectionView.dataSource = nil;
        [_collectionView removeFromSuperview];
    }
    
    
    _collectionRegisteredIdentifiers = [[NSMutableSet alloc] init];
    
    _collectionLayout = [[self.collectionLayoutClass alloc] init];
    _collectionView = [[KBCollectionMenuView alloc] initWithFrame:self.view.bounds collectionViewLayout:_collectionLayout];
    _collectionView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:242/255.0];
    _collectionView.opaque = false;
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.alwaysBounceVertical = true;
    
    [_collectionView registerClass:[KBCollectionItemView class] forCellWithReuseIdentifier:@"_empty"];
    
    __weak KBCollectionMenuController *weakSelf = self;
    _collectionView.layoutForSize = ^(CGSize size) {
        __strong KBCollectionMenuController *strongSelf = weakSelf;
        if (strongSelf != nil) {
            [strongSelf->_collectionLayout invalidateLayout];
            [strongSelf->_collectionView setNeedsLayout];
        }
    };
    
    [self.view addSubview:_collectionView];
}


- (NSIndexPath *)indexPathForItem:(KBCollectionItem *)item
{
    int sectionIndex = -1;
    
    for (KBCollectionMenuSection *section in _menuSections.sections)
    {
        sectionIndex++;
        
        int itemIndex = -1;
        
        for (KBCollectionItem *listItem in section.items)
        {
            itemIndex++;
            
            if (listItem == item)
            {
                return [NSIndexPath indexPathForItem:itemIndex inSection:sectionIndex];
            }
        }
    }
    
    return nil;
}

- (NSUInteger)indexForSection:(KBCollectionMenuSection *)section
{
    int index = -1;
    for (KBCollectionMenuSection *listSection in _menuSections.sections)
    {
        index++;
        
        if (listSection == section)
            return (NSUInteger)index;
    }
    
    return NSNotFound;
}

- (void)updateItemPositions
{
    [self updateItemPositions:false];
}

- (void)updateItemPositions:(BOOL)ignoreDragging
{
    for (NSIndexPath *indexPath in [_collectionView indexPathsForVisibleItems])
    {
        KBCollectionMenuSection *section = _menuSections.sections[indexPath.section];
        KBCollectionItem *item = section.items[indexPath.item];
        KBCollectionItemView *itemView = (KBCollectionItemView *)[_collectionView cellForItemAtIndexPath:indexPath];
        [self updateItem:item itemView:itemView positionAtIndexPath:indexPath ignoreDragging:ignoreDragging animated:true];
    }
}

- (void)updateItem:(KBCollectionItem *)item itemView:(KBCollectionItemView *)itemView positionAtIndexPath:(NSIndexPath *)indexPath ignoreDragging:(BOOL)ignoreDragging animated:(BOOL)animated
{
    KBCollectionItem *previousItem = nil;
    if (indexPath.item > 0)
    {
        if (ignoreDragging || _collectionLayout.selectedItemIndexPath == nil || ![_collectionLayout.selectedItemIndexPath isEqual:[NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section]])
        {
            previousItem = ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item - 1];
        }
    }
    
    KBCollectionItem *nextItem = nil;
    if (indexPath.item < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count - 1)
    {
        if (ignoreDragging || _collectionLayout.selectedItemIndexPath == nil || ![_collectionLayout.selectedItemIndexPath isEqual:[NSIndexPath indexPathForItem:indexPath.item + 1 inSection:indexPath.section]])
        {
            nextItem = ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item + 1];
        }
    }
    
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
    
    [itemView setItemPosition:itemPositionMask animated:animated];
}

#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (collectionView == _collectionView)
        return _menuSections.sections.count;
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == _collectionView && section < (NSInteger)_menuSections.sections.count)
        return ((KBCollectionMenuSection *)_menuSections.sections[section]).items.count;
    return 0;
}

- (UICollectionViewCell *)collectionView:(KBCollectionMenuView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
    
    if (item != nil)
    {
        KBCollectionItemView *itemView = [item dequeueItemView:collectionView registeredIdentifiers:_collectionRegisteredIdentifiers forIndexPath:indexPath];
        if (itemView.boundItem != nil)
            [itemView.boundItem unbindView];
        
        [self updateItem:item itemView:itemView positionAtIndexPath:indexPath ignoreDragging:false animated:false];
        
        [item bindView:itemView];
        
        if ([itemView isKindOfClass:[KBEditCollectionItemView class]])
            [(KBEditCollectionItemView *)itemView setEditing:collectionView.editing];        
        
        return itemView;
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"_empty" forIndexPath:indexPath];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)__unused collectionView didEndDisplayingCell:(KBCollectionItemView *)cell forItemAtIndexPath:(NSIndexPath *)__unused indexPath
{
    [cell.boundItem unbindView];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
            return item.highlightable;
    }
    
    return false;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
            return item.selectable;
    }
    
    return false;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
        {
            [item itemSelected:self];
            
            if (item.deselectAutomatically)
                [collectionView deselectItemAtIndexPath:indexPath animated:true];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
        {
            [item itemDeselected:self];
        }
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
        {
            return [item itemWantsMenu];
        }
    }
    
    return false;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)__unused sender
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
        {
            return [item itemCanPerformAction:action];
        }
    }
    
    return false;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)__unused sender
{
    if (collectionView == _collectionView)
    {
        KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
        if (item != nil)
        {
            return [item itemPerformAction:action];
        }
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KBCollectionItem *item = indexPath.section < (NSInteger)_menuSections.sections.count && indexPath.row < (NSInteger)((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items.count ? ((KBCollectionMenuSection *)_menuSections.sections[indexPath.section]).items[indexPath.item] : nil;
    
    CGSize layoutSize = collectionView.frame.size;
    
    if (item != nil)
        return [item itemSizeForContainerSize:layoutSize];
    
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)__unused collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)__unused section
{
    return 0.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (collectionView == _collectionView)
    {
        return ((KBCollectionMenuSection *)_menuSections.sections[section]).insets;
    }
    
    return UIEdgeInsetsZero;
}

#pragma mark - KBCollectionMenuLayoutDataSource && KBCollectionMenuLayoutDelegateFlowLayout

- (void)collectionView:(UICollectionView *)__unused collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    KBCollectionMenuSection *fromSection = _menuSections.sections[fromIndexPath.section];
    KBCollectionMenuSection *toSection = _menuSections.sections[toIndexPath.section];
    if (fromSection == toSection)
    {
        NSInteger fromIndex = fromIndexPath.item;
        id item = fromSection.items[fromIndex];
        
        NSInteger toIndex = toIndexPath.item;
        
        [fromSection deleteItemAtIndex:fromIndex];
        [fromSection insertItem:item atIndex:toIndex];
    }
    else
    {
        id item = fromSection.items[fromIndexPath.item];
        [fromSection deleteItemAtIndex:fromIndexPath.item];
        [toSection insertItem:item atIndex:toIndexPath.item];
    }
}

- (void)collectionView:(UICollectionView *)__unused collectionView itemAtIndexPath:(NSIndexPath *)__unused fromIndexPath willBeginMovingToIndexPath:(NSIndexPath *)__unused toIndexPath
{
    [self updateItemPositions:false];
}

- (void)collectionView:(UICollectionView *)__unused collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)__unused indexPath
{
    [self updateItemPositions:true];
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath
{
    KBCollectionItemView *itemView = (KBCollectionItemView *)[collectionView cellForItemAtIndexPath:indexPath];
    [itemView setItemPosition:KBCollectionItemViewPositionFirstInBlock | KBCollectionItemViewPositionLastInBlock];
}

- (void)collectionView:(UICollectionView *)__unused collectionView layout:(UICollectionViewLayout *)__unused collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)__unused indexPath
{
    [self updateItemPositions:false];
}

- (void)collectionView:(UICollectionView *)__unused collectionView itemAtIndexPath:(NSIndexPath *)__unused fromIndexPath didMoveToIndexPath:(NSIndexPath *)__unused toIndexPath
{
}

- (BOOL)collectionView:(UICollectionView *)__unused collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    KBCollectionMenuSection *section = _menuSections.sections[indexPath.section];
    KBCollectionItem *item = section.items[indexPath.item];
    return _editingMode && item.canBeMovedToSectionAtIndex != nil;
}

- (BOOL)collectionView:(UICollectionView *)__unused collectionView itemAtIndexPath:(NSIndexPath *) fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath
{
    KBCollectionMenuSection *section = _menuSections.sections[fromIndexPath.section];
    KBCollectionItem *item = section.items[fromIndexPath.item];
    return item.canBeMovedToSectionAtIndex != nil && item.canBeMovedToSectionAtIndex(toIndexPath.section, toIndexPath.item);
}

- (BOOL)collectionViewCanMoveItems:(UICollectionView *)__unused collectionView
{
    return _enableItemReorderingGestures;
}


#pragma mark - 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _collectionView) {
        if (scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height * 2.0f) {
            [self loadMore];
        }
    }
}

- (void)loadMore {
    
    
}


@end
