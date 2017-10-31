//
//  KBDetailCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/12/15.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"
#import "KBDetailCollectionItemView.h"

@interface KBDetailCollectionItem : KBCollectionItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *detail;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIFont *detailFont;
@property (nonatomic, strong) UIColor *detailColor;

@property (nonatomic, assign) KBDetailCollectionItemViewAccessoryType accessoryType;

@property (nonatomic) SEL action;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail;
- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon;

@end
