//
//  KBCollectionViewUpdateContext.h
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UICollectionView;

@interface KBCollectionViewUpdateContext : NSObject

- (void)insertSectionAtIndex:(NSUInteger)index;
- (void)deleteSectionAtIndex:(NSUInteger)index;
- (void)insertItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (void)deleteItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section;
- (void)replaceItemAtIndex:(NSUInteger)index inSection:(NSUInteger)section;

- (void)commit:(UICollectionView *)collectionView;

@end
