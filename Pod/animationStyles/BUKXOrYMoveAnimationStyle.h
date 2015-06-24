//
//  BUKXOrYMoveAnimationStyle.h
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import "BUKDynamicAnimationStyle.h"

typedef NS_ENUM(NSInteger, BUKPositionRelateToSuperView) {
    BUKLeftInnerBorder,
    BUKRightInnerBorder,
    BUKTopInnerBorder,
    BUKBottomInnerBorder,
    
    BUKLeftOuterBorder,
    BUKRightOuterBorder,
    BUKTopOuterBorder,
    BUKBottomOuterBorder,
    
    BUKXCenter,
    BUKYCenter,
};

@interface BUKXOrYMoveAnimationStyle : NSObject <BUKDynamicAnimationStyle>

@property (nonatomic, assign) BUKPositionRelateToSuperView startPosition;
@property (nonatomic, assign) BUKPositionRelateToSuperView showPosition;
@property (nonatomic, assign) BUKPositionRelateToSuperView endPosition;

- (instancetype)initWithView:(UIView *)view;

@end
