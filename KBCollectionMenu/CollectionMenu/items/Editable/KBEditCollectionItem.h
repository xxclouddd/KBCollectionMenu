//
//  KBEditCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBEditCollectionItem : KBCollectionItem

@property (nonatomic) BOOL allowEditing;
@property (nonatomic) BOOL editing;

- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@end
