//
//  BUKGravityCollisionBehavior.m
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import "BUKGravityCollisionBehavior.h"

@interface BUKGravityCollisionBehavior () <UIDynamicAnimatorDelegate>

@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, copy) void (^completeBlock)();

@end

@implementation BUKGravityCollisionBehavior

- (void)buk_animateView:(UIView *)view toCenter:(CGPoint)endCenter complete:(void (^)())complete
{
    NSAssert(view, @"BUKGravityCollisionBehavior: view need to animate can't be nil!");
    NSAssert(view.superview, @"BUKGravityCollisionBehavior: view must be added to super view before animation.");

    if (!view || !view.superview) {
        return;
    }
    
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:view.superview];
    self.animator.delegate = self;
    self.completeBlock = complete;
    
    CGPoint beginCenter = view.center;
    
    CGFloat deltaX = endCenter.x - beginCenter.x;
    CGFloat deltaY = endCenter.y - beginCenter.y;
    
    // add gravity behavior
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc]initWithItems:@[view]];
    gravityBehavior.gravityDirection = CGVectorMake(deltaX, deltaY);
    gravityBehavior.magnitude = 10.0f;
    [self.animator addBehavior:gravityBehavior];
    
    // add collision behavior
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[view]];
    
    if (fabs(deltaX) > fabs(deltaY)) {
        CGFloat boundaryX;
        if (deltaX > 0) {
            boundaryX = view.frame.size.width/2.0 + endCenter.x + 0.5;
        }else {
            boundaryX = endCenter.x - view.frame.size.width/2.0 - 0.5;
        }
        [collisionBehavior addBoundaryWithIdentifier:@([view hash])
                                           fromPoint:CGPointMake(boundaryX, 0)
                                             toPoint:CGPointMake(boundaryX, CGRectGetHeight(view.superview.frame))];
        
    }else {
        CGFloat boundaryY;
        if (deltaY > 0) {
            boundaryY = view.frame.size.height/2.0 + endCenter.y - 0.5;
        }else {
            boundaryY = endCenter.y - view.frame.size.height/2.0 + 0.5;
        }
        [collisionBehavior addBoundaryWithIdentifier:@([view hash])
                                           fromPoint:CGPointMake(0, boundaryY)
                                             toPoint:CGPointMake(CGRectGetWidth(view.superview.frame), boundaryY)];
    }
    [self.animator addBehavior:collisionBehavior];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator
{
    if (self.completeBlock) {
        self.completeBlock();
    }
    
    self.animator = nil;
}

@end
