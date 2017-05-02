//
//  Login.m
//  Tour
//
//  Created by Euet on 16/12/9.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Login.h"

#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface Login ()<UITextFieldDelegate,UIApplicationDelegate>
{
    BOOL isa;
}
@end
@implementation Login
-(void)viewInit{
    UIImageView * grounView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width,self.frame.size.height)] ;
    UIImage * image =[UIImage imageNamed:@"bg.jpg"];
    grounView.tag=301;
    grounView.image=image;
    [self addSubview:grounView];
    UIImageView * logoView = [UIImageView new];
    UIImage * imagelogo =[UIImage imageNamed:@"logoin"];
    logoView.image=imagelogo;
    [self addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(64);
        make.height.offset(45);
        make.width.offset(50);
    }];
    _WJButton= [UIButton new];
    [_WJButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_WJButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _WJButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [self addSubview:_WJButton];
    [_WJButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(31);
        make.height.offset(18);
    }];
    UILabel * label1 = [UILabel new];
    label1.text=@"欢迎来到易游商旅。";
    label1.textColor  = [UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:24];

    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(139);
        make.height.offset(28);
        make.width.offset(235);
    }];
    UILabel * label2 = [UILabel new];
    label2.text=@"请使用易游企业账户进行登录。";
    label2.textColor  = [UIColor whiteColor];
    label2.font=[UIFont systemFontOfSize:17];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(181);
        make.height.offset(20);
        make.width.offset(253);
    }];
    UILabel * label3 = [UILabel new];
    label3.text=@"工号";
    label3.textColor  = [UIColor whiteColor];
    label3.font=[UIFont systemFontOfSize:13];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(231);
        make.height.offset(16);
        make.width.offset(28);
    }];
    _UserName =[UITextField new];
//   _UserName.text=@"005";
    _UserName.textColor=[UIColor whiteColor];
    _UserName.font= [UIFont systemFontOfSize:20];
    _UserName.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _UserName.clearButtonMode =
    UITextFieldViewModeWhileEditing;
  //设置边框样式
    _UserName.borderStyle=UITextBorderStyleNone;
    //左视图
//    UIView * Lview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
//    _UserName.leftView = Lview;
//    //设置左边视图显示模式
//    _UserName.leftViewMode = UITextFieldViewModeAlways;
    _UserName.tag =1;
    //keyboardType 键盘样式
    _UserName.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _UserName.returnKeyType = UIReturnKeyNext;
    //secureTextEntry 密文显示
    _UserName.secureTextEntry = NO;
    //设置代理
    _UserName.delegate = self;
    [self addSubview:_UserName];
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(251);
        make.height.offset(24);
    }];
    UIImageView * checkview = [UIImageView new];
    checkview.image=[UIImage imageNamed:@"checked"];
    checkview.tag=201;
    checkview.hidden=YES;
    [self addSubview:checkview];
    [checkview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(251);
        make.height.offset(20);
        make.width.offset(24);
    }];
    UIView * wview1 = [UIView new];
    wview1.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview1];
    [wview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(275);
        make.height.offset(1);
    }];
    
    UILabel * label4= [UILabel new];
    label4.text=@"密码";
    label4.textColor  = [UIColor whiteColor];
    label4.font=[UIFont systemFontOfSize:13];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(301);
        make.height.offset(16);
        make.width.offset(28);
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
        make.top.equalTo(self).offset(301);
        make.height.offset(16);
        make.width.offset(28);
    }];

    _PassWord =[UITextField new];
//    _PassWord.text=@"12345a";
    _PassWord.textColor=[UIColor whiteColor];
    _PassWord.font= [UIFont systemFontOfSize:20];
    _PassWord.tintColor = [UIColor whiteColor];

//设置删除文字按钮
_PassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
// UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
//_PassWord.leftView = Lview1;
////设置左边视图显示模式
//_PassWord.leftViewMode = UITextFieldViewModeAlways;
_PassWord.tag =2;
//keyboardType 键盘样式
 _PassWord.keyboardType = UIKeyboardTypeDefault;
//设置return键样式
_PassWord.returnKeyType = UIReturnKeyNext;
//secureTextEntry 密文显示
_PassWord.secureTextEntry = YES;
//设置代理
_PassWord.delegate = self;
[self addSubview:_PassWord];
    
    [_PassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(321);
        make.height.offset(24);
    }];
    UIImageView * checkview1 = [UIImageView new];
    checkview1.image=[UIImage imageNamed:@"checked"];
    checkview1.tag=202;
    checkview1.hidden=YES;
    [self addSubview:checkview1];
    [checkview1 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(321);
        make.height.offset(20);
        make.width.offset(24);
    }];

    UIView * wview2 = [UIView new];
    wview2.backgroundColor=[UIColor whiteColor];
    [self addSubview:wview2];
    [wview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(345);
        make.height.offset(1);
    }];
    
    _loginButton = [UIButton new];
    _loginButton.layer.cornerRadius = 22.0;
    _loginButton.userInteractionEnabled=NO;
    _loginButton.alpha=0.4;
//_loginButton.layer.borderWidth = 1;
    _loginButton.tag=102;
//[_loginButton setTitle:@"登录" forState: UIControlStateNormal];
//[_loginButton setTitleColor:[UIColor colorWithRed:7/255 green:68/255 blue:130/255 alpha:1] forState:UIControlStateNormal];
    [_loginButton setBackgroundColor: [UIColor lightGrayColor]];
    [_loginButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_loginButton];
    [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.bottom.equalTo(self).offset(-30);
//      make.top.equalTo(self).offset(345);
        make.height.offset(44);
        make.width.offset(88);
    }];
    UILabel * label =[UILabel new];
    label.text=@"登录";
    label.textColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [_loginButton addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_loginButton).offset(19);
        make.bottom.equalTo(_loginButton).offset(-13);
        make.height.offset(18);
        make.width.offset(37);
    }];
    UIImageView * butimage = [UIImageView new];
    butimage.image = [UIImage imageNamed:@"disclosure-indicator"];
    [_loginButton addSubview:butimage];
    [butimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_loginButton).offset(-17);
        make.bottom.equalTo(_loginButton).offset(-13);
        make.height.offset(18);
        make.width.offset(10);
    }];
    _ZCButton = [UIButton new];
    _ZCButton.layer.cornerRadius = 16.0;
    _ZCButton.layer.borderWidth = 1;
    _ZCButton.titleLabel.font= [UIFont systemFontOfSize:15];
    _ZCButton.layer.borderColor=[UIColor whiteColor].CGColor;
    _ZCButton.tag=101;
    [_ZCButton setTitle:@"企业注册" forState: UIControlStateNormal];
    [_ZCButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [_ZCButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_ZCButton setBackgroundColor: [UIColor colorWithRed:7/255 green:68/255 blue:130/255 alpha:0]];
    [self addSubview:_ZCButton];
    [_ZCButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.bottom.equalTo(self).offset(-36);
        // make.top.equalTo(self).offset(345);
        make.height.offset(32);
        make.width.offset(96);
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
        make.left.equalTo(self).offset(20);
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
        _loginButton.userInteractionEnabled=YES;
        _loginButton.alpha=1;
        [_loginButton setBackgroundColor: [UIColor whiteColor]];
        }
    switch (textField.tag) {
        case 1:
            if ([textField.text isEqualToString:@""]) {
                [self yc2];
                _loginButton.userInteractionEnabled=NO;
                _loginButton.alpha=0.4;
            }
            break;
        case 2:
            if ([textField.text isEqualToString:@""]) {
                _loginButton.userInteractionEnabled=NO;
                _loginButton.alpha=0.4;
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
                _PassWord.secureTextEntry = NO;
                [send setTitle:@"隐藏" forState: UIControlStateNormal];
            }else{
                _PassWord.secureTextEntry = YES;
                [send setTitle:@"显示" forState: UIControlStateNormal];
            }
            break;
            case 102:
            
            [self endEditing:YES];
            if (self.loginHandler) {
                self.loginHandler(self.UserName.text,self.PassWord.text);
            }
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
