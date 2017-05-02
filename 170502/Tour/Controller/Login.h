//
//  Login.h
//  Tour
//
//  Created by Euet on 16/12/9.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Login : UIView
@property (nonatomic,copy) void (^loginHandler)(NSString *account,NSString *pwd);
@property(nonatomic,strong)UIButton * loginButton;
@property(nonatomic,strong)UIButton * WJButton;
@property(nonatomic,strong)UIButton * ZCButton;
@property(nonatomic,strong)UIView * coverView;
@property(nonatomic,strong)UITextField * UserName;
@property(nonatomic,strong)UITextField * PassWord;
-(void)viewInit;  //添加一个方法，用于初始化控件
-(void)changebackgraoud;
-(void)changebackgraoud1;

@end
