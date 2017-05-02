//
//  logViewController.m
//  Tour
//
//  Created by Euet on 16/12/8.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ZCViewController.h"
#import "ZCView.h"
#import "CityList.h"

#define deviceScreenWidth [[UIScreen mainScreen]bounds].size.width
#define deviceScreenHeight [[UIScreen mainScreen]bounds].size.height
@interface ZCViewController ()<CLLocationManagerDelegate>

    {
        CLLocationManager * locationManager;
        NSString * currentCity; //当前城市
    }
@property (nonatomic, strong) ZCView*aView;  //实例化一个VView的对象
@end

@implementation ZCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self creatLogin];
}
-(void)creatLogin{
    //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    _aView=[[ZCView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight)];
    [_aView viewInit];
    [self.view addSubview:_aView];
    [_aView.backbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aView.Citybut addTarget:self action:@selector(changeCity) forControlEvents:UIControlEventTouchUpInside];

    __block ZCViewController *blockSelf = self;
    __block ZCView * blockaView= _aView;
    blockaView.loginHandler=^(NSString *name,NSString *city,NSString*men,NSString*phongNumber){
        MemberRegRequest *  member  = [MemberRegRequest new];
        member.CompanyName=name;
        member.Mobile=phongNumber;
        member.Contact=men;
        member.CityCode=city;
        member.Address=@"广东广州市";
        member.Email=@"140@qq.com";
        member.IndustryCode=@"1";
        member.Size=@"50-100";
        member.ZipCode=@"511300";
       
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
      
[Basic MemberRegRequest:member success:^(id data) {
    
    [SVProgressHUD dismiss];
             NSLog(@"****%@",data[@"message"]);
            if ([data[@"status"] isEqualToString:@"T"]) {
                [blockSelf loginVC];
            }
         } failure:^(NSError *error) {
             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
         }];
    };
}
-(void)onClick:(id)send{
    [UIView animateWithDuration:0.50f/*渐变动画的时间*/ animations:^{
//    [self dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)changeCity{
    CityList *cvc = [[CityList alloc]init];
    cvc.hidesBottomBarWhenPushed = YES;
    cvc.selectCity = ^(NSString *cityName){
        _aView.cityLabel.text = cityName;
    };
    [self presentViewController:cvc animated:YES completion:nil];
}
-(void)loginVC{
    LoginViewController * vv =[LoginViewController new];
    [UIAlertView showAlertWithTitle1:@"注册成功" duration:1.2];
    [self.navigationController pushViewController:vv animated:YES] ;
//    [self presentViewController:vv animated:YES completion:nil];
}


@end
