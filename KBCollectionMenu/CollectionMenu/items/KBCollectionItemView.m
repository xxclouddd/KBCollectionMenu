//
//  KBCollectionItemView.m
//  test4
//
//  Created by 肖雄 on 16/9/26.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCollectionItemView.h"

@implementation KBCollectionItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self _initializer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self _initializer];
    }
    return self;
}

- (void)_initializer
{
    _itemPosition = 1 << 31;
    _separatorInset = 15;
    _sepertorColor = KBSeparatorColor();
    
    self.backgroundView = [[UIView alloc] init];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = KBSelectionColor();
    
    if (_topStripeView == nil) {
        _topStripeView = [[UIView alloc] init];
        _topStripeView.backgroundColor = _sepertorColor;
        [self.backgroundView addSubview:_topStripeView];
    }
    
    if (_bottomStripeView == nil) {
        _bottomStripeView = [[UIView alloc] init];
        _bottomStripeView.backgroundColor = _sepertorColor;
        [self.backgroundView addSubview:_bottomStripeView];
    }
}

- (void)setItemPosition:(int)itemPosition
{
    [self setItemPosition:itemPosition animated:false];
}

- (void)setItemPosition:(int)itemPosition animated:(BOOL)animated
{
    if (_itemPosition != itemPosition)
    {
        _itemPosition = itemPosition;
        if (animated)
        {
            [UIView animateWithDuration:0.25 animations:^
            {
                [self _updateStripes];
            }];
            [self setNeedsLayout];
        }
        else
        {
            [self _updateStripes];
            [self setNeedsLayout];
        }
    }
}

- (void)_updateStripes
{
    _topStripeView.alpha = (_itemPosition & (KBCollectionItemViewPositionFirstInBlock | KBCollectionItemViewPositionLastInBlock | KBCollectionItemViewPositionMiddleInBlock)) == 0 ? 0.0f : 1.0f;
    _bottomStripeView.alpha = (_itemPosition & (KBCollectionItemViewPositionLastInBlock | KBCollectionItemViewPositionIncludeNextSeparator)) == 0 ? 0.0f : 1.0f;
    self.backgroundView.backgroundColor = _itemPosition == 0 ? [UIColor clearColor] : [UIColor whiteColor];
}

- (void)setSepertorColor:(UIColor *)sepertorColor
{
    _sepertorColor = sepertorColor;
  
    _topStripeView.backgroundColor = sepertorColor;
    _bottomStripeView.backgroundColor = sepertorColor;
}

static void adjustSelectedBackgroundViewFrame(CGSize viewSize, int positionMask, UIEdgeInsets selectionInsets, UIView *backgroundView)
{
    CGRect frame = backgroundView.frame;
    
    float stripeHeight = 0.5f;
    
    if ((positionMask & KBCollectionItemViewPositionFirstInBlock) && (positionMask & KBCollectionItemViewPositionLastInBlock))
    {
        frame.origin.y = 0;
        frame.size.height = viewSize.height;
    }
    else if (positionMask & (KBCollectionItemViewPositionLastInBlock | KBCollectionItemViewPositionIncludeNextSeparator))
    {
        frame.origin.y = 0;
        frame.size.height = viewSize.height;
    }
    else if (positionMask & KBCollectionItemViewPositionFirstInBlock)
    {
        frame.origin.y = 0;
        frame.size.height = viewSize.height + stripeHeight;
    }
    else
    {
        frame.origin.y = 0;
        frame.size.height = viewSize.height + stripeHeight;
    }
    
    frame.origin.y -= selectionInsets.top;
    frame.size.height += selectionInsets.top + selectionInsets.bottom;
    
    backgroundView.frame = frame;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    if (selected)
    {
        adjustSelectedBackgroundViewFrame(self.frame.size, _itemPosition, _selectionInsets, self.selectedBackgroundView);
        
        [self adjustOrdering];
    }
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (highlighted)
    {
        adjustSelectedBackgroundViewFrame(self.frame.size, _itemPosition, _selectionInsets, self.selectedBackgroundView);
        
        [self adjustOrdering];
    }
}

- (void)adjustOrdering
{
    Class UITableViewCellClass = [UICollectionViewCell class];
    Class UISearchBarClass = [UISearchBar class];
    int maxCellIndex = 0;
    int index = -1;
    int selfIndex = 0;
    for (UIView *view in self.superview.subviews)
    {
        index++;
        if ([view isKindOfClass:UITableViewCellClass] || [view isKindOfClass:UISearchBarClass])
        {
            maxCellIndex = index;
            
            if (view == self)
                selfIndex = index;
        }
    }
    
    if (selfIndex < maxCellIndex)
    {
        [self.superview insertSubview:self atIndex:maxCellIndex];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize viewSize = self.bounds.size;
    
    adjustSelectedBackgroundViewFrame(viewSize, _itemPosition, _selectionInsets, self.selectedBackgroundView);
    
    static float stripeHeight = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        stripeHeight = 0.5f;
    });
    
    if (_itemPosition & KBCollectionItemViewPositionFirstInBlock)
        _topStripeView.frame = CGRectMake(0, 0, viewSize.width, stripeHeight);
    else
        _topStripeView.frame = CGRectMake(_separatorInset, 0, viewSize.width - _separatorInset, stripeHeight);
    
    if (_itemPosition & KBCollectionItemViewPositionLastInBlock)
        _bottomStripeView.frame = CGRectMake(0, viewSize.height - stripeHeight, viewSize.width, stripeHeight);
    else if (_itemPosition & KBCollectionItemViewPositionIncludeNextSeparator)
        _bottomStripeView.frame = CGRectMake(_separatorInset, viewSize.height - stripeHeight, viewSize.width - _separatorInset, stripeHeight);
}



@end


