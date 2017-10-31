//
//  KBActionCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/28.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItemView.h"

@interface KBActionCollectionItemView : KBCollectionItemView

- (void)setTitle:(NSString *)title;
- (void)setEnable:(BOOL)enable;

- (void)setBorderWidth:(CGFloat)borderWidth;
- (void)setBorderColor:(UIColor *)borderColor;
- (void)setTitleColor:(UIColor *)titleColor;
- (void)setNormalBtnBackgroundColor:(UIColor *)color;
- (void)setDisableBtnBackgroundColor:(UIColor *)color;
- (void)addTarget:(id)target action:(SEL)action;

@end
