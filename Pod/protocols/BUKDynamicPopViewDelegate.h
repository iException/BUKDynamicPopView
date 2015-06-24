//
//  BUKDynamicPopViewDelegate.h
//  Pods
//
//  Created by hyice on 15/6/23.
//
//

#import <UIKit/UIKit.h>

@protocol BUKDynamicPopViewDelegate <NSObject>

@optional
- (void)buk_dynamicPopViewWillShow:(UIView *)view;
- (void)buk_dynamicPopViewDidShow:(UIView *)view;

- (void)buk_dynamicPopViewWillHide:(UIView *)view;
- (void)buk_dynamicPopViewDidHide:(UIView *)view;

- (void)buk_dynamicPopViewBackgroundTapped:(UIView *)view;


@end
