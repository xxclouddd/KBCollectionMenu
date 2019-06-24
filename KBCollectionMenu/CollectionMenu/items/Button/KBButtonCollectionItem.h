//
//  KBButtonCollectionItem.h
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBButtonCollectionItem : KBCollectionItem

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSAttributedString *atttributedTitle;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic) NSTextAlignment alignment;

@property (nonatomic, strong) UIImage *icon;

@property (nonatomic) CGFloat leftInset;
@property (nonatomic) CGFloat additionalSeparatorInset;

@property (nonatomic) BOOL enabled;

@property (nonatomic) SEL action;

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action;


@end
