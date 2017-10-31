//
//  KBEditCollectionItemView.h
//  test4
//
//  Created by 肖雄 on 16/10/11.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionItemView.h"

typedef NS_ENUM(NSInteger, KBCollectionItemViewEditingMode) {
    KBCollectionItemViewEditingModeNone,
    KBCollectionItemViewEditingModeSelect,
    KBCollectionItemViewEditingModeDelete
};

@interface KBEditCollectionItemView : KBCollectionItemView

@property (nonatomic) BOOL allowEditing;
@property (nonatomic) BOOL editing;
@property (nonatomic) BOOL selectable;
@property (nonatomic) KBCollectionItemViewEditingMode editingMode;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
