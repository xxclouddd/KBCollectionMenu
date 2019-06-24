//
//  KBCollectionItem+RACSignalSupport.m
//  CRM
//
//  Created by 肖雄 on 17/5/25.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBCollectionItem+RACSignalSupport.h"
#import <objc/runtime.h>

@implementation KBCollectionItem (RACSignalSupport)

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (RACSignal *)rac_willUnbindViewSignal
{
    RACSignal *signal = objc_getAssociatedObject(self, _cmd);
    if (signal != nil) return signal;
    
    signal = [[self
                rac_signalForSelector:@selector(unbindView)]
               mapReplace:RACUnit.defaultUnit];
    
    objc_setAssociatedObject(self, _cmd, signal, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return signal;
}
#endif

@end
