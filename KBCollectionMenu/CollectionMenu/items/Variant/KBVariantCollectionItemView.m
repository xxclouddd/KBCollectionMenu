//
//  KBVariantCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBVariantCollectionItemView.h"

@interface KBVariantCollectionItemView ()
{
    UILabel *_titleLabel;
    UILabel *_variantLabel;
    UIImageView *_iconView;
    UIImageView *_disclosureIndicator;
}

@end

@implementation KBVariantCollectionItemView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KBGray1Color();
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = KBSystemFontOfSize(16);
        [self.contentView addSubview:_titleLabel];
        
        _variantLabel = [[UILabel alloc] init];
        _variantLabel.textColor = [UIColor lightGrayColor];
        _variantLabel.backgroundColor = [UIColor clearColor];
        _variantLabel.font = KBSystemFontOfSize(15);
        [self.contentView addSubview:_variantLabel];
        
        _disclosureIndicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"return_right_icon"]];
        [self.contentView addSubview:_disclosureIndicator];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setTitleFont:(UIFont *)font
{
    _titleLabel.font = font ?: KBSystemFontOfSize(16);
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)color
{
    _titleLabel.textColor = color ?: KBGray1Color();
}

- (void)setVariant:(NSString *)variant
{
    _variantLabel.text = variant;
    [self setNeedsLayout];
}

- (void)setVariantColor:(UIColor *)color
{
    _variantLabel.textColor = color ?: [UIColor lightGrayColor];
}

- (void)setVariantFont:(UIFont *)font
{
    _variantLabel.font = font ?: KBSystemFontOfSize(15);
    [self setNeedsLayout];
}

- (void)setIcon:(UIImage *)icon
{
    if (icon != nil)
    {
        if (_iconView == nil) {
            _iconView = [[UIImageView alloc] init];
        }
        
        if (_iconView.superview == nil) {
            [self.contentView addSubview:_iconView];
        }
        _iconView.image = icon;
        [_iconView sizeToFit];
    }
    else
    {
        _iconView.image = nil;
        [_iconView removeFromSuperview];
    }
    
    [self setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled
{
    self.userInteractionEnabled = enabled;
    
    _titleLabel.alpha = enabled ? 1.0f : 0.5f;
}

- (void)setLeftInset:(CGFloat)leftInset
{
    _leftInset = leftInset;
    self.separatorInset = _leftInset + _additionalSeparatorInset;
    
    [self setNeedsLayout];
}

- (void)setAdditionalSeparatorInset:(CGFloat)additionalSeparatorInset
{
    _additionalSeparatorInset = additionalSeparatorInset;
    self.separatorInset = _leftInset + _additionalSeparatorInset;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(bounds.size.width, CGFLOAT_MAX)];
    CGSize variantSize = [_variantLabel sizeThatFits:CGSizeMake(bounds.size.width, CGFLOAT_MAX)];
    
    _disclosureIndicator.frame = CGRectMake(bounds.size.width - _disclosureIndicator.frame.size.width - 15, floorf((bounds.size.height - _disclosureIndicator.frame.size.height) / 2), _disclosureIndicator.frame.size.width, _disclosureIndicator.frame.size.height);
    
    CGFloat startingX = _leftInset;
    if (_iconView.image != nil) {
        startingX += _iconView.image.size.width;
        startingX += 10;
    }
    
    CGFloat indicatorSpacing = 10.0f;
    CGFloat labelSpacing = 8.0f;
    CGFloat availableWidth = _disclosureIndicator.frame.origin.x - startingX - indicatorSpacing;
    
    CGFloat titleY =  floorf((bounds.size.height - titleSize.height) / 2.0f) + 0.5;
    CGFloat variantY =  floorf((bounds.size.height - variantSize.height) / 2.0f) + 0.5;
    
    if (titleSize.width + labelSpacing + variantSize.width <= availableWidth)
    {
        _titleLabel.frame = CGRectMake(startingX, titleY, titleSize.width, titleSize.height);
        _variantLabel.frame = CGRectMake(startingX + availableWidth - variantSize.width, variantY, variantSize.width, variantSize.height);
    }
    else if (titleSize.width > variantSize.width)
    {
        CGFloat titleWidth = floorf(availableWidth * 2.0f / 3.0f) - labelSpacing;
        _titleLabel.frame = CGRectMake(startingX, titleY, titleWidth, titleSize.height);
        CGFloat variantWidth = MIN(variantSize.width, availableWidth - titleWidth - labelSpacing);
        _variantLabel.frame = CGRectMake(startingX + availableWidth - variantWidth, variantY, variantWidth, variantSize.height);
    }
    else
    {
        CGFloat variantWidth = floorf(availableWidth / 2.0f) - labelSpacing;
        _variantLabel.frame = CGRectMake(startingX + availableWidth - variantWidth, variantY, variantWidth, variantSize.height);
        CGFloat titleWidth = MIN(titleSize.width, availableWidth - variantWidth - labelSpacing);
        _titleLabel.frame = CGRectMake(startingX, titleY, titleWidth, titleSize.height);
    }
    
    if (_iconView.image != nil)
    {
        _iconView.frame = CGRectMake(15, (self.frame.size.height - _iconView.frame.size.height) / 2, _iconView.frame.size.width, _iconView.frame.size.height);
    }
}


@end

