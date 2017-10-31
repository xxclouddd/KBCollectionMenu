//
//  KBCommentCollectionItemView.h
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/7.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCollectionItemView.h"

@interface KBCommentCollectionItemView : KBCollectionItemView

@property (nonatomic, assign) UIEdgeInsets contentInsets;

- (void)setText:(NSString *)text;
- (void)setFont:(UIFont *)font;

@end
