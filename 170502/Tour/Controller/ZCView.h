//
//  ZCView.h
//  Tour
//
//  Created by Euet on 16/12/12.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCView : UIView

@property (nonatomic,copy) void (^loginHandler)(NSString *name,NSString *city,NSString*men,NSString*phongNumber);
@property(nonatomic,strong)UITextField * UserName;
@property(nonatomic,strong)UITextField * Men;
@property(nonatomic,strong)UITextField * phoneNumber;
@property(nonatomic,strong)UIButton * Citybut;
@property(nonatomic,strong)UIButton * loginbut;
@property(nonatomic,strong)UIButton * backbut;
@property(nonatomic,strong)UILabel * cityLabel;
-(void)viewInit;  //添加一个方法，用于初始化控件
@end
