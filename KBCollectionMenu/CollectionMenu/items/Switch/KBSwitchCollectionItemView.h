//
//  KBSwitchCollectionItemView.h
//  test4
//
//  Created by 肖雄 on 16/9/29.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionItemView.h"

@class KBSwitchCollectionItemView;

@protocol KBSwitchCollectionItemViewDelegate <NSObject>
@optional

- (void)switchCollectionItemViewChangedValue:(KBSwitchCollectionItemView *)switchItemView isOn:(BOOL)isOn;

@end

@interface KBSwitchCollectionItemView : KBCollectionItemView

@property (nonatomic, weak) id<KBSwitchCollectionItemViewDelegate> delegate;

- (void)setTitle:(NSString *)title;
- (void)setTitleFont:(UIFont *)font;
- (void)setTitleColor:(UIColor *)titleColor;

- (void)setIsOn:(BOOL)isOn animated:(BOOL)animated;

@end
