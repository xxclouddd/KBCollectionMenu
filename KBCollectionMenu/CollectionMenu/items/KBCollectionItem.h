//
//  KBCollectionItem.h
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBCollectionItemView.h"
#import "KBCommon.h"

@interface KBCollectionItem : NSObject

@property (nonatomic) BOOL highlightable;
@property (nonatomic) BOOL selectable;
@property (nonatomic) BOOL deselectAutomatically;
@property (nonatomic) BOOL transparent;
@property (nonatomic, strong) UIColor *seperatorColor;
@property (nonatomic, copy) BOOL (^canBeMovedToSectionAtIndex)(NSUInteger, NSUInteger);

@property (nonatomic, weak) KBCollectionItemView *view;

- (Class)itemViewClass;
- (UINib *)itemViewNib;
- (BOOL)loadNib;

- (KBCollectionItemView *)dequeueItemView:(UICollectionView *)collectionView registeredIdentifiers:(NSMutableSet *)registeredIdentifiers forIndexPath:(NSIndexPath *)indexPath;
- (CGSize)itemSizeForContainerSize:(CGSize)containerSize;

- (void)bindView:(KBCollectionItemView *)view;
- (void)unbindView;
- (KBCollectionItemView *)boundView;
- (void)itemSelected:(id)actionTarget;
- (void)itemDeselected:(id)actionTarget;
- (BOOL)itemWantsMenu;
- (BOOL)itemCanPerformAction:(SEL)action;
- (void)itemPerformAction:(SEL)action;

@end
