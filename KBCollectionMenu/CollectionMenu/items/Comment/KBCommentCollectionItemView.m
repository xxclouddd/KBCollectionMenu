//
//  KBCommentCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/7.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCommentCollectionItemView.h"

@interface KBCommentCollectionItemView ()
{
    UILabel *_label;
}

@end

@implementation KBCommentCollectionItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.numberOfLines = 0;
        _label.textColor = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
        [self addSubview:_label];
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    _label.text = text;
    [self setNeedsLayout];
}

- (void)setFont:(UIFont *)font
{
    _label.font = font;
    [self setNeedsLayout];
}

- (void)setContentInsets:(UIEdgeInsets)contentInsets
{
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}

#pragma mark -
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _label.frame = CGRectMake(_contentInsets.left, _contentInsets.top, self.bounds.size.width - _contentInsets.left - _contentInsets.right, self.bounds.size.height - _contentInsets.top - _contentInsets.bottom);
}

@end
