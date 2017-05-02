//
//  ViewController.m
//  Tour
//
//  Created by Euet on 16/11/29.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "LoginViewController.h"
#import "ZCViewController.h"
#import "AppDelegate.h"
#import "Login.h"
#import "flightcityViewController.h"
#import "CardNocell.h"
#import "JPUSHService.h"


#define deviceScreenWidth [[UIScreen mainScreen]bounds].size.width
#define deviceScreenHeight [[UIScreen mainScreen]bounds].size.height
@interface LoginViewController ()<UITextFieldDelegate,UIApplicationDelegate,UITableViewDelegate,UITableViewDataSource>
{
    NSUserDefaults * userMessage;
    NSUserDefaults *  MemberCardNO;
    
    NSUserDefaults * FYw;
    NSUserDefaults * TYw;
    NSUserDefaults * HYw;



    NSUserDefaults  * NSaccount;
    NSUserDefaults  * NSpassword;

    
    UIVisualEffectView *effectView;

    NSString*_accont;
    NSString*_password;
    
    NSMutableArray * dataarry;
    //蒙版视图
    UIView * _connetview;

    UITableView * _tableView;
    
    NSString*_registrationID;

    
}
@property (nonatomic, strong) Login*aView;  //实例化一个VView的对象
@end
@implementation LoginViewController
-(void)viewWillAppear:(BOOL)animated{
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;    
}
- (void)viewDidLoad {
    self.tabBarController.tabBar.hidden=YES;
    [super viewDidLoad];
    if ([JPUSHService registrationID]) {
        _registrationID= [JPUSHService registrationID];
        NSLog(@"%@",  [JPUSHService registrationID]);
    }
        self.title=@"登 录";
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"] count]!=0) {
        [self CLloata];
        AccountVerifyRequest * Verify=[[AccountVerifyRequest alloc]init];
        Verify.Password=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
        Verify.UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
        Verify.MemberId=@"";
        Verify.LoginUserId=@"";
        Verify.RegistrationID=_registrationID;
        //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"]);
        Verify.MemberCardNo=[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"];
//        [SVProgressHUD showWithStatus:@"正在加载"];
//        [SVProgressHUD show];
        [Account AccountVerify:Verify success:^(id data) {
            [SVProgressHUD dismiss];
//            sleep(5);
//            NSLog(@"****%@",data);
            if ([data[@"status"] isEqualToString:@"T"]) {
                userMessage=[NSUserDefaults standardUserDefaults];
                [userMessage setObject:data[@"userInf"] forKey:@"userInf"];
                NSaccount=[NSUserDefaults standardUserDefaults];
                NSpassword=[NSUserDefaults standardUserDefaults];
                [NSaccount setObject:Verify.UserName forKey:@"account"];
                [NSpassword setObject: Verify.Password forKey:@"password"];
                [self rootVC];
            }else{
                [UIAlertView showAlertWithTitle:@"错误提示您的密码已修改，请重新登录！"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInf"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"account"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self creatLogin];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"登录失败,请检查您的网络设置"] duration:1.0];
        }];
    }else{
        [self creatLogin];
    }
}
-(void)creatLogin{
    dataarry=[NSMutableArray new];
    //初始化时一定要设置frame，否则VView上的两个按钮将无法被点击
    _aView=[[Login alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight)];
    [_aView viewInit];
    [self.view addSubview:_aView];
   
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.9;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    self.view.userInteractionEnabled=YES;
    [_aView addSubview:effectView];

    [_aView.ZCButton addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [_aView.WJButton addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
    __block LoginViewController *blockSelf = self;
    __block Login * blockaView= _aView;
    
    blockaView.loginHandler =^(NSString *account,NSString *pwd){
        MemberCardNO=[NSUserDefaults standardUserDefaults];
        NSaccount=[NSUserDefaults standardUserDefaults];

        if(![account isEqualToString:[[NSUserDefaults standardUserDefaults]objectForKey:@"account"]]&&![[[NSUserDefaults standardUserDefaults]objectForKey:@"account"] isEqualToString:@""] ){
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        CardNoQueryRequest * card =[CardNoQueryRequest new];
        card.Password=pwd;
        card.UserName=account;
        card.MemberId=@"";
        card.LoginUserId=@"";
        [Account CardNoQuery:card success:^(id data) {
      //NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
                NSArray *cardNoList=data[@"cardNoList"];
            if(cardNoList.count==1){
                
                [MemberCardNO setObject:data[@"cardNoList"][0][@"cardNo"] forKey:@"cardNO"];
                NSaccount=[NSUserDefaults standardUserDefaults];
                NSpassword=[NSUserDefaults standardUserDefaults];
                [NSaccount setObject:account forKey:@"account"];
                [NSpassword setObject:pwd forKey:@"password"];

                __block LoginViewController *blockSelf = self;
                    __block Login * blockaView= _aView;
                    AccountVerifyRequest * Verify=[[AccountVerifyRequest alloc]init];
                    Verify.Password=pwd;
                   Verify.RegistrationID=_registrationID;
                    Verify.UserName=account;
                    Verify.MemberId=@"";
                    Verify.LoginUserId=@"";
                    Verify.MemberCardNo=[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"];
                    [Account AccountVerify:Verify success:^(id data) {
//                        NSLog(@"****%@",data);
                        if ([data[@"status"] isEqualToString:@"T"]) {
                             [SVProgressHUD dismiss];
                            userMessage=[NSUserDefaults standardUserDefaults];
                            [userMessage setObject:data[@"userInf"] forKey:@"userInf"];
                            [self CLloata];

                        }
                        //快捷生成model
                        //[ZYZModelTool modelToolWithDictionary:data[@"userInf"][@"empList"][0] modelName:@"EmployeeModel.h"];
                    } failure:^(NSError *error) {
                        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"登录失败，请检查您的网络设置"] duration:1.0];
                    }];
                }else{
                    [SVProgressHUD dismiss];
                    _tableView.frame=CGRectMake(20, deviceScreenHeight/2-90, deviceScreenWidth-40, 180);
                     effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
                     dataarry=data[@"cardNoList"];
                    _accont=account;
                    _password=pwd;
                    NSaccount=[NSUserDefaults standardUserDefaults];
                    NSpassword=[NSUserDefaults standardUserDefaults];

                    [NSaccount setObject:account forKey:@"account"];
                    [NSpassword setObject:pwd forKey:@"password"];

                    [_tableView reloadData];
                }
            }else{
                [_aView changebackgraoud];
                [SVProgressHUD dismiss];
            }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"获取差旅卡号失败，请检查您的网络"] duration:1.0];

        }];
        }else{
            _accont=account;
            _password=pwd;
            [SVProgressHUD dismiss];

            [self logoinloatdata];
        }
      };
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(40, deviceScreenHeight, deviceScreenWidth-80, 180) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView];

}
-(void)logoinloatdata{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    __block LoginViewController *blockSelf = self;
    AccountVerifyRequest * Verify=[[AccountVerifyRequest alloc]init];
    Verify.Password=_password;
    Verify.UserName=_accont;
    Verify.MemberId=@"";
    Verify.LoginUserId=@"";
    Verify.RegistrationID=_registrationID;
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"]);
    Verify.MemberCardNo=[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"];
    [Account AccountVerify:Verify success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"****%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            userMessage=[NSUserDefaults standardUserDefaults];
            [userMessage setObject:data[@"userInf"] forKey:@"userInf"];
            [self CLloata];
        }else{
            [_aView changebackgraoud];
            [SVProgressHUD dismiss];
        }
//  [ZYZModelTool modelToolWithDictionary:data[@"userInf"][@"empList"][0] modelName:@"EmployeeModel.h"];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}

#pragma mark -差旅标准是否开启
-(void)CLloata{
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        FYw= [NSUserDefaults standardUserDefaults];
        YwApproveSetQueryRequest * ywa = [YwApproveSetQueryRequest new];
        ywa.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        ywa.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        ywa.Count=10;
        ywa.Start=0;
        ywa.para=@"1010";
        [Basic YwApproveSetQueryRequest:ywa success:^(id data) {
            if([data[@"status"] isEqualToString:@"T"]){
                //NSLog(@"%@",data);
                NSMutableArray * arr = [NSMutableArray arrayWithArray:data[@"data"]];
                
                if (arr.count==0) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"FYw"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:data[@"data"][0][@"paraValue1"] forKey:@"FYw"];
                }
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
  
        }];
        
//        TYw= [NSUserDefaults standardUserDefaults];
        YwApproveSetQueryRequest * ywa2 = [YwApproveSetQueryRequest new];
        ywa2.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        ywa2.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        ywa2.Count=10;
        ywa2.Start=0;
        ywa2.para=@"1071";
        [Basic YwApproveSetQueryRequest:ywa2 success:^(id data) {
            if([data[@"status"] isEqualToString:@"T"]){
               NSLog(@"%@",data);
                NSMutableArray * arr = [NSMutableArray arrayWithArray:data[@"data"]];
               
                if (arr.count==0) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"TYw"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:data[@"data"][0][@"paraValue1"] forKey:@"TYw"];
                }

            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    
        }];

//        HYw= [NSUserDefaults standardUserDefaults];
        YwApproveSetQueryRequest * ywa3 = [YwApproveSetQueryRequest new];
        ywa3.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        ywa3.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        ywa3.Count=10;
        ywa3.Start=0;
        ywa3.para=@"1069";
        [Basic YwApproveSetQueryRequest:ywa3 success:^(id data) {
            if([data[@"status"] isEqualToString:@"T"]){
               NSLog(@"%@",data);
                NSMutableArray * arr = [NSMutableArray arrayWithArray:data[@"data"]];
                if (arr.count==0) {
                    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"HYw"];
                }else{
                    [[NSUserDefaults standardUserDefaults] setObject:data[@"data"][0][@"paraValue1"] forKey:@"HYw"];
                }
                 [SVProgressHUD dismiss];
//                NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]);
                [self rootVC];
            }
        } failure:^(NSError *error) {
  [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
        // 处理耗时操作在此次添加
//        //通知主线程刷新
//        dispatch_async(dispatch_get_main_queue(), ^{          
//       });
//    });
//    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"] count]==0) {
//    }
    
    }
#pragma mark -登录成功更换根视图
-(void)rootVC{
     [SVProgressHUD dismiss];
    UIApplication *app =[UIApplication sharedApplication];
    AppDelegate * app2 = (AppDelegate*)app.delegate;
    [app2 tabebar];
}
#pragma mark -企业注册
-(void)onClick:(UIButton*)send{
  ZCViewController * vv = [ZCViewController new];
    vv.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    vv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//    vv.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self.navigationController pushViewController:vv animated:YES];
    //    [self presentViewController:vv animated:YES completion:nil];
}
#pragma mark - 忘记密码
-(void)onClick1:(UIButton*)send{
    [_aView changebackgraoud1];
    _aView.coverView.hidden=YES;
    ForgetpasswordViewController * vv = [ForgetpasswordViewController new];
     vv.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    //vv.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //vv.modalTransitionStyle = UIModalTransitionStylePartialCurl;
//    [self presentViewController:vv animated:YES completion:nil];
    [self.navigationController pushViewController:vv animated:YES];

}
#pragma mark -tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataarry.count;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth-40, 60)];
    view.backgroundColor=[UIColor colorWithRed:43/255.0 green:178/255.0 blue:233/255.0 alpha:1];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, deviceScreenWidth-80, 40)];
    label.text=@"请选择差旅卡号";
    label.textColor=[UIColor whiteColor];
    label.textAlignment=NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth=YES;
    label.font=[UIFont systemFontOfSize:15];
    [view addSubview:label];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
-(CardNocell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
CardNocell* cell  =[tableView dequeueReusableCellWithIdentifier:@"celled"];
    if(!cell){
    cell = [[CardNocell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"celled"];
    }
    cell.backgroundColor=[UIColor whiteColor];
    cell.strlabel.text=[NSString stringWithFormat:@"%@(%@)",dataarry[indexPath.row][@"memberName"],dataarry[indexPath.row][@"cardNo"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    _tableView.frame=CGRectMake(20, deviceScreenHeight, deviceScreenWidth-40, 180);
    effectView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    [MemberCardNO setObject:dataarry[indexPath.row][@"cardNo"] forKey:@"cardNO"];
    [self logoinloatdata];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
