//
//  KBCommon.h
//  test4
//
//  Created by 肖雄 on 16/9/30.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#ifdef __cplusplus
extern "C" {
#endif

    BOOL KBStringCompare(NSString *s1, NSString *s2);
    
    UIColor *KBSeparatorColor();
    UIColor *KBSelectionColor();
    UIColor *KBGray1Color();
    UIColor *KBGray2Color();
    UIColor *KBGray3Color();
    
    UIFont *KBSystemFontOfSize(CGFloat size);
    
#ifdef __cplusplus
}
#endif
