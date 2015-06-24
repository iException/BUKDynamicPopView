//
//  BUKExamplePopView.m
//  BUKDynamicPopView
//
//  Created by hyice on 15/6/24.
//  Copyright (c) 2015年 hyice. All rights reserved.
//

#import "BUKExamplePopView.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation BUKExamplePopView

+ (instancetype)popViewWithExampleStyle:(BUKExampleStyle)style
{
    switch (style) {
        case BUKExampleStyle_Default: {
            return [self dropDownDialog];
        }
        case BUKExampleStyle_DropMenu: {
            return [self dropMenu];
        }
        case BUKExampleStyle_PopUpMenu: {
            return [self popUpMenu];
        }
        case BUKExampleStyle_RightMenu: {
            return [self rightMenu];
        }
        case BUKExampleStyle_TwoLevelSelection: {
            return [self twoLevelSelection];
        }
    }
}

+ (instancetype)dropDownDialog
{
    BUKExamplePopView *view = [[BUKExamplePopView alloc] init];
    
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:view];
    style.startPosition = BUKTopOuterBorder;
    style.showPosition = BUKYCenter;
    style.endPosition = BUKBottomOuterBorder;
    
    view.buk_animationStyle = style;
    
    return view;
}

+ (instancetype)dropMenu
{
    BUKExamplePopView *view = [[BUKExamplePopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.6)];
    
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:view];
    style.startPosition = BUKTopOuterBorder;
    style.showPosition = BUKTopInnerBorder;
    style.endPosition = BUKTopOuterBorder;
    
    view.buk_animationStyle = style;
    
    return view;
}

+ (instancetype)popUpMenu
{
    BUKExamplePopView *view = [[BUKExamplePopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight*0.6)];
    
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:view];
    style.startPosition = BUKBottomOuterBorder;
    style.showPosition = BUKBottomInnerBorder;
    style.endPosition = BUKBottomOuterBorder;
    
    view.buk_animationStyle = style;
    
    return view;
}

+ (instancetype)rightMenu
{
    BUKExamplePopView *view = [[BUKExamplePopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.5, kScreenHeight)];
    
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:view];
    style.startPosition = BUKRightOuterBorder;
    style.showPosition = BUKRightInnerBorder;
    style.endPosition = BUKRightOuterBorder;
    
    view.buk_animationStyle = style;
    
    return view;
}

+ (instancetype)twoLevelSelection
{
    BUKExamplePopView *firstLevel = [self dropMenu];
    
    UIButton *secondLevelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    secondLevelButton.frame = CGRectMake(0, 0, 100, 100);
    [secondLevelButton setTitle:@"Second Level" forState:UIControlStateNormal];
    [secondLevelButton addTarget:firstLevel action:@selector(showSecondLevelOfSelection) forControlEvents:UIControlEventTouchUpInside];
    [firstLevel addSubview:secondLevelButton];
    
    return firstLevel;
}

#pragma mark - event
- (void)showSecondLevelOfSelection
{
    BUKExamplePopView *secondLevel = [[self class] rightMenu];
    secondLevel.frame = CGRectMake(CGRectGetWidth(self.frame)/2.0, 0, CGRectGetWidth(self.frame)/2.0, CGRectGetHeight(self.frame));
    secondLevel.buk_dynamicBackground.backgroundColor = [UIColor clearColor];
    secondLevel.backgroundColor = [UIColor orangeColor];
    
    [secondLevel buk_dynamicShowInView:self];
}

#pragma mark - life cycle -
- (instancetype)init
{
    self = [self initWithFrame:CGRectMake(kScreenWidth*0.2, 0, kScreenWidth*0.6, kScreenHeight*0.2)];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}
@end
