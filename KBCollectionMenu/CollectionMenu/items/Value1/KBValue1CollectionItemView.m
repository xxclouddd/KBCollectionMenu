//
//  KBValue1CollectionItemView.m
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/8/3.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBValue1CollectionItemView.h"

@interface KBValue1CollectionItemView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;

@end

@implementation KBValue1CollectionItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]) == nil) return nil;
    
    _breakLine = NO;
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [[UILabel alloc] init];
    _detailLabel.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
    _detailLabel.font = [UIFont systemFontOfSize:16];
//    _detailLabel.textAlignment = NSTextAlignmentRight;
    _detailLabel.numberOfLines = _breakLine ? 0 : 1;
    [self.contentView addSubview:_detailLabel];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat leftX = 15;
    
    CGSize titleSize = [self.titleLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _titleLabel.font} context:NULL].size;
    CGSize detailSize = [self.detailLabel.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _detailLabel.font} context:NULL].size;
    
    _titleLabel.frame = CGRectMake(leftX, 0, titleSize.width, size.height);
    
    CGFloat gapBetweenTitleAndDetail = titleSize.width > 0 ? 15 : 0;
    leftX += titleSize.width + gapBetweenTitleAndDetail;
    
    detailSize = CGSizeMake(MIN(detailSize.width, size.width - leftX - 15), detailSize.height);
    leftX = size.width - leftX - 15 >= detailSize.width ? size.width - 15 - detailSize.width : leftX;
    
    _detailLabel.frame = CGRectMake(leftX, 0, detailSize.width, size.height);
}

- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    _titleLabel.text = titleText;
    [self setNeedsLayout];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    _titleLabel.font = titleFont;
    [self setNeedsLayout];
}

- (void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    _detailLabel.text = detailText;
    [self setNeedsLayout];
}

- (void)setDetailColor:(UIColor *)detailColor
{
    _detailColor = detailColor;
    _detailLabel.textColor = detailColor;
}

- (void)setDetailFont:(UIFont *)detailFont
{
    _detailFont = detailFont;
    _detailLabel.font = detailFont;
    [self setNeedsLayout];
}

- (void)setBreakLine:(BOOL)breakLine
{
    _breakLine = breakLine;
    _detailLabel.numberOfLines = _breakLine ? 0 : 1;
    [self setNeedsLayout];
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle
{
    _attributedTitle = attributedTitle;
    _titleLabel.attributedText = attributedTitle;
    [self setNeedsLayout];
}

- (void)setAttributedDetail:(NSAttributedString *)attributedDetail
{
    _attributedDetail = attributedDetail;
    _detailLabel.attributedText = attributedDetail;
    [self setNeedsLayout];
}





@end
