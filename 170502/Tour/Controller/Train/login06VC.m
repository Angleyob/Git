//
//  login06VC.m
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "login06VC.h"

@interface login06VC ()<UITextFieldDelegate,UIApplicationDelegate>

@end

@implementation login06VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-80, 20, 160 , 30)];
    label.text=@"使用12306账号";
    label.textAlignment=UITextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    backbut.tag=666;
    [view addSubview:backbut];

    UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 100, deviceScreenWidth,88)];
    view1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view1];
    UILabel * name  = [UILabel new];
    name.text=@"用户名";
    name.font =[UIFont systemFontOfSize:15];
    [view1 addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(20);
        make.top.equalTo(view1).offset(11);
        make.height.offset(24);
        make.width.offset(48);
    }];
    _UserName =[UITextField new];
    //_UserName.text=@"12306 ";
    _UserName.placeholder =@"12306用户名/邮箱/手机号";
    _UserName.textColor=[UIColor blackColor];
    _UserName.font= [UIFont systemFontOfSize:15];
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
    [view1 addSubview:_UserName];
    [_UserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(20+48+20);
        make.right.equalTo(view1).offset(-20);
        make.top.equalTo(view1).offset(11);
        make.height.offset(18);
    }];
    
    UIView * viewline =[UIView new];
    viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view1 addSubview:viewline];
    [viewline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(20);
        make.right.equalTo(view1).offset(-1);
        make.top.equalTo(view1).offset(44);
        make.height.offset(1);
    }];
    
    UILabel * pass  = [UILabel new];
    pass.text=@"密码";
    pass.font =[UIFont systemFontOfSize:15];
    [view1 addSubview:pass];
    [pass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(20);
        make.top.equalTo(view1).offset(55);
        make.height.offset(24);
        make.width.offset(48);
    }];
    _PassWord =[UITextField new];
//    _PassWord.text=@"111111a";
    _PassWord.placeholder =@"12306密码非易游商旅账号密码";
    _PassWord.textColor=[UIColor blackColor];
    _PassWord.font= [UIFont systemFontOfSize:15];
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
    [self.view addSubview:_PassWord];
    [_PassWord mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1).offset(20+48+20);
        make.right.equalTo(view1).offset(-20);
        make.top.equalTo(view1).offset(55);
        make.height.offset(18);
    }];

    UIButton * okbut  = [UIButton new];
    [okbut addTarget:self action:@selector(okbutclick:) forControlEvents:UIControlEventTouchUpInside];
    [okbut setTitle:@"确定" forState:UIControlStateNormal];
    //剪切
    okbut.clipsToBounds=YES;
    //圆角
    okbut.layer.cornerRadius = 10.0;
    okbut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [self.view addSubview:okbut];
    [okbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(220);
        make.height.offset(44);
    }];
}
-(void)okbutclick:(UIButton*)send{
    if([_UserName.text isEqualToString:@""] ||[_PassWord.text isEqualToString:@""]){
        [UIAlertView showAlertWithTitle:@"12306账号用户名或密码不能为空！"];
    }else{
        if (_erro==nil) {
            TrainorderVC*tvc = [TrainorderVC new];
            tvc.trainDatadict=_trainDatadict;
            tvc.seatDatadict=_seatDatadict;
            tvc.seatarr=_seatarr;
            tvc.StopOverarr=_StopOverarr;
            tvc.requtstdict=_requtstdict;
            tvc.gxlabeltext= _gxlabeltext;
            tvc.username_12306=_UserName.text;
            tvc.pssageWord_12306=_PassWord.text;
          [self.navigationController  pushViewController:tvc animated:YES];
//            [self presentViewController:tvc animated:NO completion:nil];
        }else{
            RuleVC * trainrulevc = [RuleVC new];
            trainrulevc.erromes=_erromes;
            trainrulevc.erro=_erro;
            trainrulevc.style=_style;
            trainrulevc.trainDatadict=_trainDatadict;
            trainrulevc.seatDatadict=_seatDatadict;
            trainrulevc.requtstdict=_requtstdict;
            trainrulevc.seatarr=_seatarr;
            trainrulevc.StopOverarr=_StopOverarr;
            trainrulevc.gxlabeltext= _gxlabeltext;
            trainrulevc.username_12306=_UserName.text;
            trainrulevc.pssageWord_12306=_PassWord.text;
            [self.navigationController  pushViewController:trainrulevc animated:YES];
//        [self presentViewController:trainrulevc animated:NO completion:nil];
        }
    }
}
-(void)sendMessage:(block06)block{
    _block=block;
}
-(void)back:(UIButton*)send{
   [self.navigationController  popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
