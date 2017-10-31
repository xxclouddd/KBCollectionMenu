//
//  KBActionCollectionItemView.m
//  KuaiDiYuan_S
//
//  Created by 肖雄 on 16/11/28.
//  Copyright © 2016年 KuaidiHelp. All rights reserved.
//

#import "KBActionCollectionItemView.h"

@interface UIImage (KBColorImage)

@end

@implementation UIImage (KBColorImage)

+ (UIImage *)kb_imageWithColor:(UIColor *)color imageSize:(CGSize)imageSize
{
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@interface KBActionCollectionItemView ()
{
    UIButton *_button;
}

@end

@implementation KBActionCollectionItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.titleLabel.font = [UIFont systemFontOfSize:17];
        _button.layer.masksToBounds  = YES;
        UIImage *disableImage = [UIImage kb_imageWithColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] imageSize:CGSizeMake(1, 1)];
        UIImage *normalImage = [UIImage kb_imageWithColor:[UIColor colorWithRed:57/255.0 green:181/255.0 blue:74/255.0 alpha:1.0] imageSize:CGSizeMake(1, 1)];
        [_button setBackgroundImage:normalImage forState:UIControlStateNormal];
        [_button setBackgroundImage:disableImage forState:UIControlStateDisabled];
        _button.layer.cornerRadius = 4.0f;
        _button.layer.masksToBounds = YES;
        [self.contentView addSubview:_button];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
}
- (void)setTitleColor:(UIColor *)titleColor {
    
    [_button setTitleColor:titleColor forState:UIControlStateNormal];
}

- (void)setBorderColor:(UIColor *)borderColor {
    
    _button.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    
    _button.layer.borderWidth = borderWidth;
}

- (void)addTarget:(id)target action:(SEL)action
{
    [_button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}

- (void)setEnable:(BOOL)enable
{
    _button.enabled = enable;
}

- (void)setNormalBtnBackgroundColor:(UIColor *)color {
    
    UIImage *normalImage = [UIImage kb_imageWithColor:color imageSize:CGSizeMake(1, 1)];
    [_button setBackgroundImage:normalImage forState:UIControlStateNormal];
}

- (void)setDisableBtnBackgroundColor:(UIColor *)color {
    
    UIImage *disableImage = [UIImage kb_imageWithColor:color imageSize:CGSizeMake(1, 1)];
    [_button setBackgroundImage:disableImage forState:UIControlStateDisabled];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    
    _button.frame = CGRectMake(15, 0, size.width - 15*2, size.height);
}


@end
