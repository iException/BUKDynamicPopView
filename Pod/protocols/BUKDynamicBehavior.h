//
//  BUKDynamicBehavior.h
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import <UIKit/UIKit.h>

@protocol BUKDynamicBehavior <NSObject>

- (void)buk_animateView:(UIView *)view toCenter:(CGPoint)endCenter complete:(void (^)())complete;

@end
