//
//  ReplacePassword.m
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ReplacePassword.h"

@implementation ReplacePassword
-(void)viewInit{
    UIImageView * grounView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,self.frame.size.height)] ;
    UIImage * image =[UIImage imageNamed:@"bg.jpg"];
    grounView.tag=301;
    grounView.image=image;
    [self addSubview:grounView];
    
    _backbut=[UIButton new];
    [self addSubview:_backbut];

    UIImageView * backView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 13, 21)];
    UIImage * imagelogo =[UIImage imageNamed:@"back-chevron"];
    backView.image=imagelogo;
    [_backbut addSubview:backView];
    [_backbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(32);
        make.height.offset(21);
        make.width.offset(13);
    }];
    UILabel * label1 = [UILabel new];
    label1.text=@"重置密码";
    label1.textColor  = [UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:22];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(64);
        make.height.offset(28);
        make.width.offset(105);
    }];
    UIButton * butpassword= [UIButton new];
    butpassword.tag=103;
    [butpassword setTitle:@"显示" forState: UIControlStateNormal];
    [butpassword setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butpassword addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    butpassword.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:butpassword];
    [butpassword mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(126);
        make.height.offset(16);
        make.width.offset(28);
    }];
    
    UILabel * label2 = [UILabel new];
    label2.text=@"新密码";
    label2.textColor  = [UIColor whiteColor];
    label2.font=[UIFont systemFontOfSize:13];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(126);
        make.height.offset(16);
        make.width.offset(42);
    }];
    _newpassWord0 =[UITextField new];
    _newpassWord0.textColor=[UIColor whiteColor];
    _newpassWord0.font= [UIFont systemFontOfSize:20];
    _newpassWord0.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _newpassWord0.clearButtonMode =
    UITextFieldViewModeWhileEditing;
    //设置边框样式
    _newpassWord0.borderStyle=UITextBorderStyleNone;
    _newpassWord0.tag =1;
    //keyboardType 键盘样式
    _newpassWord0.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _newpassWord0.returnKeyType = UIReturnKeyNext;
    //secureTextEntry 密文显示
    _newpassWord0.secureTextEntry = YES;
    //设置代理
    _newpassWord0.delegate = self;
    [self addSubview:_newpassWord0];
    [_newpassWord0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(146);
        make.height.offset(20);
    }];
    
    UIImageView * checkview = [UIImageView new];
    checkview.image=[UIImage imageNamed:@"checked"];
    checkview.tag=201;
    checkview.hidden=YES;
    [self addSubview:checkview];
    [checkview mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(146);
        make.height.offset(20);
        make.width.offset(24);
    }];
    UIView * wview1 = [UIView new];
    wview1.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview1];
    [wview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(170);
        make.height.offset(1);
    }];
    UIButton * butpassword1= [UIButton new];
    butpassword1.tag=104;
    [butpassword1 setTitle:@"显示" forState: UIControlStateNormal];
    [butpassword1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [butpassword1 addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    butpassword1.titleLabel.font=[UIFont systemFontOfSize:13];
    [self addSubview:butpassword1];
    [butpassword1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(196);
        make.height.offset(16);
        make.width.offset(28);
    }];
    UILabel * label4= [UILabel new];
    label4.text=@"确认新密码";
    label4.textColor=[UIColor whiteColor];
    label4.font=[UIFont systemFontOfSize:13];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(196);
        make.height.offset(16);
        make.width.offset(70);
    }];
    _newpassWord =[UITextField new];
    _newpassWord.textColor=[UIColor whiteColor];
    _newpassWord.font= [UIFont systemFontOfSize:20];
    _newpassWord.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _newpassWord.clearButtonMode =
    UITextFieldViewModeWhileEditing;
    //设置边框样式
    _newpassWord.borderStyle=UITextBorderStyleNone;
    _newpassWord.tag =2;
    //keyboardType 键盘样式
    _newpassWord.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _newpassWord.returnKeyType = UIReturnKeyNext;
    //设置代理
    _newpassWord.delegate = self;
    //secureTextEntry 密文显示
    _newpassWord.secureTextEntry = YES;
    [self addSubview:_newpassWord];
    [_newpassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(216);
        make.height.offset(24);
    }];
    UIImageView * checkview0 = [UIImageView new];
    checkview0.image=[UIImage imageNamed:@"checked"];
    checkview0.tag=202;
    checkview0.hidden=YES;
    [self addSubview:checkview0];
    [checkview0 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(216);
        make.height.offset(20);
        make.width.offset(24);
    }];
    UIView * wview2 = [UIView new];
    wview2.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview2];
    [wview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(240);
        make.height.offset(1);
    }];
    
    _loginbut = [UIButton new];
    _loginbut.layer.cornerRadius = 22.0;
    _loginbut.userInteractionEnabled=NO;
    _loginbut.alpha=0.4;
    //_loginButton.layer.borderWidth = 1;
    _loginbut.tag=102;
    //[_loginButton setTitle:@"登录" forState: UIControlStateNormal];
    //[_loginButton setTitleColor:[UIColor colorWithRed:7/255 green:68/255 blue:130/255 alpha:1] forState:UIControlStateNormal];
    [_loginbut setBackgroundColor: [UIColor lightGrayColor]];
    //[_loginbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginbut];
    [_loginbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-30);
        //      make.top.equalTo(self).offset(345);
        make.height.offset(44);
        make.width.offset(88);
    }];

    UILabel * label =[UILabel new];
    label.text=@"提交";
    label.textColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [_loginbut addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginbut).offset(19);
        make.bottom.equalTo(_loginbut).offset(-13);
        make.height.offset(18);
        make.width.offset(37);
    }];
    UIImageView * butimage = [UIImageView new];
    butimage.image = [UIImage imageNamed:@"disclosure-indicator"];
    [_loginbut addSubview:butimage];
    [butimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_loginbut).offset(-17);
        make.bottom.equalTo(_loginbut).offset(-13);
        make.height.offset(18);
        make.width.offset(10);
    }];
    //创建蒙版
    _coverView = [UIView new];
    _coverView.tag=302;
    _coverView.hidden=YES;
    [self addSubview:_coverView];
    _coverView.backgroundColor = [UIColor whiteColor];
    _coverView.alpha = 0.9;
    [_coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        // make.top.equalTo(self).offset(345);
        make.height.offset(60);
        make.width.offset(self.frame.size.width);
    }];
    //创建提示框view
    UIView * alertView = [UIView new];
    [_coverView addSubview:alertView];
    alertView.center = _coverView.center;
    alertView.bounds = CGRectMake(0, 0, self.frame.size.width, 60);
    //创建操作提示 label
    UILabel * tslabel0 = [UILabel new];
    [alertView addSubview:tslabel0];
    tslabel0.text = @"这些登录信息似乎不正确，请重试。";
    tslabel0.font = [UIFont systemFontOfSize:15];
    tslabel0.textAlignment = NSTextAlignmentCenter;
    [tslabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(58);
        make.bottom.equalTo(self).offset(-23);
        // make.top.equalTo(self).offset(345);
        make.height.offset(18);
        //  make.width.offset(256);
    }];
    UIButton * deletebut =[UIButton new];
    [deletebut setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    deletebut.tag=401;
    [_coverView addSubview:deletebut];
    [deletebut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [deletebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_coverView).offset(-20);
        make.bottom.equalTo(self).offset(-23);
        // make.top.equalTo(self).offset(345);
        make.height.offset(15);
        make.width.offset(15);
    }];
    UILabel * tslabel = [UILabel new];
    [alertView addSubview:tslabel];
    tslabel.text = @"错误:";
    tslabel.textColor=[UIColor orangeColor];
    tslabel.font = [UIFont systemFontOfSize:15];
    tslabel.textAlignment = NSTextAlignmentCenter;
    [tslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(25);
        make.bottom.equalTo(self).offset(-23);
        // make.top.equalTo(self).offset(345);
        make.height.offset(18);
        make.width.offset(37);
    }];
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _coverView.hidden=YES;
    //取消输入框的第一响应
    UITextField *textField = (id)[self viewWithTag:1];
    UITextField *textField1 = (id)[self viewWithTag:2];
    //resignFirstResponder 取消第一响应
    //becomeFirstResponder 成为第一响应
    [textField1 resignFirstResponder];
    [textField resignFirstResponder];
}
//输入框已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _coverView.hidden=YES;
    switch (textField.tag) {
        case 1:
            break;
        case 2:
            _coverView.hidden=YES;
            break;
        default:
            break;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self changebackgraoud1];
    switch (textField.tag) {
        case 1:
            [self yc];
            break;
        case 2:
            [self yc1];
            break;
        default:
            break;
    }
    return YES;
}
-(void)yc{
    UIImageView * vi = (UIImageView*)[self viewWithTag:201];
    vi.hidden=NO;
}
-(void)yc1{
    UIImageView * vi = (UIImageView*)[self viewWithTag:202];
    vi.hidden=NO;
}
-(void)yc2{
    UIImageView * vi = (UIImageView*)[self viewWithTag:201];
    vi.hidden=YES;
}
-(void)yc3{
    UIImageView * vi = (UIImageView*)[self viewWithTag:202];
    vi.hidden=YES;
}
//输入框已经结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField

{       UITextField *textField1=(UITextField*)[self viewWithTag:1];
    UITextField *textField2=(UITextField*)[self viewWithTag:2];
    if (![textField1.text isEqualToString:@""]&&![textField2.text isEqualToString:@""]) {
        _loginbut.userInteractionEnabled=YES;
        _loginbut.alpha=1;
        [_loginbut setBackgroundColor: [UIColor whiteColor]];
    }
    switch (textField.tag) {
        case 1:
            if ([textField.text isEqualToString:@""]) {
                [self yc2];
                _loginbut.userInteractionEnabled=NO;
                _loginbut.alpha=0.4;
            }
            break;
        case 2:
            if ([textField.text isEqualToString:@""]) {
                _loginbut.userInteractionEnabled=NO;
                _loginbut.alpha=0.4;
                [self yc3];
            }
            break;
        default:
            break;
    }
    NSLog(@"输入框已经结束编辑");
}
//清除文字是调用此方法
- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self changebackgraoud1];
    switch (textField.tag) {
        case 1:
            [self yc2];
            break;
        case 2:
            [self yc3];
            break;
        default:
            break;
    }
    //返回yes 可以清除 返回no不可以清除
    return YES;
}
-(void)onClick:(UIButton*)send{
    switch (send.tag) {
        case 103:
            if([send.titleLabel.text isEqualToString:@"显示"] ){
                _newpassWord0.secureTextEntry = NO;
                [send setTitle:@"隐藏" forState: UIControlStateNormal];
            }else{
                _newpassWord0.secureTextEntry = YES;
                [send setTitle:@"显示" forState: UIControlStateNormal];
            }
            break;
        case 104:
            if([send.titleLabel.text isEqualToString:@"显示"] ){
                _newpassWord.secureTextEntry = NO;
                [send setTitle:@"隐藏" forState: UIControlStateNormal];
            }else{
                _newpassWord.secureTextEntry = YES;
                [send setTitle:@"显示" forState: UIControlStateNormal];
            }
            break;
        case 102:
            [self endEditing:YES];
//            if (self.loginHandler) {
//                self.loginHandler(self.newpassWord0.text,self.newpassWord.text);
//            }
            break;
        case 401:
            _coverView.hidden=YES;
            break;
        default:
            break;
    }
}
-(void)changebackgraoud{
    [UIView animateWithDuration:0.50f/*渐变动画的时间*/ animations:^{
        _coverView.hidden=NO;
        UIImageView * groundImage = (UIImageView*)[self viewWithTag:301];
        groundImage.image=[UIImage imageNamed:@"bg-error.jpg"];
    }];
}
-(void)changebackgraoud1{
    UIImageView * groundImage = (UIImageView*)[self viewWithTag:301];
    groundImage.image=[UIImage imageNamed:@"bg.jpg"];
}


@end
