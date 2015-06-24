//
//  BUKViewController.m
//  BUKDynamicPopView
//
//  Created by hyice on 06/23/2015.
//  Copyright (c) 2014 hyice. All rights reserved.
//

#import "BUKViewController.h"
#import "BUKExamplePopView.h"

@interface BUKViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *testView;

@end

@implementation BUKViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }
    
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"single pop view";
    }else {
        return @"multi pop view";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    NSString *title = @"";

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                title = @"Drop Down Dialog(default)";
                break;
            case 1:
                title = @"Drop Down Menu";
                break;
            case 2:
                title = @"Pop Up Menu";
                break;
            case 3:
                title = @"Right Side Menu";
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                title = @"Two Level Selection";
                break;
        }
    }
    
    cell.textLabel.text = title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UIView *view;

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                view = [BUKExamplePopView popViewWithExampleStyle:BUKExampleStyle_Default];
                break;
                
            case 1:
                view = [BUKExamplePopView popViewWithExampleStyle:BUKExampleStyle_DropMenu];
                break;
                
            case 2:
                view = [BUKExamplePopView popViewWithExampleStyle:BUKExampleStyle_PopUpMenu];
                break;
                
            case 3:
                view = [BUKExamplePopView popViewWithExampleStyle:BUKExampleStyle_RightMenu];
                break;
                
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
                view = [BUKExamplePopView popViewWithExampleStyle:BUKExampleStyle_TwoLevelSelection];
                break;
        }
    }
    [view buk_dynamicShowInView:self.view];

    
}
@end
