//
//  KBSwitchCollectionItem.h
//  test4
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCollectionItem.h"

@protocol KBSwitchCollectionItemDelegate;
@interface KBSwitchCollectionItem : KBCollectionItem

@property (nonatomic, copy) void (^toggled)(BOOL value);

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic) BOOL isOn;
@property (nonatomic, weak) id<KBSwitchCollectionItemDelegate>delegate;

- (instancetype)initWithTitle:(NSString *)title isOn:(BOOL)isOn;
- (void)setIsOn:(BOOL)isOn animated:(BOOL)animated;

@end

@protocol KBSwitchCollectionItemDelegate <NSObject>
@optional
- (void)switchCollectionItem:(KBSwitchCollectionItem *)item isOn:(BOOL)isOn;

@end
