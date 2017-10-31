//
//  KBVariantCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBVariantCollectionItem : KBCollectionItem

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) NSString *variant;
@property (nonatomic, strong) UIFont *variantFont;
@property (nonatomic, strong) UIColor *variantColor;

@property (nonatomic, assign) CGFloat itemHeight;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic) SEL action;
@property (nonatomic) BOOL enabled;

@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat additionalSeparatorInset;

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action;
- (instancetype)initWithTitle:(NSString *)title variant:(NSString *)variant action:(SEL)action;


@end
