
//
//  KBCollectionItem.m
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBCollectionItem ()
{
    NSString *_viewIdentifier;
}

@end

@implementation KBCollectionItem

- (instancetype)init
{
    self = [super init];
    if (self != nil)
    {
        _highlightable = YES;
        _selectable = YES;
        _deselectAutomatically = YES;
        _seperatorColor = KBSeparatorColor();        
    }
    return self;
}

- (Class)itemViewClass
{
    return nil;
}

- (BOOL)loadNib
{
    return NO;
}

- (UINib *)itemViewNib
{
    Class class = [self itemViewClass];
    if (!class) return nil;

    return [UINib nibWithNibName:NSStringFromClass(class) bundle:nil];
}

- (KBCollectionItemView *)dequeueItemView:(UICollectionView *)collectionView registeredIdentifiers:(NSMutableSet *)registeredIdentifiers forIndexPath:(NSIndexPath *)indexPath
{
    if (_viewIdentifier == nil)
        _viewIdentifier = [[NSString alloc] initWithFormat:@"View_%@", NSStringFromClass([self itemViewClass])];
    if (![registeredIdentifiers containsObject:_viewIdentifier])
    {
        if ([self loadNib]) {
            [collectionView registerNib:[self itemViewNib] forCellWithReuseIdentifier:_viewIdentifier];
        } else {
            [collectionView registerClass:[self itemViewClass] forCellWithReuseIdentifier:_viewIdentifier];
        }
        
        [registeredIdentifiers addObject:_viewIdentifier];
    }
    
    return [collectionView dequeueReusableCellWithReuseIdentifier:_viewIdentifier forIndexPath:indexPath];
}


- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 0);
}

- (void)bindView:(KBCollectionItemView *)view
{
    _view = view;
    _view.boundItem = self;
    _view.sepertorColor = self.seperatorColor;
}

- (void)unbindView
{
    _view.boundItem = nil;
    _view = nil;
}

- (KBCollectionItemView *)boundView
{
    return _view;
}

- (void)setSeperatorColor:(UIColor *)seperatorColor
{
    _seperatorColor = seperatorColor;
    [(KBCollectionItemView *)self.view setSepertorColor:seperatorColor];
}

- (void)itemSelected:(id)__unused actionTarget
{
}

- (void)itemDeselected:(id)__unused actionTarget
{

}

- (BOOL)itemWantsMenu
{
    return false;
}

- (BOOL)itemCanPerformAction:(SEL)__unused action
{
    return false;
}

- (void)itemPerformAction:(SEL)__unused action
{
}


@end
