//
//  KBCollectionMenuView.h
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KBCollectionMenuView;

@interface KBCollectionMenuView : UICollectionView

@property (nonatomic) BOOL editing;

@property (nonatomic) BOOL allowsSelectionDuringEditing;
@property (nonatomic) BOOL allowsMultipleSelectionDuringEditing;

@property (nonatomic, copy) void (^layoutForSize)(CGSize size);

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

- (void)selectCell:(UICollectionViewCell *)cell;
- (void)deselectCell:(UICollectionViewCell *)cell;

- (void)updateVisibleItemsNow;

@end
