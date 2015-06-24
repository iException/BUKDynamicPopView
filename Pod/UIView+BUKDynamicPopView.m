//
//  UIView+BUKDynamicPopView.m
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import "UIView+BUKDynamicPopView.h"
#import <objc/runtime.h>

#import "BUKGravityCollisionBehavior.h"
#import "BUKUIViewAnimationBehavior.h"

#import "BUKXOrYMoveAnimationStyle.h"

@interface UIView ()
@property (nonatomic, assign) BOOL buk_popViewIsAnimating;
@end

@implementation UIView (BUKDynamicPopView)
#pragma mark - public -
- (void)buk_dynamicShowInView:(UIView *)superView
{
    superView = [self buk_safeCheckSuperView:superView];
    
    [superView addSubview:self];
    
    [self buk_dynamicShowAnimation];
}

- (void)buk_dynamicShowInView:(UIView *)superView belowView:(UIView *)otherView
{
    if (!otherView) {
        [self buk_dynamicShowInView:superView];
    }
    
    superView = [self buk_safeCheckSuperView:superView];
    [superView insertSubview:self belowSubview:otherView];
    
    [self buk_dynamicShowAnimation];
}

- (void)buk_dynamicShowInView:(UIView *)superView aboveView:(UIView *)otherView
{
    if (!otherView) {
        [self buk_dynamicShowInView:superView];
    }
    
    superView = [self buk_safeCheckSuperView:superView];
    [superView insertSubview:self belowSubview:otherView];
    
    [self buk_dynamicShowAnimation];
}

- (void)buk_dynamicHide
{
    if (self.buk_dynamicPopViewDelegate
        && [self.buk_dynamicPopViewDelegate respondsToSelector:@selector(buk_dynamicPopViewWillHide:)]) {
        [self.buk_dynamicPopViewDelegate buk_dynamicPopViewWillHide:self];
    }
    self.buk_popViewIsAnimating = YES;
    CGPoint centerAfterHide = [self.buk_animationStyle buk_viewCenterAfterHide];
    [self.buk_dynamicHideBehavior buk_animateView:self toCenter:centerAfterHide complete:^{
        [self removeFromSuperview];
        if (self.buk_dynamicBackground) {
            [UIView animateWithDuration:0.2f animations:^{
                self.buk_dynamicBackground.alpha = 0;
            } completion:^(BOOL finished) {
                [self.buk_dynamicBackground removeFromSuperview];
            }];

        }
        self.buk_popViewIsAnimating = NO;

        if (self.buk_dynamicPopViewDelegate
            && [self.buk_dynamicPopViewDelegate respondsToSelector:@selector(buk_dynamicPopViewDidHide:)]) {
            [self.buk_dynamicPopViewDelegate buk_dynamicPopViewDidHide:self];
        }
    }];
}

#pragma mark - private -
- (UIView *)buk_safeCheckSuperView:(UIView *)superView
{
    if (!superView) {
        return [UIApplication sharedApplication].windows[0];
    }
    return superView;
}

- (void)buk_insertBackground
{
    for (UIGestureRecognizer *gesture in self.buk_dynamicBackground.gestureRecognizers) {
        [self.buk_dynamicBackground removeGestureRecognizer:gesture];
    }
    
    self.buk_dynamicBackground.frame = self.superview.bounds;
    
    if (!self.buk_disableBackgroundTapHide) {
        UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buk_backgroundHideTap:)];
        [self.buk_dynamicBackground addGestureRecognizer:dismissTap];
    }
    
    [self.superview insertSubview:self.buk_dynamicBackground belowSubview:self];
    
    self.buk_dynamicBackground.alpha = 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        self.buk_dynamicBackground.alpha = 0.7f;
    }];
}

- (void)buk_dynamicShowAnimation
{
    if (self.buk_dynamicPopViewDelegate
        && [self.buk_dynamicPopViewDelegate respondsToSelector:@selector(buk_dynamicPopViewWillShow:)]) {
        [self.buk_dynamicPopViewDelegate buk_dynamicPopViewWillShow:self];
    }
    self.buk_popViewIsAnimating = YES;
    [self buk_insertBackground];
    
    CGPoint centerBeforeShow = [self.buk_animationStyle buk_viewCenterBeforeShow];
    CGPoint centerWhenShowing = [self.buk_animationStyle buk_viewCenterWhenShowing];
    
    self.center = centerBeforeShow;
    [self.buk_dynamicShowBehavior buk_animateView:self toCenter:centerWhenShowing complete:^{
        self.buk_popViewIsAnimating = NO;

        if (self.buk_dynamicPopViewDelegate
            && [self.buk_dynamicPopViewDelegate respondsToSelector:@selector(buk_dynamicPopViewDidShow:)]) {
            [self.buk_dynamicPopViewDelegate buk_dynamicPopViewDidShow:self];
        }
    }];
}

#pragma mark - event -
- (void)buk_backgroundHideTap:(UIGestureRecognizer *)gesture
{
    if (self.buk_popViewIsAnimating) {
        return;
    }
    
    if (self.buk_dynamicPopViewDelegate
        && [self.buk_dynamicPopViewDelegate respondsToSelector:@selector(buk_dynamicPopViewBackgroundTapped:)]) {
        [self.buk_dynamicPopViewDelegate buk_dynamicPopViewBackgroundTapped:self];
    }
    [self buk_dynamicHide];
}

#pragma mark - setter && getter -
static void *BUKDynamicShowBehavior = &BUKDynamicShowBehavior;
- (id<BUKDynamicBehavior>)buk_dynamicShowBehavior
{
    id behavior = objc_getAssociatedObject(self, BUKDynamicShowBehavior);
    if (!behavior) {
        behavior = [[BUKGravityCollisionBehavior alloc] init];
        self.buk_dynamicShowBehavior = behavior;
    }
    return behavior;
}

- (void)setBuk_dynamicShowBehavior:(id<BUKDynamicBehavior>)buk_dynamicShowBehavior
{
    objc_setAssociatedObject(self, BUKDynamicShowBehavior, buk_dynamicShowBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void *BUKDynamicHideBehavior = &BUKDynamicHideBehavior;
- (id<BUKDynamicBehavior>)buk_dynamicHideBehavior
{
    id behavior = objc_getAssociatedObject(self, BUKDynamicHideBehavior);
    if (!behavior) {
        behavior = [[BUKUIViewAnimationBehavior alloc] init];
        self.buk_dynamicHideBehavior = behavior;
    }
    return  behavior;
}

- (void)setBuk_dynamicHideBehavior:(id<BUKDynamicBehavior>)buk_dynamicHideBehavior
{
    objc_setAssociatedObject(self, BUKDynamicHideBehavior, buk_dynamicHideBehavior, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void *BUKAnimationStyle = &BUKAnimationStyle;
- (id<BUKDynamicAnimationStyle>)buk_animationStyle
{
    id style = objc_getAssociatedObject(self, BUKAnimationStyle);
    if (!style) {
        BUKXOrYMoveAnimationStyle *defaultStyle = [[BUKXOrYMoveAnimationStyle alloc] initWithView:self];
        defaultStyle.startPosition = BUKTopOuterBorder;
        defaultStyle.showPosition = BUKYCenter;
        defaultStyle.endPosition = BUKBottomOuterBorder;
        style = defaultStyle;
        self.buk_animationStyle = style;
    }
    return style;
}

- (void)setBuk_animationStyle:(id<BUKDynamicAnimationStyle>)buk_animationStyle
{
    objc_setAssociatedObject(self, BUKAnimationStyle, buk_animationStyle, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void *BUKDynamicBackground = &BUKDynamicBackground;
- (UIView *)buk_dynamicBackground
{
    UIView *background = objc_getAssociatedObject(self, BUKDynamicBackground);
    if (!background) {
        background = [[UIView alloc] init];
        background.backgroundColor = [UIColor blackColor];
        self.buk_dynamicBackground = background;
    }
    return background;
}

- (void)setBuk_dynamicBackground:(UIView *)buk_dynamicBackground
{
    objc_setAssociatedObject(self, BUKDynamicBackground, buk_dynamicBackground, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void *BUKDisableBackgroundTapHide = &BUKDisableBackgroundTapHide;
- (BOOL)buk_disableBackgroundTapHide
{
    return [objc_getAssociatedObject(self, BUKDisableBackgroundTapHide) boolValue];
}

- (void)setBuk_disableBackgroundTapHide:(BOOL)buk_disableBackgroundTapHide
{
    objc_setAssociatedObject(self, BUKDisableBackgroundTapHide, @(buk_disableBackgroundTapHide), OBJC_ASSOCIATION_ASSIGN);
}

static void *BUKDynamicPopViewDelegate = &BUKDynamicPopViewDelegate;
- (id<BUKDynamicPopViewDelegate>)buk_dynamicPopViewDelegate
{
    return objc_getAssociatedObject(self, BUKDynamicPopViewDelegate);
}

- (void)setBuk_dynamicPopViewDelegate:(id<BUKDynamicPopViewDelegate>)buk_dynamicPopViewDelegate
{
    objc_setAssociatedObject(self, BUKDynamicPopViewDelegate, buk_dynamicPopViewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

static void *BUKPopViewIsAnimating = &BUKPopViewIsAnimating;
- (BOOL)buk_popViewIsAnimating
{
    return [objc_getAssociatedObject(self, BUKPopViewIsAnimating) boolValue];
}

- (void)setBuk_popViewIsAnimating:(BOOL)buk_popViewIsAnimating
{
    objc_setAssociatedObject(self, BUKPopViewIsAnimating, @(buk_popViewIsAnimating), OBJC_ASSOCIATION_ASSIGN);
}
@end
