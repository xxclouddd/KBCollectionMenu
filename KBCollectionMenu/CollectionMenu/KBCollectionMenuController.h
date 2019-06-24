//
//  KBCollectionMenuController.h
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCollectionMenuSectionList.h"
#import "KBCollectionMenuLayout.h"
#import "KBCollectionItemView.h"
#import "KBCollectionMenuView.h"
#import "KBViewController.h"

@interface KBCollectionMenuController : KBViewController<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) KBCollectionMenuSectionList *menuSections;
@property (nonatomic, strong) KBCollectionMenuView *collectionView;
@property (nonatomic, strong) KBCollectionMenuLayout *collectionLayout;
@property (nonatomic) BOOL enableItemReorderingGestures;
@property (nonatomic, strong) Class collectionLayoutClass;

- (void)resetCollectionView;
- (NSIndexPath *)indexPathForItem:(KBCollectionItem *)item;
- (NSUInteger)indexForSection:(KBCollectionMenuSection *)section;

- (void)enterEditingMode:(BOOL)animated;
- (void)leaveEditingMode:(BOOL)animated;

- (void)didEnterEditingMode:(BOOL)animated;
- (void)didLeaveEditingMode:(BOOL)animated;

@end
