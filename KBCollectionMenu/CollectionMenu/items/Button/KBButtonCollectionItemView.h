//
//  KBButtonCollectionItemView.h
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCollectionItemView.h"

@interface KBButtonCollectionItemView : KBCollectionItemView

@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat additionalSeparatorInset;

- (void)setTitle:(NSString *)title;
- (void)setTitleFont:(UIFont *)titleFont;
- (void)setAtttributedTitle:(NSAttributedString *)atttributedTitle;
- (void)setTitleColor:(UIColor *)titleColor;
- (void)setTitleAlignment:(NSTextAlignment)alignment;

- (void)setIcon:(UIImage *)icon;

- (void)setEnabled:(BOOL)enabled;

@end
