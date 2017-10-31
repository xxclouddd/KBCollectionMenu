//
//  KBInsetCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/10/13.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBInsetCollectionItemView.h"
#import <Masonry.h>

@implementation KBInsetCollectionItemView

- (void)setView:(UIView *)view
{    
    if (_view != view)
    {
        _view = view;
        
        if (view)
        {
            [self.contentView addSubview:view];
            
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self.contentView).insets(_insets);
            }];
        }
    }
}

- (void)setInsets:(UIEdgeInsets)insets
{
    _insets = insets;
    
    [_view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(_insets);
    }];
    
    [self layoutIfNeeded];
}

- (void)setAdditionalSeparatorInset:(CGFloat)additionalSeparatorInset
{
    _additionalSeparatorInset = additionalSeparatorInset;
    self.separatorInset = _additionalSeparatorInset;
    
    [self setNeedsLayout];
}


@end
