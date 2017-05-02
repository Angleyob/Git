//
//  Usereturnpass.m
//  Tour
//
//  Created by Euet on 17/3/17.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "Usereturnpass.h"

@interface Usereturnpass ()<UITextFieldDelegate>

@end
@implementation Usereturnpass

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    label.text=@"修改密码";
    label.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"left"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
#pragma mark -手机号
    _oldtext.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"mobile"];
    _oldtext.userInteractionEnabled=NO;
    _oldtext.textColor=[UIColor blackColor];
    _oldtext.font= [UIFont systemFontOfSize:14];
    _oldtext.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _oldtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _oldtext.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _oldtext.returnKeyType = UIReturnKeyNext;
    //设置代理
    _oldtext.delegate = self;
#pragma mark -密码
    _newtext.textColor=[UIColor blackColor];
    _newtext.font= [UIFont systemFontOfSize:14];
    _newtext.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _newtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _newtext.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _newtext.returnKeyType = UIReturnKeyNext;
    //设置代理
    _newtext.delegate = self;
    
    _oknewtext.textColor=[UIColor blackColor];
    _oknewtext.font= [UIFont systemFontOfSize:14];
    _oknewtext.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _oknewtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _oknewtext.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _oknewtext.returnKeyType = UIReturnKeyNext;
#pragma mark -验证
    //设置代理
    _yztext.delegate = self;
    _yztext.textColor=[UIColor blackColor];
    _yztext.font= [UIFont systemFontOfSize:14];
    _yztext.tintColor = [UIColor blackColor];
    //设置删除文字按钮
    _yztext.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _yztext.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _yztext.returnKeyType = UIReturnKeyNext;
    //设置代理
    _yztext.delegate = self;
    
    _yzbut.layer.cornerRadius = 16.0;
    _yzbut.layer.borderWidth = 1;
    _yzbut.alpha=0.4;
    [_yzbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_but addTarget:self action:@selector(okbutclick:) forControlEvents:UIControlEventTouchUpInside];
    
}
#pragma mark -获取验证码
-(void)onClick:(UIButton*)send{
    if (![_oldtext.text isEqualToString:@""]) {
        if ([phoneNumclass isMobileNumber:_oldtext.text]==NO) {
            [UIAlertView showAlertWithTitle1:@"请输入正确的手机号" duration:1.5];
        }else{
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            VerifyCodeRequest * verify =[VerifyCodeRequest new];
            verify.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            verify.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            verify.EmpNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"empNo"];
            
            verify.Hykh=[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"costCenterCode"] substringWithRange:NSMakeRange(0, 4)];
            verify.Mobile=_oldtext.text;

            [Account VerifyCode:verify success:^(id data) {
                [SVProgressHUD dismiss];
                NSLog(@"****%@",data);

                if ([data[@"status"] isEqualToString:@"T"]) {
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
                    NSLog(@"****%@",data[@"message"]);
                }
            } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];
        }
    }else{
        [UIAlertView showAlertWithTitle1:@"请输入手机号" duration:1.5];
    }
}
#pragma mark -获取确定修改
-(void)okbutclick:(UIButton*)send{
    if ([_newtext.text isEqualToString:@""]||[_oknewtext.text isEqualToString:@""]||[_oldtext.text isEqualToString:@""]||[_yztext.text isEqualToString:@""]) {
        [UIAlertView showAlertWithTitle1:@"您输入的信息有误，请重新输入！" duration:1.2];
    }else{
    if([_newtext.text isEqualToString:_oknewtext.text]){
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        ResetPasswordRequest* reset = [ResetPasswordRequest new];
        
        reset.Code=_yztext.text;
        reset.Hykh=[[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"costCenterCode"] substringWithRange:NSMakeRange(0, 4)];
        reset.Mobile=_oldtext.text;
        reset.UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"empNo"];
//        reset.OldPassword=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"password"];
//        reset.OldPassword=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        reset.NewPassword=_oknewtext.text;
        [Account ResetPassword:reset success:^(id data) {
            [SVProgressHUD dismiss];
            if ([data[@"status"] isEqualToString:@"T"]) {
                [UIAlertView showAlertWithTitle1:@"您的密码已更改，请重新登录！" duration:1.2];
                LoginViewController * lvc = [LoginViewController new];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInf"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"account"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sw1"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"sw2"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self.navigationController pushViewController:lvc animated:NO];
//                [self dismissViewControllerAnimated:NO completion:nil];
            }else{
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
    }else{
        [UIAlertView showAlertWithTitle:@"您两次输入的新密码不一致，请重新输入"];
    }
}
}

-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
