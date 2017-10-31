//
//  KBEditCollectionItemView.m
//  test4
//
//  Created by 肖雄 on 16/10/11.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBEditCollectionItemView.h"
#import "KBCollectionMenuView.h"

@interface KBEditCollectionItemView ()<UIGestureRecognizerDelegate>
{
    UIPanGestureRecognizer *_panGestureRecognizer;
    UITapGestureRecognizer *_tapGestureRecognizer;
    UIImageView *_editView;
}

@end

@implementation KBEditCollectionItemView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initializer];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializer];
    }
    return self;
}

- (void)initializer
{
    _allowEditing = YES;
    _selectable = YES;
        
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    [self addGestureRecognizer:_panGestureRecognizer];
    _panGestureRecognizer.delegate = self;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self addGestureRecognizer:_tapGestureRecognizer];
    _tapGestureRecognizer.delegate = self;
}

#pragma mark - setter
- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self _updateEditView];
}

- (void)setSelectable:(BOOL)selectable
{
    _selectable = selectable;
    
    [self _updateEditView];
}

- (void)setEditing:(BOOL)editing
{
    [self setEditing:editing animated:NO];
}

- (void)setEditingMode:(KBCollectionItemViewEditingMode)editingMode
{
    if (_editingMode != editingMode) {
        _editingMode = editingMode;
        [self _updateEditView];
    }
}

- (void)setAllowEditing:(BOOL)allowEditing
{
    _allowEditing = allowEditing;
    
    if (!allowEditing) {
        [self setEditing:NO animated:NO];
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    if (_editing != editing)
    {
        if (editing && !_allowEditing) {
            return;
        }
        
        if (_editView == nil)
        {
            [self _editView];
            [self _updateEditView];
            _editView.userInteractionEnabled = true;
            [_editView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editViewTapGesture:)]];
            _editView.alpha = 0.0f;
            [self addSubview:_editView];
            
            [self _layoutEditView];
        }
        
        _editing = editing;
        
        if (editing && !_allowEditing) {
            return;
        }
        
        if (animated)
        {
            [UIView animateWithDuration:0.3 delay:0.0 options:0 animations:^
             {
                 _editView.alpha = _editing ? 1.0f : 0.0f;
                 [self layoutSubviews];
             } completion:nil];
        }
        else
        {
            _editView.alpha = _editing ? 1.0f : 0.0f;
            [self setNeedsLayout];
        }
    }
}

#pragma mark - private method
- (UIImageView *)_editView
{
    if (_editView == nil && _editingMode != KBCollectionItemViewEditingModeNone)
    {
        if (_editingMode == KBCollectionItemViewEditingModeSelect)
            _editView = [[UIImageView alloc] init];
        else
            NSLog(@"Unsupport");
    }
    return _editView;
}

- (void)_layoutEditView
{
    CGSize editViewSize = _editView.image.size;
    _editView.frame = CGRectMake(_editing ? 12.0f : -editViewSize.width, floorf((self.bounds.size.height - editViewSize.height) / 2.0f), editViewSize.width, editViewSize.height);
}

- (void)_updateEditView
{
    if (_editingMode == KBCollectionItemViewEditingModeNone)
    {
    
    }
    else if (_editingMode == KBCollectionItemViewEditingModeSelect)
    {
        if (self.selected)
            _editView.image = [UIImage imageNamed:@"ModernMenuSelectSelectedIcon"];
        else
            _editView.image = _selectable ? [UIImage imageNamed:@"ModernMenuSelectNormalIcon"] : [UIImage imageNamed:@"ModernMenuSelectDeselectedIcon"];
    }
    else if (_editingMode == KBCollectionItemViewEditingModeDelete)
    {
        
    }
}

- (void)_updateCellWhenTapGesture
{
    if (_editingMode == KBCollectionItemViewEditingModeSelect)
    {
        if (self.selected)
            [[self _collectionMenuView] deselectCell:self];
        else
            [[self _collectionMenuView] selectCell:self];
    }
}

static KBCollectionMenuView *_findCollectionMenuView(UIView *baseView)
{
    if (baseView == nil || [baseView isKindOfClass:[KBCollectionMenuView class]])
        return (KBCollectionMenuView *)baseView;
    
    return _findCollectionMenuView(baseView.superview);
}

- (KBCollectionMenuView *)_collectionMenuView
{
    return _findCollectionMenuView(self.superview);
}

#pragma mark - layout subview
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    
    CGRect contentFrame = self.contentView.frame;
    contentFrame.origin.x = _editing && _editingMode != KBCollectionItemViewEditingModeNone? 36 : 0;
    contentFrame.size.width = _editing && _editingMode != KBCollectionItemViewEditingModeNone? bounds.size.width - 36 : bounds.size.width;
    self.contentView.frame = contentFrame;
    
    if (_editView) {
        [self _layoutEditView];
    }
}

#pragma mark - Gestures
- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    CGPoint translation = [gesture translationInView:self];
    UIGestureRecognizerState state = [gesture state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged) {
        [gesture setTranslation:CGPointZero inView:self];
    }
    
    CGRect rect  = self.contentView.frame;
    rect.origin.x = rect.origin.x + translation.x;
    self.contentView.frame = rect;
}

- (void)handleTapGestureRecognizer:(UIPanGestureRecognizer *)gesture
{
    [self _updateCellWhenTapGesture];
}

- (void)editViewTapGesture:(UITapGestureRecognizer *)gesture
{
    [self _updateCellWhenTapGesture];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // more mode configure...
    if (gestureRecognizer == _panGestureRecognizer)
    {
        if (_editing && _editingMode == KBCollectionItemViewEditingModeDelete) {
            return YES;
        } else {
            return NO;
        }
    }
    else if (gestureRecognizer == _tapGestureRecognizer)
    {
        if (_editing && _editingMode == KBCollectionItemViewEditingModeSelect) {
            return YES;
        } else {
            return NO;
        }
    }
    
    return [super gestureRecognizerShouldBegin:gestureRecognizer];
}


@end
