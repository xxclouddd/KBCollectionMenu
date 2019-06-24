//
//  KBValue1CollectionItem.m
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/8/3.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBValue1CollectionItem.h"
#import "KBValue1CollectionItemView.h"

@implementation KBValue1CollectionItem

- (instancetype)initWithTitle:(NSString *)title detail:(NSString *)detail
{
    if ((self = [super init]) == nil) return nil;
    
    self.highlightable = false;
    self.selectable = false;
    
    _titleText = title;
    _detailText = detail;
    
    _breakLine = NO;
    _titleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleFont = [UIFont systemFontOfSize:16];
    _detailColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
    _detailFont = [UIFont systemFontOfSize:16];
    
    return self;
}

- (Class)itemViewClass
{
    return [KBValue1CollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    if (!self.breakLine) {
        return CGSizeMake(containerSize.width, 49);
    }
    
    NSString *title = self.attributedTitle ? self.attributedTitle.string : self.titleText;
    NSString *detail = self.attributedDetail ? self.attributedDetail.string : self.detailText;
    
    CGSize titleSize = [title boundingRectWithSize:containerSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _titleFont} context:NULL].size;
    
    CGFloat gapBetweenTitleAndDetail = titleSize.width > 0 ? 15 : 0;
    CGSize expectedSize = CGSizeMake(containerSize.width - titleSize.width - gapBetweenTitleAndDetail - 30, containerSize.height);
    CGSize detailSize = [detail boundingRectWithSize:expectedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _detailFont} context:NULL].size;
    
    return CGSizeMake(containerSize.width, MAX(detailSize.height+20, 49));
}

- (void)bindView:(KBValue1CollectionItemView *)view
{
    [super bindView:view];
    
    view.breakLine = self.breakLine;
    view.titleText = self.titleText;
    view.titleColor = self.titleColor;
    view.titleFont = self.titleFont;
    view.detailText = self.detailText;
    view.detailColor = self.detailColor;
    view.detailFont = self.detailFont;
    
    if (self.attributedTitle || !self.titleText) {
        view.attributedTitle = self.attributedTitle;
    }
    
    if (self.attributedDetail || !self.detailText) {
        view.attributedDetail = self.attributedDetail;
    }
}

#pragma mark - setter 
- (void)setTitleText:(NSString *)titleText
{
    _titleText = titleText;
    [(KBValue1CollectionItemView *)self.view setTitleText:titleText];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    [(KBValue1CollectionItemView *)self.view setTitleColor:titleColor];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [(KBValue1CollectionItemView *)self.view setTitleFont:titleFont];
}

- (void)setDetailText:(NSString *)detailText
{
    _detailText = detailText;
    [(KBValue1CollectionItemView *)self.view setDetailText:detailText];
}

- (void)setDetailColor:(UIColor *)detailColor
{
    _detailColor = detailColor;
    [(KBValue1CollectionItemView *)self.view setDetailColor:detailColor];
}

- (void)setDetailFont:(UIFont *)detailFont
{
    _detailFont = detailFont;
    [(KBValue1CollectionItemView *)self.view setDetailFont:detailFont];
}

- (void)setBreakLine:(BOOL)breakLine
{
    _breakLine = breakLine;
    [(KBValue1CollectionItemView *)self.view setBreakLine:breakLine];
}

- (void)setAttributedTitle:(NSAttributedString *)attributedTitle
{
    _attributedTitle = attributedTitle;
    [(KBValue1CollectionItemView *)self.view setAttributedTitle:attributedTitle];
}

- (void)setAtributedDetail:(NSAttributedString *)attributedDetail
{
    _attributedDetail = attributedDetail;
    [(KBValue1CollectionItemView *)self.view setAttributedDetail:attributedDetail];
}

@end
