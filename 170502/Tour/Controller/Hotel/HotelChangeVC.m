//
//  HotelChangeVC.m
//  Tour
//
//  Created by Euet on 17/3/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "HotelChangeVC.h"
#import "sxtablecell1.h"

@interface HotelChangeVC ()<UITableViewDelegate,UITableViewDataSource>

{
    UITableView * _tableView;
    NSMutableArray * dataArray;
    NSMutableArray * AdmindataArray;
    NSMutableArray * BusinessdataArray;
    
    NSMutableArray * AirportandStopdataArray;
    NSMutableArray * dataArray1;
    NSMutableArray * AirportdataArray;
    NSMutableArray * StopdataArray;



}

@end

@implementation HotelChangeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 100 , 30)];
    label.text=@"商业区选择";
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
    [self leftview];
    [self loadData:@"0"];
    [self loadData:@"1"];
    [self loadData1:@"机场"];
    [self loadData1:@"车站"];
    [self creatTable];
}

-(void)loadData1:(NSString*)string{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    if ([string isEqualToString:@"机场"]) {
        AirportdataArray = [NSMutableArray new];
    }else{
        StopdataArray = [NSMutableArray new];
    }
    
    PointQueryRequest * pqr = [PointQueryRequest new];
    pqr.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    pqr.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    pqr.Value=string;
    pqr.CityId=_cityId;
    [Basic PointQueryRequest:pqr success:^(id data) {
        NSLog(@"%@",data);
        
        if ([data[@"status"] isEqualToString:@"T"]) {
//        poiList
         if ([string isEqualToString:@"机场"]) {
             AirportdataArray = [NSMutableArray arrayWithArray:data[@"poiList"]];
         }else{
             StopdataArray = [NSMutableArray arrayWithArray:data[@"poiList"]];
         }
            AirportandStopdataArray =[NSMutableArray arrayWithArray:AirportdataArray];
            for (NSDictionary * dic in StopdataArray) {
                [AirportandStopdataArray addObject:dic];
            }
            NSMutableArray * arr = [NSMutableArray new];
            for (NSDictionary * dict in AirportandStopdataArray) {
                NSMutableDictionary * dit = [NSMutableDictionary dictionaryWithDictionary:dict];
                [dit setValue:@"0" forKey:@"num"];
                [arr addObject:dit];
            }
            AirportandStopdataArray = [NSMutableArray arrayWithArray:arr];
            NSLog(@"%@",AirportandStopdataArray);
     }
    } failure:^(NSError *error) {
    }];
}
-(void)loadData:(NSString*)string{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    if ([string isEqualToString:@"0"]) {
        BusinessdataArray = [NSMutableArray new];
    }else{
        AdmindataArray = [NSMutableArray new];
    }
    DistrictQueryRequest * dqr = [DistrictQueryRequest new];
    dqr.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    dqr.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    dqr.NeedType=string;
    dqr.CityId=_cityId;
    [Basic  DistrictQueryRequest:dqr success:^(id data) {
         [SVProgressHUD dismiss];
        if ([data[@"status"] isEqualToString:@"T"]) {
            NSLog(@"%@",data);
            if ([string isEqualToString:@"0"]) {
                BusinessdataArray = [NSMutableArray arrayWithArray:data[@"businessList"]];

//                NSMutableDictionary * dic = [NSMutableDictionary new];
//                [dic setValue:@"全部" forKey:@"name"];
//                [dic setValue:@"" forKey:@"id"];
//                [dic setValue:@"0" forKey:@"type"];
//                [BusinessdataArray addObject:dic];
                
                NSMutableArray * arr = [NSMutableArray new];
                for (NSDictionary * dict in BusinessdataArray) {
                    NSMutableDictionary * dit = [NSMutableDictionary dictionaryWithDictionary:dict];
                    [dit setValue:@"0" forKey:@"num"];
                    [arr addObject:dit];
                }
                BusinessdataArray = [NSMutableArray arrayWithArray:arr];
            }else{
                AdmindataArray = [NSMutableArray arrayWithArray:data[@"districtList"]];
//                NSMutableDictionary * dic = [NSMutableDictionary new];
//                [dic setValue:@"全部" forKey:@"name"];
//                [dic setValue:@"" forKey:@"id"];
//                [dic setValue:@"1" forKey:@"type"];
//                [AdmindataArray addObject:dic];
                NSMutableArray * arr = [NSMutableArray new];
                for (NSDictionary * dict in AdmindataArray) {
                    NSMutableDictionary * dit = [NSMutableDictionary dictionaryWithDictionary:dict];
                    [dit setValue:@"0" forKey:@"num"];
                    [arr addObject:dit];
                }
                AdmindataArray = [NSMutableArray arrayWithArray:arr];
            }
            dataArray =[NSMutableArray arrayWithArray:AdmindataArray];
            [_tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)leftview{
    UIView * leftview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE1, 120, deviceScreenHeight*SCREEN_RATE1)]];
    leftview.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:leftview];
   
    UIButton * but  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 120, 56)]];
    but.tag=9000;
    [but setTitle:@"行政区" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.titleLabel.textAlignment=NSTextAlignmentCenter;
    [but addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    but.backgroundColor=[UIColor whiteColor];
    [leftview addSubview:but];

    UIView * viewline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 57, 120, 1)]];
    viewline.backgroundColor=[UIColor blackColor];
//viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [leftview addSubview:viewline];
    
    UIButton * but1  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 58, 120, 56)]];
    but1.tag=9001;
    [but1 setTitle:@"商圈" forState:UIControlStateNormal];
    [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but1.titleLabel.textAlignment=NSTextAlignmentCenter;
    [but1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [leftview addSubview:but1];
    
    UIView * viewline1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 113, 120, 1)]];
    viewline1.backgroundColor=[UIColor blackColor];
//    viewline1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [leftview addSubview:viewline1];
    
    UIButton * but3  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 114, 120, 56)]];
    but3.tag=9002;
    [but3 setTitle:@"机场车站" forState:UIControlStateNormal];
    [but3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but3.titleLabel.textAlignment=NSTextAlignmentCenter;
    [but3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [leftview addSubview:but3];
    
    UIView * viewline2 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 171, 120, 1)]];
    viewline1.backgroundColor=[UIColor blackColor];
    //    viewline1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [leftview addSubview:viewline2];
}

#pragma mark -tableview相关代理方法
-(void)creatTable{
    _tableView =[[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 64*SCREEN_RATE1, 255, (deviceScreenHeight-64)*SCREEN_RATE1)] style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 56/SCREEN_RATE1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    sxtablecell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    // cell的复用
    if (!cell) {
        cell = [[sxtablecell1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    if ([[dataArray[1] allKeys] containsObject:@"poiName"]) {
        cell.strlabel.text=dataArray[indexPath.row][@"poiName"];
    }else{
        cell.strlabel.text=dataArray[indexPath.row][@"name"];
    }
    if([dataArray[indexPath.row][@"num"] isEqualToString:@"1"]){
        cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    }else{
        cell.strlabel.textColor=[UIColor blackColor];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([dataArray[indexPath.row][@"num"] isEqualToString:@"0"]) {
        for (NSMutableDictionary * dict in dataArray) {
            dict[@"num"]=@"0";
        }
        if (_block) {
            _block(dataArray[indexPath.row]);
        }
        dataArray[indexPath.row][@"num"]=@"1";
    }else{
       dataArray[indexPath.row][@"num"]=@"0";
    }
    [self.navigationController popViewControllerAnimated:NO];

    [_tableView reloadData];
}
#pragma mark -leftview按钮相关
-(void)click:(UIButton*)send{
    switch (send.tag) {
        case 9000:{
            send.backgroundColor=[UIColor whiteColor];
            UIButton * one = (UIButton*)[self.view viewWithTag:9001];
            one.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * two = (UIButton*)[self.view viewWithTag:9002];
            two.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            for (NSMutableDictionary * dict in BusinessdataArray) {
                dict[@"num"]=@"0";
            }
            for (NSMutableDictionary * dict in AirportandStopdataArray) {
                dict[@"num"]=@"0";
            }
            dataArray =[NSMutableArray arrayWithArray:AdmindataArray];
            [_tableView reloadData];
            break;
        }
        case 9001:{
            send.backgroundColor=[UIColor whiteColor];
            UIButton * one = (UIButton*)[self.view viewWithTag:9000];
            one.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * two = (UIButton*)[self.view viewWithTag:9002];
            two.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            for (NSMutableDictionary * dict in AdmindataArray) {
                dict[@"num"]=@"0";
            }
            for (NSMutableDictionary * dict in AirportandStopdataArray) {
                dict[@"num"]=@"0";
            }
            dataArray =[NSMutableArray arrayWithArray:BusinessdataArray];
            [_tableView reloadData];
            break;
        }
        case 9002:{
            send.backgroundColor=[UIColor whiteColor];
            UIButton * one = (UIButton*)[self.view viewWithTag:9000];
            one.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * two = (UIButton*)[self.view viewWithTag:9001];
            two.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            for (NSMutableDictionary * dict in AdmindataArray) {
                dict[@"num"]=@"0";
            }
            for (NSMutableDictionary * dict in BusinessdataArray) {
                dict[@"num"]=@"0";
            }
            dataArray =[NSMutableArray arrayWithArray:AirportandStopdataArray];
            [_tableView reloadData];
            break;
        }
        default:
            break;
    }
}
#pragma mark -返回相关
-(void)back:(UIButton*)but{
//[self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cellBalock:(cellBalock)block{
    _block=block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
