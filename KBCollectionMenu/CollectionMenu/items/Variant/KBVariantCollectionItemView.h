//
//  KBVariantCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItemView.h"

@interface KBVariantCollectionItemView : KBCollectionItemView

@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat additionalSeparatorInset;

- (void)setTitle:(NSString *)title;
- (void)setTitleColor:(UIColor *)color;
- (void)setTitleFont:(UIFont *)font;

- (void)setVariant:(NSString *)variant;
- (void)setVariantColor:(UIColor *)color;
- (void)setVariantFont:(UIFont *)font;

- (void)setIcon:(UIImage *)icon;
- (void)setEnabled:(BOOL)enabled;

@end
