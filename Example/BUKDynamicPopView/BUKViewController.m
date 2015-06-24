//
//  BUKViewController.m
//  BUKDynamicPopView
//
//  Created by hyice on 06/23/2015.
//  Copyright (c) 2014 hyice. All rights reserved.
//

#import "BUKViewController.h"
#import <BUKDynamicPopView/BUKDynamicPopView.h>

@interface BUKViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *testView;

@end

@implementation BUKViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSString *title = @"test";

    switch (indexPath.row) {
        case 0:
            title = @"Top-->Center-->Bottom(default)";
            break;
        case 1:
            title = @"Top-->Center-->Right";
            break;
    }
    
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self topCenterBottom];
            break;
            
        case 1:
            [self topCenterRight];
            break;
            
        default:
            break;
    }
}

#pragma mark - dynamic styles
- (void)topCenterBottom
{
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:self.testView];
    style.startPosition = BUKTopOuterBorder;
    style.showPosition = BUKYCenter;
    style.endPosition = BUKBottomOuterBorder;
    
    self.testView.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100, 0, 200, 150);
    [self.testView buk_dynamicShowInView:self.view];
}

- (void)topCenterRight
{
    BUKXOrYMoveAnimationStyle *style = [[BUKXOrYMoveAnimationStyle alloc] initWithView:self.testView];
    style.startPosition = BUKTopOuterBorder;
    style.showPosition = BUKYCenter;
    style.endPosition = BUKRightOuterBorder;
    
    self.testView.buk_animationStyle = style;
    
    self.testView.frame = CGRectMake(CGRectGetMidX(self.view.bounds) - 100, 0, 200, 150);
    [self.testView buk_dynamicShowInView:self.view];
}

#pragma mark - setter && getter
- (UIView *)testView
{
    if (!_testView) {
        _testView = [[UIView alloc] init];
        _testView.backgroundColor = [UIColor greenColor];
    }
    return _testView;
}
@end
