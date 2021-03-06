//
//  KBValue1CollectionItem.h
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/8/3.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBCollectionItem.h"

@interface KBValue1CollectionItem : KBCollectionItem

@property (nonatomic, assign) BOOL breakLine;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) NSString *detailText;
@property (nonatomic, strong) UIColor *detailColor;
@property (nonatomic, strong) UIFont *detailFont;

@property (nonatomic, strong) NSAttributedString *attributedTitle;
@property (nonatomic, strong) NSAttributedString *attributedDetail;

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail;

@end
