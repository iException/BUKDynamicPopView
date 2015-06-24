//
//  BUKXOrYMoveAnimationStyle.m
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import "BUKXOrYMoveAnimationStyle.h"

@interface BUKXOrYMoveAnimationStyle ()

@property (nonatomic, weak) UIView *view;

@end

@implementation BUKXOrYMoveAnimationStyle

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    
    if (self) {
        self.view = view;
    }
    
    return self;
}

- (CGPoint)buk_viewCenterBeforeShow
{
    return [self centerForPosition:self.startPosition];
}

- (CGPoint)buk_viewCenterWhenShowing
{
    return [self centerForPosition:self.showPosition];
}

- (CGPoint)buk_viewCenterAfterHide
{
    return [self centerForPosition:self.endPosition];
}

- (CGPoint)centerForPosition:(BUKPositionRelateToSuperView)position
{
    if (!self.view || !self.view.superview) {
        return CGPointZero;
    }
    
    CGRect viewFrame = self.view.frame;
    CGRect superViewFrame = self.view.superview.bounds;
    
    CGFloat x, y;
    
    switch (position) {
        case BUKLeftInnerBorder: {
            x = CGRectGetMinX(superViewFrame) + CGRectGetWidth(viewFrame);
            y = viewFrame.origin.y;
            break;
        }
        case BUKRightInnerBorder: {
            x = CGRectGetMaxX(superViewFrame) - CGRectGetWidth(viewFrame);
            y = viewFrame.origin.y;
            break;
        }
        case BUKTopInnerBorder: {
            x = viewFrame.origin.x;
            y = CGRectGetMinY(superViewFrame) + CGRectGetHeight(viewFrame);
            break;
        }
        case BUKBottomInnerBorder: {
            x = viewFrame.origin.x;
            y = CGRectGetMaxY(superViewFrame) - CGRectGetHeight(viewFrame);
            break;
        }
        case BUKLeftOuterBorder: {
            x = CGRectGetMinX(superViewFrame) - CGRectGetWidth(viewFrame);
            y = viewFrame.origin.y;
            break;
        }
        case BUKRightOuterBorder: {
            x = CGRectGetMaxX(superViewFrame) + CGRectGetWidth(viewFrame);
            y = viewFrame.origin.y;
            break;
        }
        case BUKTopOuterBorder: {
            x = viewFrame.origin.x;
            y = CGRectGetMinY(superViewFrame) - CGRectGetHeight(viewFrame);
            break;
        }
        case BUKBottomOuterBorder: {
            x = viewFrame.origin.x;
            y = CGRectGetMaxY(superViewFrame) + CGRectGetHeight(viewFrame);
            break;
        }
        case BUKXCenter: {
            x = CGRectGetMidX(superViewFrame) - CGRectGetWidth(viewFrame)/2.0;
            y = viewFrame.origin.y;
            break;
        }
        case BUKYCenter: {
            x = viewFrame.origin.x;
            y = CGRectGetMidY(superViewFrame) - CGRectGetHeight(viewFrame)/2.0;
            break;
        }
        default: {
            x = 0;
            y = 0;
            break;
        }
    }
    return CGPointMake(x + CGRectGetWidth(viewFrame)/2.0, y + CGRectGetHeight(viewFrame)/2.0);
}

@end
