//
//  forgetpassWord.m
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "forgetpassWord.h"
@interface forgetpassWord ()<UITextFieldDelegate,UIApplicationDelegate,CLLocationManagerDelegate>{
    BOOL isa;
}
@end
@implementation forgetpassWord
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
    label1.text=@"忘记密码";
    label1.textColor  = [UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:22];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(64);
        make.height.offset(28);
        make.width.offset(105);
    }];
    
    UILabel * label2 = [UILabel new];
    label2.text=@"工号";
    label2.textColor  = [UIColor whiteColor];
    label2.font=[UIFont systemFontOfSize:13];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(126);
        make.height.offset(16);
        make.width.offset(56);
    }];
    _workNumber =[UITextField new];
    _workNumber.textColor=[UIColor whiteColor];
    _workNumber.font= [UIFont systemFontOfSize:20];
    _workNumber.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _workNumber.clearButtonMode =
    UITextFieldViewModeWhileEditing;
    //设置边框样式
    _workNumber.borderStyle=UITextBorderStyleNone;
    _workNumber.tag =1;
    //keyboardType 键盘样式
    _workNumber.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _workNumber.returnKeyType = UIReturnKeyNext;
    //secureTextEntry 密文显示
    _workNumber.secureTextEntry = NO;
    //设置代理
    _workNumber.delegate = self;
    [self addSubview:_workNumber];
    [_workNumber mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    UILabel * label4= [UILabel new];
    label4.text=@"差旅卡号";
    label4.textColor=[UIColor whiteColor];
    label4.font=[UIFont systemFontOfSize:13];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(196);
        make.height.offset(16);
        make.width.offset(56);
    }];
    _cardnNmber =[UITextField new];
    _cardnNmber.textColor=[UIColor whiteColor];
    _cardnNmber.font= [UIFont systemFontOfSize:20];
    _cardnNmber.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _cardnNmber.clearButtonMode =
    UITextFieldViewModeWhileEditing;
    //设置边框样式
    _cardnNmber.borderStyle=UITextBorderStyleNone;
    _cardnNmber.tag =2;
    //keyboardType 键盘样式
    _cardnNmber.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _cardnNmber.returnKeyType = UIReturnKeyNext;
    //设置代理
    _cardnNmber.delegate = self;
    [self addSubview:_cardnNmber];
    [_cardnNmber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
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
    
    UILabel * label6= [UILabel new];
    label6.text=@"验证码";
    label6.textColor  = [UIColor whiteColor];
    label6.font=[UIFont systemFontOfSize:13];
    [self addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(336);
        make.height.offset(16);
        make.width.offset(56);
    }];
    _phoneNumber =[UITextField new];
    _phoneNumber.textColor=[UIColor whiteColor];
    _phoneNumber.font= [UIFont systemFontOfSize:20];
    _phoneNumber.tintColor = [UIColor whiteColor];
    
    //设置删除文字按钮
    _phoneNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
    //_PassWord.leftView = Lview1;
    ////设置左边视图显示模式
    //_PassWord.leftViewMode = UITextFieldViewModeAlways;
    _phoneNumber.tag =3;
    //keyboardType 键盘样式
    _phoneNumber.keyboardType = UIKeyboardTypeNumberPad;
    //设置return键样式
    _phoneNumber.returnKeyType = UIReturnKeyNext;
    //设置代理
    _phoneNumber.delegate = self;
    [self addSubview:_phoneNumber];
    
    [_phoneNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(286);
        make.height.offset(20);
    }];
    UIImageView * checkview2 = [UIImageView new];
    checkview2.image=[UIImage imageNamed:@"checked"];
    checkview2.tag=203;
    checkview2.hidden=YES;
    [self addSubview:checkview2];
    [checkview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(286);
        make.height.offset(20);
        make.width.offset(24);
    }];
    UIView * wview4 = [UIView new];
    wview4.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview4];
    [wview4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(380);
        make.height.offset(1);
    }];
    
    UILabel * label5= [UILabel new];
    label5.text=@"手机号码";
    label5.textColor  = [UIColor whiteColor];
    label5.font=[UIFont systemFontOfSize:13];
    [self addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(266);
        make.height.offset(16);
        make.width.offset(56);
    }];
    _verifyNumber =[UITextField new];
    _verifyNumber.textColor=[UIColor whiteColor];
    _verifyNumber.font= [UIFont systemFontOfSize:20];
    _verifyNumber.tintColor = [UIColor whiteColor];
    
    _verifyNumber.userInteractionEnabled=NO;
    //设置删除文字按钮
    _verifyNumber.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
    //_PassWord.leftView = Lview1;
    ////设置左边视图显示模式
    //_PassWord.leftViewMode = UITextFieldViewModeAlways;
    _verifyNumber.tag =4;
    //keyboardType 键盘样式
    _verifyNumber.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _verifyNumber.returnKeyType = UIReturnKeyNext;
    //设置代理
    _verifyNumber.delegate = self;
    [self addSubview:_verifyNumber];
    [_verifyNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-136);
        make.top.equalTo(self).offset(356);
        make.height.offset(20);
    }];
    _verifybut = [UIButton new];
    _verifybut.layer.cornerRadius = 16.0;
    _verifybut.userInteractionEnabled=NO;
    _verifybut.layer.borderWidth = 1;
    _verifybut.layer.borderColor=[UIColor whiteColor].CGColor;
    _verifybut.alpha=0.4;
    [_verifybut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:_verifybut];
    [_verifybut mas_makeConstraints:^(MASConstraintMaker *make) {
                //make.left.equalTo(self).offset(20);
                make.right.equalTo(self).offset(-20);
                make.top.equalTo(self).offset(345);
                make.height.offset(32);
                make.width.offset(105);
            }];
    UILabel * labelv =[UILabel new];
    labelv.text=@"获取验证码";
    labelv.font= [UIFont systemFontOfSize:15];
    labelv.textColor= [UIColor whiteColor];
    [_verifybut addSubview:labelv];
    [labelv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_verifybut).offset(16);
        make.top.equalTo(_verifybut).offset(8);
        make.height.offset(16);
        make.width.offset(80);
    }];

//    UIImageView * checkview1 = [UIImageView new];
//    checkview1.image=[UIImage imageNamed:@"checked"];
//    checkview1.tag=204;
//    checkview1.hidden=YES;
//    [self addSubview:checkview1];
//    [checkview1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        //make.left.equalTo(self).offset(20);
//        make.right.equalTo(self).offset(-20);
//        make.top.equalTo(self).offset(356);
//        make.height.offset(20);
//        make.width.offset(24);
//    }];
    UIView * wview3 = [UIView new];
    wview3.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview3];
    [wview3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(310);
        make.height.offset(1);
    }];
    

    _loginbut = [UIButton new];
    _loginbut.layer.cornerRadius = 22.0;
    _loginbut.userInteractionEnabled=NO;
    _loginbut.alpha=0.4;
    _loginbut.tag=102;
    //[_loginButton setTitleColor:[UIColor colorWithRed:7/255 green:68/255 blue:130/255 alpha:1] forState:UIControlStateNormal];
    [_loginbut setBackgroundColor: [UIColor lightGrayColor]];
//   [_loginbut addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginbut];
    [_loginbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-30);
        //      make.top.equalTo(self).offset(345);
        make.height.offset(44);
        make.width.offset(122);
    }];
    UILabel * label =[UILabel new];
    label.text=@"重置密码";
    label.textColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [_loginbut addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginbut).offset(19);
        make.bottom.equalTo(_loginbut).offset(-13);
        make.height.offset(20);
        make.width.offset(73);
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
     _tslabel0= [UILabel new];
    [alertView addSubview:_tslabel0];
    _tslabel0.text = @"这些登录信息似乎不正确,请重试。";
    _tslabel0.font = [UIFont systemFontOfSize:15];
    _tslabel0.textAlignment = NSTextAlignmentCenter;
    [_tslabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.bottom.equalTo(self).offset(-25);
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
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-23);
        // make.top.equalTo(self).offset(345);
        make.height.offset(18);
        make.width.offset(37);
    }];

}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{   _coverView.hidden=YES;
    //取消输入框的第一响应
    UITextField *textField = (id)[self viewWithTag:1];
    UITextField *textField1 = (id)[self viewWithTag:2];
    UITextField *textField2 = (id)[self viewWithTag:3];
    UITextField *textField3 = (id)[self viewWithTag:4];

    //resignFirstResponder 取消第一响应
    //becomeFirstResponder 成为第一响应
    [textField1 resignFirstResponder];
    [textField resignFirstResponder];
    [textField2 resignFirstResponder];
    [textField3 resignFirstResponder];

}
//输入框已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    _coverView.hidden=YES;

    switch (textField.tag) {
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [self changebackgraoud1];
    isa=YES;
    switch (textField.tag) {
        case 1:
            [self yc];
            break;
        case 2:
            [self yc1];
            break;
        case 3:
            if (range.location>=11)
            {
                [self yc4];
                isa=NO;
            }
            else
            {
                isa=YES;
            }
            break;
        case 4:
            [self yc6];
            break;
        default:
            break;
    }
    return isa;
}
-(void)yc{
    UIImageView * vi = (UIImageView*)[self viewWithTag:201];
    vi.hidden=NO;
}
-(void)yc1{
    UIImageView * vi = (UIImageView*)[self viewWithTag:202];
    vi.hidden=NO;
}
-(void)yc4{
    UIImageView * vi = (UIImageView*)[self viewWithTag:203];
    vi.hidden=NO;
}
-(void)yc6{
    UIImageView * vi = (UIImageView*)[self viewWithTag:204];
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
-(void)yc5{
    UIImageView * vi = (UIImageView*)[self viewWithTag:203];
    vi.hidden=YES;
}
-(void)yc7{
    UIImageView * vi = (UIImageView*)[self viewWithTag:204];
    vi.hidden=YES;
}

//输入框已经结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    UITextField *textField1=(UITextField*)[self viewWithTag:1];
    UITextField *textField2=(UITextField*)[self viewWithTag:2];
    UITextField *textField3=(UITextField*)[self viewWithTag:3];
    UITextField *textField4=(UITextField*)[self viewWithTag:4];

    if (![textField1.text isEqualToString:@""]&&![textField2.text isEqualToString:@""]&&![textField3.text isEqualToString:@""]&&[textField4.text isEqualToString:@""]) {
        _verifybut.userInteractionEnabled=YES;
        _verifybut.alpha=1;
    }
    if (![textField1.text isEqualToString:@""]&&![textField2.text isEqualToString:@""]&&![textField3.text isEqualToString:@""]&&![textField4.text isEqualToString:@""]) {
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
                _verifybut.userInteractionEnabled=NO;
                _verifybut.alpha=0.4;
            }
            break;
        case 2:
            if ([textField.text isEqualToString:@""]) {
                _loginbut.userInteractionEnabled=NO;
                _loginbut.alpha=0.4;
                _verifybut.userInteractionEnabled=NO;
                _verifybut.alpha=0.4;
                [self yc3];
            }
            break;
        case 3:
            if ([textField.text isEqualToString:@""]) {
                _loginbut.userInteractionEnabled=NO;
                _loginbut.alpha=0.4;
                _verifybut.userInteractionEnabled=NO;
                _verifybut.alpha=0.4;
                [self yc5];
            }
        case 4:
            if ([textField.text isEqualToString:@""]) {
                _loginbut.userInteractionEnabled=NO;
                _loginbut.alpha=0.4;
                [self yc7];
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
        case 3:
            [self yc5];
            break;
        case 4:
            [self yc7];
            break;
        default:
            break;
    }
    //返回yes 可以清除 返回no不可以清除
    return YES;
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
-(void)onClick:(UIButton*)send{
    if (send.tag==401) {
        _coverView.hidden=YES;
    }
    _verifyNumber.userInteractionEnabled=YES;
    _verifybut.userInteractionEnabled=NO;
    _verifybut.alpha=0.4;
    [self endEditing:YES];
    if (self.loginHandler) {
        self.loginHandler(self.workNumber.text,self.cardnNmber.text,self.phoneNumber.text);
    }
}

//-(void)onClick1:(UIButton*)send{
//        [self endEditing:YES];
//        if (self.CZHandler) {
//            self.CZHandler(self.workNumber.text,self.cardnNmber.text,self.phoneNumber.text,self.verifyNumber.text);
//        }
//}
@end
