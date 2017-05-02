//
//  StatusListVC.m
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "StatusListVC.h"
#import "LGLCalenderViewController.h"
#import "statusCell.h"
#import "sxtablecell.h"

@interface StatusListVC ()<UITableViewDelegate,UITableViewDataSource,statusCellDelegate>
{
    
    UITableView * _TableView;
    NSMutableArray * _dataArray;
    NSMutableArray * _dataArray1;
    NSMutableArray * _dataArray2;

    
    UIView * dataview;

    NSString * _outstr;
    NSString * _backstr;
    NSString * _datestr;

    /*前 日期选择*/
    UIButton * butleft;
    NSMutableArray *flightarr;

    NSString *dateString;
    UILabel * toulabel;

    
    //筛选视图
    UIView * SXview;
    //蒙版视图
    UIView * _SXconnetview;

    UITableView * _tableView3;
    NSMutableArray * _sxdata;
    
    NSMutableArray * stasusArr;
    NSMutableArray * conpanyArr;
    NSMutableArray * playtimeArr;
}
@end

@implementation StatusListVC
-(void)viewWillAppear:(BOOL)animated{
 [super viewWillAppear:animated];
    [self loadata];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self creatTable];
//    [self loadata];
}
-(void)loadata{
    _dataArray=[NSMutableArray new];
    _dataArray1=[NSMutableArray new];
    _dataArray2=[NSMutableArray new];
   
//    for (NSMutableDictionary * dic in _Alldata[@"data"]) {
//        [ _dataArray1 addObject:dic];
//        AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
//        [ _dataArray addObject:model];
//}
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
            
            for (NSMutableDictionary * dic1 in data[@"data"]) {
                AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic1];
                [ _dataArray2 addObject:model];
            }
            
            for (NSMutableDictionary * dic in _Alldata[@"data"]) {
                NSMutableDictionary * dict1 = [NSMutableDictionary dictionaryWithDictionary:dic];
                [dict1 setObject:@"0" forKey:@"num"];
                [ _dataArray1 addObject:dict1];
                AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dict1];
                [ _dataArray addObject:model];
            }
            [_TableView reloadData];

        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
    
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    
}
-(void)initview{
    NSString*filePath=[[NSBundle mainBundle] pathForResource:@"flight"ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData * data =[content dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    flightarr = [NSMutableArray array];
    for (NSMutableDictionary * dic in json) {
        FlightModel * model = [FlightModel mj_objectWithKeyValues:dic];
        [flightarr addObject:model];
    }
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor=[UIColor whiteColor] ;
    [self.view addSubview:view];
    toulabel= [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    toulabel.adjustsFontSizeToFitWidth=YES;
//    NSString * strout =@"";
//    NSString * strback =@"";
//   
//    for (FlightModel * model  in flightarr) {
//        if([_startcity isEqualToString:model.CityName]){
//            strout=model.AirportCode;
//        }
//        if([_stopcity isEqualToString:model.CityName]){
//            strback=model.AirportCode;
//        }
//    }
    toulabel.text=[NSString stringWithFormat:@"%@-%@",_startcity,_stopcity];
    toulabel.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view addSubview:toulabel];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"left"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    UIButton * sxbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-64, 10, 44,44)];
    [sxbut setTitle:@"筛选" forState:UIControlStateNormal];
    [sxbut setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1] forState:UIControlStateNormal];
    sxbut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [sxbut addTarget:self action:@selector(sxclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sxbut];
    dataview= [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, 46)];
    dataview.backgroundColor= [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:dataview];
    /*前后日期选择*/
    butleft = [UIButton new];
    butleft.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    butleft.tag=555;
    [butleft setTitle:@"前一天" forState: UIControlStateNormal];
    [butleft addTarget:self action:@selector(qhonclick:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *iv =[[UIImageView alloc]initWithFrame:CGRectMake(0, 7,8, 16)];
    //获取当前时间并转换为字符串
    NSDate * date1 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatter stringFromDate:date1];
    // NSLog(@"%@***%@",_datestr,dateString);
    if([_datestr isEqualToString:dateString]){
        butleft.userInteractionEnabled=NO;
    }else{
        butleft.userInteractionEnabled=YES;
    }
    [butleft setTitleColor:[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1] forState:UIControlStateNormal];
    iv.image=[UIImage imageNamed:@"left"];
    [butleft addSubview:iv];
    [dataview addSubview:butleft];
    [butleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataview).offset(20);
        make.top.equalTo(dataview).offset(8);
        make.height.offset(30);
        make.width.offset((self.view.frame.size.width-44)/4+12);
    }];
    UIView* viewlin =[UIView new];
    viewlin.backgroundColor=[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1];
    [dataview addSubview:viewlin ];
    [viewlin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataview).offset(self.view.frame.size.width/2-((self.view.frame.size.width-44)/3)/2-17);
        make.top.equalTo(dataview).offset(10);
        make.height.offset(20);
        make.width.offset(1);
    }];
    _databut = [UIButton new];
    _databut.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _databut.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    _datestr=_startFlyDate;
    
    if([_datestr isEqualToString:dateString]){
        butleft.userInteractionEnabled=NO;
    }else{
        butleft.userInteractionEnabled=YES;
    }
    [_databut setTitle:_startFlyDate forState: UIControlStateNormal];
    
    [_databut setTitleColor:[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1] forState:UIControlStateNormal];
    [_databut addTarget:self action:@selector(datechange:) forControlEvents:UIControlEventTouchUpInside];
    [dataview addSubview:_databut];
    [_databut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataview).offset(self.view.frame.size.width/2-((self.view.frame.size.width-44)/3)/2);
        make.top.equalTo(dataview).offset(8);
        make.height.offset(30);
        make.width.offset((self.view.frame.size.width-44)/3);
    }];
    
    UIButton * butright = [UIButton new];
    butright.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIImageView *iv1 =[[UIImageView alloc]initWithFrame:CGRectMake((self.view.frame.size.width-44)/4+12-11, 7,8, 16)];
    iv1.image=[UIImage imageNamed:@"right"];
    [butright addSubview:iv1];
    butright.tag=557;
    [butright addTarget:self action:@selector(qhonclick:) forControlEvents:UIControlEventTouchUpInside];
    [butright setTitle:@"后一天" forState: UIControlStateNormal];
    [butright setTitleColor:[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1] forState:UIControlStateNormal];
    [dataview addSubview:butright];
    [butright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(dataview).offset(-20);
        make.top.equalTo(dataview).offset(8);
        make.height.offset(30);
        make.width.offset((self.view.frame.size.width-44)/4+12);
    }];
    UIView* viewlin1 =[UIView new];
    viewlin1.backgroundColor=[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1];
    [dataview addSubview:viewlin1 ];
    [viewlin1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataview).offset(self.view.frame.size.width/2+((self.view.frame.size.width-44)/3)/2+17);
        make.top.equalTo(dataview).offset(10);
        make.height.offset(20);
        make.width.offset(1);
    }];
}
-(void)creatTable{
    _TableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100)];
    _TableView.delegate = self;
    _TableView.dataSource = self;
    _TableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_TableView];
#pragma mark -更多筛选视图
    _SXconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _SXconnetview.backgroundColor=[UIColor blackColor];
    _SXconnetview.alpha=0.7;
    [self.view  addSubview:_SXconnetview];
    
    SXview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )]];
    [self.view addSubview:SXview];
    UIView * sxtitleView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 50)]];
    sxtitleView.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [SXview addSubview:sxtitleView];
    UIButton * cancelbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(19, 14, 52, 18)]];
    [cancelbut setTitle:@"取消" forState:UIControlStateNormal];
    cancelbut.titleLabel.font=[UIFont systemFontOfSize:14];
    
    [cancelbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelbut addTarget:self action:@selector(cancelbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:cancelbut];
    
    UIButton * clearbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(148, 10, 80, 30)]];
    clearbut.titleLabel.font=[UIFont systemFontOfSize:14];
    clearbut.backgroundColor=[UIColor darkGrayColor];
    clearbut.titleLabel.textAlignment=NSTextAlignmentCenter;
    [clearbut setTitle:@"清除筛选" forState:UIControlStateNormal];
    [clearbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [clearbut addTarget:self action:@selector(clearbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:clearbut];
    
    UIButton * okbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(321, 14, 52, 18)]];
    okbut.titleLabel.font=[UIFont systemFontOfSize:14];
    [okbut setTitle:@"确定" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
    [SXview addSubview:okbut];
    UIView * leftView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 50, 120, 292)]];
    leftView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [SXview addSubview:leftView];
    
    UIButton * Lbut1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 120, 60)]];
    Lbut1.tag=1001;
    Lbut1.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut1.backgroundColor=[UIColor whiteColor];
    [Lbut1 setTitle:@"计划时间" forState:UIControlStateNormal];
    [Lbut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut1 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 61, 120, 1)]];
    lineView.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView];
    
    UIButton * Lbut2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 62, 120, 60)]];
    Lbut2.tag=1002;
    Lbut2.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut2 setTitle:@"航空公司" forState:UIControlStateNormal];
    [Lbut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut2 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut2];
    
    UIView * lineView1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 122, 120, 1)]];
    lineView1.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView1];
    UIButton * Lbut3 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 123, 120, 60)]];
    Lbut3.tag=1003;
    Lbut3.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut3 setTitle:@"航班状态" forState:UIControlStateNormal];
    [Lbut3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut3 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut3];
    
    UIView * lineView2 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 184, 120, 1)]];
    lineView2.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView2];
    
    
    _tableView3= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(118, 50, 255, 298)] style:UITableViewStylePlain];
    _tableView3.backgroundColor=[UIColor whiteColor];
    _tableView3.dataSource=self;
    _tableView3.delegate=self;
    [SXview addSubview:_tableView3];
    // _sxdata=[NSMutableArray arrayWithArray:];
    [_tableView3 reloadData];
    
    
    NSArray * arr = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"00:00--06:00",@"num":@"0",@"type":@"1"},@{@"1":@"06:00--12:00",@"num":@"0"},@{@"1":@"12:00--18:00",@"num":@"0"},@{@"1":@"18:00--24:00",@"num":@"0"}];
    playtimeArr=[NSMutableArray arrayWithArray:arr];
    NSMutableArray *  arr2 = [NSMutableArray new];
    for (NSDictionary * dict  in playtimeArr) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr2 addObject:d];
    }
    playtimeArr=[NSMutableArray arrayWithArray:arr2];


    NSArray * arr0 = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"中国国航",@"num":@"0",@"type":@"2"},@{@"1":@"中国联航",@"num":@"0"},@{@"1":@"海南航空",@"num":@"0"},@{@"1":@"东方航空",@"num":@"0"},@{@"1":@"南方航空",@"num":@"0"}];
    
    conpanyArr=[NSMutableArray arrayWithArray:arr0];
    NSMutableArray *  arr20 = [NSMutableArray new];
    for (NSDictionary * dict  in conpanyArr) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr20 addObject:d];
    }
    conpanyArr=[NSMutableArray arrayWithArray:arr20];
    
    
    NSArray * arr1 = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"未起飞",@"num":@"0",@"type":@"3",@"status":@"0"},@{@"1":@"待起飞",@"num":@"0",@"status":@"1"},@{@"1":@"飞行中",@"num":@"0",@"status":@"2"},@{@"1":@"已到达",@"num":@"0",@"status":@"3"},@{@"1":@"已取消",@"num":@"0",@"status":@"4"}];
    stasusArr=[NSMutableArray arrayWithArray:arr1];
    NSMutableArray *  arr21 = [NSMutableArray new];
    for (NSDictionary * dict  in stasusArr) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr21 addObject:d];
    }
    stasusArr=[NSMutableArray arrayWithArray:arr21];
    _sxdata=[NSMutableArray arrayWithArray:playtimeArr];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([tableView isEqual:_TableView]) {
        return 116/SCREEN_RATE1;
    }else{
        return 40/SCREEN_RATE;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:_TableView]) {
        return _dataArray.count;
    }else{
        return _sxdata.count;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
if ([tableView isEqual:_TableView]) {
    statusCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[statusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.delegate=self;
    cell.backgroundColor=[UIColor blackColor];
//    [cell setCellWithModel:_dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AttentionModel * app = [AttentionModel new];
    app=_dataArray[indexPath.row];
    
    cell.fromcityLabel.text=app.departCityName;
   cell.tocityLabel.text=app.arriveCityName;
   cell.fromtimeLabel.text=app.planTimes;
   cell.totimeLabel.text=app.planTimee;
   cell.flightlogoimage.image=[UIImage imageNamed:app.airwayId];
    if ([app.flightStatus isEqualToString:@"0"]) {
        cell.flystatusimage.image=[UIImage imageNamed:@"state_to_take_off"];
    }else if ([app.flightStatus isEqualToString:@"1"]){
       cell.flystatusimage.image=[UIImage imageNamed:@"state_wait_fly"];
    }else if ([app.flightStatus isEqualToString:@"2"]){
       cell.flystatusimage.image=[UIImage imageNamed:@"state_in_flight"];
    }
    else if ([app.flightStatus isEqualToString:@"3"]){
       cell.flystatusimage.image=[UIImage imageNamed:@"state_arrived"];
    }
    else if ([app.flightStatus isEqualToString:@"4"]){
        cell.flystatusimage.image=[UIImage imageNamed:@"state_cancel"];
    }else{
    
    }
    if ([app.flightStatus isEqualToString:@"3"]) {
        cell.Attentionbut.userInteractionEnabled=NO;
        cell.Attentionimage.image=[UIImage imageNamed:@"followed"];
        cell.Attentionlabel.text=@"已到达";
        cell.Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    }else if([app.flightStatus isEqualToString:@"4"]){
        cell.Attentionbut.userInteractionEnabled=NO;
        cell.Attentionimage.image=[UIImage imageNamed:@"followed"];
        cell.Attentionlabel.text=@"已取消";
        cell.Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    }else{
        if ([app.num isEqualToString:@"1"]) {
            cell.Attentionimage.image=[UIImage imageNamed:@"followed"];
            cell.Attentionlabel.text=@"已关注";
            cell.Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        }else{
            if (_dataArray2.count!=0) {
                for (AttentionModel * app1  in _dataArray2) {
                    if ([app.flightNo isEqualToString:app1.flightNo]&&[app.flightDate isEqualToString:app1.flightDate]&&[app.departCode isEqualToString:app1.departCode]&&[app.arrCode isEqualToString:app1.arrCode]) {
                        cell.Attentionimage.image=[UIImage imageNamed:@"followed"];
                        cell.Attentionlabel.text=@"已关注";
                        //            NSLog(@"*********oiodifouofi %ld",indexPath.row);
                        cell.Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                        break;
                    }else{
                        cell.Attentionimage.image=[UIImage imageNamed:@"follow"];
                        cell.Attentionlabel.text=@"关注";
                        cell.Attentionlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
                        cell.Attentionbut.userInteractionEnabled=YES;
                        //                    break;
                    }
                }
            }else{
                cell.Attentionimage.image=[UIImage imageNamed:@"follow"];
                cell.Attentionlabel.text=@"关注";
                cell.Attentionlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
                cell.Attentionbut.userInteractionEnabled=YES;
            }
        }
        
    }
    cell.flightnumLabel.text=[NSString stringWithFormat:@"%@ %@",app.airwayName,app.flightNo];
    cell.fromflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.departName,app.arrt];
    cell.toflycityLabel.text=[NSString stringWithFormat:@"%@ %@",app.arrName,app.arrt];
    return cell;
}else{
    sxtablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    // cell的复用
    if (!cell) {
        cell = [[sxtablecell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.strlabel.text=_sxdata[indexPath.row][@"1"];
    if([_sxdata[indexPath.row][@"num"] isEqualToString:@"1"]){
        cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    }else{
        cell.strlabel.textColor=[UIColor blackColor];
    }
    return cell;
 }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    statusCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if ([tableView isEqual:_TableView]) {
        if ([cell.Attentionlabel.text isEqualToString:@"已关注"]) {
           StatusMessageVC * smvc = [StatusMessageVC new];
            smvc.attmodel=_dataArray[indexPath.row];
            smvc.num=3;
            [self presentViewController:smvc animated:NO completion:nil];
        }
    }else{
        if ([_sxdata[1][@"type"] isEqualToString:@"1"]) {
            if(indexPath.row!=0){
                int count=0;
                if ([playtimeArr[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    playtimeArr[indexPath.row][@"num"]=@"0";
                    
                    for (int i=0;i<playtimeArr.count;i++) {
                        if ([playtimeArr[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<playtimeArr.count;i++) {
                            playtimeArr[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        playtimeArr[0][@"num"]=@"1";
                    }
                }else{
                    playtimeArr[0][@"num"]=@"0";
                    //如果不是 改成1
                    playtimeArr[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<playtimeArr.count;i++) {
                    playtimeArr[i][@"num"]=@"0";
                }
                //如果不是 改成1
                playtimeArr[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:playtimeArr];
            [_tableView3 reloadData];
        }else if ([_sxdata[1][@"type"] isEqualToString:@"2"]){
            int count=0;
            if(indexPath.row!=0){
                if ([conpanyArr[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    conpanyArr[indexPath.row][@"num"]=@"0";
                    for (int i=0;i<conpanyArr.count;i++) {
                        if ([conpanyArr[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<conpanyArr.count;i++) {
                            conpanyArr[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        conpanyArr[0][@"num"]=@"1";
                    }
                }else{
                    conpanyArr[0][@"num"]=@"0";
                    //如果不是 改成1
                    conpanyArr[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<conpanyArr.count;i++) {
                    conpanyArr[i][@"num"]=@"0";
                }
                //如果不是 改成1
                conpanyArr[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:conpanyArr];
            [_tableView3 reloadData];
        }else if ([_sxdata[1][@"type"] isEqualToString:@"3"]){
            int count=0;
            if(indexPath.row!=0){
                if ([stasusArr[indexPath.row][@"num"] isEqualToString:@"1"]) {
                    stasusArr[indexPath.row][@"num"]=@"0";
                    for (int i=0;i<stasusArr.count;i++) {
                        if ([stasusArr[i][@"num"] isEqualToString:@"1"]) {
                            count=count+1;
                        }
                    }
                    if (count==0) {
                        for (int i=0;i<stasusArr.count;i++) {
                            stasusArr[i][@"num"]=@"0";
                        }
                        //如果不是 改成1
                        stasusArr[0][@"num"]=@"1";
                    }
                }else{
                    stasusArr[0][@"num"]=@"0";
                    //如果不是 改成1
                    stasusArr[indexPath.row][@"num"]=@"1";
                }
            }else{
                for (int i=0;i<stasusArr.count;i++) {
                    stasusArr[i][@"num"]=@"0";
                }
                //如果不是 改成1
                stasusArr[indexPath.row][@"num"]=@"1";;
            }
            _sxdata=[NSMutableArray arrayWithArray:stasusArr];
            [_tableView3 reloadData];
        }else{
        }
    }
}
-(void)statusbutClick:(statusCell *)cell{
    
    NSIndexPath * indexPath = [_TableView indexPathForCell:cell];
  
    AttentionModel * model = [AttentionModel new];
    model=_dataArray[indexPath.row];
    _flightnum=model.flightNo;

    if ([cell.Attentionlabel.text isEqualToString:@"关注"]) {
        NSString *title =@"关注航班";
        NSString *message =@"输入手机号接受该航班最新的动态提醒";
        NSString *cancelButtonTitle = @"取消";
        NSString *otherButtonTitle = @"关注";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder=@"请输入手机号";
            textField.secureTextEntry = NO;
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 读取文本框的值显示出来
            UITextField * mess = alertController.textFields.firstObject;
            //      NSLog(@"%@",mess.text);
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            CustomFlightSchedule * cfs = [CustomFlightSchedule new];
            cfs.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            cfs.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            
            cfs.FlightDate=_databut.titleLabel.text;
            NSString * strout =@"";
            NSString * strback =@"";
            
            for (FlightModel * model  in flightarr) {
                if([_startcity isEqualToString:model.CityName]){
                    strout=model.AirportCode;
                }
                if([_stopcity isEqualToString:model.CityName]){
                    strback=model.AirportCode;
                }
            }
            cfs.TravelRange=[NSString stringWithFormat:@"%@%@",strout,strback];
            cfs.LxrTel=mess.text;
            cfs.PassengerTel=@"";
            cfs.FlightNo=_flightnum;
            cfs.Xm=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"userName"];
            [Flight CustomFlightSchedule:cfs success:^(id data) {
                [SVProgressHUD dismiss];
                NSLog(@"%@***%@",data[@"message"],data);
                if ([data[@"status"] isEqualToString:@"T"]) {
                    model.num=@"1";
                    cell.Attentionbut.userInteractionEnabled=NO;
                    cell.Attentionimage.image=[UIImage imageNamed:@"followed"];
                    cell.Attentionlabel.text=@"已关注";
                    cell.Attentionlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                    [UIAlertView showAlertWithTitle:data[@"message"]];
                    
                }else{
                    [UIAlertView showAlertWithTitle:data[@"message"]];
                }
                [_TableView reloadData];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        CancelFlightSchedule * can = [CancelFlightSchedule new];
        can.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        can.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
//        AttentionModel * model = [AttentionModel new];
//        model=_dataArray[0];
        can.FlightNo=_flightnum;
        [Flight CancelFlightScheduleyQuery:can success:^(id data) {
            [SVProgressHUD dismiss];
            if ([data[@"status"] isEqualToString:@"T"]) {
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
                cell.Attentionimage.image=[UIImage imageNamed:@"follow"];
                cell.Attentionlabel.text=@"关注";
                cell.Attentionlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
                cell.Attentionbut.userInteractionEnabled=YES;
            }else{
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
 
    }
    
    
}

-(void)datechange:(UIButton*)send{
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    //ctl.sss=_datestrback;
    //ctl.isa=YES;
    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
        NSString *str1 =paramas[@"month"];
        NSString *str2=paramas[@"day"];
        if([paramas[@"month"] intValue]<10){
            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
        }
        if([paramas[@"day"] intValue]<10){
            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
        }
        [ _databut setTitle:[NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2] forState:UIControlStateNormal];

        if (_numORdate==YES) {
            [self secondreq1:_databut.titleLabel.text];
        }else{
            [self secondreq:_databut.titleLabel.text];
        }
    }];
    //[self.navigationController  pushViewController:ctl animated:YES];
    [self presentViewController:ctl animated:YES completion:nil];
}

#pragma mark -头部视图按钮
-(void)qhonclick:(UIButton* )send{
    NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *dateFormatter1= [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSDate*qDate;
    NSDate * qde;
    NSDate* hDate;
    NSDate * hde;
    NSString *result;
    NSString *result1;
    switch (send.tag) {
        case 555:
            //前一天
            //由 NSString:转换为 NSDate
            qDate = [dateFormatter dateFromString:_databut.titleLabel.text];
            qde=[NSDate dateWithTimeInterval:-24*60*60 sinceDate:qDate];
            NSLog(@"%@",qde);
            //由 NSDate转换为 NSString
            result = [dateFormatter stringFromDate:qde];
            NSLog(@"%@",result);
            _datestr=result;
            if([_datestr isEqualToString:dateString]){
                butleft.userInteractionEnabled=NO;
            }else{
                butleft.userInteractionEnabled=YES;
            }
            if(_numORdate==YES){
                [self secondreq1:result];
            }else{
                [self secondreq:result];
            }
            break;
        case 557:
            //后一天
            //由 NSString转换为 NSDate
            hDate = [dateFormatter1 dateFromString:_databut.titleLabel.text];
            hde=[NSDate dateWithTimeInterval:24*60*60 sinceDate:hDate];
            NSLog(@"%@",hde);
            //由 NSDate转换为 NSString
            result1 = [dateFormatter1 stringFromDate:hde];
            NSLog(@"%@",result1);
            if(_numORdate==YES){
                [self secondreq1:result1];
            }else{
                [self secondreq:result1];
            }
            _datestr=result1;
            if([_datestr isEqualToString:dateString]){
                butleft.userInteractionEnabled=NO;
            }else{
                butleft.userInteractionEnabled=YES;
            }
            break;
        default:
            break;
    }
}
-(void)secondreq:(NSString*)string{
    [_databut setTitle:string forState: UIControlStateNormal];
    _dataArray=[NSMutableArray new];
    _Alldata=[NSMutableDictionary new];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightScheduleListQuery * slq = [FlightScheduleListQuery new];
    slq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    slq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    slq.FlightDate=string;
    slq.FlightValue=_flightnum;
    [Flight FlightScheduleListQuery:slq success:^(id data) {
        [SVProgressHUD dismiss];
        // NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            _Alldata=data;
            for (NSMutableDictionary * dic in _Alldata[@"data"]) {
                AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
                [ _dataArray addObject:model];
            }
            [_TableView reloadData];
        }else{
            [UIAlertView showAlertWithTitle:data[@"message"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)secondreq1:(NSString*)string{
    _dataArray=[NSMutableArray new];
    _Alldata=[NSMutableDictionary new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightScheduleListQuery * slq = [FlightScheduleListQuery new];
    slq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    slq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    slq.FlightDate=string;
    
        NSString * strout =@"";
        NSString * strback =@"";
    
        for (FlightModel * model  in flightarr) {
            if([_startcity isEqualToString:model.CityName]){
                strout=model.AirportCode;
            }
            if([_stopcity isEqualToString:model.CityName]){
                strback=model.AirportCode;
            }
        }
    slq.FlightValue=[NSString stringWithFormat:@"%@%@",strout,strback];
    [Flight FlightScheduleListQuery:slq success:^(id data) {
        [SVProgressHUD dismiss];
         NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            _Alldata=data;
            for (NSMutableDictionary * dic in _Alldata[@"data"]) {
                AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
                [ _dataArray addObject:model];
            }
            [_databut setTitle:string forState: UIControlStateNormal];

            _flightnum=_Alldata[@"data"][0][@"flightNo"];
         
            [_TableView reloadData];
        }else{
            [UIAlertView showAlertWithTitle:data[@"message"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)cancelbut:(UIButton*)send{
    SXview.frame = [framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)okbut:(UIButton*)send{
    
    NSMutableArray *  arr = [NSMutableArray arrayWithArray:_dataArray1];
    
    NSMutableArray *  arr1 = [NSMutableArray new];
    
    for (NSMutableDictionary * dict in playtimeArr) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr1 = [NSMutableArray arrayWithArray:arr];
                break;
            }else{
                for (int i=0; i<arr.count; i++) {
                    if ([[arr[i][@"planTimee"] substringWithRange:NSMakeRange(0,2)] intValue]>=[[dict[@"1"] substringWithRange:NSMakeRange(0,2)] intValue]) {
                        if (([[arr[i][@"planTimee"] substringWithRange:NSMakeRange(0,2)] intValue]<[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])||(([[arr[i][@"planTimee"] substringWithRange:NSMakeRange(0,2)] intValue]==[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])&&([[arr[i][@"planTimee"] substringWithRange:NSMakeRange(3,2)] intValue]<=0))) {
                                [arr1 addObject:arr[i]];
                        }
                    }
                }
            }
        }
    }
    NSMutableArray *  arr2 = [NSMutableArray new];
    for (NSMutableDictionary * dict in conpanyArr) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr2 = [NSMutableArray arrayWithArray:arr1];
                break;
            }else{
                for (int i=0; i<arr1.count; i++) {
                    if ([arr1[i][@"airwayName"] isEqualToString:dict[@"1"]]){
                        [arr2 addObject:arr1[i]];
                    }
                }
            }
        }
    }
    NSMutableArray *  arr3 = [NSMutableArray new];
    for (NSMutableDictionary * dict in stasusArr) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr3 = [NSMutableArray arrayWithArray:arr2];
                break;
            }else{
                for (int i=0; i<arr2.count; i++) {
                    if ([arr2[i][@"flightStatus"] isEqualToString:dict[@"status"]]){
                        [arr3 addObject:arr2[i]];
                    }
                }
            }
        }
    }
//    NSLog(@"%@",arr3);
    if (arr3.count!=0) {
        _dataArray=[NSMutableArray new];
        for (NSMutableDictionary * dic in arr3) {
//            [ _dataArray1 addObject:dic];
            AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
            [_dataArray addObject:model];
        }
        [_TableView reloadData];
    }else{
        [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.8];
        _dataArray=[NSMutableArray new];
        for (NSMutableDictionary * dic in _dataArray1) {
            //            [ _dataArray1 addObject:dic];
            AttentionModel * model = [AttentionModel mj_objectWithKeyValues:dic];
            [ _dataArray addObject:model];
        }
        [_TableView reloadData];
    }
    SXview.frame  =[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375,400 )];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

}
-(void)clearbut:(UIButton*)send{
    
    for (int i=0;i<playtimeArr.count;i++) {
        playtimeArr[i][@"num"]=@"0";
    }
    //如果不是 改成1
    playtimeArr[0][@"num"]=@"1";
    
    for (int i=0;i<conpanyArr.count;i++) {
        conpanyArr[i][@"num"]=@"0";
    }
    //如果不是 改成1
    conpanyArr[0][@"num"]=@"1";
    
    for (int i=0;i<stasusArr.count;i++) {
        stasusArr[i][@"num"]=@"0";
    }
    //如果不是 改成1
    stasusArr[0][@"num"]=@"1";
    
    
    
    _dataArray=[NSMutableArray new];
    for (NSMutableDictionary * dic in _dataArray1) {
        AttentionModel * model =[[AttentionModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [_dataArray addObject:model];
    }
    [_TableView reloadData];
    [_tableView3 reloadData];
}
-(void)sxclick:(UIButton*)send{
  SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1-340, 375, 400)];
    _SXconnetview.frame=CGRectMake(0, 0, 375/SCREEN_RATE, deviceScreenHeight-340/SCREEN_RATE1);

}
-(void)Lbut:(UIButton*)send{
    switch (send.tag) {
        case 1001:{
            _sxdata=[NSMutableArray arrayWithArray:playtimeArr];
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1002];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIButton * but2 = (UIButton*)[self.view viewWithTag:1003];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            send.backgroundColor=[UIColor whiteColor];
            
            break;}
            
        case 1002:{
            _sxdata=[NSMutableArray arrayWithArray:conpanyArr];
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1001];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIButton * but2 = (UIButton*)[self.view viewWithTag:1003];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            break;
        }
        case 1003:{
            UIButton * but1 = (UIButton*)[self.view viewWithTag:1001];
            but1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIButton * but2 = (UIButton*)[self.view viewWithTag:1002];
            but2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            _sxdata=[NSMutableArray arrayWithArray:stasusArr];
            break;
        }
        default:
            break;
    }
    [_tableView3 reloadData];
}


#pragma mark -底部视图按钮
-(void)footclick:(UIButton*)send{

}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
