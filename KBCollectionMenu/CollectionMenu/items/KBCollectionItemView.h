//
//  KBCollectionItemView.h
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBCommon.h"
@class KBCollectionItem;

typedef enum {
    KBCollectionItemViewPositionFirstInBlock = 1,
    KBCollectionItemViewPositionLastInBlock = 2,
    KBCollectionItemViewPositionMiddleInBlock = 4,
    KBCollectionItemViewPositionIncludeNextSeparator = 8
} KBCollectionItemViewPosition;

@interface KBCollectionItemView : UICollectionViewCell
{
    UIView *_topStripeView;
    UIView *_bottomStripeView;
    
    int _itemPosition;
}

@property (nonatomic, assign) CGFloat separatorInset;
@property (nonatomic, assign) UIEdgeInsets selectionInsets;
@property (nonatomic, assign) UIColor *sepertorColor;

- (void)setItemPosition:(int)itemPosition;
- (void)setItemPosition:(int)itemPosition animated:(BOOL)animated;

@property (nonatomic, weak) KBCollectionItem *boundItem;

// If subclass overload this method, it must call [super layoutSubviews].
- (void)layoutSubviews;

@end
