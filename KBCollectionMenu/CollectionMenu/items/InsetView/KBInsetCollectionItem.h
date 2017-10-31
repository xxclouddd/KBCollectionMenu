//
//  KBInsetCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/13.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBInsetCollectionItem : KBCollectionItem

@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat additionalSeparatorInset;
@property (nonatomic) CGFloat presetsHeight;
@property (nonatomic, strong) UIView *insetView;

- (instancetype)initWithInsetView:(UIView *)insetView;

@end
