//
//  KBButtonCollectionItem.m
//  test4
//
//  Created by 肖雄 on 16/9/27.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBButtonCollectionItem.h"
#import "KBButtonCollectionItemView.h"

@implementation KBButtonCollectionItem

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action
{
    self = [super init];
    if (self != nil)
    {
        _title = title;
        _titleColor = [UIColor blackColor];
        _alignment = NSTextAlignmentLeft;
        _enabled = true;
        
        _leftInset = 15;
        
        _action = action;
        
        [self setCanBeMovedToSectionAtIndex:^BOOL(NSUInteger idx1, NSUInteger idx2) {
            return YES;
        }];
    }
    return self;
}

- (Class)itemViewClass
{
    return [KBButtonCollectionItemView class];
}

- (CGSize)itemSizeForContainerSize:(CGSize)containerSize
{
    return CGSizeMake(containerSize.width, 44);
}

- (void)itemSelected:(id)actionTarget
{
    if (_action != NULL && [actionTarget respondsToSelector:_action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [actionTarget performSelector:_action];
#pragma clang diagnostic pop
    }
}

- (void)bindView:(KBButtonCollectionItemView *)view
{
    [super bindView:view];
    
    [view setTitle:_title];
    [view setTitleColor:_titleColor];
    [view setTitleAlignment:_alignment];
    [view setEnabled:_enabled];
    
    if (_titleFont) {
        [view setTitleFont:_titleFont];
    }
    if (_atttributedTitle || (!_atttributedTitle && !_title)) {
        [view setAtttributedTitle:_atttributedTitle];
    }
    
    [view setIcon:_icon];
    
    view.leftInset = _leftInset;
    [view setAdditionalSeparatorInset:_additionalSeparatorInset];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    if (self.view != nil)
        [(KBButtonCollectionItemView *)self.view setTitle:title];
}

- (void)setEnabled:(BOOL)enabled
{
    if (_enabled != enabled)
    {
        _enabled = enabled;
        self.selectable = enabled;
        
        [(KBButtonCollectionItemView *)[self boundView] setEnabled:_enabled];
    }
}

- (void)setLeftInset:(CGFloat)leftInset
{
    _leftInset = leftInset;
    
    [(KBButtonCollectionItemView *)[self boundView] setLeftInset:_leftInset];
}

- (void)setAdditionalSeparatorInset:(CGFloat)additionalSeparatorInset {
    _additionalSeparatorInset = additionalSeparatorInset;
    
    [(KBButtonCollectionItemView *)[self boundView] setAdditionalSeparatorInset:_additionalSeparatorInset];
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    
    [(KBButtonCollectionItemView *)[self boundView] setTitleFont:titleFont];
}

- (void)setAtttributedTitle:(NSAttributedString *)atttributedTitle
{
    _atttributedTitle = atttributedTitle;
    
    [(KBButtonCollectionItemView *)[self boundView] setAtttributedTitle:atttributedTitle];
}


@end
