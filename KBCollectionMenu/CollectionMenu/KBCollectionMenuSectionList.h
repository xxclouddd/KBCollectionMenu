//
//  KBCollectionMenuSectionList.h
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBCollectionMenuSection.h"

@interface KBCollectionMenuSectionList : NSObject

@property (nonatomic, readonly) NSArray *sections;

- (void)addSection:(KBCollectionMenuSection *)section;
- (void)insertSection:(KBCollectionMenuSection *)section atIndex:(NSUInteger)index;
- (void)deleteSection:(NSUInteger)section;

- (void)addItemToSection:(NSUInteger)section item:(KBCollectionItem *)item;
- (void)insertItem:(KBCollectionItem *)item toSection:(NSUInteger)section atIndex:(NSUInteger)index;
- (void)deleteItemFromSection:(NSUInteger)section atIndex:(NSUInteger)index;
- (void)replaceItemInSection:(NSUInteger)section atIndex:(NSUInteger)index withItem:(KBCollectionItem *)item;

- (NSUInteger)indexOfSection:(KBCollectionMenuSection *)section;
- (KBCollectionMenuSection *)sectionAtIndex:(NSUInteger)index;

- (void)beginRecordingChanges;
- (BOOL)commitRecordedChanges:(UICollectionView *)collectionView;
- (BOOL)commitRecordedChanges:(UICollectionView *)collectionView additionalActions:(void (^)())additionalActions;

@end
