//
//  BUKUIViewAnimationBehavior.m
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import "BUKUIViewAnimationBehavior.h"

@implementation BUKUIViewAnimationBehavior

- (void)buk_animateView:(UIView *)view toCenter:(CGPoint)endCenter complete:(void (^)())complete
{
    [UIView animateWithDuration:0.2f animations:^{
        view.center = endCenter;
    } completion:^(BOOL finished) {
        if (complete) {
            complete();
        }
    }];
}

@end
