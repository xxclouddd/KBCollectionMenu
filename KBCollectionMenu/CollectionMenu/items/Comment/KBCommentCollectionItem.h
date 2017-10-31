//
//  KBCommentCollectionItem.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/7.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBCommentCollectionItem : KBCollectionItem

@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) UIEdgeInsets insets;

- (instancetype)initWithText:(NSString *)text;

@end
