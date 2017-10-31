//
//  KBCommentCollectionItem.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/7.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBCommentCollectionItem.h"
#import "KBCommentCollectionItemView.h"

@implementation KBCommentCollectionItem

- (instancetype)init
{
    return [self initWithText:nil];
}

- (instancetype)initWithText:(NSString *)text
{
    self = [super init];
    if (self != nil)
    {
        self.transparent = YES;
        self.highlightable = NO;
        self.selectable = NO;
        
        _text = text;
        _titleFont = [UIFont systemFontOfSize:12];
        _insets = UIEdgeInsetsMake(7, 15, 7, 15);
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBCommentCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    CGFloat height = _insets.top + _insets.bottom;
    height += [_text boundingRectWithSize:CGSizeMake(containerSize.width - _insets.left - _insets.right, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _titleFont} context:NULL].size.height;
    height = ceil(height);
    
    return CGSizeMake(containerSize.width, height);
}

- (void)bindView:(KBCommentCollectionItemView *)view
{
    [super bindView:view];
    
    [view setText:_text];
    [view setFont:_titleFont];
    [view setContentInsets:_insets];
}

#pragma mark - setter and getter
- (void)setText:(NSString *)text
{
    _text = text;
    [(KBCommentCollectionItemView *)self.view setText:text];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [(KBCommentCollectionItemView *)self.view setFont:titleFont];
}

- (void)setInsets:(UIEdgeInsets)insets
{
    _insets = insets;
    [(KBCommentCollectionItemView *)self.view setContentInsets:insets];
}


@end
