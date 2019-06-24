//
//  KBViewController.h
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/3/13.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KBViewController : UIViewController

@property (nonatomic) BOOL viewControllerIsChangingInterfaceOrientation;
@property (nonatomic) BOOL viewControllerHasEverAppeared;

@property (nonatomic) BOOL navigationBarShouldBeHidden;

@property (nonatomic, readonly) UIEdgeInsets controllerInset;
@property (nonatomic) UIEdgeInsets parentInsets;

@property (nonatomic) BOOL automaticallyManageScrollViewInsets;
@property (nonatomic) BOOL ignoreKeyboardWhenAdjustingScrollViewInsets;

@property (nonatomic, strong) NSArray *scrollViewsForAutomaticInsetsAdjustment;

- (BOOL)shouldAdjustScrollViewInsetsForInversedLayout;

- (BOOL)shouldIgnoreNavigationBar;

@end
