//
//  StatusMessageVC.m
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "StatusMessageVC.h"
#import "AttentionFlightDid.h"

#import "statusMessageCell.h"
#import "AttentionModel.h"

@interface StatusMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _TableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _dataArray1;

}
@end
@implementation StatusMessageVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor=[UIColor whiteColor] ;
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"航班详情";
    label.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"left"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    
    UIButton * refreshbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-40, 25, 20, 20)];
    [refreshbut setBackgroundImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    [refreshbut addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:refreshbut];

    UIButton * cancelbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20,537, 335, 44)]];

    [cancelbut setTitle:@"取消关注" forState:UIControlStateNormal];
    [cancelbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelbut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [cancelbut addTarget:self action:@selector(cancelbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelbut];
    
    [self initview];
    [self creatTable];
//    [self loaddata];
}
-(void)initview{
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _dataArray=[NSMutableArray new];
    if (_num==3) {
        [_dataArray addObject:_attmodel];
    }else{
        AttentionModel * model = [AttentionModel mj_objectWithKeyValues:_dict];
        [_dataArray addObject:model];
    }
   
    [_TableView reloadData];
}
-(void)loaddata{
    AttentionModel * model = [AttentionModel new];
    model=_dataArray[0];
    _dataArray1=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;
    AttentionFlightScheduleListQuery * atf = [AttentionFlightScheduleListQuery new];
    atf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    atf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    atf.Count=100;
    atf.Start=0;
    atf.PhoneNumber=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"mobile"];
    [Flight AttentionFlightScheduleListQuery:atf success:^(id data) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            for (NSMutableDictionary * dic in data[@"data"]) {
                
                if([dic[@"flightNo"] isEqualToString:model.flightNo]&&[dic[@"flightDate"] isEqualToString:model.flightDate]&&[dic[@"departCode"] isEqualToString:model.departCode]&&[dic[@"arrCode"] isEqualToString:model.arrCode]){
                    AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
                    [ _dataArray1 addObject:model];

                }
                           }
        }
        _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
        NSLog(@"%@",_dataArray1);
        [_TableView reloadData];
        
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];

    
}
-(void)creatTable{
    _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+30/SCREEN_RATE1, self.view.frame.size.width, (392+20)/SCREEN_RATE1)];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_TableView];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 392/SCREEN_RATE1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    statusMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[statusMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.backgroundColor=[UIColor blackColor];
    [cell setCellWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)back:(UIButton*)send{
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)cancelbut:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    CancelFlightSchedule * can = [CancelFlightSchedule new];
    can.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    can.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    AttentionModel * model = [AttentionModel new];
    model=_dataArray[0];
    can.FlightNo=model.flightNo;
    [Flight CancelFlightScheduleyQuery:can success:^(id data) {
         [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"T"]) {
        [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
          
            [self dismissViewControllerAnimated:NO completion:nil];

        }else{
             [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)refresh:(UIButton*)send{
    [self loaddata];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
