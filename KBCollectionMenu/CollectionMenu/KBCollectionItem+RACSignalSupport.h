//
//  KBCollectionItem+RACSignalSupport.h
//  CRM
//
//  Created by 肖雄 on 17/5/25.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBCollectionItem.h"

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
#import <ReactiveCocoa/ReactiveCocoa.h>
#endif

@interface KBCollectionItem (RACSignalSupport)

#if __has_include(<ReactiveCocoa/ReactiveCocoa.h>)
- (RACSignal *)rac_willUnbindViewSignal;
#endif

@end
