//
//  KBInsetCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/13.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItemView.h"

@interface KBInsetCollectionItemView : KBCollectionItemView

@property (nonatomic, strong) UIView *view;
@property (nonatomic) UIEdgeInsets insets;
@property (nonatomic) CGFloat additionalSeparatorInset;

@end
