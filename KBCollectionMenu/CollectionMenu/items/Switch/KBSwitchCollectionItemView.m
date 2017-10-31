//
//  TGSwitchCollectionItemView.m
//  test4
//
//  Created by 肖雄 on 16/9/29.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBSwitchCollectionItemView.h"

@interface KBSwitchCollectionItemView ()
{
    UILabel *_titleLabel;
    UISwitch *_switchView;
}

@end

@implementation KBSwitchCollectionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KBGray1Color();
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = KBSystemFontOfSize(16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_titleLabel];
        
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_switchView];
    }
    return self;
}

- (void)switchValueChanged:(__unused UISwitch *)aSwitch
{
    id<KBSwitchCollectionItemViewDelegate> delegate = _delegate;
    if ([delegate respondsToSelector:@selector(switchCollectionItemViewChangedValue:isOn:)])
        [delegate switchCollectionItemViewChangedValue:self isOn:_switchView.on];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleLabel.textColor = titleColor ?: KBGray1Color();
}

- (void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font ?: KBSystemFontOfSize(16);
}

- (void)setIsOn:(BOOL)isOn animated:(BOOL)animated
{
    [_switchView setOn:isOn animated:animated];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGSize switchSize = _switchView.bounds.size;
    _switchView.frame = CGRectMake(bounds.size.width - switchSize.width - 15.0f, floorf((bounds.size.height - switchSize.height) / 2.0f), switchSize.width, switchSize.height);
    
    _titleLabel.frame = CGRectMake(15.0f, floorf((bounds.size.height - 26.0f) / 2.0f), bounds.size.width - 15.0f - switchSize.width - 15 - 5, 26.0f);
}


@end
