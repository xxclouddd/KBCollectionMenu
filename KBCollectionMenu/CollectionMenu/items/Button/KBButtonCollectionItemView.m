
//
//  KBButtonCollectionItemView.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBButtonCollectionItemView.h"

@interface KBButtonCollectionItemView ()
{
    UIImageView *_iconView;
    UILabel *_titleLabel;
    NSTextAlignment _alignment;
}

@end

@implementation KBButtonCollectionItemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"init");
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_titleLabel];        
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
    
    [self setNeedsLayout];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleLabel.font = titleFont;
    
    [self setNeedsLayout];
}

- (void)setAtttributedTitle:(NSAttributedString *)atttributedTitle
{
    _titleLabel.attributedText = atttributedTitle;
 
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleLabel.textColor = titleColor;
}

- (void)setTitleAlignment:(NSTextAlignment)alignment
{
    _alignment = alignment;
    
    [self setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled
{
    _titleLabel.alpha = enabled ? 1.0f : 0.5f;
}

- (void)setIcon:(UIImage *)icon
{
    if (icon != nil) {
        if (_iconView == nil) {
            _iconView = [[UIImageView alloc] init];
        }
        
        if (_iconView.superview == nil) {
            [self addSubview:_iconView];
        }
        _iconView.image = icon;
    } else {
        _iconView.image = nil;
        [_iconView removeFromSuperview];
    }
    
    [self setNeedsLayout];
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
    
    /*
    CGRect bounds = self.bounds;
    
    CGFloat inset = _leftInset;
    
    if (_iconView.superview != nil) {
        CGSize iconSize = _iconView.image.size;
        _iconView.frame = CGRectMake(floor((_leftInset - iconSize.width) / 2.0f), floor((bounds.size.height - iconSize.height) / 2.0f), iconSize.width, iconSize.height);
    }
    
    _titleLabel.frame = CGRectMake(inset, floor((bounds.size.height - 26) / 2), bounds.size.width - inset - 15.0f, 26);
    [_titleLabel sizeToFit];
    
    //    CGFloat verticalOffset = KBRetinaPixel;
    CGFloat verticalOffset = 0.5;
    if (_itemPosition & KBCollectionItemViewPositionLastInBlock)
        verticalOffset -= 0.5;
    if (_itemPosition & KBCollectionItemViewPositionFirstInBlock)
        verticalOffset += 0.5;
    
    if (_alignment == NSTextAlignmentCenter)
        _titleLabel.frame = CGRectMake(floor((bounds.size.width - _titleLabel.frame.size.width) / 2), floor((bounds.size.height - _titleLabel.frame.size.height) / 2) + verticalOffset, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
    else
        _titleLabel.frame = CGRectMake(inset, floor((bounds.size.height - _titleLabel.frame.size.height) / 2) + verticalOffset, _titleLabel.frame.size.width, _titleLabel.frame.size.height);
     */
    CGRect bounds = self.bounds;
    
    CGFloat startingX = _leftInset;
    if (_iconView.image != nil) {
        CGSize iconSize = _iconView.image.size;
        _iconView.frame = CGRectMake(startingX, floor((bounds.size.height - iconSize.height) / 2.0f), iconSize.width, iconSize.height);
        startingX += _iconView.image.size.width;
        startingX += 10;
    }
    
    
    CGSize titleSize = [_titleLabel sizeThatFits:CGSizeMake(bounds.size.width - startingX - 15.0f, CGFLOAT_MAX)];
    _titleLabel.frame = CGRectMake(startingX, floor((bounds.size.height - titleSize.height) / 2), MIN(bounds.size.width - startingX - 15.0f, titleSize.width), titleSize.height);
    
    if (_alignment == NSTextAlignmentCenter) {
        CGRect titleFrame = _titleLabel.frame;
        titleFrame.origin.x = floor((bounds.size.width - _titleLabel.frame.size.width) / 2);
        _titleLabel.frame = titleFrame;
    } else {
        CGRect titleFrame = _titleLabel.frame;
        titleFrame.origin.x = startingX;
        _titleLabel.frame = titleFrame;
    }

}


@end
