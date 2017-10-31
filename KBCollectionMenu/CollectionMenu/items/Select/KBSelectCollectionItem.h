//
//  KBSelectCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBEditCollectionItem.h"

@interface KBSelectCollectionItem : KBEditCollectionItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) CGFloat leftInset;
@property (nonatomic, assign) CGFloat leftInsetDuringEditing;

@property (nonatomic) SEL selectAction;
@property (nonatomic) SEL deselectAction;

- (instancetype)initWithTitle:(NSString *)title;

@end
