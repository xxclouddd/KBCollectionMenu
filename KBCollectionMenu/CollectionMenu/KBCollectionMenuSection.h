//
//  KBCollectionMenuSection.h
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBCollectionItem.h"

@interface KBCollectionMenuSection : NSObject

@property (nonatomic, readonly, strong) NSArray *items;

@property (nonatomic) UIEdgeInsets insets;

- (instancetype)initWithItems:(NSArray *)items;

- (void)insertItem:(KBCollectionItem *)item atIndex:(NSUInteger)index;
- (void)deleteItemAtIndex:(NSUInteger)index;
- (BOOL)deleteItem:(KBCollectionItem *)item;
- (NSUInteger)indexOfItem:(KBCollectionItem *)item;
- (void)addItem:(KBCollectionItem *)item;
- (void)replaceItems:(NSArray *)items;
- (void)replaceItemAtIndex:(NSUInteger)index withItem:(KBCollectionItem *)item;
- (KBCollectionItem *)itemAtIndex:(NSUInteger)index;

@end
