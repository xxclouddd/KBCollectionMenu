//
//  KBCommon.m
//  test4
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBCommon.h"


BOOL KBStringCompare(NSString *s1, NSString *s2)
{
    if (s1.length == 0 && s2.length == 0)
        return YES;
    
    if ((s1 == nil) != (s2 == nil))
        return NO;
    
    return s1 == nil || [s1 isEqualToString:s2];
}

UIColor *KBSeparatorColor()
{
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        color = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    });
    return color;
}

UIColor *KBSelectionColor()
{
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        color = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0];
    });
    return color;
}

UIColor *KBGray1Color()
{
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        color = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    });
    return color;
}

UIColor *KBGray2Color()
{
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        color = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    });
    return color;
}

UIColor *KBGray3Color()
{
    static UIColor *color = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        color = [UIColor colorWithRed:152/255.0 green:152/255.0 blue:152/255.0 alpha:1.0];
    });
    return color;
}

UIFont *KBSystemFontOfSize(CGFloat size)
{
    return [UIFont systemFontOfSize:size];
}

