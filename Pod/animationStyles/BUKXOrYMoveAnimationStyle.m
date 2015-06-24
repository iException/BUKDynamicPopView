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
    CGRect superViewBounds = self.view.superview.bounds;
    
    CGFloat x, y;
    
    switch (position) {
        case BUKLeftInnerBorder: {
            x = CGRectGetWidth(viewFrame)/2.0;
            y = CGRectGetMidY(viewFrame);
            break;
        }
        case BUKRightInnerBorder: {
            x = CGRectGetMaxX(superViewBounds) - CGRectGetWidth(viewFrame)/2.0;
            y = CGRectGetMidY(viewFrame);
            break;
        }
        case BUKTopInnerBorder: {
            x = CGRectGetMidX(viewFrame);
            y = CGRectGetHeight(viewFrame)/2.0;
            break;
        }
        case BUKBottomInnerBorder: {
            x = CGRectGetMidX(viewFrame);
            y = CGRectGetMaxY(superViewBounds) - CGRectGetHeight(viewFrame)/2.0;
            break;
        }
        case BUKLeftOuterBorder: {
            x = -CGRectGetWidth(viewFrame)/2.0;
            y = CGRectGetMidY(viewFrame);
            break;
        }
        case BUKRightOuterBorder: {
            x = CGRectGetMaxX(superViewBounds) + CGRectGetWidth(viewFrame)/2.0;
            y = CGRectGetMidY(viewFrame);
            break;
        }
        case BUKTopOuterBorder: {
            x = CGRectGetMidX(viewFrame);
            y = CGRectGetMinY(superViewBounds) - CGRectGetHeight(viewFrame)/2.0;
            break;
        }
        case BUKBottomOuterBorder: {
            x = CGRectGetMidX(viewFrame);
            y = CGRectGetMaxY(superViewBounds) + CGRectGetHeight(viewFrame)/2.0;
            break;
        }
        case BUKXCenter: {
            x = CGRectGetMidX(superViewBounds);
            y = CGRectGetMidY(viewFrame);
            break;
        }
        case BUKYCenter: {
            x = CGRectGetMidX(viewFrame);
            y = CGRectGetMidY(superViewBounds);
            break;
        }
        default: {
            x = 0;
            y = 0;
            break;
        }
    }
    return CGPointMake(x, y);
}

@end
