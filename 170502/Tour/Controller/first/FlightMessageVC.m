//
//  FlightMessageVC.m
//  Created by Euet on 16/12/22.
//  Copyright © 2016年 lhy. All rights reserved.


#import "FlightMessageVC.h"
#import "AirMessageCell.h"
#import "flightJTmodel.h"
#import "JTCell.h"
#import "LGLCalenderViewController.h"
#import "sxtablecell.h"
#import "AlertViewManager.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface FlightMessageVC ()<UITableViewDelegate,UITableViewDataSource,AirMessageCellDelegate >
{
    UIButton * butright;
    UIView * footview;
    BOOL open;
    UIView * view1;
    UIView * view0;
    UIButton * jtmessagebut;
    UIImageView * jtimage;
    UIImageView * jtimagelogo;
    
    NSMutableArray *flightarr;

    NSString * _outstr;
    NSString * _backstr;
    NSString * _datestr;
    /*前 日期选择*/
    UIButton * butleft;
    
    NSString *dateString;
    UILabel * toulabel;
    UITableView * _tableView;
    //组头视图数据源数组
    NSMutableArray * _dataArray;
    //组头视图数据源数组
    NSMutableArray * _dataArray1;
    //组头视图数据源数组
    NSMutableArray * _dataArray2;
    //判断组头视图的展开
    NSMutableArray * _array;
    NSString*px;
    
    UIImageView  * image1;
    UIImageView  * image2;
    UIImageView  * image3;
    UIImageView  * image4;

    
    
     UITableView * _tableView1;
    //蒙版视图
    UIView * _JTconnetview;
    //蒙版视图
    UIView * _connetview;
    UILabel*connetviewlabel;
    UILabel*connetviewlabel1;
    UILabel*connetviewlabel2;
    UILabel*connetviewlabel3;
    //sessionid
    NSString*session;
    //所有cell数据源
    NSMutableArray * _Cabinarray;
    NSMutableArray * _Cabinarray1;
    //经停信息
    NSMutableArray * StopOverarr;
   
    BOOL twoandone;
    /*往返时显示去程视图，作为tableview的投视图*/
    UIView * headview;
    UIImageView * imageview;
    UILabel * datelab;
    UILabel * datetime;
    UILabel * flightno;
    /*  */
    UIView * dataview;
    //底部视图控件
    UIImageView * priceim;
    UILabel * pricelabel;
    UIImageView * timeiamge;
    UILabel * timelabel;
    UIImageView * sxiamge;
    UILabel * sxlabel;
    //排序-升
    NSArray * timearr;
    NSArray * pricearr;
    //排序-降
    NSArray * Jtimearr;
    NSArray * Jpricearr;

    
    NSMutableArray * time1;

    //筛选视图
    UIView * SXview;
    //蒙版视图
    UIView * _SXconnetview;
    UITableView * _tableView2;
    NSMutableArray * _sxdata;
  //  NSMutableArray * sxarr1;
  //  NSMutableArray * sxarr12;
    
    NSArray * arry1;
    NSArray * arry2;

    NSMutableArray * arr3;

    NSArray * arry3;
    NSMutableArray * arr4;
    
    NSArray * arry4;
    BOOL zf;
//    //改签判断
//    BOOL gqYESorNO;

}
@end
@implementation FlightMessageVC
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
   // NSLog(@"%@",_arr);
   // NSLog(@"***$$$%@",_requtstdict);
   // NSLog(@" %@",_to?@"YES":@"NO");
    open=NO;
    if(_arr.count==2){
        _arr=[NSMutableArray new];
    }
    if(_arr.count==0){
       _tableView.frame=CGRectMake(0, 110,deviceScreenWidth , deviceScreenHeight-160);
    }
    if(_arr.count==1){
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    
    if(_gqYESorNO==YES){
      [self loadData1];
    }else{
        if (_Approval==YES){
            [self loadDataApproval];
        }else{
            [self loadData];
        }
    }
    
    [self Tabview];
    [self creattable];
}
#pragma mark -初始化
-(void)initview{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];
    _array = [[NSMutableArray alloc] init];
    _Cabinarray=[NSMutableArray array];
   // NSLog(@"****%@",_arr);
    if(_arr.count==0){
        _arr=[NSMutableArray new];
    }
    if(_arr1.count==1){
        _arr=[NSMutableArray arrayWithArray:_arr1];
    }
    twoandone=NO;
}
#pragma mark -审批时_获取数据
-(void)loadDataApproval{
    NSLog(@"%@",_FdataArray);
    
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightQuery * Query=[FlightQuery new];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    
    Query.ArrivalCity=_FdataArray[0][@"toCityCharacter"];
    Query.DepartCity=_FdataArray[0][@"fromCityCharacter"];
    Query.DepartDate=[_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];

    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
    
    [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray2=data[@"flightDataList"];
            if (_dataArray2.count==0) {
                [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
            }else{
                for (int  i=0;i<_dataArray2.count; i++) {
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                    [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                    [_dataArray addObject:dic];
                    [_dataArray1 addObject:dic];
                }            float pr;
                NSString * zk;
                pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
                if(pr<10){
                    zk=[NSString stringWithFormat:@"%.lf折",pr];
                }else if(pr==10){
                    zk=@"全价";
                }else{
                    zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
                }
                px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
                session=data[@"sessionId"];
                for (NSDictionary *dic in _dataArray) {
                    [_array addObject:@"0"];
                }
                [_tableView reloadData];
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)secondreq2:(NSString*)string{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    [_databut setTitle:string forState: UIControlStateNormal];

    FlightQuery * Query=[FlightQuery new];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.ArrivalCity=_FdataArray[0][@"toCityCharacter"];
    Query.DepartCity=_FdataArray[0][@"fromCityCharacter"];
    Query.DepartDate=string;
    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
    [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            //_dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
            _dataArray2=data[@"flightDataList"];
            
            if (_dataArray2.count==0) {
                [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
            }else{
                for (int  i=0;i<_dataArray2.count; i++) {
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                    [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                    [_dataArray addObject:dic];
                    [_dataArray1 addObject:dic];
                }
                float pr;
                NSString * zk;
                pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
                if(pr<10){
                    zk=[NSString stringWithFormat:@"%.lf折",pr];
                }else if(pr==10){
                    zk=@"全价";
                }else{
                    zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
                }
                px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
                session=data[@"sessionId"];
                for (NSDictionary *dic in _dataArray) {
                    [_array addObject:@"0"];
                }
                [_tableView reloadData];
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"standPrice" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
        
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
        
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
#pragma mark -改签时_获取数据
-(void)loadData1{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightQuery * Query=[FlightQuery new];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.ArrivalCity=_tocity;
    Query.DepartCity=_fromcity;
    Query.DepartDate=_fromdate;
//    Query.CabinType= _requtstdict[@"CabinType"];
    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
        [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            //_dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
            _dataArray2=data[@"flightDataList"];
            
            if (_dataArray2.count==0) {
                [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
            }else{
                for (int  i=0;i<_dataArray2.count; i++) {
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                    [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                    [_dataArray addObject:dic];
                    [_dataArray1 addObject:dic];
                }
            float pr;
            NSString * zk;
            pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
            if(pr<10){
                zk=[NSString stringWithFormat:@"%.lf折",pr];
            }else if(pr==10){
                zk=@"全价";
            }else{
                zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
            }
            px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
            session=data[@"sessionId"];
            for (NSDictionary *dic in _dataArray) {
                [_array addObject:@"0"];
            }
            [_tableView reloadData];
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"standPrice" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)secondreq1:(NSString*)string{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightQuery * Query=[FlightQuery new];
    [_databut setTitle:string forState: UIControlStateNormal];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.ArrivalCity=_tocity;
    Query.DepartCity=_fromcity;
    Query.DepartDate=string;
    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
    [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            //_dataArray = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0",@"0",@"0", nil];
            _dataArray2=data[@"flightDataList"];
            
            if (_dataArray2.count==0) {
                [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
            }else{
                for (int  i=0;i<_dataArray2.count; i++) {
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                    [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                    [_dataArray addObject:dic];
                    [_dataArray1 addObject:dic];
                }
            float pr;
            NSString * zk;
            pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
            if(pr<10){
                zk=[NSString stringWithFormat:@"%.lf折",pr];
            }else if(pr==10){
                zk=@"全价";
            }else{
                zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
            }
            px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
            session=data[@"sessionId"];
            for (NSDictionary *dic in _dataArray) {
                [_array addObject:@"0"];
            }
                [_tableView reloadData];
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"standPrice" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
        
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
        
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
#pragma mark - 正常单—获取数据
-(void)loadData{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightQuery * Query=[FlightQuery new];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
     Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
   //NSLog(@"%@",_requtstdict);
    if (([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]&&twoandone==YES)||([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]&&_to==YES)) {
        twoandone=NO;
        Query.ArrivalCity=(NSString*)_requtstdict[@"outcity"];
        Query.DepartCity=(NSString*)_requtstdict[@"backcity"];
        Query.DepartDate=_requtstdict[@"dataBack"];
        Query.CabinType= _requtstdict[@"CabinType"];
    }else{
    Query.ArrivalCity=(NSString*)_requtstdict[@"backcity"];
    Query.DepartCity=(NSString*)_requtstdict[@"outcity"];
    Query.DepartDate=_requtstdict[@"dataOut"];
        Query.CabinType= _requtstdict[@"CabinType"];
    }
    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
   //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"]);
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString: @"1"])
    {
        Query.BusinessType=@"1";
        NSMutableArray * arr1=[NSMutableArray array];
        for (NSMutableDictionary * dic in _menarray) {
            Passageresmodel * passnger = [Passageresmodel new];
            passnger.PsgName=dic[@"empName"];
            passnger.PsgCardId=dic[@"certNo"];
            [arr1 addObject:passnger];
        }
        Query.Passageres =[Passageresmodel mj_keyValuesArrayWithObjectArray:arr1];
    }
    [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
       NSLog(@"%@",data);
    if([data[@"status"] isEqualToString:@"T"]){
//        _dataArray=data[@"flightDataList"];
//        _dataArray1=data[@"flightDataList"];
        _dataArray2=data[@"flightDataList"];
        if (_dataArray2.count==0) {
            [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
        }else{
            for (int  i=0;i<_dataArray2.count; i++) {
                NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                [_dataArray addObject:dic];
                [_dataArray1 addObject:dic];
            }
        float pr;
        NSString * zk;
         pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
        if(pr<10){
            zk=[NSString stringWithFormat:@"%.lf折",pr];
        }else if(pr==10){
            zk=@"全价";
        }else{
            zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
        }
        px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
        session=data[@"sessionId"];
        for (NSDictionary *dic in _dataArray) {
            [_array addObject:@"0"];
        }
            [_tableView reloadData];
        }
    }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
       
        //升序排列
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        //降序排列
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
        
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
        
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
#pragma mark -自定义导航栏
-(void)Tabview{
    NSString*filePath=[[NSBundle mainBundle] pathForResource:@"flight"ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData * data =[content dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    flightarr = [NSMutableArray array];
    for (NSMutableDictionary * dic in json) {
        FlightModel * model = [FlightModel mj_objectWithKeyValues:dic];
        [flightarr addObject:model];
    }

    //_outstr=_requtstdict[@"outcity"];
   // _backstr=_requtstdict[@"backcity"];
    _datestr=_requtstdict[@"dataOut"];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
     toulabel= [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    toulabel.adjustsFontSizeToFitWidth=YES;
   
    if(_gqYESorNO==YES){
        NSString * strout =@"";
        NSString * strback =@"";
        for (FlightModel * model  in flightarr) {
            if([_fromcity isEqualToString:model.AirportCode]){
                strout=model.CityName;
            }
            if([_tocity isEqualToString:model.AirportCode]){
                strback=model.CityName;
            }
        }
        _datestr=_fromdate;
        toulabel.text=[NSString stringWithFormat:@"%@-%@(改签)",strout,strback];
    }else{
        if (_Approval==YES) {
            _datestr= [_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
            
            NSString * strout =@"";
            NSString * strback =@"";
            for (FlightModel * model  in flightarr) {
                if([_FdataArray[0][@"fromCityCharacter"] isEqualToString:model.AirportCode]){
                    strout=model.CityName;
                }
                if([_FdataArray[0][@"toCityCharacter"] isEqualToString:model.AirportCode]){
                    strback=model.CityName;
                }
            }
            toulabel.text=[NSString stringWithFormat:@"%@-%@",strout,strback];
        }else{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]){
                if(_to!=YES){
                    if(_arr.count==1){
                        _outstr=_requtstdict[@"backcity"];
                        _backstr=_requtstdict[@"outcity"];
                        _datestr=_requtstdict[@"dataBack"];
                        //_requtstdict[@"outcity"];
                        //_requtstdict[@"backcity"];
                        toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"backcityname"],_requtstdict[@"outcityname"]];
                    }else{
                        _datestr=_requtstdict[@"dataOut"];
                        
                        _outstr=_requtstdict[@"outcity"];
                        _backstr=_requtstdict[@"backcity"];
                        toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"outcityname"],_requtstdict[@"backcityname"]];
                    }
                }else{
                    _datestr=_requtstdict[@"dataBack"];
                    _outstr=_requtstdict[@"backcity"];
                    _backstr=_requtstdict[@"outcity"];
                    toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"backcityname"],_requtstdict[@"outcityname"]];
                }
            }else{
                _datestr=_requtstdict[@"dataOut"];
                
                _outstr=_requtstdict[@"outcity"];
                _backstr=_requtstdict[@"backcity"];
                
                toulabel.text=[NSString stringWithFormat:@"%@-%@",_requtstdict[@"outcityname"],_requtstdict[@"backcityname"]];
            }
        }
    }
//    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]){
//        if(_to!=YES){
//            if(_arr.count==1){
//                _outstr=_requtstdict[@"backcity"];
//                _backstr=_requtstdict[@"outcity"];
//                _datestr=_requtstdict[@"dataBack"];
//                //_requtstdict[@"outcity"];
//                //_requtstdict[@"backcity"];
//                
//                toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"backcityname"],_requtstdict[@"outcityname"]];
//            }else{
//                _datestr=_requtstdict[@"dataOut"];
//
//                _outstr=_requtstdict[@"outcity"];
//                _backstr=_requtstdict[@"backcity"];
//                toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"outcityname"],_requtstdict[@"backcityname"]];
//            }
//        }else{
//            _datestr=_requtstdict[@"dataBack"];
//            _outstr=_requtstdict[@"backcity"];
//            _backstr=_requtstdict[@"outcity"];
//                toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"backcityname"],_requtstdict[@"outcityname"]];
//            }
//    }else{
//        _datestr=_requtstdict[@"dataOut"];
//
//        _outstr=_requtstdict[@"outcity"];
//        _backstr=_requtstdict[@"backcity"];
//        
//    toulabel.text=[NSString stringWithFormat:@"%@-%@",_requtstdict[@"outcityname"],_requtstdict[@"backcityname"]];
//    }
    toulabel.textColor=[UIColor whiteColor];
    [view addSubview:toulabel];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    backbut.tag=666;
    [view addSubview:backbut];
    dataview= [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, 46)];
    dataview.backgroundColor= [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:dataview];
#pragma mark -往返显示视图
    /* *往返显示视图* */
    headview=[[UIView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth,44)];
        headview.backgroundColor= [UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:headview];
    imageview = [UIImageView new];
    imageview.alpha=0.9;
    [headview addSubview:imageview];
    [imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headview).offset((deviceScreenWidth-240)/5);
        make.top.equalTo(headview).offset(5);
        make.height.offset(30);
        make.width.offset(30);
    }];
     datelab = [UILabel new];
    datelab.textColor=[UIColor whiteColor];
    datelab.adjustsFontSizeToFitWidth=YES;
    [headview addSubview:datelab];
    [datelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headview).offset(30+2*((deviceScreenWidth-240)/5));
        make.top.equalTo(headview).offset(5);
        make.height.offset(30);
        make.width.offset(90);
    }];
    datetime = [UILabel new];
    datetime.textColor=[UIColor whiteColor];
    datetime.adjustsFontSizeToFitWidth=YES;
    [headview addSubview:datetime];
    [datetime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headview).offset(120+3*((deviceScreenWidth-240)/5));
        make.top.equalTo(headview).offset(5);
        make.height.offset(30);
        make.width.offset(70);
    }];
    flightno = [UILabel new];
    flightno.textColor=[UIColor whiteColor];
//    flightno.backgroundColor=[UIColor redColor];
    flightno.adjustsFontSizeToFitWidth=YES;
    [headview addSubview:flightno];
    [flightno mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headview).offset(190+4*((deviceScreenWidth-240)/5));
        make.top.equalTo(headview).offset(5);
        make.height.offset(30);
        make.width.offset(50);
    }];
    /* * * */
    
#pragma mark -前后日期选择
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
   
    if (_gqYESorNO==YES) {
        _datestr=_fromdate;
        if([_datestr isEqualToString:dateString]){
            butleft.userInteractionEnabled=NO;
        }else{
            butleft.userInteractionEnabled=YES;
        }
        [_databut setTitle:_fromdate forState: UIControlStateNormal];
    }else{
        if (_Approval==YES) {
        _datestr=[_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
            if([_datestr isEqualToString:dateString]){
                butleft.userInteractionEnabled=NO;
            }else{
                butleft.userInteractionEnabled=YES;
            }
            [_databut setTitle:[_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)] forState: UIControlStateNormal];
        }else{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]){
                if(_arr.count==1){
                    _datestr=_requtstdict[@"dataBack"];
                    if([_datestr isEqualToString:dateString]){
                        butleft.userInteractionEnabled=NO;
                    }else{
                        butleft.userInteractionEnabled=YES;
                    }
                    [_databut setTitle:_requtstdict[@"dataBack"] forState: UIControlStateNormal];
                }else{
                    _datestr=_requtstdict[@"dataOut"];
                    if([_datestr isEqualToString:dateString]){
                        butleft.userInteractionEnabled=NO;
                    }else{
                        butleft.userInteractionEnabled=YES;
                    }
                    [_databut setTitle:_requtstdict[@"dataOut"] forState: UIControlStateNormal];
                }
            }else{
                _datestr=_requtstdict[@"dataOut"];
                if([_datestr isEqualToString:dateString]){
                    butleft.userInteractionEnabled=NO;
                }else{
                    butleft.userInteractionEnabled=YES;
                }
                [_databut setTitle:_requtstdict[@"dataOut"] forState: UIControlStateNormal];
            }
        }
}
    [_databut setTitleColor:[UIColor colorWithRed:64/255.0 green:112/255.0 blue:159/255.0 alpha:1] forState:UIControlStateNormal];
    [_databut addTarget:self action:@selector(datechange:) forControlEvents:UIControlEventTouchUpInside];
    [dataview addSubview:_databut];
    [_databut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dataview).offset(self.view.frame.size.width/2-((self.view.frame.size.width-44)/3)/2);
        make.top.equalTo(dataview).offset(8);
        make.height.offset(30);
        make.width.offset((self.view.frame.size.width-44)/3);
    }];
    
     butright = [UIButton new];
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
   footview =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-50, deviceScreenWidth, 50)];
    footview.backgroundColor=[UIColor colorWithRed:48/255.0 green:61/255.0 blue:79/255.0 alpha:1];
    [self.view addSubview:footview];
    UIButton * pricebut = [UIButton new];
    pricebut.tag =444;
    [pricebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:pricebut];
    [pricebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset((deviceScreenWidth-144)/4);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(48);
    }];
    priceim = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, 20, 20)];
    priceim.image= [UIImage imageNamed:@"price_on"];
    [pricebut addSubview:priceim];
    pricelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 48, 14)];
    pricelabel.text=@"从低到高";
    pricelabel.textAlignment=NSTextAlignmentCenter;
    pricelabel.font= [UIFont systemFontOfSize:11];
    pricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    [pricebut addSubview:pricelabel];
    UIButton * timebut = [UIButton new];
    timebut.tag =445;
    [timebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:timebut];
    [timebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(2*((deviceScreenWidth-144)/4)+48);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(48);
    }];
    timeiamge = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, 20, 20)];
    timeiamge.image= [UIImage imageNamed:@"time_off"];
    [timebut addSubview:timeiamge];
    timelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 48, 14)];
    timelabel.text=@"时间";
    timelabel.textAlignment=NSTextAlignmentCenter;
    timelabel.font =[UIFont systemFontOfSize:11];
    //timelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [timebut addSubview:timelabel];
    
    UIButton * sxbut = [UIButton new];
    sxbut.tag =446;
     [sxbut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:sxbut];
    [sxbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(3*((deviceScreenWidth-144)/4)+2*48);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(48);
    }];
    sxiamge = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, 20, 20)];
    sxiamge.image= [UIImage imageNamed:@"filter_off"];
    [sxbut addSubview:sxiamge];
    sxlabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 48, 14)];
    sxlabel.text=@"筛选";
    sxlabel.textAlignment=NSTextAlignmentCenter;
    sxlabel.font =[UIFont systemFontOfSize:11];
   // sxlabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [sxbut addSubview:sxlabel];
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
            
//            if(_arr.count==1){
//                if([_datestr isEqualToString:_requtstdict[@""]]){
//                    butleft.userInteractionEnabled=NO;
//                }else{
//                    butleft.userInteractionEnabled=YES;
//                }
//            }else{
                if([_datestr isEqualToString:dateString]){
                    butleft.userInteractionEnabled=NO;
                }else{
                    butleft.userInteractionEnabled=YES;
//                }
            }
            if(_gqYESorNO==YES){
                [self secondreq1:result];
            }else{
                if (_Approval==YES) {
                    [self secondreq2:result];
                }else{
                    [self secondreq:result];
                }
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
            if(_gqYESorNO==YES){
                [self secondreq1:result1];
            }else{
                if (_Approval==YES) {
                    [self secondreq2:result1];
                }else{
                    [self secondreq:result1];
                }
            }
            _datestr=result1;
            if([_datestr isEqualToString:_requtstdict[@"dataBack"]]){
                butright.userInteractionEnabled=NO;
            }else{
                butright.userInteractionEnabled=YES;
            }
            break;
        default:
            break;
    }
}
-(void)datechange:(UIButton*)send{
//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    //ctl.sss=_datestrback;
//    //ctl.isa=YES;
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
////        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
////        _aView1.dataOutlabel.text = date;
////        _aView1.weekOutlabel.text=[weekday weekdaywith:paramas];
//        [ _databut setTitle:[NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2] forState:UIControlStateNormal];
//        if (_gqYESorNO==YES) {
//            [self secondreq1:_databut.titleLabel.text];
//
//        }else{
//            [self secondreq:_databut.titleLabel.text];
//        }
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    if (_arr.count==0) {
//        changeDateVc * cdc =[changeDateVc new];
//        cdc.outOrback=@"back";
//        cdc.outdate=@"";
//        cdc.type=@"flight";
//        cdc.block=^(NSMutableDictionary*dict){
//            NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
//            NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
//            [ _databut setTitle:dict[@"back"] forState:UIControlStateNormal];
//            
//            _datestr=dict[@"back"];
//            if (_gqYESorNO==YES) {
//                [self secondreq1:_databut.titleLabel.text];
//                
//            }else{
//                [self secondreq:_databut.titleLabel.text];
//            }
//        };
//        [self presentViewController:cdc animated:NO completion:nil];
        
        changeDateVc * cdc =[changeDateVc new];
        cdc.outOrback=@"back";
        cdc.outdate=_requtstdict[@"dataBack"];
        cdc.type=@"flight";
        
        cdc.block=^(NSMutableDictionary*dict){
            NSDate * d1=  [LGLCalendarDate dateFromString:dict[@"back"]];
            NSDate * d2=  [LGLCalendarDate dateFromString:_requtstdict[@"dataBack"]];
            NSInteger h=[weekday getDaysFrom:d1 To:d2];
            if (h<0) {
                [UIAlertView showAlertWithTitle1:@"你的返回日期不能早于出发日期，请重新选择！" duration:1.5];
            }else{
                NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
                NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
                [ _databut setTitle:dict[@"back"] forState:UIControlStateNormal];
                _datestr=dict[@"back"];
                if (_gqYESorNO==YES) {
                    [self secondreq1:_databut.titleLabel.text];
                    
                }else{
                    [self secondreq:_databut.titleLabel.text];
                }
   
            }
    };
        [self presentViewController:cdc animated:NO completion:nil];

        
    }else{
        changeDateVc * cdc =[changeDateVc new];
        cdc.outOrback=@"back";
        cdc.outdate=dateString;
        cdc.type=@"flight";
        
        cdc.block=^(NSMutableDictionary*dict){
            NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
            NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            [ _databut setTitle:dict[@"back"] forState:UIControlStateNormal];
            _datestr=dict[@"back"];
            if (_gqYESorNO==YES) {
                [self secondreq1:_databut.titleLabel.text];
                
            }else{
                [self secondreq:_databut.titleLabel.text];
            }
        };
        [self presentViewController:cdc animated:NO completion:nil];
    }
   
}
-(void)secondreq:(NSString*)string{
    _dataArray=[NSMutableArray array];
    _dataArray1=[NSMutableArray array];
    _dataArray2=[NSMutableArray array];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
     [_databut setTitle:string forState: UIControlStateNormal];
    FlightQuery * Query=[FlightQuery new];
    Query.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Query.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Query.ArrivalCity=_backstr;
    Query.DepartCity=_outstr;
    Query.DepartDate=string;
    Query.CabinType= _requtstdict[@"CabinType"];
    Query.OrderBy=@"2";
    Query.AscOrDesc=@"1";
    Query.SortType=@"1";
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"]);
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString: @"1"])
    {
        Query.BusinessType=@"1";
        NSMutableArray * arr1=[NSMutableArray array];
        for (NSMutableDictionary * dic in _menarray) {
            Passageresmodel * passnger = [Passageresmodel new];
            passnger.PsgName=dic[@"empName"];
            passnger.PsgCardId=dic[@"certNo"];
            [arr1 addObject:passnger];
        }
        Query.Passageres =[Passageresmodel mj_keyValuesArrayWithObjectArray:arr1];
    }
    [Flight FlightQuery:Query success:^(id data) {
        [SVProgressHUD dismiss];
        _array = [[NSMutableArray alloc] init];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray2=data[@"flightDataList"];
            
            if (_dataArray2.count==0) {
                [UIAlertView showAlertWithTitle:@"未查询到航班，请重新查询！"];
            }else{
                for (int  i=0;i<_dataArray2.count; i++) {
                    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:_dataArray2[i]];
                    [dic setValue:_dataArray2[i][@"cabinData"][@"price"] forKey:@"price"];
                    [_dataArray addObject:dic];
                    [_dataArray1 addObject:dic];
                }
            float pr;
            NSString * zk;
            pr=[_dataArray[0][@"cabinData"][@"discount"] floatValue]/10;
            if(pr<10){
                zk=[NSString stringWithFormat:@"%.lf折",pr];
            }else if(pr==10){
                zk=@"全价";
            }else{
                zk=[NSString stringWithFormat:@"全价%.lf倍",pr/10];
            }
            px=[NSString stringWithFormat:@"%@ %@-%@ %@（%@）￥%@",_dataArray[0][@"flightNo"],[_dataArray[0][@"departTime"]  substringToIndex:5],[_dataArray[0][@"departTime"]  substringToIndex:5],zk,_dataArray[0][@"cabinData"][@"cabin"],_dataArray[0][@"cabinData"][@"price"]];
            session=data[@"sessionId"];
            for (NSDictionary *dic in _dataArray) {
                [_array addObject:@"0"];
            }
            [_tableView reloadData];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:YES];
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:YES];
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        pricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors1];
        
        NSSortDescriptor *TimesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"departTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptorJ = [[NSSortDescriptor alloc] initWithKey:@"price" ascending:NO];
    
        NSArray *descriptorsJ = [NSArray arrayWithObjects:TimesortDescriptorJ,nil];
        
        NSArray *descriptorsJ1 = [NSArray arrayWithObjects:PricesortDescriptorJ,nil];
        
        Jtimearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ];
       
        Jpricearr  =  [_dataArray sortedArrayUsingDescriptors:descriptorsJ1];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
#pragma mark -底部视图按钮
-(void)footclick:(UIButton*)send{
    switch (send.tag) {
        case 444:
            priceim.image= [UIImage imageNamed:@"price_on"];
            pricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            timeiamge.image= [UIImage imageNamed:@"time_off"];
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            timelabel.text=@"时间";
            sxiamge.image= [UIImage imageNamed:@"filter_off"];
            sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            if([pricelabel.text isEqualToString:@"价格"]){
                pricelabel.text =@"从低到高";
                _dataArray=[NSMutableArray arrayWithArray:pricearr];
            }else if([pricelabel.text isEqualToString:@"从低到高"]){
                pricelabel.text=@"从高到低";
                _dataArray=[NSMutableArray arrayWithArray:Jpricearr];
            }else{
                pricelabel.text =@"从低到高";
                _dataArray=[NSMutableArray arrayWithArray:pricearr];
            }
            [_tableView reloadData];
            break;
        case 445:
            timeiamge.image= [UIImage imageNamed:@"time_on"];
            timelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"price_off"];
            pricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            pricelabel.text=@"价格";
            sxiamge.image= [UIImage imageNamed:@"filter_off"];
            sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            if([timelabel.text isEqualToString:@"时间"]){
                timelabel.text =@"从早到晚";
                _dataArray=[NSMutableArray arrayWithArray:timearr];
            }else if([timelabel.text isEqualToString:@"从早到晚"]){
               timelabel.text=@"从晚到早";
            _dataArray=[NSMutableArray arrayWithArray:Jtimearr];
            }else{
                timelabel.text =@"从早到晚";
                _dataArray=[NSMutableArray arrayWithArray:timearr];
            }
               [_tableView reloadData];
            break;
        case 446:{
            sxiamge.image= [UIImage imageNamed:@"filter_on"];
            sxlabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"price_off"];
            pricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            pricelabel.text=@"价格";
            timeiamge.image= [UIImage imageNamed:@"time_off"];
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            timelabel.text=@"时间";
//            self.tabBarController.tabBar.frame=CGRectZero;
            SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1-370, 375, 395)];
            _SXconnetview.frame=CGRectMake(0, 0, 375/SCREEN_RATE1, deviceScreenHeight-370/SCREEN_RATE1);
            break;
        }
        default:
            break;
    }
}
#pragma mark -返回按钮
-(void)back:(UIButton*)send{
    
    [AlertViewManager alertWithTitle:@"温馨提示"
 message:@"你是否确定退出？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
     if (index==1) {
         [self.navigationController popToRootViewControllerAnimated:YES];
    }
 }];
    
}
#pragma mark -创建列表
-(void)creattable{
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight+60) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    connetviewlabel=[UILabel new];
    connetviewlabel.text=@"退改签规则";
    connetviewlabel.textColor=[UIColor whiteColor];
    [_connetview addSubview:connetviewlabel];
    [connetviewlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview).offset(deviceScreenWidth/2-40);
        make.top.equalTo(_connetview).offset(100);
        make.height.offset(40);
        make.width.offset(100);
    }];
    connetviewlabel1=[UILabel new];
    connetviewlabel1.text=@"退票说明：";
    connetviewlabel1.adjustsFontSizeToFitWidth = YES;
    connetviewlabel1.textColor=[UIColor whiteColor];
    [_connetview addSubview:connetviewlabel1];
    [connetviewlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview).offset(40);
        make.top.equalTo(_connetview).offset(130);
        make.height.offset(80);
        make.right.equalTo(_connetview).offset(-40);
    }];
    
    connetviewlabel2=[UILabel new];
    connetviewlabel2.adjustsFontSizeToFitWidth = YES;
    connetviewlabel2.text=@"变更说明：";
    connetviewlabel2.textColor=[UIColor whiteColor];
    [_connetview addSubview:connetviewlabel2];
    [connetviewlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview).offset(40);
        make.top.equalTo(_connetview).offset(220);
        make.right.equalTo(_connetview).offset(-40);
        make.height.offset(80);
    }];
    
    connetviewlabel3=[UILabel new];
    connetviewlabel3.text=@"温馨提示：仅供参考，最终以航司规定为准！";
    connetviewlabel3.adjustsFontSizeToFitWidth = YES;
    connetviewlabel3.textColor=[UIColor whiteColor];
    [_connetview addSubview:connetviewlabel3];
    [connetviewlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview).offset(40);
        make.top.equalTo(_connetview).offset(300);
        make.height.offset(40);
        make.right.equalTo(_connetview).offset(-40);
    }];
    
    _JTconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _JTconnetview.backgroundColor=[UIColor blackColor];
    _JTconnetview.alpha=0.7;
    [self.view  addSubview:_JTconnetview];
    
    UIView * taview =[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 190, 375, 20)]];
    UILabel * label = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(152, 0, 73, 20)]];
    label.text=@"经停信息";
    label.font=[UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth=YES;
    label.textColor=[UIColor whiteColor];
    [taview addSubview:label];
    [_JTconnetview addSubview:taview];
    
    _tableView1= [[UITableView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 255, 375, 150)] style:UITableViewStylePlain];
    _tableView1.backgroundColor=[UIColor blackColor];
    _tableView1.alpha=0.7;
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.bounces=NO;
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab:)];
    [_tableView1 addGestureRecognizer:tab];
    _tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
    [_JTconnetview addSubview:_tableView1];
#pragma mark -筛选视图
    _SXconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _SXconnetview.backgroundColor=[UIColor blackColor];
    _SXconnetview.alpha=0.7;
    [self.view  addSubview:_SXconnetview];
    
    SXview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE, 375,395 )]];
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

    UIView * ZFView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 50, 375, 55)]];
    ZFView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [SXview addSubview:ZFView];
    
    UIButton * zfbut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 18, 20, 18)]];
    zf=NO;
    zfbut.tag=901;
    [zfbut addTarget:self action:@selector(zfbut:) forControlEvents:UIControlEventTouchUpInside];
    [zfbut setBackgroundImage:[UIImage imageNamed:@"check_off"] forState:UIControlStateNormal];
    [ZFView addSubview:zfbut];
    
    UILabel * zflabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(50, 16, 64, 18)]];
    zflabel.textAlignment=NSTextAlignmentCenter;
    zflabel.text=@"仅看直飞";
    zflabel.adjustsFontSizeToFitWidth=YES;
    [ZFView addSubview:zflabel];

    UIView * leftView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 105, 120, 292)]];
    leftView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [SXview addSubview:leftView];
    
    UIButton * Lbut1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 120, 60)]];
    Lbut1.tag=1001;
    Lbut1.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut1.backgroundColor=[UIColor whiteColor];
    [Lbut1 setTitle:@"起飞时间" forState:UIControlStateNormal];
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
    
     arry1 = @[@"不限",@"00:00--06:00",@"06:00--12:00",@"12:00--18:00",@"18:00--24:00"];
     arry2 = @[@"不限",@"中国国航",@"中国联航",@"海南航空",@"东方航空",@"南方航空"];
   
    arry3=@[@"1",@"0",@"0",@"0",@"0",@"0"];
    
    arr3=[NSMutableArray arrayWithArray:arry3];
    
    arry4=@[@"1",@"0",@"0",@"0",@"0"];
    
    arr4=[NSMutableArray arrayWithArray:arry4];

    
    _tableView2= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 105, 255, 292)] style:UITableViewStylePlain];
    _tableView2.backgroundColor=[UIColor whiteColor];
    _tableView2.dataSource=self;
    _tableView2.delegate=self;
    [SXview addSubview:_tableView2];
    _sxdata=[NSMutableArray arrayWithArray:arry1];
    [_tableView2 reloadData];
}
-(void)Lbut:(UIButton *)send{
    switch (send.tag) {
        case 1001:{
            _sxdata=[NSMutableArray arrayWithArray:arry1];
            UIButton * but =(UIButton*)[self.view viewWithTag:1002];
            but.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            [_tableView2 reloadData];
            break;
        }
        case 1002:{
            UIButton * but =(UIButton*)[self.view viewWithTag:1001];
            but.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            send.backgroundColor=[UIColor whiteColor];
            _sxdata=[NSMutableArray arrayWithArray:arry2];
            [_tableView2 reloadData];
            break;
        }
        default:
            break;
    }
    
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){

        if([_array[section] isEqualToString:@"0"]){
            return 90;
        }else if([_dataArray[section][@"stopOver"] isEqualToString:@"1"]&&[_array[section]  isEqualToString:@"1"]){
            return 134;
        }else{
            return 90;
        }
    }else if([tableView isEqual:_tableView2]){
        
        return 0.01;

    }else{
        return 30;
    }
}

//设置组的尾部视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
     view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
        view0.backgroundColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
        
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 89)];
    view.backgroundColor = [UIColor whiteColor];
    _outTimelabel =[UILabel new];
    _outTimelabel.font=[UIFont systemFontOfSize:15];
    _outTimelabel.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    _outTimelabel.text=[_dataArray[section][@"departTime"]  substringToIndex:5];
    [view addSubview:_outTimelabel];
    [_outTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(10);
        make.height.offset(20);
        make.width.offset(48);
    }];
//        [12]	(null)	@"departTerminal" : @""	[19]	(null)	@"arrivalTerminal" : @"T1"

    _outAirlabel=[UILabel new];
    _outAirlabel.text=[NSString stringWithFormat:@"%@ %@",_dataArray[section][@"departCity"],_dataArray[section][@"departTerminal"]];
    _outAirlabel.font=[UIFont systemFontOfSize:15];
    _outAirlabel.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [view addSubview:_outAirlabel];
    [_outAirlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(deviceScreenWidth/2-(deviceScreenWidth/3)/2);
        make.top.equalTo(view).offset(10);
        make.height.offset(20);
        make.width.offset(deviceScreenWidth/2);
    }];
    _pricelabel=[UILabel new];
    _pricelabel.text=[NSString stringWithFormat:@"￥%@",_dataArray[section][@"cabinData"][@"price"]];
    _pricelabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
    [view addSubview:_pricelabel];
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-15);
        make.top.equalTo(view).offset(10);
        make.height.offset(20);
        make.width.offset(60);
    }];
    _arriveTimelabel=[UILabel new];
    //截取字符串前五位
    _arriveTimelabel.text=[_dataArray[section][@"arrivalTime"]  substringToIndex:5];
    _arriveTimelabel.font=[UIFont systemFontOfSize:14];
    _arriveTimelabel.textColor=[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];
    [view addSubview:_arriveTimelabel];
    [_arriveTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(38);
        make.height.offset(18);
        make.width.offset(44);
    }];
    _arriveAirlabel=[UILabel new];
    _arriveAirlabel.text=[NSString stringWithFormat:@"%@ %@",_dataArray[section][@"arrivalCity"],_dataArray[section][@"arrivalTerminal"]];
    _arriveAirlabel.font=[UIFont systemFontOfSize:14];
    _arriveAirlabel.textColor=[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];
    [view addSubview:_arriveAirlabel];
    [_arriveAirlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(deviceScreenWidth/2-(deviceScreenWidth/3)/2);
        make.top.equalTo(view).offset(38);
        make.height.offset(18);
        make.width.offset(deviceScreenWidth/2);
    }];
    _discountlabel=[UILabel new];
   // NSLog(@"%@",_dataArray[section][@"cabinData"][@"discount"]);
    float i;
    i=[_dataArray[section][@"cabinData"][@"discount"] floatValue]/10;
    if(i==10.0){
        _discountlabel.text=@"全价";
    }else{
        _discountlabel.text=[NSString stringWithFormat:@"%.1lf折",i];
    }
        _discountlabel.font=[UIFont systemFontOfSize:10];

    _discountlabel.textColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    [view addSubview:_discountlabel];
    [_discountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-20);
        make.top.equalTo(view).offset(38);
        make.height.offset(18);
        make.width.offset(42);
    }];
    _logoimageview  =[UIImageView new];
    _logoimageview.backgroundColor=[UIColor whiteColor];
    _logoimageview.image=[ UIImage imageNamed:_dataArray[section][@"airways"]];
    [view addSubview:_logoimageview];
    [_logoimageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.bottom.equalTo(view).offset(-7);
        make.height.offset(12);
        make.width.offset(13);
    }];
    _airConpanylabel  =[UILabel new];
    _airConpanylabel.textColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    NSString* strcopany=[NSString stringWithFormat:@"%@%@",_dataArray[section][@"airwaysName"],_dataArray[section][@"flightNo"]];
    _airConpanylabel.font=[UIFont systemFontOfSize:12];
         _airConpanylabel.text=strcopany;
    CGSize labelsize =[strcopany boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    [view addSubview:_airConpanylabel];
    [_airConpanylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15+15);
        make.bottom.equalTo(view).offset(-5);
        make.height.offset(18);
        make.width.offset(labelsize.width);
    }];
        
    UIView * vline =[UIView new];
    vline.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [view addSubview:vline];
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_airConpanylabel.mas_right).with.offset(7);
        make.bottom.equalTo(view).offset(-8);
        make.height.offset(12);
        make.width.offset(1);
    }];
        
    _airStylelabel  =[UILabel new];
    _airStylelabel.textColor=[UIColor colorWithRed:206/255.0 green:206/255.0 blue:206/255.0 alpha:1];
    _airStylelabel.font=[UIFont systemFontOfSize:12];
    _airStylelabel.text=[NSString stringWithFormat:@"机型:%@",_dataArray[section][@"flightMode"]];
    [view addSubview:_airStylelabel];
        
    [_airStylelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vline.mas_right).with.offset(7);
        make.bottom.equalTo(view).offset(-5);
        make.height.offset(18);
        make.width.offset(66);
    }];
        image4=[UIImageView new];
        [view addSubview:image4];
        [image4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(view).offset(-19);
            make.bottom.equalTo(view).offset(-5);
            make.height.offset(16);
            make.width.offset(32);
        }];
    image2=[UIImageView new];
    [view addSubview:image2];
    [image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(-19-61);
        make.bottom.equalTo(view).offset(-5);
        make.height.offset(16);
        make.width.offset(32);
    }];
    image3=[UIImageView new];
    [view addSubview:image3];
    [image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(-19-61-98);
        make.bottom.equalTo(view).offset(-5);
        make.height.offset(16);
        make.width.offset(32);
    }];
        if([_dataArray[section][@"stopOver"] isEqualToString:@"1"]){
            image4.image=[UIImage imageNamed:@"jingting"];
        }
        if (_Approval!=YES) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF:)];
            [view addGestureRecognizer:tap];
            view.tag=section+1;
        }
    [view0 addSubview:view];
    //头部试图下得展开视图
    view1 =[[UIView  alloc]initWithFrame:CGRectMake(0, 90, deviceScreenWidth, 44)];
        view1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    jtimagelogo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 16, 16)];
    jtimagelogo.image=[UIImage imageNamed:@"infolo"];
    [view1 addSubview:jtimagelogo];
     jtmessagebut = [[UIButton alloc]initWithFrame:CGRectMake(36,12, 60, 16)];
    jtmessagebut.hidden=YES;
    jtmessagebut.titleLabel.font=[UIFont systemFontOfSize:14];
    [jtmessagebut setTitleColor:[UIColor colorWithRed:29/255.0 green:176/255.0 blue:233/255.0 alpha:1] forState:UIControlStateNormal];
    [jtmessagebut setTitle:@"经停信息" forState:UIControlStateNormal];
        [jtmessagebut setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
    [view1 addSubview:jtmessagebut];
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFpp:)];
    [jtmessagebut addGestureRecognizer:tapp];
    
    jtimage = [[UIImageView alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-30, 0, 60, 8)];
    jtimage.image=[UIImage imageNamed:@"hide_flight"];
    [view1 addSubview:jtimage];
        UIView * leftview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 4, 46)];
        leftview.backgroundColor  = [UIColor colorWithRed:13/255.0 green:68/255.0 blue:124/255.0 alpha:1];
    [view1 addSubview:leftview];
    [view0 addSubview:view1];
        
    if([_array[section] isEqualToString:@"0"]){
        view1.hidden=YES;
        jtmessagebut.hidden=YES;
        jtimage.hidden=YES;
        jtimagelogo.hidden=YES;
    }else if([_array[section] isEqualToString:@"1"]&&[_dataArray[section][@"stopOver"] isEqualToString:@"1"]){
    view1.hidden=NO;
    jtmessagebut.hidden=NO;
    jtimage.hidden=NO;
    jtimagelogo.hidden=NO;
    }else{
        view1.hidden=YES;
        jtmessagebut.hidden=YES;
        jtimage.hidden=YES;
        jtimagelogo.hidden=YES;
    }
    return view0;
    }else if([tableView isEqual:_tableView2]){
        return 0;
    }else{
        UIView * jtview = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 0, 375, 30)]];
        
        UILabel * label1 = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(35, 7, 56, 16)]];
        label1.adjustsFontSizeToFitWidth=YES;
        label1.textAlignment=NSTextAlignmentCenter;
        label1.text=@"经停城市";
        label1.textColor=[UIColor whiteColor];
        label1.font=[UIFont systemFontOfSize:14];
        [jtview addSubview:label1];
        UIView * view11=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(104, 0, 1, 30)]];
        view11.backgroundColor=[UIColor whiteColor];
        [jtview addSubview:view11];

        UILabel * label2 = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(119, 7, 56, 16)]];
        label2.adjustsFontSizeToFitWidth=YES;

        label2.textAlignment=NSTextAlignmentCenter;
        label2.text=@"经停起始";
        label2.textColor=[UIColor whiteColor];
        label2.font=[UIFont systemFontOfSize:14];
        [jtview addSubview:label2];
         UIView * view2=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(187, 0, 1, 30)]];
        view2.backgroundColor=[UIColor whiteColor];
        [jtview addSubview:view2];

        UILabel * label3 = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(202, 7, 56, 16)]];
        label3.adjustsFontSizeToFitWidth=YES;
        label3.textAlignment=NSTextAlignmentCenter;
        label3.text=@"经停结束";
        label3.textColor=[UIColor whiteColor];
        label3.font=[UIFont systemFontOfSize:14];
        [jtview addSubview:label3];
        
         UIView * view3=[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(271, 0, 1, 30)]];
        view3.backgroundColor=[UIColor whiteColor];
        [jtview addSubview:view3];

        UILabel * label4 = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(286, 7, 56, 16)]];
        label4.adjustsFontSizeToFitWidth=YES;
        label4.textAlignment=NSTextAlignmentCenter;
        label4.text=@"停留时长";
        label4.textColor=[UIColor whiteColor];
        label4.font=[UIFont systemFontOfSize:14];
        [jtview addSubview:label4];
        UIView * vline = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(20, 29, 355, 1)]];
        vline.backgroundColor=[UIColor whiteColor];
        [jtview addSubview:vline];
        return jtview;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        return 80;
    }else if([tableView isEqual:_tableView2]){
        
        return 44/SCREEN_RATE;
        
    }else{
            return 30/SCREEN_RATE;
        }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return _dataArray.count;
    }
    else if([tableView isEqual:_tableView2]){
        
        return 1;
        
    }else{
            return 1;
        }
}
//设置行数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
 if([tableView isEqual:_tableView]){
    if(_array.count==0){
      return 0;
    }
    if ([_array[section] isEqualToString:@"0"]) {
        return 0;
    }
    NSInteger num = 0;
    for (NSDictionary *dict in _Cabinarray) {
        if ([dict[@"isOpen"] isEqualToString:@"0"]) {
            num++;
        } else {
            num = num  + [dict[@"cabinData"] count];
        }
    }
        return num;
 } else if([tableView isEqual:_tableView2]){
     
     return _sxdata.count;
     
 }
 else{
            return StopOverarr.count;
        }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
//    if(indexPath.section==0){
        AirMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (AirMessageCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"AirMessageCell" owner:self options:nil]  lastObject];
            cell.leftview.backgroundColor=[UIColor colorWithRed:13/255.0 green:70/255.0 blue:128/255.0 alpha:1];
            cell.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        }
        
    cell.mySection = 0;
    NSString * isTwo = @"NO";
    NSDictionary * dict = [[NSDictionary alloc]init];
    NSInteger num = 0;
    for (NSInteger x = 0; x< _Cabinarray.count; x++) {
        if (num == indexPath.row) {
            dict = _Cabinarray[x][@"cabinData"][0];
            cell.mySection = x ;
            break;
        }
        NSDictionary * myDict = _Cabinarray[x];
        if ([myDict[@"isOpen"] isEqualToString:@"0"]) {
            num++;
            if (num == indexPath.row) {
                dict = _Cabinarray[x + 1][@"cabinData"][0];
                isTwo = @"NO";
                cell.mySection = x + 1;
                break;
            }
        } else {
            cell.mySection = x ;
            isTwo = @"YES";
            NSInteger myNum = num + [_Cabinarray[x][@"cabinData"] count] ;
            if (myNum <= indexPath.row) {
                dict =  _Cabinarray[x][@"cabinData"][0];
                isTwo = @"NO";
                num = myNum ;
                continue;
            }
            NSInteger xx = 0;
            if (indexPath.row == (num + [_Cabinarray[x][@"cabinData"] count])) {
                xx = indexPath.row - num - 1;
            } else {
                xx = indexPath.row - num;
            }
            dict = _Cabinarray[x][@"cabinData"][xx];
            break;
        }
    }
    cell.celldict=dict;
    if ([isTwo isEqualToString:@"YES"]) {
        cell.showview.hidden = YES;
        cell.separatorInset = UIEdgeInsetsMake(0, 80, 0, 20);
        cell.cabinname.hidden=YES;
    }
    if([dict[@"policyType"] isEqualToString:@"ASMS_HSCZ"]){
       cell.gwimagelabel.image=[UIImage imageNamed:@"tag-sale"];
     [cell.bookbut setTitle:@"申请" forState:UIControlStateNormal];
    }else if([dict[@"policyType"] isEqualToString:@"ASMS_TJZC"]){
        //特价
        //cell.gwimagelabel.image=[UIImage imageNamed:@"tag-sale"];
    }else if([dict[@"policyType"] isEqualToString:@"ASMS_XYZC"]||[dict[@"policyType"] isEqualToString:@"OTA_OTA"]){
        //协议/Users/lhy/Desktop/文字剪辑.textClipping
      //  cell.gwimagelabel.image=[UIImage imageNamed:@"tag-sale"]CPS_PTZC;
    }else if([dict[@"policyType"] isEqualToString:@"CPS_TJZC"]){
      //促销
    // cell.gwimagelabel.image=[UIImage imageNamed:@"tag-sale1"];
    }else if([dict[@"policyType"] isEqualToString:@"TSZC"]){
        //特惠
       // cell.gwimagelabel.image=[UIImage imageNamed:@"tag-sale"];
    }else{
    [cell.bookbut setTitle:@"预订" forState:UIControlStateNormal];
    cell.gwimagelabel.hidden=YES;
   }
        
        cell.cabinname.textColor=UIColorFromRGBA(0x888888, 1.0);
        cell.bookbut.backgroundColor=UIColorFromRGBA(0xf8b500, 1.0);
        [cell.tgbutton setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        cell.cabinname.text=_Cabinarray[cell.mySection][@"cabinName"];
        cell.pricelabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
        cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",dict[@"price"]];
    float i ;
    i=[dict[@"discount"] floatValue]/10;
    //字体自适应
        cell.seatlabel.textColor=UIColorFromRGBA(0x888888, 1.0);
    cell.seatlabel.adjustsFontSizeToFitWidth = YES;
    if(i==10.0){
        cell.seatlabel.text=[NSString stringWithFormat:@"%@/%@",dict[@"cabin"],@"全价"];
    }else if(i<10.0){
         cell.seatlabel.text=[NSString stringWithFormat:@"%@/%.1lf折",dict[@"cabin"],i];
    }else{
          cell.seatlabel.text=[NSString stringWithFormat:@"%@/全价%.1lf倍",dict[@"cabin"],i/10];
    }
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString:@"2"]){
        cell.gzlabel.hidden=YES;
    }else{
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]) {
            if(![dict[@"violation"] isEqualToString:@""])  {
//                [[NSUserDefaults standardUserDefaults]setObject:@"wg" forKey:@"wh"];
                cell.gzlabel.text=@"违规";
                cell.gzlabel.textColor=[UIColor redColor];
            }else{
//                [[NSUserDefaults standardUserDefaults]setObject:@"hg" forKey:@"wh"];
            }
        }else{
           cell.gzlabel.hidden=YES;
        }
    }
    if(![dict[@"seatNum"] isEqualToString:@"A"]){
        if([dict[@"seatNum"] isEqualToString:@"0"]){
            [cell.bookbut setTitle:@"已售完" forState:UIControlStateNormal];
            cell.bookbut.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
            cell.bookbut.userInteractionEnabled=NO;
        }
        
         cell.bookbut.backgroundColor=UIColorFromRGBA(0xf8b500, 1.0);
        cell.czlabel.text= [NSString stringWithFormat:@"余%@张",dict[@"seatNum"]];
        cell.czlabel.textColor=[UIColor redColor];
    }
        return cell;
}else if([tableView isEqual:_tableView2]){
    sxtablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    // cell的复用
    if (!cell) {
        cell = [[sxtablecell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.strlabel.text=_sxdata[indexPath.row];
    if(_sxdata.count==5){
        if([arr4[indexPath.row] isEqualToString:@"1"]){
            cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        }else{
            cell.strlabel.textColor=[UIColor blackColor];
        }
    }else{
        if([arr3[indexPath.row] isEqualToString:@"1"]){
            cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        }else{
            cell.strlabel.textColor=[UIColor blackColor];
        }
    }
           return cell;
}else{
    
            JTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[JTCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                //cell= (hotelCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"hotelCell" owner:self options:nil]  lastObject];
            }
            cell.backgroundColor=[UIColor blackColor];
            [cell setCellWithModel:StopOverarr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        //获取cell的方法
        AirMessageCell * cell  = (AirMessageCell*)[tableView cellForRowAtIndexPath:indexPath];
        if (cell.showview.hidden) {
            return;
        }
    
            NSDictionary * dict = _Cabinarray[cell.mySection];
        if ([dict[@"isOpen"] isEqualToString:@"0"]) {
            [dict setValue:@"1" forKey:@"isOpen"];
        } else {
            [dict setValue:@"0" forKey:@"isOpen"];
        }
            [_Cabinarray replaceObjectAtIndex:cell.mySection withObject:dict];
            [_tableView reloadData];
    }else if([tableView isEqual:_tableView2]){
        sxtablecell * cell  = (sxtablecell*)[tableView cellForRowAtIndexPath:indexPath];
    if(_sxdata.count==6){
        //判断是不是1 如果是 改成0
        if(indexPath.row!=0){
            if ([arr3[indexPath.row] isEqualToString:@"1"]) {
             
                [arr3 replaceObjectAtIndex:indexPath.row withObject:@"0"];
            }else{
                [arr3 replaceObjectAtIndex:0 withObject:@"0"];
                    //如果不是 改成1
                [arr3 replaceObjectAtIndex:indexPath.row withObject:@"1"];
            }
        }else{
                for (int i=0;i<arr3.count;i++) {
                    [arr3 replaceObjectAtIndex:i withObject:@"0"];
                }
                //如果不是 改成1
                [arr3 replaceObjectAtIndex:indexPath.row withObject:@"1"];
                }
        [_tableView2 reloadData];
        BOOL isbool = [arr3 containsObject: @"1"];
        if(isbool==YES){
        }else{
            for (int i=0;i<arr3.count;i++) {
                [arr3 replaceObjectAtIndex:i withObject:@"0"];
            }
            //如果不是 改成1
            [arr3 replaceObjectAtIndex:0 withObject:@"1"];
            [_tableView2 reloadData];
        }
    }else{
        //判断是不是1 如果是 改成0
        if(indexPath.row!=0){
            if ([arr4[indexPath.row] isEqualToString:@"1"]) {
                [arr4 replaceObjectAtIndex:indexPath.row withObject:@"0"];
            }else{
                [arr4 replaceObjectAtIndex:0 withObject:@"0"];
                //如果不是 改成1
                [arr4 replaceObjectAtIndex:indexPath.row withObject:@"1"];
            }
        }else{
            for (int i=0;i<arr4.count;i++) {
                [arr4 replaceObjectAtIndex:i withObject:@"0"];
            }
            //如果不是 改成1
            [arr4 replaceObjectAtIndex:indexPath.row withObject:@"1"];
        }
        [_tableView2 reloadData];
        BOOL isbool = [arr4 containsObject: @"1"];
        if(isbool==YES){
        }else{
            for (int i=0;i<arr4.count;i++) {
                [arr4 replaceObjectAtIndex:i withObject:@"0"];
            }
            //如果不是 改成1
            [arr4 replaceObjectAtIndex:0 withObject:@"1"];
            [_tableView2 reloadData];
        }
    }
    }
}
-(void)showGFpp:(UITapGestureRecognizer *)tapp{
    [UIView animateWithDuration:0.01 animations:^{
    _JTconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)showGFtab:(UITapGestureRecognizer *)tab{
    [UIView animateWithDuration:0.01 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
#pragma mark -航班请求
-(void) showGF:(UITapGestureRecognizer *)tap
{   //判断是不是1 如果是 改成0
    if ([_array[tap.view.tag - 1] isEqualToString:@"1"]) {
        [_array replaceObjectAtIndex:tap.view.tag - 1 withObject:@"0"];
    }else{
        for (int i=0;i<_array.count;i++) {
            [_array replaceObjectAtIndex:i withObject:@"0"];
        }
        //如果不是 改成1
        [_array replaceObjectAtIndex:tap.view.tag - 1 withObject:@"1"];
    }

    [_tableView setContentOffset:CGPointMake(0,(tap.view.tag - 1)*90) animated:YES];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    StopOverQuery * soq = [StopOverQuery new];
    soq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    soq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    soq.FlightNo=_dataArray[tap.view.tag - 1][@"flightNo"];
    soq.SessionId=session;
    [Flight StopOverQuery:soq success:^(id data) {
// [SVProgressHUD dismiss];
       StopOverarr=[NSMutableArray array];
//NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            for (NSMutableDictionary * dic in data[@"stopOverList"]) {
                flightJTmodel * model =[[flightJTmodel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [StopOverarr addObject:model];
            }
            [_tableView1 reloadData];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    _Cabinarray=[NSMutableArray array];
    CabinQuery * cabin  =[CabinQuery new];
    cabin.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    cabin.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    cabin.SessionId=session;
    cabin.FlightNo=_dataArray[tap.view.tag - 1][@"flightNo"];
    [Flight CabinQuery:cabin success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        NSMutableArray * arr =[NSMutableArray arrayWithArray:data[@"cabinDataList"]];
        for (NSInteger x = 0; x <arr.count ; x++) {
            NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:arr[x]];
            [d setValue:@"0" forKey:@"isOpen"];
            [arr replaceObjectAtIndex:x withObject:d];
        }
        _Cabinarray = [NSMutableArray arrayWithArray:arr];      // for (NSDictionary * dic  in _Cabinarray) {
     //   NSLog(@"%@",dic[@"policyId"]);
     //   }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
    if(session.length!=0){
        StopOverQuery * soq  =[StopOverQuery new];
        soq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        soq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        soq.FlightNo=_dataArray[tap.view.tag - 1][@"flightNo"];
        [Flight StopOverQuery:soq success:^(id data) {
            if([data[@"status"] isEqualToString:@"T"]){
                StopOverarr=data[@"stopOverList"];
            }
        } failure:^(NSError *error) {
        }];
    }
}
-(void)bookbutClick:(AirMessageCell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    
    if(_gqYESorNO==YES){
        if(_block){
            _block([NSMutableDictionary dictionaryWithDictionary:cell.celldict],_dataArray[indexPath.section][@"flightNo"],_dataArray[indexPath.section][@"departTime"],_datestr);
        }
        [self.navigationController popViewControllerAnimated:NO];
    }else{
        OrderVC * vc  = [OrderVC new];
        if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
            _arr =[NSMutableArray new];
        }else{
            [_databut setTitle:_requtstdict[@"dataBack"] forState: UIControlStateNormal];
            toulabel.text=[NSString stringWithFormat:@"%@-%@(往返)",_requtstdict[@"backcityname"],_requtstdict[@"outcityname"]];
            _outstr=_requtstdict[@"backcity"];
            _backstr=_requtstdict[@"outcity"];
            _datestr=_requtstdict[@"dataBack"];
            if([_datestr isEqualToString:dateString]){
                butleft.userInteractionEnabled=NO;
            }else{
                butleft.userInteractionEnabled=YES;
            }
        }
        NSMutableDictionary * dict= [[NSMutableDictionary alloc]init];
        [dict  setValue: _dataArray[indexPath.section][@"meal"] forKey:@"meal"];
        [dict setValue:cell.celldict[@"cabin"] forKey:@"Cabin"];
        [dict setValue:cell.celldict[@"policyId"] forKey:@"policyId"];
        
        [dict setValue:cell.celldict[@"policyType"] forKey:@"policyType"];
        [dict setValue: _dataArray[indexPath.section][@"arrivalTerminal"] forKey:@"arrivalTerminal"];
        [dict setValue: _dataArray[indexPath.section][@"departTerminal"] forKey:@"departTerminal"];
        [dict setValue:_dataArray[indexPath.section][@"flightNo"] forKey:@"flightNo"];
        [dict setValue:session forKey:@"sessionId"];
        [dict setValue:_dataArray[indexPath.section][@"departTime"] forKey:@"date"];
        [dict setValue:_dataArray[indexPath.section][@"arrivalTime"] forKey:@"arrivalTime"];
        if(_arr.count==1){
            [dict setValue:[NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.section][@"departDate"],_requtstdict[@"week1"]] forKey:@"outdate"];
        }else{
            [dict setValue:[NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.section][@"departDate"],_requtstdict[@"week"]] forKey:@"outdate"];
        }
        [dict setValue:[NSString stringWithFormat:@"%@%@",_dataArray[indexPath.section][@"airwaysName"],_dataArray[indexPath.section][@"flightNo"]]forKey:@"conpany"];
        [dict  setValue: _dataArray[indexPath.section][@"flightMode"] forKey:@"flightMode"];
        [dict  setValue: @"1" forKey:@"BusinessType"];
        [dict setValue:_dataArray[indexPath.section][@"departCity"] forKey:@"departCity"];
        [dict setValue:_dataArray[indexPath.section][@"arrivalCity"] forKey:@"arrivalCity"];
        [dict setValue:cell.celldict[@"price"] forKey:@"price"];
        [dict setValue:cell.celldict[@"noteSimp"] forKey:@"noteSimp"];
        [dict setValue:cell.celldict[@"serviceFee"] forKey:@"serviceFee"];
        
        
        [dict setValue:_dataArray[indexPath.section][@"airConstructionFee"] forKey:@"airConstructionFee"];
        
        [dict  setValue:_dataArray[indexPath.section][@"flyTime"] forKey:@"flyTime"];
        [dict setValue:_dataArray[indexPath.section][@"punctualityRate"] forKey:@"punctualityRate"];
        [dict  setValue: _dataArray[indexPath.section][@"stopOver"] forKey:@"stopOver"];
        if (_arr.count<2) {
            [_arr addObject:dict];
            NSLog(@"%@",_arr);
        }
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]&&_arr.count==1){
            _tableView.frame=CGRectMake(0, 154,deviceScreenWidth , deviceScreenHeight-198);
            imageview.image=[UIImage imageNamed:@"forward_white"];
            datelab.text=_arr[0][@"outdate"];
            datetime.text=[NSString stringWithFormat:@"%@-%@",[_arr[0][@"date"] substringToIndex:5],[_arr[0][@"arrivalTime"] substringToIndex:5]];
            flightno.text=_arr[0][@"flightNo"];
        }
        //* ** *核对订单页面所需数据* ** *//
        NSMutableArray * arr1 =[NSMutableArray new];
        NSMutableDictionary * dict1= [[NSMutableDictionary alloc]init];
        [dict1 setValue:session forKey:@"sessionId"];
        [dict1 setValue:[NSString stringWithFormat:@"%@ %@",_requtstdict[@"dataOut"],_requtstdict[@"week"]] forKey:@"outdate"];
        [dict1 setValue:_dataArray[indexPath.section][@"departTime"] forKey:@"date"];
        [dict1 setValue:[NSString stringWithFormat:@"%@%@",_dataArray[indexPath.section][@"airwaysName"],_dataArray[indexPath.section][@"flightNo"]]forKey:@"conpany"];
        [dict1 setValue:cell.celldict[@"cabin"] forKey:@"Cabin"];
        [dict1 setValue:_dataArray[indexPath.section][@"flightNo"]
                 forKey:@"flightNo"];
        [dict setValue:cell.celldict[@"policyType"] forKey:@"policyType"];

        [dict1 setValue:cell.celldict[@"price"] forKey:@"price"];
        [dict1  setValue:_dataArray[indexPath.section][@"flyTime"] forKey:@"flyTime"];
        [dict1  setValue:_dataArray[indexPath.section][@"arrivalTime"] forKey:@"arrivalTime"];
        [dict1  setValue:_dataArray[indexPath.section][@"arrivalCity"] forKey:@"arrivalCity"];
        [dict1  setValue:_dataArray[indexPath.section][@"departCity"] forKey:@"departCity"];
        [dict1  setValue: _dataArray[indexPath.section][@"meal"] forKey:@"meal"];
        [dict1  setValue: _dataArray[indexPath.section][@"flightMode"] forKey:@"flightMode"];
        [dict1  setValue: _dataArray[indexPath.section][@"stopOver"] forKey:@"stopOver"];
        [dict1  setValue: @"1" forKey:@"BusinessType"];
        [arr1 addObject:dict1];
        vc.cabinArray=arr1;
        vc.menarray=_menarray;
        
        //*       * * * * *    * *//
        RuleVC* rvc =[RuleVC new];
        NSString *title = @"提示";
        NSString *title1 = @"取消";
        NSString *okButtonTitle = @"确认预订";
        NSString *message=@"";
        if([cell.gzlabel.text isEqualToString:@"违规"]){
            [[NSUserDefaults standardUserDefaults]setObject:@"wg" forKey:@"wh"];

            
            message = [NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@，\n%@",_dataArray[indexPath.section][@"flightNo"],cell.celldict[@"violation"],px];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                rvc.dataArr=_arr;
                rvc.cabinArray=arr1;
                rvc.menarray=_menarray;

                rvc.requtstdict=_requtstdict;
                rvc.erromes=cell.celldict[@"violation"];
                rvc.erro=[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"flightNo"],cell.celldict[@"violation"]];
                NSLog(@"%@",[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"flightNo"],cell.celldict[@"violation"]]);
                            [self.navigationController pushViewController:rvc animated:YES];
            }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            [[NSUserDefaults standardUserDefaults]setObject:@"hg" forKey:@"wh"];

            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
                if(_arr.count==2){
                    NSLog(@"%@",_arr);
                    vc.dataArray=_arr;
                    vc.menarray=_menarray;
                       [self.navigationController pushViewController:vc animated:YES];
//                    [self presentViewController:vc animated:YES completion:nil];
                }else{
                    dateString =[_arr[0][@"outdate"] substringWithRange:NSMakeRange(0, 10)];
                    twoandone=YES;
                    [self loadData];
                    [_tableView reloadData];
                }
            }else{
                vc.dataArray=_arr;
                vc.menarray=_menarray;

                //NSLog(@"%@",_arr);
                         [self.navigationController pushViewController:vc animated:YES];
//                [self presentViewController:vc animated:YES completion:nil];
            }
        }
  
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    footview.hidden=NO;
//    [self showTabBar];
    
    if (_dataArray.count==_dataArray1.count) {
        _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
    }
    SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 395)];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

    [UIView animateWithDuration:0.01 animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    [UIView animateWithDuration:0.01 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)tgbuttonClick:(AirMessageCell *)cell{
    footview.hidden=YES;
   NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    [UIView animateWithDuration:0.01 animations:^{
        _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
        }completion:nil];
    RemarkString * remark =[RemarkString new];
    remark.PolicyId=cell.celldict[@"policyId"];
    remark.FlightNo=_dataArray[indexPath.section][@"flightNo"];
    remark.SeatClass=cell.celldict[@"cabin"];
    remark.SessionId=session;
    remark.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    remark.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight RemarkString:remark success:^(id data) {
//    NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            connetviewlabel1.text=[NSString stringWithFormat:@"\t%@：%@%@%@",data[@"data"][0][@"regulationName"],data[@"data"][0][@"data"][0][@"itemDes"],data[@"data"][0][@"data"][0][@"itemValue"],@"%"];
             connetviewlabel2.text=[NSString stringWithFormat:@"\t%@：%@%@%@",data[@"data"][1][@"regulationName"],data[@"data"][1][@"data"][0][@"itemDes"],data[@"data"][1][@"data"][0][@"itemValue"],@"%"];
        }
    } failure:^(NSError *error) {
    }];
  }
#pragma mark -筛选按钮点击方法
-(void)okbut:(UIButton*)send{
    footview.hidden=NO;
    if(zf==NO){
        int num=0;
        NSMutableArray * ar = [NSMutableArray new];
        for (int i=0;i<arr4.count;i++) {
            if([arr4[i] isEqualToString:@"1"]){
                [ar addObject:arry1[i]];
            }
        }
        NSMutableArray * ar1 = [NSMutableArray new];
        for (int i=0;i<arr3.count;i++) {
            if([arr3[i] isEqualToString:@"1"]){
                [ar1 addObject:arry2[i]];
            }
        }
        if(![ar[0] isEqualToString:@"不限"] && [ar1[0] isEqualToString:@"不限"]){
            if(ar.count==1){
                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray1) {
                   
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                if (time1.count!=0) {
                    _dataArray=[NSMutableArray arrayWithArray:time1];
                    
                }else{
                    [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];
                    
                    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
                }
                [_tableView reloadData];

            }else if (ar.count==2){
//                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                if (time1.count!=0) {
                    _dataArray=[NSMutableArray arrayWithArray:time1];
                }else{
                    [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];
                    
                    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
                }
                [_tableView reloadData];
            }else if (ar.count==3){
                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                if (time1.count!=0) {
                    _dataArray=[NSMutableArray arrayWithArray:time1];
                    
                }else{
                    [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];
                    
                    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
                }
                [_tableView reloadData];

            }else   if (ar.count==4){
                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[3] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[3] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                if (time1.count!=0) {
                    _dataArray=[NSMutableArray arrayWithArray:time1];
                    
                }else{
                    [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];
                    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
                }
                [_tableView reloadData];
            }else{
            
            }
//            _dataArray=[NSMutableArray arrayWithArray:time1];
//            [_tableView reloadData];
        }else if (![ar[0] isEqualToString:@"不限"] && ![ar1[0] isEqualToString:@"不限"]){
            time1=[NSMutableArray new];

            if(ar.count==1){
                for (NSMutableDictionary * dict in _dataArray1) {
                    //                    NSLog(@"%d",[[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]);
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else if (ar.count==2){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else if (ar.count==3){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                
                
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else   if (ar.count==4){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[3] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[3] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else{
                
            }
            
            NSMutableArray * time2 =[NSMutableArray new];
            
            if(ar1.count==1){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                            [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==2){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==3){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                    }
                }
            }else   if (ar1.count==4){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                                        }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==5){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time2 addObject:dict];
                    }}
            }else{
                
            }
            if (time2.count!=0) {
                _dataArray=[NSMutableArray arrayWithArray:time2];
                
            }else{
                [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];

                _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
            }
            
            [_tableView reloadData];
        }else if([ar[0] isEqualToString:@"不限"] && ![ar1[0] isEqualToString:@"不限"]){
            time1=[NSMutableArray new];
            if(ar1.count==1){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==2){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==3){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                }
            }else   if (ar1.count==4){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==5){
                for (NSMutableDictionary * dict in _dataArray1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time1 addObject:dict];
                    }}
            }else{
                
            }
            if (time1.count!=0) {
                _dataArray=[NSMutableArray arrayWithArray:time1];
                
            }else{
                [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];
                _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
            }
            [_tableView reloadData];
            
        }else{
            [_tableView reloadData];
        }
    }else{
        NSMutableArray * zfarr = [NSMutableArray array];
        for (NSMutableDictionary * dict in _dataArray1) {
            if ([dict[@"stopOver"] isEqualToString:@"0"]) {
                [zfarr addObject:dict];
            }
        }
    _dataArray=[NSMutableArray arrayWithArray:zfarr];
//int num=0;
        NSMutableArray * ar = [NSMutableArray new];
        for (int i=0;i<arr4.count;i++) {
            if([arr4[i] isEqualToString:@"1"]){
                [ar addObject:arry1[i]];
            }
        }
        NSMutableArray * ar1 = [NSMutableArray new];
        for (int i=0;i<arr3.count;i++) {
            if([arr3[i] isEqualToString:@"1"]){
                [ar1 addObject:arry2[i]];
            }
        }
        if(![ar[0] isEqualToString:@"不限"] && [ar1[0] isEqualToString:@"不限"]){
           
            time1=[NSMutableArray new];

            if(ar.count==1){
                for (NSMutableDictionary * dict in _dataArray) {
                    //                    NSLog(@"%d",[[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]);
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else if (ar.count==2){
//                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else if (ar.count==3){
//                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
//                _dataArray=[NSMutableArray arrayWithArray:time1];
//                [_tableView reloadData];
            }else   if (ar.count==4){
//                time1=[NSMutableArray new];
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[3] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[3] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
            }else{
                
            }
            if (time1.count!=0) {
                _dataArray=[NSMutableArray arrayWithArray:time1];
                
            }else{
                [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];

                _dataArray=[NSMutableArray arrayWithArray:zfarr];
            }
            [_tableView reloadData];

            
        }else if (![ar[0] isEqualToString:@"不限"] && ![ar1[0] isEqualToString:@"不限"]){
            time1=[NSMutableArray new];
            
            if(ar.count==1){
                for (NSMutableDictionary * dict in _dataArray) {
                    //                    NSLog(@"%d",[[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]);
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                //                _dataArray=[NSMutableArray arrayWithArray:time1];
                //                [_tableView reloadData];
            }else if (ar.count==2){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                //                _dataArray=[NSMutableArray arrayWithArray:time1];
                //                [_tableView reloadData];
            }else if (ar.count==3){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
            }else   if (ar.count==4){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[0] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[1] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[1] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[2] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[2] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[3] substringWithRange:NSMakeRange(7,2)] intValue]){
                        if ([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]>[[ar[3] substringWithRange:NSMakeRange(0,2)] intValue]) {
                            [time1 addObject:dict];
                        }
                    }
                }
                //                _dataArray=[NSMutableArray arrayWithArray:time1];
                //                [_tableView reloadData];
            }else{
                
            }
            NSMutableArray * time2 =[NSMutableArray new];
            
            if(ar1.count==1){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==2){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==3){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                    }
                }
            }else   if (ar1.count==4){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time2 addObject:dict];
                    }
                }
            }else if (ar1.count==5){
                for (NSMutableDictionary * dict in time1) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time2 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time2 addObject:dict];
                    }}
            }else{
                
            }
            if (time2.count!=0) {
                _dataArray=[NSMutableArray arrayWithArray:time2];
                
            }else{
                [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];

                _dataArray=[NSMutableArray arrayWithArray:zfarr];
            }            [_tableView reloadData];
        }else if([ar[0] isEqualToString:@"不限"] && ![ar1[0] isEqualToString:@"不限"]){
            time1=[NSMutableArray new];
            if(ar1.count==1){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==2){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==3){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                }
            }else   if (ar1.count==4){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time1 addObject:dict];
                    }
                }
            }else if (ar1.count==5){
                for (NSMutableDictionary * dict in _dataArray) {
                    if([dict[@"airwaysName"] isEqualToString:ar1[0]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[1]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[2]]){
                        [time1 addObject:dict];
                    }
                    if([dict[@"airwaysName"] isEqualToString:ar1[3]]){
                        [time1 addObject:dict];
                    }}
            }else{
                
            }
            if (time1.count!=0) {
                _dataArray=[NSMutableArray arrayWithArray:time1];
            }else{
                [UIAlertView showAlertWithTitle1:@"未筛选出符合条件的航班" duration:1.2];

                _dataArray=[NSMutableArray arrayWithArray:zfarr];
              }
            [_tableView reloadData];
        }else{
            [_tableView reloadData];
        }
        //仅看直飞
    }
    SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 395)];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)cancelbut:(UIButton*)send{
    footview.hidden=NO;
//    [self showTabBar];
    if (_dataArray.count==_dataArray1.count) {
        _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
    }
 SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 395)];
_SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
}
-(void)clearbut:(UIButton*)send{

    UIButton * but =(UIButton*)[self.view viewWithTag:901];
    
    if(zf==YES){
        zf=NO;
        [but setBackgroundImage:[UIImage imageNamed:@"check_off"] forState:UIControlStateNormal];
    }
    
    for (int i=0;i<arr4.count;i++) {
        if (i==0) {
            [arr4 replaceObjectAtIndex:i withObject:@"1"];
        }else{
            [arr4 replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    for (int i=0;i<arr3.count;i++) {
        if (i==0) {
            [arr3 replaceObjectAtIndex:i withObject:@"1"];
        }else{
            [arr3 replaceObjectAtIndex:i withObject:@"0"];
        }
    }
    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
    [_tableView2 reloadData];
    [_tableView reloadData];
//    SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 395)];

}
-(void)setBlock:(GQBlcok)block{
    _block=block;
}

-(void)zfbut:(UIButton*)send{
    if(zf==NO){
        zf=YES;
        [send setBackgroundImage:[UIImage imageNamed:@"check_on"] forState:UIControlStateNormal];
    }else{
        zf=NO;
        [send setBackgroundImage:[UIImage imageNamed:@"check_off"] forState:UIControlStateNormal];
    }
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE1;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE1;
    return newFrame;
}
@end
