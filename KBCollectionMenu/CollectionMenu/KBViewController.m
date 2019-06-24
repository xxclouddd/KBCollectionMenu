//
//  KBViewController.m
//  KBCollectionMenu
//
//  Created by 肖雄 on 17/3/13.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBViewController.h"

@interface KBViewController ()

@end

@implementation KBViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self _commonViewControllerInit];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self _commonViewControllerInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    _viewControllerHasEverAppeared = YES;
    
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)_commonViewControllerInit
{
    self.automaticallyManageScrollViewInsets = NO;
    
//    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)])
//        [self setAutomaticallyAdjustsScrollViewInsets:false];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerKeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewControllerKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (CGFloat)_currentStatusBarHeight
{
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat minStatusBarHeight = [self prefersStatusBarHidden] ? 0.0f : 20.0f;
    return MAX(minStatusBarHeight, MIN(statusBarFrame.size.width, statusBarFrame.size.height));
}

- (CGFloat)navigationBarHeightForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    static CGFloat portraitHeight = 44.0f;
    static CGFloat landscapeHeight = 32.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        CGFloat widescreenWidth = MAX(screenSize.width, screenSize.height);
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && ABS(widescreenWidth - 736) > FLT_EPSILON)
        {
            portraitHeight = 44.0f;
            landscapeHeight = 32.0f;
        }
        else
        {
            portraitHeight = 44.0f;
            landscapeHeight = 44.0f;
        }
    });
    
    return (UIInterfaceOrientationIsPortrait(orientation) ? portraitHeight : landscapeHeight);
}

- (CGFloat)tabBarHeight
{
    static CGFloat height = 0.0f;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
            height = 49.0f;
        else
            height = 56.0f;
    });
    
    return height;
}

- (void)viewControllerKeyboardWillChangeFrame:(NSNotification *)notification
{
    CGFloat statusBarHeight = [self _currentStatusBarHeight];
    
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardHeight = MIN(keyboardFrame.size.height, keyboardFrame.size.width);
    double duration = ([[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]);
    
    if (!_viewControllerHasEverAppeared)
    {
        [UIView performWithoutAnimation:^
         {
             [self _updateControllerInsetForOrientation:self.interfaceOrientation statusBarHeight:statusBarHeight keyboardHeight:keyboardHeight force:false notify:true];
         }];
    }
    else
    {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             [self _updateControllerInsetForOrientation:self.interfaceOrientation statusBarHeight:statusBarHeight keyboardHeight:keyboardHeight force:false notify:true];
         } completion:nil];
    }
}

- (void)viewControllerKeyboardWillHide:(NSNotification *)notification
{
    CGFloat statusBarHeight = [self _currentStatusBarHeight];
    
    float keyboardHeight = 0.0f;
    double duration = ([[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]);
    
    if (!_viewControllerHasEverAppeared)
    {
        [UIView performWithoutAnimation:^
         {
             [self _updateControllerInsetForOrientation:self.interfaceOrientation statusBarHeight:statusBarHeight keyboardHeight:keyboardHeight force:false notify:true];
         }];
    }
    else
    {
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             [self _updateControllerInsetForOrientation:self.interfaceOrientation statusBarHeight:statusBarHeight keyboardHeight:keyboardHeight force:false notify:true];
         } completion:nil];
    }
}

- (bool)_updateControllerInsetForOrientation:(UIInterfaceOrientation)orientation statusBarHeight:(CGFloat)statusBarHeight keyboardHeight:(CGFloat)keyboardHeight force:(bool)force notify:(bool)notify
{
    CGFloat navigationBarHeight = ([self navigationBarShouldBeHidden] || [self shouldIgnoreNavigationBar]) ? 0 : [self navigationBarHeightForInterfaceOrientation:orientation];
    
    UIEdgeInsets edgeInset = UIEdgeInsetsMake(self.extendedLayoutIncludesOpaqueBars ? (statusBarHeight + navigationBarHeight) : 0, 0, 0, 0);
    
    edgeInset.left += _parentInsets.left;
    edgeInset.top += _parentInsets.top;
    edgeInset.right += _parentInsets.right;
    edgeInset.bottom += _parentInsets.bottom;
    
    if ([self.parentViewController isKindOfClass:[UITabBarController class]])
        edgeInset.bottom += [self tabBarHeight];
    
    if (!_ignoreKeyboardWhenAdjustingScrollViewInsets)
        edgeInset.bottom = MAX(edgeInset.bottom, keyboardHeight);
    
    UIEdgeInsets previousInset = _controllerInset;
    
    if (force || !UIEdgeInsetsEqualToEdgeInsets(previousInset, edgeInset))
    {
        _controllerInset = edgeInset;
        
        if (notify)
            [self controllerInsetUpdated:previousInset];
        
        return true;
    }
    
    return false;
}

- (void)controllerInsetUpdated:(UIEdgeInsets)previousInset
{
    if (self.isViewLoaded)
    {
        if (self.automaticallyManageScrollViewInsets)
        {
            if (_scrollViewsForAutomaticInsetsAdjustment != nil)
            {
                for (UIScrollView *scrollView in _scrollViewsForAutomaticInsetsAdjustment)
                {
                    [self _autoAdjustInsetsForScrollView:scrollView previousInset:previousInset];
                }
            }
            else
            {
                for (UIView *view in self.view.subviews)
                {
                    if ([view isKindOfClass:[UIScrollView class]])
                    {
                        [self _autoAdjustInsetsForScrollView:(UIScrollView *)view previousInset:previousInset];
                        
                        break;
                    }
                }
            }
        }
    }
}

- (void)_autoAdjustInsetsForScrollView:(UIScrollView *)scrollView previousInset:(UIEdgeInsets)previousInset
{
    CGPoint contentOffset = scrollView.contentOffset;
    
    UIEdgeInsets finalInset = self.controllerInset;
    
    scrollView.contentInset = finalInset;
    // scrollView.scrollIndicatorInsets = self.controllerScrollInset;
    
    if (!UIEdgeInsetsEqualToEdgeInsets(previousInset, UIEdgeInsetsZero))
    {
        CGFloat maxOffset = scrollView.contentSize.height - (scrollView.frame.size.height - finalInset.bottom);
        
        if (![self shouldAdjustScrollViewInsetsForInversedLayout])
            contentOffset.y += previousInset.top - finalInset.top;
        
        contentOffset.y = MAX(-finalInset.top, MIN(contentOffset.y, maxOffset));
        [scrollView setContentOffset:contentOffset animated:NO];
    }
    else if (contentOffset.y < finalInset.top)
    {
        contentOffset.y = -finalInset.top;
        [scrollView setContentOffset:contentOffset animated:NO];
    }
}

- (bool)shouldAdjustScrollViewInsetsForInversedLayout
{
    return false;
}

- (BOOL)shouldIgnoreNavigationBar
{
    return NO;
}


@end
