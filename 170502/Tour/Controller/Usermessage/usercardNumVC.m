//
//  usercardNumVC.m
//  Tour
//
//  Created by Euet on 17/3/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "usercardNumVC.h"
#import "MainViewController.h"

@interface usercardNumVC ()<UITextFieldDelegate>

{
    NSString * newtype;
    
    NSMutableDictionary * d;

}

@end

@implementation usercardNumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 110 , 30)];
    label.text=@"证件号码";
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
    UIButton * okbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 40, 20)];
    [okbut setTitle:@"确定" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:okbut];

    
    if([_numtype isEqualToString:@"身份证"]){
        newtype=@"NI";
    }else if ([_numtype isEqualToString:@"护照"]){
        newtype=@"ID";
    }else{
       newtype=@"";
    }
    
    _numtext.text=_num;
    _numtext.textColor=[UIColor blackColor];
    _numtext.font= [UIFont systemFontOfSize:20];
    _numtext.tintColor = [UIColor whiteColor];
    //设置删除文字按钮
    _numtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    //keyboardType 键盘样式
    _numtext.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _numtext.returnKeyType = UIReturnKeyNext;
    //设置代理
    _numtext.delegate = self;
    d=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"];
    NSLog(@"%@",d);
//    NSArray * a = @[d[@"userName"],d[@"empList"][0][@"mobile"],d[@"empList"][0][@"email"],d[@"company"][@"name"],d[@"empList"][0][@"costCenterName"],seatstring,d[@"empList"][0][@"certNo"]];
}

-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:YES];

//    [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)okclick:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BookEmpModifyRequest * bem = [BookEmpModifyRequest new];
    bem.Address=@"";
    bem.Birthday=@"";
    bem.Duty=@"";
    bem.Email=@"";
    bem.EmpId=@"";
    bem.EmpNo=d[@"empList"][0][@"empNo"];
    bem.EmpRank=@"";
    bem.EmpStatus=@"";
    bem.EngName=@"";
    bem.IfBookOut=@"";
    bem.IsBooker=@"";
    bem.IsChecker=@"";
    bem.Level=@"";
    bem.Passport=@"";
    bem.PlaceOfBirth=@"";
    bem.PlaceOfIssue=@"";
    bem.PostCode=@"";
    bem.Role=@"";
    bem.Sex=@"";
    bem.Telphone=@"";
    bem.Validity=@"";
    bem.CardType=newtype;
    bem.CardId=_numtext.text;
    bem.Mobile=d[@"empList"][0][@"mobile"];
    bem.Nation=d[@"empList"][0][@"national"];
    bem.EmpName=d[@"userName"];
    bem.ModifyType=@"U";
    bem.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    bem.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    bem.DeptNo=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"departMent"];
    [Account BookEmpModify:bem success:^(id data) {
        // NSLog(@"%@",data[@"message"]);
        [SVProgressHUD dismiss];
        if([data[@"status"] isEqualToString:@"T"]){
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
            self.navigationController.tabBarController.selectedIndex = 4;
            [self.navigationController popToRootViewControllerAnimated:YES];
            
//            MainViewController* main = [MainViewController new];
//        main.navigationController.navigationBar.hidden=NO;
//        [self.navigationController  pushViewController:main animated:YES];
   //[self dismissViewControllerAnimated:NO completion:nil];
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    //[self.navigationController popViewControllerAnimated:YES];
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
