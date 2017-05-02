//
//  TrainVC.m
//  Tour
//
//  Created by Euet on 17/1/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrainVC.h"
//#import "trainCell.h"
#import "train1Cell.h"
#import "login06VC.h"
#import "Tjtmodel.h"
#import "TrainorderVC.h"
#import "TJTCell.h"
#import "LGLCalenderViewController.h"
#import "sxtablecell.h"
#import "TraincityMotel.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
@interface TrainVC ()<UITableViewDelegate,UITableViewDataSource,train1CellDelegate>
{
    //筛选所需出发到达站点的标记
    NSString * _outnum;
    NSString * _backnum;
    
    BOOL open;
    UIView * view1;
    UIView * view0;
    UIButton * jtmessagebut;
    UIImageView * jtimage;
    UIImageView * jtimagelogo;
    
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
    NSMutableArray * _dataArray1;

    //作为类型数组
    NSMutableArray * _seatArray;

    //判断组头视图的展开
    NSMutableArray * _array;
    NSMutableArray * _array1;

    NSString*px;
    //蒙版视图
    UIView * _JTconnetview;
    UITableView * _tableView1;
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
    /*  */
    UIView * dataview;
    //底部视图控件
    UIImageView * priceim;
    UILabel * SXpricelabel;
    UIImageView * timeiamge;
    UILabel * timelabel;
    UIImageView * sxiamge;
    UILabel * sxlabel;
    UIImageView * hsiamge;
    UILabel * hslabel;

    //排序
    NSArray * timearr;
    NSArray * timearr1;
    NSArray * pricearr;
    NSArray * pricearr1;
    NSArray * runtime;
    NSArray * runtime1;
    
    
    //筛选视图
    UIView * SXview;
    //蒙版视图
    UIView * _SXconnetview;

    UITableView * _tableView3;
    NSMutableArray * _sxdata;
    
    
    NSArray * ccArray;
    NSArray * ccnum;
    NSMutableArray * ccArraynum;

    
    NSArray * zxArray;
    NSArray * zxnum;
    NSMutableArray * zxArraynum;
    
    NSArray * fcArray;
    NSArray * fcnum;
    NSMutableArray * fcArraynum;
    
    NSArray * ddArray;
    NSArray * ddnum;
    NSMutableArray * ddArraynum;
    
   
    NSArray * outArray;
    NSArray * outnum;
    NSMutableArray * outArraynum;
    
    NSArray * toArray;
    NSArray * tonum;
    NSMutableArray * toArraynum;
    
    
    
}
@end

@implementation TrainVC

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden=NO;
    [SVProgressHUD dismiss];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initview];
    
    if (_Approval==YES) {
        [self loadtadaApproval];
    }else{
        [self loadtada];
    }
    [self creatable];
}
#pragma mark - 创建tableview
-(void)creatable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-160) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [self.view addSubview:_tableView];
    
    _JTconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _JTconnetview.backgroundColor=[UIColor blackColor];
    _JTconnetview.alpha=0.7;
    [self.view  addSubview:_JTconnetview];
   
    UIView * taview =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 150, 375, 20)]];
    UILabel * label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(152, 0, 73, 20)]];
    label.text=@"经停信息";
    label.font=[UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth=YES;
    label.textColor=[UIColor whiteColor];
    [taview addSubview:label];
    [_JTconnetview addSubview:taview];

    _tableView1= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 215, 375, 250)] style:UITableViewStylePlain];
    _tableView1.backgroundColor=[UIColor blackColor];
    // _tableView1.alpha=0.7;
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

    SXview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE, 375,400 )]];
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
    
    UIView * leftView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 50, 120, 298)]];
    leftView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [SXview addSubview:leftView];
    
    UIButton * Lbut1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 120, 30)]];
    Lbut1.tag=1001;
    Lbut1.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut1.backgroundColor=[UIColor whiteColor];
    [Lbut1 setTitle:@"车次类型" forState:UIControlStateNormal];
    [Lbut1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut1 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut1];
    
    UIView * lineView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 31, 120, 1)]];
    lineView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [leftView addSubview:lineView];
    
    UIButton * Lbut2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 31, 120, 30)]];
    Lbut2.tag=1002;
    Lbut2.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut2 setTitle:@"坐席类型" forState:UIControlStateNormal];
    [Lbut2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut2 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut2];
    UIView * lineView1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 62, 120, 1)]];
    lineView1.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView1];
    
    UIButton * Lbut3 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 63, 120, 30)]];
    Lbut3.tag=1003;
    Lbut3.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut3 setTitle:@"发车时段" forState:UIControlStateNormal];
    [Lbut3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut3 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut3];
    UIView * lineView2 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 94, 120, 1)]];
    lineView2.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView2];
    
    UIButton * Lbut4 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 95, 120, 30)]];
    Lbut4.tag=1004;
    Lbut4.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut4 setTitle:@"到达时段" forState:UIControlStateNormal];
    [Lbut4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut4 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut4];
    UIView * lineView4 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 126, 120, 1)]];
    lineView4.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView4];
    UIButton * Lbut5 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 127, 120, 30)]];
    Lbut5.tag=1005;
    Lbut5.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut5 setTitle:@"出发站点" forState:UIControlStateNormal];
    [Lbut5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut5 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut5];
    UIView * lineView5 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 158, 120, 1)]];
    lineView5.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView5];
    UIButton * Lbut6 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 159, 120, 30)]];
    Lbut6.tag=1006;
    Lbut6.titleLabel.font=[UIFont systemFontOfSize:14];
    Lbut6.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [Lbut6 setTitle:@"到达站点" forState:UIControlStateNormal];
    [Lbut6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Lbut6 addTarget:self action:@selector(Lbut:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:Lbut6];
    UIView * lineView6 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 189, 120, 1)]];
    lineView6.backgroundColor=[UIColor grayColor];
    [leftView addSubview:lineView6];

    ccArray = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"G/C-高铁/城际",@"num":@"0",@"type":@"1"},@{@"1":@"Z-直达",@"num":@"0"},@{@"1":@"T-特快",@"num":@"0"},@{@"1":@"K-快速",@"num":@"0"}];
   ccArraynum=[NSMutableArray arrayWithArray:ccArray];
    NSMutableArray *  arr1 = [NSMutableArray new];
    for (NSDictionary * dict  in ccArraynum) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr1 addObject:d];
    }
    ccArraynum=[NSMutableArray arrayWithArray:arr1];
    
    fcArray = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"00:00--06:00",@"num":@"0",@"type":@"3"},@{@"1":@"06:00--12:00",@"num":@"0"},@{@"1":@"12:00--18:00",@"num":@"0"},@{@"1":@"18:00--24:00",@"num":@"0"}];
    fcArraynum=[NSMutableArray arrayWithArray:fcArray];
    NSMutableArray *  arr2 = [NSMutableArray new];
    for (NSDictionary * dict  in fcArraynum) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr2 addObject:d];
    }
    fcArraynum=[NSMutableArray arrayWithArray:arr2];

    ddArray = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"00:00--06:00",@"num":@"0",@"type":@"4"},@{@"1":@"06:00--12:00",@"num":@"0"},@{@"1":@"12:00--18:00",@"num":@"0"},@{@"1":@"18:00--24:00",@"num":@"0"}];
    ddArraynum=[NSMutableArray arrayWithArray:ddArray];
    
    NSMutableArray *  arr3 = [NSMutableArray new];
    
    for (NSDictionary * dict  in ddArraynum) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr3 addObject:d];
    }
    ddArraynum=[NSMutableArray arrayWithArray:arr3];

    zxArray = @[@{@"1":@"不限",@"num":@"1"},@{@"1":@"硬座",@"num":@"0",@"type":@"2"},@{@"1":@"软座",@"num":@"0"},@{@"1":@"硬卧",@"num":@"0"},@{@"1":@"软卧",@"num":@"0"},@{@"1":@"高级软卧",@"num":@"0"},@{@"1":@"商务座",@"num":@"0"},@{@"1":@"一等座",@"num":@"0"},@{@"1":@"二等座",@"num":@"0"},@{@"1":@"特等座",@"num":@"0"}];
    zxArraynum=[NSMutableArray arrayWithArray:zxArray];
    NSMutableArray *  arr4 = [NSMutableArray new];
    for (NSDictionary * dict  in zxArraynum) {
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [arr4 addObject:d];
    }
    zxArraynum=[NSMutableArray arrayWithArray:arr4];
    
    for (TraincityMotel * model  in _cityarr) {
//       NSLog(@"%@",model.spell);
        if (model.spell.length!=1) {
        if([_requtstdict[@"outcity"] isEqualToString:model.stationCode]){
           _outnum=model.stationName;
        }
        if([_requtstdict[@"backcity"] isEqualToString:model.stationCode]){
          _backnum=model.stationName;
            _backnum=model.spell;
        }
     }
    }
    outArraynum=[NSMutableArray new];
    toArraynum=[NSMutableArray new];
    for (TraincityMotel * model  in _cityarr) {
        if (model.spell.length!=1) {
            if (model.stationName.length<=_outnum.length) {
                if([[_outnum substringWithRange:NSMakeRange(0, 2)] isEqualToString:[model.stationName substringWithRange:NSMakeRange(0, 2)]]){
                    NSDictionary *statusDict = model.mj_keyValues;
                    [outArraynum addObject:statusDict];
                }
            }else{
                if([_outnum isEqualToString:[model.stationName substringWithRange:NSMakeRange(0, _outnum.length)]]){
                    NSDictionary *statusDict = model.mj_keyValues;
                    [outArraynum addObject:statusDict];
                 }
            }
            
            if (model.stationName.length<=_backnum.length) {
                if([[_outnum substringWithRange:NSMakeRange(0, 2)]  isEqualToString:[model.stationName substringWithRange:NSMakeRange(0,  2)]]){
                    NSDictionary *statusDict = model.mj_keyValues;
                    [toArraynum addObject:statusDict];
                }
            }else{
                if([_backnum  isEqualToString:[model.stationName substringWithRange:NSMakeRange(0, _backnum.length)]]){
                    NSDictionary *statusDict = model.mj_keyValues;
                    [toArraynum addObject:statusDict];
                }
             }
            }
        }
    
//    NSLog(@"%@",toArraynum);
    NSMutableArray *  arr5 = [NSMutableArray new];
    NSMutableDictionary * dict1 = [NSMutableDictionary new];
    [dict1 setValue:@"不限" forKey:@"stationName"];
    [dict1 setValue:@"1" forKey:@"num"];
    [arr5 addObject:dict1];
    
    for (NSDictionary * dict  in outArraynum) {
    
    NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [d setValue:@"0" forKey:@"num"];
     
        [d setValue:@"5" forKey:@"type"];
       
        [arr5 addObject:d];
    }
    outArraynum=[NSMutableArray arrayWithArray:arr5];

    NSMutableArray *  arr6 = [NSMutableArray new];
    NSMutableDictionary * dict2 = [NSMutableDictionary new];
    [dict2 setValue:@"不限" forKey:@"stationName"];
    [dict2 setValue:@"1" forKey:@"num"];
    [arr6 addObject:dict2];
    
    for (NSDictionary * dict  in toArraynum) {
        
        NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
        [d setValue:@"0" forKey:@"num"];
        
        [d setValue:@"6" forKey:@"type"];
        
        [arr6 addObject:d];
    }

    toArraynum=[NSMutableArray arrayWithArray:arr6];


    _tableView3= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(118, 50, 255, 298)] style:UITableViewStylePlain];
    _tableView3.backgroundColor=[UIColor whiteColor];
    _tableView3.dataSource=self;
    _tableView3.delegate=self;
    [SXview addSubview:_tableView3];
    _sxdata=[NSMutableArray arrayWithArray:ccArraynum];
    [_tableView3 reloadData];

}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if([_array[section] isEqualToString:@"0"]){
            return 90;
        }else{
            return 134;
        }
    }else if([tableView isEqual:_tableView3]){
        return 0;
    }else{
        return 30/SCREEN_RATE1;
    }
}
//设置组的尾部视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     if([tableView isEqual:_tableView]){
    view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    view.backgroundColor = [UIColor whiteColor];
    _outcitylabel=[UILabel new];
    _outcitylabel.text=_dataArray[section][@"fromStationName"];
    _outcitylabel.font=[UIFont systemFontOfSize:14];
    _outcitylabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    [view addSubview:_outcitylabel];
    [_outcitylabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(10);
        make.height.offset(18);
        make.width.offset(100);
    }];
    _outTimelabel =[UILabel new];
    _outTimelabel.font=[UIFont systemFontOfSize:15];
    _outTimelabel.textColor=[UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    _outTimelabel.text=[_dataArray[section][@"startTime"]  substringToIndex:5];
    [view addSubview:_outTimelabel];
    [_outTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(31);
        make.height.offset(20);
        make.width.offset(48);
    }];
    UILabel *trainCodelabel=[UILabel new];
    trainCodelabel.adjustsFontSizeToFitWidth=YES;
    trainCodelabel.text=_dataArray[section][@"trainCode"];
    trainCodelabel.textAlignment=NSTextAlignmentCenter;
    trainCodelabel.font=[UIFont systemFontOfSize:12];
    trainCodelabel.textColor=[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];
    [view addSubview:trainCodelabel];
    [trainCodelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((deviceScreenWidth-222)/3+15+48);
        make.top.equalTo(view).offset(12);
        make.height.offset(14);
        make.width.offset(48);
    }];
    UIImageView * imageline = [UIImageView new];
    imageline.image= [UIImage imageNamed:@"11"];
    [view addSubview:imageline];
    [imageline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.top.equalTo(view).offset(55);
        make.height.offset(3);
        make.right.equalTo(view).offset(-15);
    }];
    UILabel  * runtimelabel =[UILabel new];
    runtimelabel.adjustsFontSizeToFitWidth=YES;
    runtimelabel.font=[UIFont systemFontOfSize:12];
    runtimelabel.textAlignment=NSTextAlignmentCenter;
     NSString *str3 = [_dataArray[section][@"runTime"] stringByReplacingOccurrencesOfString:@":" withString:@"时"];
    runtimelabel.text =[NSString stringWithFormat:@"%@分",str3];;
    runtimelabel.textColor=[UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1];
    [view addSubview:runtimelabel];
    [runtimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((deviceScreenWidth-222)/3+15+48);
        make.top.equalTo(view).offset(36);
        make.height.offset(14);
        make.width.offset(48);
    }];
    _arriveAirlabel=[UILabel new];
    _arriveAirlabel.text=_dataArray[section][@"toStationName"];
    _arriveAirlabel.font=[UIFont systemFontOfSize:14];
    _arriveAirlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    [view addSubview:_arriveAirlabel];
    [_arriveAirlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((2*(deviceScreenWidth-222)/3)+15+2*48);
        make.top.equalTo(view).offset(9);
        make.height.offset(18);
        make.width.offset(100);
    }];
    _pricelabel=[UILabel new];
    _pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_dataArray[section][@"minPrice"] floatValue]];
    _pricelabel.textColor=[UIColor colorWithRed:238/255.0 green:132/255.0 blue:43/255.0 alpha:1];
         _pricelabel.textAlignment=NSTextAlignmentRight;
    [view addSubview:_pricelabel];
    [_pricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view).offset(-13);
        make.top.equalTo(view).offset(10);
        make.height.offset(20);
        make.width.offset(100);
    }];
    _arriveTimelabel=[UILabel new];
    //截取字符串前五位
    _arriveTimelabel.text=[_dataArray[section][@"arriveTime"]  substringToIndex:5];
    _arriveTimelabel.font=[UIFont systemFontOfSize:14];
    _arriveTimelabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    [view addSubview:_arriveTimelabel];
    [_arriveTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((2*(deviceScreenWidth-222)/3)+15+2*48);
        make.top.equalTo(view).offset(31);
        make.height.offset(18);
        make.width.offset(44);
    }];
    UIImageView  * image1=[UIImageView new];

         if ([_dataArray[section][@"fromStationName"] isEqualToString:_dataArray[section][@"startStationName"]]) {
             if ([_dataArray[section][@"toStationName"] isEqualToString:_dataArray[section][@"endStationName"]]) {
                 image1.image=[UIImage imageNamed:@"1_1"];
             }else{
                 image1.image=[UIImage imageNamed:@"1_0"];
             }
         }else{
             if ([_dataArray[section][@"toStationName"] isEqualToString:_dataArray[section][@"endStationName"]]) {
                 image1.image=[UIImage imageNamed:@"0_1"];
             }else{
                 image1.image=[UIImage imageNamed:@"0_0"];
             }
         }
          [view addSubview:image1];
    [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((deviceScreenWidth-222)/3+15+46);
        make.height.offset(4);
        make.top.equalTo(view).offset(28);
        make.width.offset(52);
    }];
    //座位与票数
    UILabel * seatlabel = [UILabel new];
    seatlabel.adjustsFontSizeToFitWidth=YES;
    seatlabel.font=[UIFont systemFontOfSize:13];
    seatlabel.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    [view addSubview:seatlabel];
    [seatlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset((deviceScreenWidth-240)/4);
        make.bottom.equalTo(view).offset(-9);
        make.height.offset(14);
        make.width.offset(80);
    }];
    UILabel * seatlabel1 = [UILabel new];
    seatlabel1.adjustsFontSizeToFitWidth=YES;

    seatlabel1.font=[UIFont systemFontOfSize:13];
seatlabel1.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    [view addSubview:seatlabel1];
    [seatlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(2*((deviceScreenWidth-240)/4)+80);
        make.bottom.equalTo(view).offset(-9);
        make.height.offset(14);
        make.width.offset(80);
    }];
    UILabel * seatlabel2 = [UILabel new];
    seatlabel2.adjustsFontSizeToFitWidth=YES;
    seatlabel2.font=[UIFont systemFontOfSize:13];
    seatlabel2.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
    [view addSubview:seatlabel2];
    [seatlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(3*((deviceScreenWidth-240)/4)+2*80);
        make.bottom.equalTo(view).offset(-9);
        make.height.offset(14);
        make.width.offset(80);
    }];
         UIView * line = [UIView new];
         line.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1];
         [view addSubview:line];
         [line mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(view).offset(0);
             make.bottom.equalTo(view).offset(-1);
             make.height.offset(1);
             make.width.offset(deviceScreenWidth);
         }];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"GD"] isEqualToString:@"G,D"]||[_dataArray[section][@"trainType"]isEqualToString:@"G"]||[_dataArray[section][@"trainType"]isEqualToString:@"D"]){
        for (NSDictionary * dict in _dataArray[section][@"seatTypeList"]){
            if([dict[@"seatTypeName"] isEqualToString:@"二等座"]){
                if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                    seatlabel.text=[NSString stringWithFormat:@"二等座:%@",dict[@"count"]];
                }else{
                    if([dict[@"count"] isEqualToString:@"0"]){
                        seatlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                    }
                  seatlabel.text=[NSString stringWithFormat:@"二等座:%@张",dict[@"count"]];
                }
            }else if([dict[@"seatTypeName"] isEqualToString:@"一等座"]){
                if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                    seatlabel1.text=[NSString stringWithFormat:@"一等座:%@",dict[@"count"]];
                }else{
                    if([dict[@"count"] isEqualToString:@"0"]){
                        seatlabel1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                    }
                    seatlabel1.text=[NSString stringWithFormat:@"一等座:%@张",dict[@"count"]];
                }
                }else if([dict[@"seatTypeName"] isEqualToString:@"商务座"]||[dict[@"seatTypeName"] isEqualToString:@"特等座"]){
                    if([dict[@"seatTypeName"] isEqualToString:@"商务座"]){
                    if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                        seatlabel2.text=[NSString stringWithFormat:@"%@:%@",dict[@"seatTypeName"],dict[@"count"]];
                    }else{
                        if([dict[@"count"] isEqualToString:@"0"]){
                            seatlabel2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                        }
                        seatlabel2.text=[NSString stringWithFormat:@"%@:%@张",dict[@"seatTypeName"],dict[@"count"]];
                    }}else{
                        if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                            seatlabel2.text=[NSString stringWithFormat:@"%@:%@",dict[@"seatTypeName"],dict[@"count"]];
                        }else{
                            if([dict[@"count"] isEqualToString:@"0"]){
                                seatlabel2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                            }
                            seatlabel2.text=[NSString stringWithFormat:@"%@:%@张",dict[@"seatTypeName"],dict[@"count"]];
                        }
                    }
            }else{
                seatlabel.text=@"二等座:0张";
                seatlabel1.text=@"一等座:0张";
                seatlabel2.text=@"商务座:0张";
                seatlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                seatlabel1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                seatlabel2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
            }
        }
    }else{
        for (NSDictionary * dict in _dataArray[section][@"seatTypeList"]){
            if([dict[@"seatTypeName"] isEqualToString:@"硬座"]){
                if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                    seatlabel.text=[NSString stringWithFormat:@"硬座:%@",dict[@"count"]];
                }else{
                    if([dict[@"count"] isEqualToString:@"0"]){
                        seatlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                        seatlabel.text=[NSString stringWithFormat:@"硬座:%@张",dict[@"count"]];
                    }else{
                        seatlabel.text=[NSString stringWithFormat:@"硬座:%@张",dict[@"count"]];
 
                    }
                }
            }else if([dict[@"seatTypeName"] isEqualToString:@"硬卧"]){
                if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                    seatlabel1.text=[NSString stringWithFormat:@"硬卧:%@",dict[@"count"]];
                }else{
                    if([dict[@"count"] isEqualToString:@"0"]){
                        seatlabel1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                        seatlabel1.text=[NSString stringWithFormat:@"硬卧:%@张",dict[@"count"]];
                    }else{
                        seatlabel1.text=[NSString stringWithFormat:@"硬卧:%@张",dict[@"count"]];
                    }
                }
            }else if([dict[@"seatTypeName"] isEqualToString:@"软卧"]){
                if([dict[@"count"] isEqualToString:@"有"]||[dict[@"count"] isEqualToString:@"无"]){
                    seatlabel2.text=[NSString stringWithFormat:@"软卧:%@",dict[@"count"]];
                }else{
                    if([dict[@"count"] isEqualToString:@"0"]){
                        seatlabel2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                        seatlabel2.text=[NSString stringWithFormat:@"软卧:%@张",dict[@"count"]];

                    }else{
                        seatlabel2.text=[NSString stringWithFormat:@"软卧:%@张",dict[@"count"]];
                    }
                }
            }else{
//                seatlabel.text=@"硬座:0张";
//                seatlabel1.text=@"硬卧:0张";
//                seatlabel2.text=@"软卧:0张";
//                seatlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
//                seatlabel1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
//                seatlabel2.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                         }
        }
        
    }
         
         if (_Approval!=YES) {
             UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF3:)];
             [view addGestureRecognizer:tap3];
             view.tag=section+1;
         }
    [view0 addSubview:view];
    //头部试图下得展开视图
    view1 =[[UIView  alloc]initWithFrame:CGRectMake(0, 90, deviceScreenWidth, 44)];
    jtimagelogo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 12, 16, 16)];
    jtimagelogo.image=[UIImage imageNamed:@"infolo"];
    [view1 addSubview:jtimagelogo];
    view1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    jtmessagebut = [[UIButton alloc]initWithFrame:CGRectMake(36,12, 60, 16)];
    jtmessagebut.hidden=YES;
    jtmessagebut.titleLabel.font=[UIFont systemFontOfSize:14];
    [jtmessagebut setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
    [jtmessagebut setTitle:@"经停信息" forState:UIControlStateNormal];
    [view1 addSubview:jtmessagebut];
    UITapGestureRecognizer *tapp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFpp:)];
    [jtmessagebut addGestureRecognizer:tapp];
    jtimage = [[UIImageView alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-30, 0, 60, 8)];
    jtimage.image=[UIImage imageNamed:@"hide_flight"];
    [view1 addSubview:jtimage];
    [view0 addSubview:view1];
         
    if([_array[section] isEqualToString:@"0"]){
        view1.hidden=YES;
        jtmessagebut.hidden=YES;
        jtimage.hidden=YES;
        jtimagelogo.hidden=YES;
    }else{
        view1.hidden=NO;
        jtmessagebut.hidden=NO;
        jtimage.hidden=NO;
        jtimagelogo.hidden=NO;
    }
    return view0;
     }else if([tableView isEqual:_tableView3]){
         return 0;
     }else{
             UIView * jtview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 30)]];
         jtview.backgroundColor=[UIColor colorWithRed:13/255.0 green:70/255.0 blue:128/255.0 alpha:1];
         
         jtview.backgroundColor=[UIColor blackColor];
             UILabel * label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(42, 7, 28, 16)]];
             label1.adjustsFontSizeToFitWidth=YES;
             label1.textAlignment=NSTextAlignmentCenter;
             label1.text=@"站次";
             label1.textColor=[UIColor whiteColor];
             label1.font=[UIFont systemFontOfSize:14];
             [jtview addSubview:label1];
             UIView * view11=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(88, 0, 1, 30)]];
             view11.backgroundColor=[UIColor whiteColor];
             [jtview addSubview:view11];
             UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 7, 28, 16)]];
             label2.adjustsFontSizeToFitWidth=YES;
             label2.textAlignment=NSTextAlignmentCenter;
             label2.text=@"站点";
             label2.textColor=[UIColor whiteColor];
             label2.font=[UIFont systemFontOfSize:14];
             [jtview addSubview:label2];
             UIView * view2=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(154, 0, 1, 30)]];
             view2.backgroundColor=[UIColor whiteColor];
             [jtview addSubview:view2];
             
             UILabel * label3 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(160, 7, 56, 16)]];
             label3.adjustsFontSizeToFitWidth=YES;
             label3.textAlignment=NSTextAlignmentCenter;
             label3.text=@"到站时间";
             label3.textColor=[UIColor whiteColor];
             label3.font=[UIFont systemFontOfSize:14];
             [jtview addSubview:label3];
         
         UIView * view3=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(221, 0, 1, 30)]];
         view3.backgroundColor=[UIColor whiteColor];
         [jtview addSubview:view3];
         
         UILabel * label4 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(228, 7, 56, 16)]];
         label4.adjustsFontSizeToFitWidth=YES;
         label4.textAlignment=NSTextAlignmentCenter;
         label4.text=@"出发时间";
         label4.textColor=[UIColor whiteColor];
         label4.font=[UIFont systemFontOfSize:14];
         [jtview addSubview:label4];

             UIView * view4=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(288, 0, 1, 30)]];
             view4.backgroundColor=[UIColor whiteColor];
             [jtview addSubview:view4];
             
             UILabel * label5 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(295, 7, 56, 16)]];
             label5.adjustsFontSizeToFitWidth=YES;
             label5.textAlignment=NSTextAlignmentCenter;
             label5.text=@"停留时长";
             label5.textColor=[UIColor whiteColor];
             label5.font=[UIFont systemFontOfSize:14];
             [jtview addSubview:label5];
         
         UIView * vline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 29, 335, 1)]];
             vline.backgroundColor=[UIColor whiteColor];
             [jtview addSubview:vline];
         return jtview;
     }
}
#pragma mark -筛选视图按钮触发
-(void)Lbut:(UIButton*)but{
    switch (but.tag) {
        case 1001:{
            _sxdata=[NSMutableArray arrayWithArray:ccArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1002];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1003];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1004];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1005];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1006];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];
            break;
        }
        case 1002:{
            _sxdata=[NSMutableArray arrayWithArray:zxArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1001];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1003];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1004];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1005];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1006];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];
            break;}
        case 1003:{
            _sxdata=[NSMutableArray arrayWithArray:fcArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1001];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1002];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1004];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1005];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1006];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];

            break;}
        case 1004:{
            _sxdata=[NSMutableArray arrayWithArray:ddArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1001];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1003];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1002];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1005];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1006];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];
            break;
        }
        case 1005:{
            _sxdata=[NSMutableArray arrayWithArray:outArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1001];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1003];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1004];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1002];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1006];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];
            break;}
        case 1006:{
            _sxdata=[NSMutableArray arrayWithArray:toArraynum];
            UIButton * b1 =(UIButton*)[self.view viewWithTag:1001];
            b1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b2 =(UIButton*)[self.view viewWithTag:1003];
            b2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b3 =(UIButton*)[self.view viewWithTag:1004];
            b3.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b4 =(UIButton*)[self.view viewWithTag:1005];
            b4.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIButton * b5 =(UIButton*)[self.view viewWithTag:1002];
            b5.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            but.backgroundColor=[UIColor whiteColor];
            break;}
        default:
            break;
    }
    [_tableView3 reloadData];
}
-(void)okbut:(UIButton*)send{
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

    SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 340)];
//    if([[dict[@"departTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[ar[0] substringWithRange:NSMakeRange(7,2)] intValue])
    // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
  //数据源
    _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
    NSMutableArray *  arr = [NSMutableArray arrayWithArray:_dataArray];
    
    NSMutableArray *  arr1 = [NSMutableArray new];
    //车次
        for (NSDictionary * dict in ccArraynum) {
            if ([dict[@"num"] isEqualToString:@"1"]) {
                if ([dict[@"1"] isEqualToString:@"不限"]) {
                  arr1 = [NSMutableArray arrayWithArray:arr];
                    break;
                }else{
                for (int i=0; i<arr.count; i++) {
                    if ([arr[i][@"trainType"] isEqualToString:[dict[@"1"] substringWithRange:NSMakeRange(0,1)]]) {
                        [arr1 addObject:arr[i]];
                    }
                 }
               }
            }
        }
//   坐席
    NSMutableArray * arr2 = [NSMutableArray new];
    for (NSDictionary * dict in zxArraynum) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr2 = [NSMutableArray arrayWithArray:arr1];
                break;
            }else{
                for (int i=0; i<arr1.count; i++) {
                    NSMutableArray  * setarr = [NSMutableArray new];
                        setarr=arr1[i][@"seatTypeList"];
                    for (int j=0;j<setarr.count; j++) {
                        if ([setarr[j][@"seatTypeName"] isEqualToString:dict[@"1"]]){
                                [arr2 addObject:arr1[i]];
                        }
                    }
                }
            }
        }
    }
//   发车时间
    NSMutableArray * arr3 = [NSMutableArray new];
    for (NSDictionary * dict in fcArraynum) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr3 = [NSMutableArray arrayWithArray:arr2];
                break;
            }else{
                for (int i=0; i<arr2.count; i++) {
                    if ([[arr2[i][@"startTime"] substringWithRange:NSMakeRange(0,2)] intValue]>=[[dict[@"1"] substringWithRange:NSMakeRange(0,2)] intValue]) {
                        if (([[arr2[i][@"startTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])||(([[arr2[i][@"startTime"] substringWithRange:NSMakeRange(0,2)] intValue]==[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])&&([[arr2[i][@"startTime"] substringWithRange:NSMakeRange(3,2)] intValue]<=0))) {
                            [arr3 addObject:arr2[i]];
                        }
                    }
                }
            }
        }
    }
//到达时间
    NSMutableArray * arr4 = [NSMutableArray new];
    for (NSDictionary * dict in ddArraynum) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"1"] isEqualToString:@"不限"]) {
                arr4 = [NSMutableArray arrayWithArray:arr3];
                break;
            }else{
                for (int i=0; i<arr3.count; i++) {
                    if ([[arr3[i][@"arriveTime"] substringWithRange:NSMakeRange(0,2)] intValue]>=[[dict[@"1"] substringWithRange:NSMakeRange(0,2)] intValue]) {
                        if (([[arr3[i][@"arriveTime"] substringWithRange:NSMakeRange(0,2)] intValue]<[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])||(([[arr3[i][@"arriveTime"] substringWithRange:NSMakeRange(0,2)] intValue]==[[dict[@"1"] substringWithRange:NSMakeRange(7,2)] intValue])&&([[arr3[i][@"arriveTime"] substringWithRange:NSMakeRange(3,2)] intValue]<=0))) {
                            [arr4 addObject:arr3[i]];
                        }
                    }
                }
            }
        }
    }
  //出发站点
    NSMutableArray * arr5 = [NSMutableArray new];
    for (NSDictionary * dict in outArraynum) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"stationName"] isEqualToString:@"不限"]) {
                arr5 = [NSMutableArray arrayWithArray:arr4];
                break;
            }else{
                for (int i=0; i<arr4.count; i++) {
                    if ([arr4[i][@"fromStationName"] isEqualToString:dict[@"stationName"]]) {
                        [arr5 addObject:arr4[i]];
                    }
                   
                }
            }
        }
    }
  //到达站点
    NSMutableArray * arr6 = [NSMutableArray new];
    for (NSDictionary * dict in toArraynum) {
        if ([dict[@"num"] isEqualToString:@"1"]) {
            if ([dict[@"stationName"] isEqualToString:@"不限"]) {
                arr6 = [NSMutableArray arrayWithArray:arr5];
                break;
            }else{
                for (int i=0; i<arr5.count; i++) {
                    if ([arr5[i][@"toStationName"] isEqualToString:dict[@"stationName"]]) {
                        [arr6 addObject:arr5[i]];
                    }
                    
                }
            }
        }
    }

    if (arr6.count==0) {
        _dataArray=[NSMutableArray arrayWithArray:_dataArray1];
        [_tableView reloadData];
        [UIAlertView showAlertWithTitle:@"未筛选出符合条件的车次,请重新筛选。"];
    }else{
        _dataArray=[NSMutableArray arrayWithArray:arr6];
        [_tableView reloadData];
    }
}
-(void)cancelbut:(UIButton*)send{
    SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE1, 375, 340)];
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    _dataArray =[ NSMutableArray arrayWithArray:_dataArray1];
    [_tableView reloadData];
}
-(void)clearbut:(UIButton*)send{
    
    _dataArray =[ NSMutableArray arrayWithArray:_dataArray1];
   
    for (int i=0;i<ccArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            ccArraynum[i][@"num"]=@"1";
        }else{
            ccArraynum[i][@"num"]=@"0";
        }
    }
    for (int i=0;i<zxArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            zxArraynum[i][@"num"]=@"1";
        }else{
            zxArraynum[i][@"num"]=@"0";
        }
    }
    for (int i=0;i<fcArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            fcArraynum[i][@"num"]=@"1";
        }else{
            fcArraynum[i][@"num"]=@"0";
        }
    }
    for (int i=0;i<ddArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            ddArraynum[i][@"num"]=@"1";
        }else{
            ddArraynum[i][@"num"]=@"0";
        }
    }
    
    for (int i=0;i<outArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            outArraynum[i][@"num"]=@"1";
        }else{
            outArraynum[i][@"num"]=@"0";
        }
    }
    for (int i=0;i<toArraynum.count;i++) {
        if (i==0) {
            //如果不是 改成1
            toArraynum[i][@"num"]=@"1";
        }else{
            toArraynum[i][@"num"]=@"0";
        }
    }
    [_tableView reloadData];
    [_tableView3 reloadData];
}

-(void)showGFpp:(UITapGestureRecognizer *)tapp{
    [UIView animateWithDuration:0.2 animations:^{
        _JTconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    _SXconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

    [UIView animateWithDuration:0.2 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}

-(void)showGFtab:(UITapGestureRecognizer *)tab{
    
    [UIView animateWithDuration:0.2 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
}
-(void)showGF3:( UITapGestureRecognizer *)tap{
    //判断 如果是1 改成0
    if ([_array[tap.view.tag - 1] isEqualToString:@"1"]) {
        [_array replaceObjectAtIndex:tap.view.tag - 1 withObject:@"0"];
    }else{
        for (int i=0;i<_array.count;i++) {
            [_array replaceObjectAtIndex:i withObject:@"0"];
        }
        //如果不是 改成1
        [_array replaceObjectAtIndex:tap.view.tag - 1 withObject:@"1"];
    }
    _seatArray=_dataArray[tap.view.tag - 1][@"seatTypeList"];
    _array1=[NSMutableArray new];
    for (NSDictionary *dic in _seatArray) {
        [_array1 addObject:@"0"];
    }
    [_tableView reloadData];
    
    [_tableView setContentOffset:CGPointMake(0,(tap.view.tag - 1)*90) animated:YES];

    PassStationQuery *  psq  =[PassStationQuery new];
    psq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    psq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    psq.FromStationCode=_requtstdict[@"outcity"];
    psq.ToStationCode=_requtstdict[@"backcity"];
    psq.StartTime=_requtstdict[@"dataOut"];
    psq.TrainCode=_dataArray[tap.view.tag - 1][@"trainCode"];
    psq.TrainNo=_dataArray[tap.view.tag - 1][@"trainNo"];

    [Train PassStationQuery:psq success:^(id data) {
        StopOverarr=[NSMutableArray new];
//NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            for (NSMutableDictionary * dic in data[@"passStationList"] ) {
                Tjtmodel * model =[[Tjtmodel alloc] init];
                [model setValuesForKeysWithDictionary:dic];
                [StopOverarr addObject:model];
            }
            [_tableView1 reloadData];
                    }
    } failure:^(NSError *error) {
    }];
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 if([tableView isEqual:_tableView]){
    if ([_array1[indexPath.row] isEqualToString:@"0"]) {
        return 80;

    }else{
        return 221;
    }
 }else if ([tableView isEqual:_tableView3]){
     return 40/SCREEN_RATE;
 }
 else{
    return 30/SCREEN_RATE;
 }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return _dataArray.count;
    }else if ([tableView isEqual:_tableView3]){
        return 1;
    }
    else{
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
    return _seatArray.count;
 }else if([tableView isEqual:_tableView3]){
     return _sxdata.count;
 }else{
     return StopOverarr.count;
 }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if([tableView isEqual:_tableView]){
    train1Cell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    // cell的复用
    if (!cell) {
        cell= (train1Cell*)[[[NSBundle  mainBundle]  loadNibNamed:@"train1Cell" owner:self options:nil]  lastObject];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.delegate=self;
    cell.seatlabel.text=_seatArray[indexPath.row][@"seatTypeName"];
    cell.seatlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    cell.countlabel.textColor=[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TYw"] isEqualToString: @"1"]) {
            if([_seatArray[indexPath.row][@"fss"] count]==0){
                
                // [[NSUserDefaults standardUserDefaults]setObject:@"hg" forKey:@"twh"];
                cell.gzlabel.text=@"合规";
            }else{
                // [[NSUserDefaults standardUserDefaults]setObject:@"wg" forKey:@"twh"];
                cell.gzlabel.text=@"违规";
            }
            
            if([cell.gzlabel.text isEqualToString:@"违规"]){
                cell.gzlabel.textColor=[UIColor redColor];
            }
        }else{
            cell.gzlabel.hidden=YES;
  
        }
        }else{
        cell.gzlabel.hidden=YES;
    }
    if ([_array1[indexPath.row] isEqualToString:@"1"]){
        [cell.bookbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.bookbutton.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        [cell.bookbutton setTitle:@"收起" forState:UIControlStateNormal];
    }else{
        [cell.bookbutton setTitle:@"预订" forState:UIControlStateNormal];
        [cell.bookbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.bookbutton.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    }
    if([_seatArray[indexPath.row][@"count"] isEqualToString:@"有"]){
                cell.countlabel.text=[NSString stringWithFormat:@"%@",_seatArray[indexPath.row][@"count"]];
    }else if([_seatArray[indexPath.row][@"count"] isEqualToString:@"无"]){
            cell.countlabel.text=@"无票";
    }else{
           NSInteger  count =[_seatArray[indexPath.row][@"count"] integerValue];
               if(count!=0){
                    cell.countlabel.text=[NSString stringWithFormat:@"%@张",_seatArray[indexPath.row][@"count"]];
                          }else{
                    cell.countlabel.text=@"无票";
                }
            }
            if([cell.countlabel.text isEqualToString:@"无票"]){
                cell.bookbutton.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
               cell.bookbutton.userInteractionEnabled=NO;
            }
    cell.pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_seatArray[indexPath.row][@"price"] floatValue]];
    cell.pricelabel.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
    if([_array1[indexPath.row] isEqualToString:@"0"]){
        cell.view1.hidden=YES;
        cell.view2.hidden=YES;
        cell.label123.hidden=YES;
        cell.label12306.hidden=YES;
        cell.yybut.hidden=YES;
        cell.book123.hidden=YES;
        cell.yyimage.hidden=YES;
        cell.yylabel.hidden=YES;
        cell.yylabel2.hidden=YES;
        cell.image06.hidden=YES;
        cell.viewline.hidden=YES;
    }else{
        cell.book123.backgroundColor=[UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
        [cell.book123 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cell.yybut.backgroundColor=[UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
        [cell.yybut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
      return cell;
  }else if([tableView isEqual:_tableView3]){
      sxtablecell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
      // cell的复用
      if (!cell) {
          cell = [[sxtablecell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
      }
      if ([[_sxdata[indexPath.row] allKeys] containsObject:@"1"]) {
          cell.strlabel.text=_sxdata[indexPath.row][@"1"];
      }else{
          cell.strlabel.text=_sxdata[indexPath.row][@"stationName"];
      }
     
      if([_sxdata[indexPath.row][@"num"] isEqualToString:@"1"]){
          cell.strlabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
      }else{
          cell.strlabel.textColor=[UIColor blackColor];
      }
           return cell;

  }else{
      TJTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
      if (!cell) {
          cell = [[TJTCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
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
{   //获取cell的方法
   // UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
     if([tableView isEqual:_tableView3]){
         sxtablecell * cell  = (sxtablecell*)[tableView cellForRowAtIndexPath:indexPath];
        
         NSMutableArray *  arr = [NSMutableArray arrayWithArray:_sxdata];
         NSMutableArray *  arr1 = [NSMutableArray new];
         
         for (NSDictionary * dict  in arr) {
             NSMutableDictionary * d = [NSMutableDictionary dictionaryWithDictionary:dict];
             [arr1 addObject:d];
         }
         _sxdata=[NSMutableArray arrayWithArray:arr1];
         NSLog(@"%@",_sxdata);
         if ([_sxdata[1][@"type"] isEqualToString:@"1"]) {
             if(indexPath.row!=0){
                 int count=0;
                 if ([ccArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     ccArraynum[indexPath.row][@"num"]=@"0";
                     
                     for (int i=0;i<ccArraynum.count;i++) {
                         if ([ccArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     
                     if (count==0) {
                         for (int i=0;i<ccArraynum.count;i++) {
                             ccArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         ccArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     ccArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     ccArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<ccArraynum.count;i++) {
                     ccArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 ccArraynum[indexPath.row][@"num"]=@"1";;
             }
              _sxdata=[NSMutableArray arrayWithArray:ccArraynum];
              [_tableView3 reloadData];
         }else if ([_sxdata[1][@"type"] isEqualToString:@"2"]){
             if(indexPath.row!=0){
                 int count =0;
                 if ([zxArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     zxArraynum[indexPath.row][@"num"]=@"0";
                     for (int i=0;i<zxArraynum.count;i++) {
                         if ([zxArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     if (count==0) {
                         for (int i=0;i<zxArraynum.count;i++) {
                             zxArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         zxArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     zxArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     zxArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<zxArraynum.count;i++) {
                     zxArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 zxArraynum[indexPath.row][@"num"]=@"1";;
             }
             _sxdata=[NSMutableArray arrayWithArray:zxArraynum];
             [_tableView3 reloadData];
         }else if ([_sxdata[1][@"type"] isEqualToString:@"3"]){
             if(indexPath.row!=0){
                 int count=0;
                 if ([fcArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     fcArraynum[indexPath.row][@"num"]=@"0";
                     for (int i=0;i<fcArraynum.count;i++) {
                         if ([fcArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     if (count==0) {
                         for (int i=0;i<fcArraynum.count;i++) {
                             fcArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         fcArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     fcArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     fcArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<fcArraynum.count;i++) {
                     fcArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 fcArraynum[indexPath.row][@"num"]=@"1";;
             }
             _sxdata=[NSMutableArray arrayWithArray:fcArraynum];
             [_tableView3 reloadData];
         }else if ([_sxdata[1][@"type"] isEqualToString:@"4"]){
             if(indexPath.row!=0){
                 int  count=0;
                 if ([ddArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     ddArraynum[indexPath.row][@"num"]=@"0";
                     for (int i=0;i<ddArraynum.count;i++) {
                         if ([ddArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     if (count==0) {
                         for (int i=0;i<ddArraynum.count;i++) {
                             ddArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         ddArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     ddArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     ddArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<ddArraynum.count;i++) {
                     ddArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 ddArraynum[indexPath.row][@"num"]=@"1";;
             }
             _sxdata=[NSMutableArray arrayWithArray:ddArraynum];
             [_tableView3 reloadData];
         }else if ([_sxdata[1][@"type"] isEqualToString:@"5"]){
             if(indexPath.row!=0){
                 int count=0;
                 if ([outArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     outArraynum[indexPath.row][@"num"]=@"0";
                     for (int i=0;i<outArraynum.count;i++) {
                         if ([outArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     if (count==0) {
                         for (int i=0;i<outArraynum.count;i++) {
                             outArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         outArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     outArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     outArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<outArraynum.count;i++) {
                     outArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 outArraynum[indexPath.row][@"num"]=@"1";;
             }
             _sxdata=[NSMutableArray arrayWithArray:outArraynum];
             [_tableView3 reloadData];
         }else if ([_sxdata[1][@"type"] isEqualToString:@"6"]){
             if(indexPath.row!=0){
                 int count=0;
                 if ([toArraynum[indexPath.row][@"num"] isEqualToString:@"1"]) {
                     toArraynum[indexPath.row][@"num"]=@"0";
                     for (int i=0;i<toArraynum.count;i++) {
                         if ([toArraynum[i][@"num"] isEqualToString:@"1"]) {
                             count=count+1;
                         }
                     }
                     if (count==0) {
                         for (int i=0;i<toArraynum.count;i++) {
                             toArraynum[i][@"num"]=@"0";
                         }
                         //如果不是 改成1
                         toArraynum[0][@"num"]=@"1";
                     }
                 }else{
                     toArraynum[0][@"num"]=@"0";
                     //如果不是 改成1
                     toArraynum[indexPath.row][@"num"]=@"1";
                 }
             }else{
                 for (int i=0;i<toArraynum.count;i++) {
                     toArraynum[i][@"num"]=@"0";
                 }
                 //如果不是 改成1
                 toArraynum[indexPath.row][@"num"]=@"1";;
             }
             _sxdata=[NSMutableArray arrayWithArray:toArraynum];
             [_tableView3 reloadData];
         }else{
         }
     }
}
#pragma mark - 创建初始化视图
-(void)initview{
    _array = [[NSMutableArray alloc] init];
    _array1 = [[NSMutableArray alloc] init];

    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    toulabel= [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    toulabel.adjustsFontSizeToFitWidth=YES;

    _outstr=_requtstdict[@"outcity"];
    _backstr=_requtstdict[@"backcity"];
    
    if (_Approval==YES) {
        _datestr=_TdataDict[@"departureDate"];

        toulabel.text=[NSString stringWithFormat:@"%@-%@",_TdataDict[@"fromStationName"],_TdataDict[@"toStationName"]];
    }else{
        _datestr=_requtstdict[@"dataOut"];

     toulabel.text=[NSString stringWithFormat:@"%@-%@",_requtstdict[@"outcityname"],_requtstdict[@"backcityname"]];
    }
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
    //NSLog(@"%@***%@",_datestr,dateString);
    
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
    
//    _datestr=_requtstdict[@"dataOut"];
        if([_datestr isEqualToString:dateString]){
            butleft.userInteractionEnabled=NO;
        }else{
            butleft.userInteractionEnabled=YES;
        }
    [_databut setTitle:_datestr forState: UIControlStateNormal];
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
    UIView * footview =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-50, deviceScreenWidth, 50)];
    footview.backgroundColor=[UIColor colorWithRed:48/255.0 green:61/255.0 blue:79/255.0 alpha:1];
    [self.view addSubview:footview];
    UIButton * pricebut = [UIButton new];
    pricebut.tag =444;
    [pricebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:pricebut];
    [pricebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset((deviceScreenWidth-192)/5);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(48);
    }];
    priceim = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, 20, 20)];
    priceim.image= [UIImage imageNamed:@"price_on"];
    [pricebut addSubview:priceim];
    SXpricelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 48, 14)];
    SXpricelabel.text=@"从低到高";
    SXpricelabel.textAlignment=NSTextAlignmentCenter;
    SXpricelabel.font= [UIFont systemFontOfSize:11];
    SXpricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
    [pricebut addSubview:SXpricelabel];
    UIButton * timebut = [UIButton new];
    timebut.tag =445;
    [timebut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:timebut];
    [timebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(2*((deviceScreenWidth-192)/5)+48);
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
   
    UIButton * hsbut = [UIButton new];
    hsbut.tag =446;
    [hsbut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:hsbut];
    [hsbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(3*((deviceScreenWidth-192)/5)+2*48);
        make.top.equalTo(footview).offset(9);
        make.height.offset(35);
        make.width.offset(48);
    }];
    hsiamge = [[UIImageView alloc]initWithFrame:CGRectMake(14,0, 20, 20)];
    hsiamge.image= [UIImage imageNamed:@"filter_off"];
    [hsbut addSubview:hsiamge];
    hslabel = [[UILabel alloc]initWithFrame:CGRectMake(0,21, 48, 14)];
    hslabel.text=@"耗时";
    hslabel.textAlignment=NSTextAlignmentCenter;
    hslabel.font =[UIFont systemFontOfSize:11];
    hslabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [hsbut addSubview:hslabel];
   
    UIButton * sxbut = [UIButton new];
    sxbut.tag =447;
    [sxbut addTarget:self action:@selector(footclick:) forControlEvents:UIControlEventTouchUpInside];
    [footview addSubview:sxbut];
    [sxbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footview).offset(4*((deviceScreenWidth-192)/5)+3*48);
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
       sxlabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [sxbut addSubview:sxlabel];
}
-(void)footclick:(UIButton*)send{
    switch (send.tag) {
        case 444:{
              priceim.image= [UIImage imageNamed:@"price_on"];
              SXpricelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            if ([SXpricelabel.text isEqualToString:@"价格"]) {
                SXpricelabel.text=@"从低到高";
                _dataArray=[NSMutableArray arrayWithArray:pricearr];
            }else if([SXpricelabel.text isEqualToString:@"从低到高"]){
                _dataArray=[NSMutableArray arrayWithArray:pricearr1];
                SXpricelabel.text=@"从高到低";
            }else{
                _dataArray=[NSMutableArray arrayWithArray:pricearr];
                SXpricelabel.text=@"从低到高";
            }
            [_tableView reloadData];
            timeiamge.image= [UIImage imageNamed:@"time_off"];
            timelabel.text=@"时间";
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            hsiamge.image= [UIImage imageNamed:@"filter_off"];
            hslabel.text=@"耗时";
            hslabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            break;
        }
        case 446:
        {
            hsiamge.image= [UIImage imageNamed:@"filter_on"];
            hslabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            if ([ hslabel.text isEqualToString:@"耗时"]) {
                hslabel.text=@"从短到长";
                _dataArray=[NSMutableArray arrayWithArray:runtime];
            }else if([hslabel.text isEqualToString:@"从短到长"]){
                _dataArray=[NSMutableArray arrayWithArray:runtime1];
                hslabel.text=@"从长到短";
            }else{
                _dataArray=[NSMutableArray arrayWithArray:runtime];
                hslabel.text=@"从短到长";
            }
            [_tableView reloadData];
            timeiamge.image= [UIImage imageNamed:@"time_off"];
            timelabel.text=@"时间";
            timelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"price_off"];
            SXpricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            SXpricelabel.text=@"价格";
            break;
        }
        case 445:
        {
            timeiamge.image= [UIImage imageNamed:@"time_on"];
            timelabel.textColor=[UIColor colorWithRed:29/255.0 green:162/255.0 blue:214/255.0 alpha:1];
            if ([ timelabel.text isEqualToString:@"时间"]) {
                timelabel.text=@"从早到晚";
                _dataArray=[NSMutableArray arrayWithArray:timearr];
            }else if([timelabel.text isEqualToString:@"从早到晚"]){
                _dataArray=[NSMutableArray arrayWithArray:timearr1];
                timelabel.text=@"从晚到早";
            }else{
                _dataArray=[NSMutableArray arrayWithArray:timearr];
                timelabel.text=@"从早到晚";
            }
            [_tableView reloadData];
            hsiamge.image= [UIImage imageNamed:@"filter_off"];
            hslabel.text=@"耗时";
            hslabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            priceim.image= [UIImage imageNamed:@"price_off"];
            SXpricelabel.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            SXpricelabel.text=@"价格";
            break;
        }
        case 447:
            _SXconnetview.frame=CGRectMake(0, 0, 375/SCREEN_RATE, deviceScreenHeight-345/SCREEN_RATE1);

            SXview.frame=[framsizeclass newSuitFrame:CGRectMake(0, deviceScreenHeight*SCREEN_RATE-345, 375, 345)];
            break;
        default:
            break;
    }
    
}
-(void)loadtada{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainQuery * tquery =[TrainQuery new];
    tquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tquery.FromStation=_requtstdict[@"outcity"];
    tquery.ToStation=_requtstdict[@"backcity"];
    tquery.OrderBy=@"2";
    tquery.AscOrDesc=@"1";
    tquery.TrainDate=_requtstdict[@"dataOut"];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
        tquery.Cllx=@"1";
        tquery.TravelPersonId =@"1";
    }else{
        tquery.Cllx=@"2";
        
    }
    tquery.CheciType=[[NSUserDefaults standardUserDefaults] objectForKey:@"GD"];
    
    [Train TrainQuery:tquery success:^(id data) {
        _array = [[NSMutableArray alloc] init];

        //NSLog(@"%@",data);
        [SVProgressHUD dismiss];
        if([data[@"status"] isEqualToString:@"T"]){
                        _dataArray=data[@"trainDataList"];
            _dataArray1=data[@"trainDataList"];
            
            if (_dataArray1.count==0) {
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
            }else{
                for (NSDictionary * dic in _dataArray) {
                    [_array addObject:@"0"];
                    NSLog(@"%@",dic[@"minPrice"]);
                }
                [_tableView reloadData];
            }
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
        }
        
        
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
        
        NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
        
        NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:YES];
        
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
        NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
        
        pricearr= [_dataArray sortedArrayUsingDescriptors:descriptors1];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        runtime = [_dataArray sortedArrayUsingDescriptors:descriptors2];
        
        NSSortDescriptor *TimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
        
        NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:NO];
        
        NSArray *descriptors01 = [NSArray arrayWithObjects:TimesortDescriptor1,nil];
        NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        NSArray *descriptors21 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
        
        pricearr1= [_dataArray sortedArrayUsingDescriptors:descriptors11];
        timearr1  =  [_dataArray sortedArrayUsingDescriptors:descriptors01];
        runtime1= [_dataArray sortedArrayUsingDescriptors:descriptors21];
    } failure:^(NSError *error) {
        //@"seatTypeList":@"4 elements"
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
#pragma mark -审批查询
-(void)loadtadaApproval{
    NSLog(@"%@",_TdataDict);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainQuery * tquery =[TrainQuery new];
    tquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tquery.FromStation=_TdataDict[@"fromStation"];
    tquery.ToStation=_TdataDict[@"toStation"];
    tquery.OrderBy=@"2";
    tquery.AscOrDesc=@"1";
    tquery.TrainDate=_TdataDict[@"departureDate"];
    
    if([_TdataDict[@"tripType"] isEqualToString:@"1"]){
        tquery.Cllx=@"1";
        tquery.TravelPersonId =@"1";
    }else{
        tquery.Cllx=@"2";
    }
  tquery.CheciType=@"";
   [Train TrainQuery:tquery success:^(id data) {
    NSLog(@"%@",data);
         [SVProgressHUD dismiss];
       if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"trainDataList"];
           _dataArray1=data[@"trainDataList"];
        for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
            NSLog(@"%@",dic[@"minPrice"]);
        }
                [_tableView reloadData];
       }
       NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
       
       NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
      
       NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:YES];
       
       NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
       NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
       NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
       pricearr= [_dataArray sortedArrayUsingDescriptors:descriptors1];
       timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
       runtime = [_dataArray sortedArrayUsingDescriptors:descriptors2];
       
       NSSortDescriptor *TimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO];
       
       NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
       
       NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:NO];
       
       NSArray *descriptors01 = [NSArray arrayWithObjects:TimesortDescriptor1,nil];
       NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
       NSArray *descriptors21 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
       pricearr1= [_dataArray sortedArrayUsingDescriptors:descriptors11];
       timearr1  =  [_dataArray sortedArrayUsingDescriptors:descriptors01];
       runtime1= [_dataArray sortedArrayUsingDescriptors:descriptors21];
       }
   
   failure:^(NSError *error) {
       //@"seatTypeList":@"4 elements"
       [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
   }];
}
-(void)Tsecondreq2:(NSString*)string{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    [_databut setTitle:string forState: UIControlStateNormal];
    TrainQuery * tquery =[TrainQuery new];
    tquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tquery.FromStation=_TdataDict[@"fromStation"];
    tquery.ToStation=_TdataDict[@"toStation"];
    tquery.OrderBy=@"2";
    tquery.AscOrDesc=@"1";
    tquery.TrainDate=string;
    
    if([_TdataDict[@"tripType"] isEqualToString:@"1"]){
        tquery.Cllx=@"1";
         tquery.TravelPersonId =@"1";
    }else{
        tquery.Cllx=@"2";
    }
    tquery.CheciType=@"";
    _array = [[NSMutableArray alloc] init];

    [Train TrainQuery:tquery success:^(id data) {
        
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"trainDataList"];
            _dataArray1=data[@"trainDataList"];
            for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
//                NSLog(@"%@",dic[@"minPrice"]);
            }
            [_tableView reloadData];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
        
        NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
        
        NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:YES];
        
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
        
        NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
        pricearr= [_dataArray sortedArrayUsingDescriptors:descriptors1];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        runtime = [_dataArray sortedArrayUsingDescriptors:descriptors2];
        
        NSSortDescriptor *TimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
        
        NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:NO];
        
        NSArray *descriptors01 = [NSArray arrayWithObjects:TimesortDescriptor1,nil];
        NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        NSArray *descriptors21 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
        
        pricearr1= [_dataArray sortedArrayUsingDescriptors:descriptors11];
        timearr1  =  [_dataArray sortedArrayUsingDescriptors:descriptors01];
        runtime1= [_dataArray sortedArrayUsingDescriptors:descriptors21];
        
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
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
//        //        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        //        _aView1.dataOutlabel.text = date;
//        //        _aView1.weekOutlabel.text=[weekday weekdaywith:paramas];
//        [ _databut setTitle:[NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2] forState:UIControlStateNormal];
//        if (_Approval==YES) {
//            [self Tsecondreq2:_databut.titleLabel.text];
//
//        }else{
//            [self Tsecondreq:_databut.titleLabel.text];
//        }
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrback=@"back";
    cdc.outdate=@"";
    cdc.type=@"flight";
    cdc.block=^(NSMutableDictionary*dict){
        NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
//        NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
        [ _databut setTitle:dict[@"back"] forState:UIControlStateNormal];
        if (_Approval==YES) {
            [self Tsecondreq2:_databut.titleLabel.text];
        }else{
            [self Tsecondreq:_databut.titleLabel.text];
        }
    };
    [self presentViewController:cdc animated:NO completion:nil];
    
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
            if (_Approval==YES) {
                [self Tsecondreq2:result];
            }else{
                [self Tsecondreq:result];
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
            
            _datestr=result1;
            if([_datestr isEqualToString:dateString]){
                butleft.userInteractionEnabled=NO;
            }else{
                butleft.userInteractionEnabled=YES;
            }
            if (_Approval==YES) {
                [self Tsecondreq2:result1];
            }else{
                [self Tsecondreq:result1];
            }
            break;
        default:
            break;
    }
}
-(void)Tsecondreq:(NSString*)string{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    [_databut setTitle:string forState: UIControlStateNormal];
    
    TrainQuery * tquery =[TrainQuery new];
    tquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tquery.FromStation=_requtstdict[@"outcity"];
    tquery.ToStation=_requtstdict[@"backcity"];
    tquery.OrderBy=@"2";
    tquery.AscOrDesc=@"1";
    tquery.TrainDate=string;
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
        tquery.Cllx=@"1";
         tquery.TravelPersonId =@"1";
    }else{
        tquery.Cllx=@"2";
    }
    tquery.CheciType=[[NSUserDefaults standardUserDefaults] objectForKey:@"GD"];
    _array = [[NSMutableArray alloc] init];

    [Train TrainQuery:tquery success:^(id data) {
      [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"trainDataList"];
            _dataArray1=data[@"trainDataList"];
            for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
                NSLog(@"%@",dic[@"minPrice"]);
            }
            [_tableView reloadData];
        }
        NSSortDescriptor *TimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:YES];
        
        NSSortDescriptor *PricesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:YES];
        
        NSSortDescriptor *runtimesortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:YES];
        
        NSArray *descriptors = [NSArray arrayWithObjects:TimesortDescriptor,nil];
        NSArray *descriptors1 = [NSArray arrayWithObjects:PricesortDescriptor,nil];
        
        NSArray *descriptors2 = [NSArray arrayWithObjects:runtimesortDescriptor,nil];
        pricearr= [_dataArray sortedArrayUsingDescriptors:descriptors1];
        timearr  =  [_dataArray sortedArrayUsingDescriptors:descriptors];
        runtime = [_dataArray sortedArrayUsingDescriptors:descriptors2];
        
        
        NSSortDescriptor *TimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"startTime" ascending:NO];
        
        NSSortDescriptor *PricesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"minPrice" ascending:NO];
        
        NSSortDescriptor *runtimesortDescriptor1 = [[NSSortDescriptor alloc] initWithKey:@"runTimeMinute" ascending:NO];
        
        NSArray *descriptors01 = [NSArray arrayWithObjects:TimesortDescriptor1,nil];
        NSArray *descriptors11 = [NSArray arrayWithObjects:PricesortDescriptor1,nil];
        NSArray *descriptors21 = [NSArray arrayWithObjects:runtimesortDescriptor1,nil];
        
        pricearr1= [_dataArray sortedArrayUsingDescriptors:descriptors11];
        timearr1  =  [_dataArray sortedArrayUsingDescriptors:descriptors01];
        runtime1= [_dataArray sortedArrayUsingDescriptors:descriptors21];
        
    } failure:^(NSError *error) {
    }];
}
-(void)bookbuttonClick:(train1Cell *)cell{
    NSIndexPath *indexPath = [_tableView indexPathForCell:cell];
    //判断是不是1
    //如果是 改成0
    if ([_array1[indexPath.row] isEqualToString:@"1"]) {
        [_array1 replaceObjectAtIndex:indexPath.row withObject:@"0"];
    }else{
        for (int i=0;i<_array1.count;i++) {
            [_array1 replaceObjectAtIndex:i withObject:@"0"];
        }
    //如果不是 改成1
        [_array1   replaceObjectAtIndex:indexPath.row withObject:@"1"];
    }
    [_tableView reloadData];
}
-(void)book123Click:(train1Cell *)cell{
    
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];

    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
        if(!([_seatArray[indexPath.row][@"count"] isEqualToString:@"有"]||[_seatArray[indexPath.row][@"count"] isEqualToString:@"无"])){
            NSInteger  count =[_seatArray[indexPath.row][@"count"] integerValue];
            if(_menarray.count>count){
                [UIAlertView showAlertWithTitle:@"乘车人数多于剩余票数，请重新预定"];
            }else{
                if([cell.gzlabel.text isEqualToString:@"违规"]){
                    NSString *title = @"提示";
                    NSString *title1 = @"取消";
                    NSString *okButtonTitle = @"确认预订";
                    NSString *message=@"";
                    if([cell.gzlabel.text isEqualToString:@"违规"]){
                        message = [NSString stringWithFormat:@"本车次%@违背了差旅标准：\n%@",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                        [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        }]];
                        [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                            login06VC * trainrulevc = [login06VC new];
                            trainrulevc.erromes=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"];
                            trainrulevc.erro=[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                            trainrulevc.style=@"train";
                            trainrulevc.trainDatadict=_dataArray[indexPath.section];
                            trainrulevc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                            trainrulevc.requtstdict=_requtstdict;
                            trainrulevc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                            trainrulevc.StopOverarr=StopOverarr;
                            trainrulevc.gxlabeltext= cell.gzlabel.text;
                            
                            [self.navigationController pushViewController:trainrulevc animated:NO];
//                            [self presentViewController:trainrulevc animated:NO completion:nil];
                        }]];
                        [self presentViewController:alertController animated:YES completion:nil];
                    }
                }else{
                    login06VC*tvc = [login06VC new];
                    tvc.trainDatadict=_dataArray[indexPath.section];
                    tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                    tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                    tvc.StopOverarr=StopOverarr;
                    tvc.requtstdict=_requtstdict;
                    tvc.gxlabeltext= cell.gzlabel.text;
                     [self.navigationController pushViewController:tvc animated:NO];
//                    [self presentViewController:tvc animated:NO completion:nil];
                }
            }
        }else{
            if([cell.gzlabel.text isEqualToString:@"违规"]){
                NSString *title = @"提示";
                NSString *title1 = @"取消";
                NSString *okButtonTitle = @"确认预订";
                NSString *message=@"";
                if([cell.gzlabel.text isEqualToString:@"违规"]){
                    message = [NSString stringWithFormat:@"本车次%@违背了差旅标准：\n%@",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        login06VC * trainrulevc = [login06VC new];
                        trainrulevc.erromes=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"];
                        trainrulevc.erro=[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                        trainrulevc.style=@"train";
                        trainrulevc.trainDatadict=_dataArray[indexPath.section];
                        trainrulevc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                        trainrulevc.requtstdict=_requtstdict;
                        trainrulevc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                        trainrulevc.StopOverarr=StopOverarr;
                        trainrulevc.gxlabeltext= cell.gzlabel.text;
                        [self.navigationController  pushViewController:trainrulevc animated:YES];
//                        [self presentViewController:trainrulevc animated:NO completion:nil];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }else{
                login06VC*tvc = [login06VC new];
                tvc.trainDatadict=_dataArray[indexPath.section];
                tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                tvc.StopOverarr=StopOverarr;
                tvc.requtstdict=_requtstdict;
                tvc.gxlabeltext= cell.gzlabel.text;
                [self.navigationController  pushViewController:tvc animated:YES];
//                [self presentViewController:tvc animated:NO completion:nil];
            }
        }
    }else{
        login06VC*tvc = [login06VC new];
        tvc.trainDatadict=_dataArray[indexPath.section];
        tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
        tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
        tvc.StopOverarr=StopOverarr;
        tvc.requtstdict=_requtstdict;
        NSLog(@"%@",_requtstdict);
        [self.navigationController  pushViewController:tvc animated:YES];

//        [self presentViewController:tvc animated:NO completion:nil];
    }
    //login06VC*logo = [login06VC new];
   // [self presentViewController:logo animated:NO completion:nil];
}
-(void)yybutClick:(train1Cell *)cell{
    
    NSIndexPath * indexPath = [_tableView indexPathForCell:cell];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
       if(!([_seatArray[indexPath.row][@"count"] isEqualToString:@"有"]||[_seatArray[indexPath.row][@"count"] isEqualToString:@"无"])){
        NSInteger  count =[_seatArray[indexPath.row][@"count"] integerValue];
           if(_menarray.count>count){
               [UIAlertView showAlertWithTitle:@"乘车人数多于余票张数，请重新预定"];
           }else{
               if([cell.gzlabel.text isEqualToString:@"违规"]){
                   NSString *title = @"提示";
                   NSString *title1 = @"取消";
                   NSString *okButtonTitle = @"确认预订";
                   NSString *message=@"";
                       message = [NSString stringWithFormat:@"本车次%@违背了差旅标准：\n%@",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                       [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                       }]];
                       [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                           RuleVC * trainrulevc = [RuleVC new];
                           trainrulevc.erromes=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"];
                           trainrulevc.erro=[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                           trainrulevc.style=@"train";
                           trainrulevc.trainDatadict=_dataArray[indexPath.section];
                           trainrulevc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                           trainrulevc.requtstdict=_requtstdict;
                           trainrulevc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                           trainrulevc.StopOverarr=StopOverarr;
                           trainrulevc.gxlabeltext= cell.gzlabel.text;
                           trainrulevc.menarray=_menarray;
                           trainrulevc.Tcount=count;

                         [self.navigationController  pushViewController:trainrulevc animated:YES];
//                           [self presentViewController:trainrulevc animated:NO completion:nil];
                       }]];
                       [self presentViewController:alertController animated:YES completion:nil];
               }else{
                   TrainorderVC*tvc = [TrainorderVC new];
                   tvc.trainDatadict=_dataArray[indexPath.section];
                   tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                   tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                   tvc.StopOverarr=StopOverarr;
                   tvc.requtstdict=_requtstdict;
                   tvc.gxlabeltext= cell.gzlabel.text;
                   tvc.menarray=_menarray;
                   tvc.count=count;
                   [self.navigationController  pushViewController:tvc animated:YES];
//                   [self presentViewController:tvc animated:NO completion:nil];
               }
           }
       }else{
            if([cell.gzlabel.text isEqualToString:@"违规"]){
                         NSString *title = @"提示";
                           NSString *title1 = @"取消";
                           NSString *okButtonTitle = @"确认预订";
                           NSString *message=@"";
                           if([cell.gzlabel.text isEqualToString:@"违规"]){
                               message = [NSString stringWithFormat:@"本车次%@违背了差旅标准：\n%@",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                               UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                               [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                               }]];
                               [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                                   RuleVC * trainrulevc = [RuleVC new];
                                   trainrulevc.erromes=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"];
                                   trainrulevc.erro=[NSString stringWithFormat:@"本次航班%@违背了差旅标准：\n%@\n\n请选择您的原因：",_dataArray[indexPath.section][@"trainCode"],_dataArray[indexPath.section][@"seatTypeList"][indexPath.row][@"fss"][0][@"violationCn"]];
                                   trainrulevc.style=@"train";
                                   trainrulevc.trainDatadict=_dataArray[indexPath.section];
                                   trainrulevc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                                   trainrulevc.requtstdict=_requtstdict;
                                   trainrulevc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                                   trainrulevc.StopOverarr=StopOverarr;
                                   trainrulevc.gxlabeltext= cell.gzlabel.text;
                                   trainrulevc.menarray=_menarray;
                                   trainrulevc.Tcount=10;
                                   [self.navigationController  pushViewController:trainrulevc animated:YES];
                                   //                           [self presentViewController:trainrulevc animated:NO completion:nil];
                               }]];
                               [self presentViewController:alertController animated:YES completion:nil];
                           }
                       }
                else{
//                   if(!([_seatArray[indexPath.row][@"count"] isEqualToString:@"有"]||[_seatArray[indexPath.row][@"count"] isEqualToString:@"无"])){
//                       NSInteger  count =[_seatArray[indexPath.row][@"count"] integerValue];
//                       if(_menarray.count>count){
//                           [UIAlertView showAlertWithTitle:@"乘车人数多于余票张数，请重新预定"];
//                       }else{
                           TrainorderVC*tvc = [TrainorderVC new];
                           tvc.trainDatadict=_dataArray[indexPath.section];
                           tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                           tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                        tvc.menarray=_menarray;

                           tvc.StopOverarr=StopOverarr;
                           tvc.requtstdict=_requtstdict;
                           tvc.count=10;
                           tvc.gxlabeltext= cell.gzlabel.text;
                           [self.navigationController  pushViewController:tvc animated:YES];
//                       }
//                   }
//                   [self presentViewController:tvc animated:NO completion:nil];
               }
           
        //    [self presentViewController:tvc animated:NO completion:nil];
       }
    }else{
        if(!([_seatArray[indexPath.row][@"count"] isEqualToString:@"有"]||[_seatArray[indexPath.row][@"count"] isEqualToString:@"无"])){
            NSInteger  count =[_seatArray[indexPath.row][@"count"] integerValue];
            if(_menarray.count>count){
//                [UIAlertView showAlertWithTitle:@"乘车人数多于余票张数，请重新预定"];
            }else{
                TrainorderVC*tvc = [TrainorderVC new];
                tvc.trainDatadict=_dataArray[indexPath.section];
                tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
                tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
                tvc.StopOverarr=StopOverarr;
                tvc.requtstdict=_requtstdict;
                tvc.menarray=_menarray;

                tvc.count=count;
                tvc.gxlabeltext= cell.gzlabel.text;
                [self.navigationController  pushViewController:tvc animated:YES];
            }
        }else{
            TrainorderVC*tvc = [TrainorderVC new];
            tvc.trainDatadict=_dataArray[indexPath.section];
            tvc.seatDatadict=_dataArray[indexPath.section][@"seatTypeList"][indexPath.row];
            tvc.seatarr=_dataArray[indexPath.section][@"seatTypeList"];
            tvc.StopOverarr=StopOverarr;
            tvc.requtstdict=_requtstdict;
            tvc.count=10;
            
            tvc.gxlabeltext= cell.gzlabel.text;
            [self.navigationController  pushViewController:tvc animated:YES];
        }
    }
}
-(void)back:(UIButton*)but{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:NO];
}
@end
