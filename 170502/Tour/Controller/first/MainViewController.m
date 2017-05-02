//
//  MainViewController.m
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "MainViewController.h"
#import "InterfaseTableCell.h"
#import "DetailsController.h"
#import "LoginViewController.h"
#import "CYmenlistVC.h"
#import "systemVC.h"
#import "ForgetpasswordViewController.h"
#import "Usereturnpass.h"
#import "DloadingViewController.h"


#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    //头部视图
    UIView * headView;
}
@property (nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation MainViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadate];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    //Do any additional setup after loading the view.
    //    [self loadate];
    [self initWith];//初始化tableView
    [self initData];//初始化头部视图
}
-(void)loadate{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    AccountVerifyRequest * Verify=[[AccountVerifyRequest alloc]init];
    Verify.Password=[[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
    Verify.UserName=[[NSUserDefaults standardUserDefaults] objectForKey:@"account"];
    Verify.MemberId=@"";
    Verify.LoginUserId=@"";
    Verify.MemberCardNo=[[NSUserDefaults standardUserDefaults]objectForKey:@"cardNO"];
    [Account AccountVerify:Verify success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"****%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            [[NSUserDefaults standardUserDefaults] setObject:data[@"userInf"] forKey:@"userInf"];
            [_tableView reloadData];
        }else{
  //[UIAlertView showAlertWithTitle:@"错误提示您的密码已修改，请重新登录！"];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)initWith
{
    self.navigationController.navigationBar.hidden = YES;
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"<"style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backItem;
    
    _dataArray = [NSMutableArray array];
    _dataArray =  [NSMutableArray arrayWithObjects:@"常用旅客",@"常用联系人",@"系统设置",@"修改密码",@"联系客服",@"客户端下载",@"退出登录",nil];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, SCREEN_W, SCREEN_H-20 ) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    //_tableView.bounces=NO;
    [self.view addSubview:_tableView];
    
}
-(void)initData
{
    }
#pragma mark TableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return   150/SCREEN_RATE1;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSMutableDictionary * d  =[NSMutableDictionary new];
    d=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"];
    NSLog(@"%@",d);
    //头部视图
    headView = [UIView new];
    headView.frame = CGRectMake(0, 0, SCREEN_W, 150/SCREEN_RATE1);
    headView.backgroundColor = [UIColor colorWithRed:7/255.0 green:71/255.0 blue:136/255.0 alpha:1];
    //    [self.view addSubview:headView];
    //_tableView.tableHeaderView = headView;
    UILabel * Namelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 50, 90, 40)]];
    //NSString * NameString = //用户名字
    Namelabel.text = d[@"userName"];
    Namelabel.textColor = [UIColor whiteColor];
    Namelabel.font = [UIFont systemFontOfSize:25];
    [headView addSubview:Namelabel];
    
    UILabel * DepartmentLabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(110, 55, 90, 40)]];
    //    NSString * DepartmentString = //部门职责
    DepartmentLabel.text = d[@"company"][@"shortName"];
    DepartmentLabel.textColor = [UIColor whiteColor];
    [headView addSubview:DepartmentLabel];
    
    NSMutableArray * tableDataArray = [NSMutableArray arrayWithObjects:@"登陆账号：",@"",@"", nil];

    NSString*str= d[@"empList"][0][@"empNo"];
    NSString*str1=@"";
    NSString*str2=@"";
    NSMutableArray * DataArray = [NSMutableArray arrayWithObjects:str,str1,str2, nil];//获取数据赋值即可
    for (int i=0; i<3; i++) {
        UILabel * label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 50+(30*i+10), 90, 100)]];
        label.text = tableDataArray[i];
        label.adjustsFontSizeToFitWidth=YES;
        label.textColor = [UIColor whiteColor];
        [headView addSubview:label];
        
        UILabel * Datalabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(100, 50+(30*i+10), 150, 100)]];
        Datalabel.text = DataArray[i];
        Datalabel.font=[UIFont systemFontOfSize:14];
        Datalabel.adjustsFontSizeToFitWidth=YES;
        Datalabel.textColor = [UIColor whiteColor];
        [headView addSubview:Datalabel];
    }
    
    
    
    UIButton * button = [UIButton new];
    button.frame = [framsizeclass newSuitFrame:CGRectMake(244, 66, 80, 80)];
//    [button setTitle:@">"forState:UIControlStateNormal];
//    button.titleLabel.textAlignment=NSTextAlignmentCenter;
    
    
    UIImageView * image =[UIImageView new];
    image.frame = [framsizeclass newSuitFrame:CGRectMake(67, 33, 13, 13)];
    image.image=[UIImage imageNamed:@"chevron1"];
    [button addSubview:image];
    [headView addSubview:button];
    
    
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchDown];//点击事件跳转
    return headView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"Cell";
    InterfaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[InterfaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    //去除点击效果
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    cell.label.text = _dataArray[indexPath.row];
    NSMutableArray * imageNameArr = [NSMutableArray arrayWithObjects:@"frequent_passenger@2x",@"frequent_contact",@"asetting",@"change_password",@"contact_us",@"dang",@"sign_out",nil];//倒入图片名字即可
    for (int i=0; i<imageNameArr.count; i++) {
        cell.logoimage.image= [UIImage imageNamed:imageNameArr[indexPath.row]];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"row：%ld",(long)indexPath.row);
    if(indexPath.row==6){
        [AlertViewManager alertWithTitle:@"温馨提示"
                                 message:@"你是否确定退出登录？"textFieldNumber:0 actionNumber:2
                            actionTitles:@[@"取消",@"确定"]
                        textFieldHandler:nil
                           actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                     if (index==1) {
                                         LoginViewController * lvc = [LoginViewController new];
                                         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInf"];
                                         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
                                         [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"account"];
                                         [[NSUserDefaults standardUserDefaults] synchronize];
                                         [self.navigationController pushViewController:lvc animated:NO];
                                     }
                                 }];
    }else if (indexPath.row==5){
        DloadingViewController * dloading = [DloadingViewController new];
        [self presentViewController:dloading animated:NO completion:nil];
    }else if (indexPath.row==4){
        [AlertViewManager alertWithTitle:@"温馨提示" message:@"欢迎您的致电,客服电话:4008566966" textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
            if (index==1) {
                UIWebView*callWebview =[[UIWebView alloc] init];
                NSURL *telURL =[NSURL URLWithString:@"tel:4008566966"];// 貌似tel:// 或者 tel: 都行
                [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
                //记得添加到view上
                [self.view addSubview:callWebview];
            }
        }];
        
    }else if (indexPath.row==3){
        Usereturnpass * rvc = [Usereturnpass new];
//        ForgetpasswordViewController * rvc = [ForgetpasswordViewController new];
       rvc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController  pushViewController:rvc animated:YES];
        [self.navigationController pushViewController:rvc animated:NO];

//        [self presentViewController:rvc animated:NO completion:nil];
    }else if (indexPath.row==2){
        systemVC * rvc = [ systemVC new];
        [self presentViewController:rvc animated:NO completion:nil];
        
    }else if (indexPath.row==1){
         contactVC* convc = [contactVC new];
         convc.metype=@"hid";
         [self presentViewController:convc animated:NO completion:nil];
    }else{
       CYmenlistVC* cmvc = [CYmenlistVC new];
        [self presentViewController:cmvc animated:NO completion:nil];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 67;
}
-(void)buttonClick
{
    DetailsController *DetailsVc = [[DetailsController alloc]init];
//    // 添加导航栏
//    UINavigationController *uNC = [[UINavigationController alloc]initWithRootViewController:DetailsVc];
    DetailsVc.hidesBottomBarWhenPushed = YES;
    DetailsVc.navigationController.navigationBar.hidden=YES;
    [self.navigationController  pushViewController:DetailsVc animated:YES];
    //  [self presentViewController:DetailsVc animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

