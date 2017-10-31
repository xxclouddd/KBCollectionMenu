//
//  KBSelectCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBEditCollectionItemView.h"

@interface KBSelectCollectionItemView : KBEditCollectionItemView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat leftInset;
@property (nonatomic, assign) CGFloat leftInsetDuringEditing;

@end
