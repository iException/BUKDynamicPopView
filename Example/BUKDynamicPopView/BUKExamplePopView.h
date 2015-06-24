//
//  BUKExamplePopView.h
//  BUKDynamicPopView
//
//  Created by hyice on 15/6/24.
//  Copyright (c) 2015年 hyice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BUKDynamicPopView/BUKDynamicPopView.h>

typedef NS_ENUM(NSInteger, BUKExampleStyle) {
    BUKExampleStyle_Default,
    BUKExampleStyle_DropMenu,
    BUKExampleStyle_PopUpMenu,
    BUKExampleStyle_RightMenu,
    
    BUKExampleStyle_TwoLevelSelection,
};
@interface BUKExamplePopView : UIView

+ (instancetype)popViewWithExampleStyle:(BUKExampleStyle)style;

@end
