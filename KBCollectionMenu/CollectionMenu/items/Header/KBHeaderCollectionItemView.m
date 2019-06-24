//
//  KBHeaderCollectionItemView.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBHeaderCollectionItemView.h"

@interface KBHeaderCollectionItemView ()
{
    UILabel *_label;
}

@end

@implementation KBHeaderCollectionItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _label = [[UILabel alloc] init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor lightGrayColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentLeft;
        _label.lineBreakMode = NSLineBreakByTruncatingTail;
        _label.numberOfLines = 1;
        [self addSubview:_label];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _label.text = title;
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize labelSize = [_label sizeThatFits:CGSizeMake(self.bounds.size.width - 30.0f, CGFLOAT_MAX)];
    _label.frame = CGRectMake(15.0f, 0.0f, labelSize.width, labelSize.height);
}

@end
