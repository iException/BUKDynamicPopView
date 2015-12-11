//
//  UIView+BUKDynamicPopView.h
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import <UIKit/UIKit.h>
#import "BUKDynamicBehavior.h"
#import "BUKDynamicAnimationStyle.h"
#import "BUKDynamicPopViewDelegate.h"

/**
 *  Notification support for view transition.
 */
extern NSString * BUKDynamicPopViewWillShowNotification;
extern NSString * BUKDynamicPopViewWillHideNotification;
extern NSString * BUKDynamicPopViewDidShowNotification;
extern NSString * BUKDynamicPopViewDidHideNotification;

@interface UIView (BUKDynamicPopView)

/**
 *  Behavior for dynamic show animation. If behavior is nil, `BUKGravityCollisionBehavior` will be
 *  used.
 *
 *  @see BUKGravityCollisionBehavior
 */
@property (nonatomic, strong) id<BUKDynamicBehavior> buk_dynamicShowBehavior UI_APPEARANCE_SELECTOR;

/**
 *  Behavior for dynamic hide animation. If behavior is nil, `BUKUIViewAnimationBehavior` will be
 *  used.
 *
 *  @see BUKUIViewAnimationBehavior
 */
@property (nonatomic, strong) id<BUKDynamicBehavior> buk_dynamicHideBehavior UI_APPEARANCE_SELECTOR;



/**
 *  Style used to decide the position of self before show, when showing, and after hide. If style
 *  is nil, `BUKXOrYMoveAnimationStyle` from outer top to outer bottom will be used.
 *
 *  @see BUKXOrYMoveAnimationStyle
 */
@property (nonatomic, strong) id<BUKDynamicAnimationStyle> buk_animationStyle UI_APPEARANCE_SELECTOR;



/**
 *  Background inserted below self. If background is nil, a black translucent view will be used.
 */
@property (nonatomic, strong) UIView *buk_dynamicBackground UI_APPEARANCE_SELECTOR;

/**
 *  You can tap background to dynamic hide self by default. If you don't want this feature, you
 *  can set this property to NO to disable it.
 *
 *  @warning This flag only disable the tap gesture, but the background is still showing. You can
 *  directly set the buk_dynamicBackground to hidden if you want.
 */
@property (nonatomic, assign) BOOL buk_disableBackgroundTapHide UI_APPEARANCE_SELECTOR;


/**
 *  Flag for you to known whether the pop view is animating for push or pop.
 */
@property (nonatomic, assign, readonly) BOOL buk_popViewIsAnimating;


/**
 *  Dynamic show hide event delegate.
 */
@property (nonatomic, assign) id<BUKDynamicPopViewDelegate> buk_dynamicPopViewDelegate;



/**
 *  Add self to superView, and dynamic show self using `buk_dynamicShowBehavior`. Behavior will
 *  be used to animate self's center from `[self.buk_animationStyle buk_viewCenterBeforeShow]`
 *  to `[self.buk_animationStyle buk_viewCenterWhenShowing]`.
 *
 *  @see buk_dynamicShowBehavior
 *  @see buk_animationStyle
 */
- (void)buk_dynamicShowInView:(UIView *)superView;

/**
 *  Insert self into superView below otherView, and then do things same as `- buk_dynamicShowInView`.
 *
 *  @see - (void)buk_dynamicShowInView:(UIView *)superView;
 */
- (void)buk_dynamicShowInView:(UIView *)superView belowView:(UIView *)otherView;

/**
 *  Insert self into superView above otherView, and then do things same as `- buk_dynamicShowInView`.
 *
 *  @see - (void)buk_dynamicShowInView:(UIView *)superView;
 */
- (void)buk_dynamicShowInView:(UIView *)superView aboveView:(UIView *)otherView;



/**
 *  Dynamic hide self useing `buk_viewCenterAfterHide`. Behavior will be used to animate self's
 *  center from current value to `[self.buk_animationStyle buk_viewCenterAfterHide]`.
 *
 *  @see buk_viewCenterAfterHide
 *  @see buk_animationStyle
 */
- (void)buk_dynamicHide;

@end
