//
//  KBDetailCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/12/15.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItemView.h"

typedef NS_ENUM(NSInteger, KBDetailCollectionItemViewAccessoryType) {
    KBDetailCollectionItemViewAccessoryNone,
    KBDetailCollectionItemViewAccessoryDisclosureIndicator,
};

@interface KBDetailCollectionItemView : KBCollectionItemView

- (void)setAccessoryType:(KBDetailCollectionItemViewAccessoryType)accessoryType;
- (void)setTitle:(NSString *)title;
- (void)setDetail:(NSString *)detail;
- (void)setIcon:(UIImage *)icon;

- (void)setTitleFont:(UIFont *)titleFont;
- (void)setTitleColor:(UIColor *)titleColor;

- (void)setDetailFont:(UIFont *)detailFont;
- (void)setDetailColor:(UIColor *)detailColor;

@end
