//
//  KBDetailCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/12/15.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBDetailCollectionItemView.h"

@interface KBDetailCollectionItemView ()
{
    UIImageView *_iconView;
    UIImageView *_accessoryView;
    UILabel *_titleLabel;
    UILabel *_detailLabel;
}

@end

@implementation KBDetailCollectionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLabel.font = KBSystemFontOfSize(16);
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)setDetail:(NSString *)detail
{
    if (detail != nil)
    {
        if (_detailLabel == nil)
        {
            _detailLabel = [[UILabel alloc] init];
            _detailLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
            _detailLabel.backgroundColor = [UIColor clearColor];
            _detailLabel.font = KBSystemFontOfSize(12);
            [self.contentView addSubview:_detailLabel];
        }
        
        _detailLabel.text = detail;
        [self setNeedsLayout];
    }
}

- (void)setIcon:(UIImage *)icon
{
    if (icon != nil)
    {
        if (_iconView == nil)
        {
            _iconView = [[UIImageView alloc] init];
            [self.contentView addSubview:_iconView];
        }
        
        _iconView.image = icon;
        [self setNeedsLayout];
    }
}

- (void)setAccessoryType:(KBDetailCollectionItemViewAccessoryType)accessoryType
{
    if (accessoryType != KBDetailCollectionItemViewAccessoryNone) {
        if (_accessoryView == nil) {
            _accessoryView = [[UIImageView alloc] init];
            [self.contentView addSubview:_accessoryView];
        }
        
        if (accessoryType == KBDetailCollectionItemViewAccessoryDisclosureIndicator) {
            _accessoryView.image = [UIImage imageNamed:@"return_right_icon"];
        } else {
            NSAssert(NO, @"unknow type");
        }
        
        [self setNeedsLayout];
    } else {
        _accessoryView.image = nil;
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleLabel.font = titleFont;
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleLabel.textColor = titleColor;
}

- (void)setDetailFont:(UIFont *)detailFont
{
    _detailLabel.font = detailFont;
    [self setNeedsLayout];
}

- (void)setDetailColor:(UIColor *)detailColor
{
    _detailLabel.textColor = detailColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGSize size = self.contentView.frame.size;
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(size.width, CGFLOAT_MAX)];
    CGSize detailSize = [_detailLabel sizeThatFits:CGSizeMake(size.width, CGFLOAT_MAX)];

    CGFloat titleBetweenDetailGap = 6;
    CGFloat startingX = 15.0f;
    CGFloat startingY = (size.height - titleSize.height - detailSize.height - titleBetweenDetailGap) / 2.0;
    
    if (_iconView.image != nil)
    {
        CGSize imageSize = _iconView.image.size;
        _iconView.frame = CGRectMake(startingX, (size.height - imageSize.height) / 2, imageSize.width, imageSize.height);

        startingX += imageSize.width;
        startingX += 10;
    }

    _titleLabel.frame = CGRectMake(startingX, startingY, size.width - startingX, titleSize.height);
    startingY += titleSize.height + titleBetweenDetailGap;

    _detailLabel.frame = CGRectMake(startingX, startingY, size.width - startingX, detailSize.height);
    
    CGSize accessoryImageSize = _accessoryView.image.size;
    _accessoryView.frame = CGRectMake(size.width - accessoryImageSize.width - 15, floorf((size.height - accessoryImageSize.height) / 2), accessoryImageSize.width, accessoryImageSize.height);
}

@end
