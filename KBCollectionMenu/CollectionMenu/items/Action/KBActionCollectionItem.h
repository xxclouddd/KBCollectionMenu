//
//  KBActionCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/28.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBActionCollectionItem : KBCollectionItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, assign) NSInteger itemHeight;
@property (nonatomic, strong) UIColor *normalBackgroundColor;
@property (nonatomic, strong) UIColor *disableBackgroundColor;

@property (nonatomic, strong) UIColor *borderColor;
@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, weak) id target;
@property (nonatomic) SEL action;

- (instancetype)initWithTitle:(NSString *)title;

- (void)addTarget:(id)target action:(SEL)action;

@end
