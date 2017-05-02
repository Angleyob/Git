//
//  changeView.m
//  Tour
//
//  Created by Euet on 16/12/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "changeView.h"
@interface changeView ()<UIPickerViewDataSource, UIPickerViewDelegate>
@end
@implementation changeView

-(void)initview{
    UIView * vv = [UIView new];
    vv.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self addSubview:vv];
    [vv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.height.offset(30);
        make.width.offset(self.frame.size.width);
    }];
    UIPickerView *pickerView = [UIPickerView new];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [self loadPickerData];
    [self addSubview:pickerView];
    [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.equalTo(self).offset(30);
        make.width.offset(self.frame.size.width);
    }];
}
-(void)loadPickerData{
    _arr=@[@"经济舱",@"商务舱",@"头等舱",@"不限"];
}
#pragma mark 设置列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
#pragma mark 设置行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arr[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    NSString * str = _arr[rowOne];
     NSLog(@"%@",str);
}

@end
