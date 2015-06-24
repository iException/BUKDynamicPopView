//
//  BUKDynamicAnimationStyle.h
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import <UIKit/UIKit.h>

@protocol BUKDynamicAnimationStyle <NSObject>

- (CGPoint)buk_viewCenterBeforeShow;
- (CGPoint)buk_viewCenterWhenShowing;
- (CGPoint)buk_viewCenterAfterHide;

@end
