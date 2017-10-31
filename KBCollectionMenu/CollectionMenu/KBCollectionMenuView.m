//
//  KBCollectionMenuView.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionMenuView.h"
#import "KBEditCollectionItemView.h"

@interface KBCollectionMenuView ()
{
    CGSize _validSize;
    
    BOOL _pAllowsSelection;
    BOOL _pAllowsMultipleSelection;
}

@end

@implementation KBCollectionMenuView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self != nil)
    {

    }
    return self;
}

- (void)updateVisibleItemsNow
{
    CGRect bounds = self.bounds;
    [self setBounds:CGRectOffset(bounds, 0.0f, 0.1f)];
    [self setBounds:bounds];
    [self layoutSubviews];
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];
    
    if (!CGSizeEqualToSize(_validSize, bounds.size)) {
        _validSize = bounds.size;
        if (_layoutForSize) {
            _layoutForSize(bounds.size);
        }
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    if (!CGSizeEqualToSize(_validSize, frame.size)) {
        _validSize = frame.size;
        if (_layoutForSize) {
            _layoutForSize(frame.size);
        }
    }
}

- (void)setEditing:(BOOL)editing
{
    [self setEditing:editing animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (_editing != editing)
    {
        _editing = editing;
        
//        [self _updateAllowsSelectionPolicy];
        
        for (id cell in [self visibleCells])
        {
            if ([cell isKindOfClass:[KBEditCollectionItemView class]])
            {
                [(KBEditCollectionItemView *)cell setEditing:editing animated:animated];
            }
        }
    }
}

- (void)_updateAllowsSelectionPolicy
{
    if (_editing)
    {
        [super setAllowsSelection:_allowsSelectionDuringEditing];
        [super setAllowsMultipleSelection:_allowsMultipleSelectionDuringEditing];
    } else {
        [super setAllowsSelection:_pAllowsSelection];
        [super setAllowsMultipleSelection:_pAllowsMultipleSelection];
    }
}

- (void)selectCell:(UICollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath != nil)
    {
        id<UICollectionViewDelegate> delegate = self.delegate;
        if (![delegate respondsToSelector:@selector(collectionView:shouldSelectItemAtIndexPath:)] || [delegate collectionView:self shouldSelectItemAtIndexPath:indexPath])
        {
            [self selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            
            if ([delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)])
                [delegate collectionView:self didSelectItemAtIndexPath:indexPath];
        }
    }
}

- (void)deselectCell:(UICollectionViewCell *)cell
{
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    if (indexPath != nil)
    {
        id<UICollectionViewDelegate> delegate = self.delegate;
        if (![delegate respondsToSelector:@selector(collectionView:shouldDeselectItemAtIndexPath:)] || [delegate collectionView:self shouldDeselectItemAtIndexPath:indexPath])
        {
            [self deselectItemAtIndexPath:indexPath animated:NO];
            
            if ([delegate respondsToSelector:@selector(collectionView:didDeselectItemAtIndexPath:)])
                [delegate collectionView:self didDeselectItemAtIndexPath:indexPath];
        }
    }    
}

- (void)dealloc
{
}

/*
- (void)updateVisibleItemsNow
{
    CGRect bounds = self.bounds;
    [self setBounds:CGRectOffset(bounds, 0.0f, 0.1f)];
    [self setBounds:bounds];
    [self layoutSubviews];
}

- (void)reloadData
{
    [super reloadData];
    [self updateVisibleItemsNow];
    [self layoutSubviews];
    
    CGPoint offset = self.contentOffset;
    UIEdgeInsets inset = self.contentInset;
    
    if (offset.y < -inset.top)
    {
        offset.y = -inset.top;
        CGRect bounds = self.bounds;
        bounds.origin.y = offset.y;
        self.bounds = bounds;
    }
}

- (BOOL)canCancelContentTouches
{
    return true;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)__unused view
{
    return true;
}
 */

- (void)setAllowsSelection:(BOOL)allowsSelection
{
    [super setAllowsSelection:allowsSelection];
    _pAllowsSelection = allowsSelection;
}

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    [super setAllowsMultipleSelection:allowsMultipleSelection];
    _pAllowsMultipleSelection = allowsMultipleSelection;
}

- (void)setAllowsSelectionDuringEditing:(BOOL)allowsSelectionDuringEditing
{
    _allowsSelectionDuringEditing = allowsSelectionDuringEditing;
    [self _updateAllowsSelectionPolicy];
}

- (void)setAllowsMultipleSelectionDuringEditing:(BOOL)allowsMultipleSelectionDuringEditing
{
    _allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing;
    [self _updateAllowsSelectionPolicy];
}



@end
