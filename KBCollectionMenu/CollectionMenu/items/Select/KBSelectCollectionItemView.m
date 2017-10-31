//
//  KBSelectCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/12.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBSelectCollectionItemView.h"
#import <Masonry.h>

@interface KBSelectCollectionItemView ()

@end

@implementation KBSelectCollectionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.selectedBackgroundView = [[UIView alloc] init];
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        
        _leftInset = 15;
        _leftInsetDuringEditing = 10;
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(_leftInset);
            make.centerY.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)setLeftInset:(CGFloat)leftInset
{
    _leftInset = leftInset;
    
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(self.leftInset);
    }];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];

    [self _updateLeftInset];
}

- (void)_updateLeftInset
{
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        CGFloat left = self.editing ? self.leftInsetDuringEditing : _leftInset;
        make.left.equalTo(self.contentView).offset(left);
    }];
}

@end
