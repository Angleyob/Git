//
//  ZCView.m
//  Tour
//
//  Created by Euet on 16/12/12.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ZCView.h"
@interface ZCView ()<UITextFieldDelegate,UIApplicationDelegate,CLLocationManagerDelegate>
{
    CLLocationManager * locationManager;
    NSString * currentCity; //当前城市
     BOOL isa;
}
@end
@implementation ZCView
-(void)viewInit{
    //判断定位功能是否打开
    if ([CLLocationManager locationServicesEnabled]) {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        //[locationManager requestAlwaysAuthorization];
        currentCity = [[NSString alloc] init];
        [locationManager startUpdatingLocation];
    }else{
        NSLog(@"请打开定位服务");
    }
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
    label1.text=@"企业注册";
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
  label2.text=@"企业名称";
  label2.textColor  = [UIColor whiteColor];
  label2.font=[UIFont systemFontOfSize:13];
  [self addSubview:label2];
  [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(20);
    make.top.equalTo(self).offset(126);
    make.height.offset(16);
    make.width.offset(56);
}];
_UserName =[UITextField new];
_UserName.textColor=[UIColor whiteColor];
_UserName.font= [UIFont systemFontOfSize:20];
_UserName.tintColor = [UIColor whiteColor];
//设置删除文字按钮
_UserName.clearButtonMode =
UITextFieldViewModeWhileEditing;
//设置边框样式
_UserName.borderStyle=UITextBorderStyleNone;
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
    label4.text=@"城市";
    label4.textColor=[UIColor whiteColor];
    label4.font=[UIFont systemFontOfSize:13];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(20);
    make.top.equalTo(self).offset(196);
    make.height.offset(16);
    make.width.offset(28);
}];
    _Citybut = [UIButton new];
    [self addSubview:_Citybut];
    _cityLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 24)];
    _cityLabel.textColor  = [UIColor whiteColor];
    [_Citybut addSubview:_cityLabel];
    [_Citybut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(216);
        make.height.offset(24);
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
    UILabel * label5= [UILabel new];
    label5.text=@"联系人";
    label5.textColor  = [UIColor whiteColor];
    label5.font=[UIFont systemFontOfSize:13];
    [self addSubview:label5];
    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(266);
        make.height.offset(16);
        make.width.offset(42);
    }];
    _Men =[UITextField new];
    _Men.textColor=[UIColor whiteColor];
    _Men.font= [UIFont systemFontOfSize:20];
    _Men.tintColor = [UIColor whiteColor];

    //设置删除文字按钮
    _Men.clearButtonMode = UITextFieldViewModeWhileEditing;
    // UIView * Lview1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 24)];
    //_PassWord.leftView = Lview1;
    ////设置左边视图显示模式
    //_PassWord.leftViewMode = UITextFieldViewModeAlways;
_Men.tag =2;
//keyboardType 键盘样式
_Men.keyboardType = UIKeyboardTypeDefault;
//设置return键样式
_Men.returnKeyType = UIReturnKeyNext;
//设置代理
_Men.delegate = self;
[self addSubview:_Men];
    [_Men mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-54);
        make.top.equalTo(self).offset(286);
        make.height.offset(20);
    }];
    UIImageView * checkview1 = [UIImageView new];
checkview1.image=[UIImage imageNamed:@"checked"];
checkview1.tag=202;
checkview1.hidden=YES;
[self addSubview:checkview1];
[checkview1 mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(self).offset(20);
    make.right.equalTo(self).offset(-20);
    make.top.equalTo(self).offset(286);
    make.height.offset(20);
    make.width.offset(24);
}];
UIView * wview3 = [UIView new];
wview3.backgroundColor=[UIColor whiteColor];
[self addSubview:wview3];
[wview3 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self).offset(20);
    make.right.equalTo(self).offset(-20);
    make.top.equalTo(self).offset(310);
    make.height.offset(1);
}];
    
    UILabel * label6= [UILabel new];
    label6.text=@"手机号码";
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
        make.top.equalTo(self).offset(356);
        make.height.offset(20);
    }];
    UIImageView * checkview2 = [UIImageView new];
    checkview2.image=[UIImage imageNamed:@"checked"];
    checkview2.tag=203;
    checkview2.hidden=YES;
    [self addSubview:checkview2];
    [checkview2 mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.top.equalTo(self).offset(356);
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
_loginbut = [UIButton new];
_loginbut.layer.cornerRadius = 22.0;
_loginbut.userInteractionEnabled=NO;
_loginbut.alpha=0.4;
//_loginButton.layer.borderWidth = 1;
_loginbut.tag=102;
//[_loginButton setTitle:@"登录" forState: UIControlStateNormal];
//[_loginButton setTitleColor:[UIColor colorWithRed:7/255 green:68/255 blue:130/255 alpha:1] forState:UIControlStateNormal];
[_loginbut setBackgroundColor: [UIColor lightGrayColor]];
[_loginbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
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
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
    {
        //取消输入框的第一响应
        UITextField *textField = (id)[self viewWithTag:1];
        UITextField *textField1 = (id)[self viewWithTag:2];
        UITextField *textField2 = (id)[self viewWithTag:3];
        //resignFirstResponder 取消第一响应
        //becomeFirstResponder 成为第一响应
        [textField1 resignFirstResponder];
        [textField resignFirstResponder];
        [textField2 resignFirstResponder];
    }
    //输入框已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField
    {
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
    //输入框已经结束编辑
 - (void)textFieldDidEndEditing:(UITextField *)textField
 {
     UITextField *textField1=(UITextField*)[self viewWithTag:1];
     UITextField *textField2=(UITextField*)[self viewWithTag:2];
     UITextField *textField3=(UITextField*)[self viewWithTag:3];

     if (![textField1.text isEqualToString:@""]&&![textField2.text isEqualToString:@""]&&![textField3.text isEqualToString:@""]) {
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
            case 3:
                if ([textField.text isEqualToString:@""]) {
                    _loginbut.userInteractionEnabled=NO;
                    _loginbut.alpha=0.4;
                    [self yc5];
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
            default:
                break;
        }
        //返回yes 可以清除 返回no不可以清除
        return YES;
    }
-(void)onClick:(UIButton*)send{
    [self endEditing:YES];
    if (self.loginHandler) {
        self.loginHandler(self.UserName.text,self.cityLabel.text,self.Men.text,self.phoneNumber.text);
    }
}
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"允许\"定位\"提示" message:@"请在设置中打开定位" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok = [UIAlertAction actionWithTitle:@"打开定位" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开定位设置
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }];
}
//定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation  {
    
    [locationManager stopUpdatingLocation];
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            NSDictionary *test = [placemark addressDictionary];
            //  Country(国家)  State(省)  SubLocality(区)
            NSLog(@"555%@", test[@"City"]);
            NSMutableString * text =test[@"City"];
         NSString * city=[text substringToIndex:2];
            _cityLabel.text=city;
        }
    }];
}
@end
