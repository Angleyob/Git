//
//  HotelorderList.m
//  Tour
//
//  Created by Euet on 17/2/14.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "HotelorderList.h"
#import "hotelorderCell.h"

#import "HotelorderlistMessVC.h"

#import "ForderTPmessVC.h"
#import "TrainGQorderMessVC.h"

@interface HotelorderList ()<UITableViewDelegate,UITableViewDataSource>
{
    UIScrollView*_scrollView;
    
    UIScrollView*_scrollView1;
    UIView * viewline;
    NSMutableArray*  _array ;
    
    UITableView * _tableView;
    UITableView * _tableView1;
    
    NSMutableArray*  _Allarray1;
    
    NSMutableArray*  _Allarray2;
    
    NSMutableArray*  _Allarray3;
    
    NSMutableArray*  _Allarray4;
    
    NSMutableArray*  _arrayTaday;
    
    NSMutableArray*  _arrayYesterday;
    
    NSMutableArray*  _arrayBmonth;
    
    NSMutableArray*  _arraySmonth;
    
    NSMutableArray*  _TGarray;
    
    NSMutableArray*  _TParray;
    
    NSMutableArray*  _GQarray;
}
@end
@implementation HotelorderList
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden  = NO;
    self.tabBarController.tabBar.hidden=NO;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
       switch (_num) {
        case 301:
                [self loadData];
            break;
        case 302:{
            [self loadData];
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((1)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(80*(1), 0);
            break;
        }
        case 303:{
            [self loadData];
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((3)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(80*(3), 0);
        }
            break;
           default:{
               [self loadData];
           }
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 100 , 30)];
    label.text=@"酒店订单";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    [self initview];
    [self creatTable];
}
#pragma mark -返回触发事件
-(void)back:(UIButton*)send{
    if (_back==1) {
        self.navigationController.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark -初始化数据源
-(void)initData{
    _arraySmonth=[NSMutableArray new];
    _arrayBmonth=[NSMutableArray new];
    _arrayYesterday=[NSMutableArray new];
    _arrayTaday=[NSMutableArray new];
}
#pragma mark -初始化视图
-(void)initview{
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight)];
    view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
    _scrollView1 =[[UIScrollView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0,375,45)]];
    _scrollView1.contentSize= CGSizeMake(8*80, 45/SCREEN_RATE);
    //边界不滑动
    _scrollView1.bounces = NO;
    _scrollView1.alpha=1;
    //分页
//    _scrollView1.pagingEnabled = YES;
    // _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView1.showsVerticalScrollIndicator=NO;
    [view addSubview:_scrollView1];
    
    UIButton * but1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 80, 45)]];
    [but1 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but1.tag=101;
    [but1 setTitle:@"全部" forState:UIControlStateNormal];
    [but1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but1.titleLabel.font=[UIFont systemFontOfSize:14];
    //but1.backgroundColor=[UIColor greenColor];
    [_scrollView1 addSubview:but1];
    
    UIButton * but2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(80, 0, 80, 45)]];
    [but2 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but2.tag=102;
    [but2 setTitle:@"待审批" forState:UIControlStateNormal];
    [but2 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but2.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but2];
    
    UIButton * but3 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(2*80,0, 80, 45)]];
    [but3 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but3.tag=103;
    [but3 setTitle:@"审批中" forState:UIControlStateNormal];
    [but3 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but3.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but3];
    
    UIButton * but4 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(3*80,0, 80, 45)]];
    [but4 setTitle:@"待支付" forState:UIControlStateNormal];
    [but4 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but4.titleLabel.font=[UIFont systemFontOfSize:14];
    [but4 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but4.tag=104;
    [_scrollView1 addSubview:but4];
    UIButton * but5 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake( 4*80,0, 80, 45)]];
    [but5 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but5.tag=105;
    [but5 setTitle:@"待确认" forState:UIControlStateNormal];
    [but5 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but5.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but5];
    
    UIButton * but6 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(5*80,0, 80, 45)]];
    [but6 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but6.tag=106;
    [but6 setTitle:@"已确认" forState:UIControlStateNormal];
    [but6 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but6.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but6];
    
    UIButton * but7 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(6*80,0,80, 45)]];
    [but7 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but7.tag=107;
    [but7 setTitle:@"已取消" forState:UIControlStateNormal];
    [but7 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but7.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but7];
    
    
    viewline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 41, 80, 4)]];
    viewline.backgroundColor= UIColorFromRGBA(0x004284, 1.0);
    [_scrollView1 addSubview:viewline];
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 45/SCREEN_RATE, deviceScreenWidth, deviceScreenHeight-64-44/SCREEN_RATE-45/SCREEN_RATE) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view addSubview:_tableView];
    [_scrollView addSubview:view];
}
#pragma mark -创建列表，实现代理
-(void)creatTable{
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        return 50/SCREEN_RATE1;
    }else{
        return 0.01;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        UIView * view = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 50)]];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        UILabel * label  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 10, 30, 30)]];
        if(section==0){
            label.text=@"今天";
        }else if(section==1){
            label.text=@"昨天";
        }else if(section==2){
            label.text=@"本月";
        }else{
            label.text=@"上月";
        }
        label.adjustsFontSizeToFitWidth=YES;
        label.textAlignment=NSTextAlignmentCenter;
        [view addSubview:label];
        UIImageView  * img  = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(44, 11, 13, 8)]];
        img.image=[UIImage imageNamed:@""];
        [view addSubview:img];
        UIView * vline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 49, 375, 1)]];
        vline.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        //vline.backgroundColor=[UIColor redColor];
        [view addSubview:vline];
        UITapGestureRecognizer *tapo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFo:)];
        [view addGestureRecognizer:tapo];
        view.tag=section+1;
        return view;
    }else{
        return 0;
    }
}
-(void)showGFo:(UITapGestureRecognizer *)tapo
{
    //判断是不是1 如果是 改成0
    if ([_array[tapo.view.tag - 1] isEqualToString:@"1"]) {
        [_array replaceObjectAtIndex:tapo.view.tag - 1 withObject:@"0"];
    }else{
        for (int i=0;i<_array.count;i++) {
            [_array replaceObjectAtIndex:i withObject:@"0"];
        }
        //如果不是 改成1
        [_array replaceObjectAtIndex:tapo.view.tag - 1 withObject:@"1"];
    }
    [_tableView reloadData];
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        return 90/SCREEN_RATE1;
    }else{
        return 80/SCREEN_RATE1;
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return 4;
    }else{
        return 1;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if ([_array[section] isEqualToString:@"0"]) {
            return 0;
        }
        switch (section) {
            case 0:{
                return _arrayTaday.count;
                break;
            }
            case 1:{
                return _arrayYesterday.count;
                break;
            }
            case 2:{
                return _arrayBmonth.count;
                break;
            }
            case 3:{
                return _arraySmonth.count;
                break;
            }
            default:
                break;
        }
        return 0;
    }else{
        return 0;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
        hotelorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[hotelorderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.celldict=_arrayTaday[indexPath.row];
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayTaday[indexPath.row][@"checkInDate"] substringWithRange:NSMakeRange(5, 5)]];
            cell.weeklabel.text=[weekday weekdaywith1:_arrayTaday[indexPath.row][@"checkInDate"]];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_arrayTaday[indexPath.row][@"payMoney"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@",_arrayTaday[indexPath.row][@"hotelName"]];
            cell.namelabel.text=_arrayTaday[indexPath.row][@"guest"];
            cell.numlabel.text=[NSString stringWithFormat:@"%@晚",_arrayTaday[indexPath.row][@"roomNightNum"]];
           
            if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                 cell.statuslabel.text=@"已预订";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if ([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"待确认";
            }else if ([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
                cell.statuslabel.text=@"已确认";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if ([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]){
                cell.statuslabel.text=@"已取消";

            }else if ([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]){
                cell.statuslabel.text=@"已取消";

            }else if ([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
                cell.statuslabel.text=@"已取消";
            }else{
            
            }
   //            if([_arrayTaday[indexPath.row][@"orderPayType"] isEqualToString:@"0"] && [_arrayTaday[indexPath.row][@"payType"] isEqualToString:@"1"] &&!([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]&&[_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]&&[_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"9"])){
//                cell.statuslabel.text=@"待支付";
//            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
////                cell.statuslabel.text=@"待审批";
//                
//            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
////                cell.statuslabel.text=@"审批中";
//                
//            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
//                cell.statuslabel.text=@"待确认";
//                
//            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
//                cell.statuslabel.text=@"已确认";
//                
//            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"5"]||[_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]||[_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]||[_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
//                cell.statuslabel.text=@"已取消";
//            }else {
//                
//            }
            return cell;
        }else if(indexPath.section==1){
            hotelorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[hotelorderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arrayYesterday[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayYesterday[indexPath.row][@"checkInDate"] substringWithRange:NSMakeRange(5, 5)]];
            cell.weeklabel.text=[weekday weekdaywith1:_arrayYesterday[indexPath.row][@"checkInDate"]];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_arrayYesterday[indexPath.row][@"payMoney"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@",_arrayYesterday[indexPath.row][@"hotelName"]];
            cell.namelabel.text=_arrayYesterday[indexPath.row][@"guest"];
            cell.numlabel.text=[NSString stringWithFormat:@"%@晚",_arrayYesterday[indexPath.row][@"roomNightNum"]];
            
            if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已预订";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if ([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"待确认";
            }else if ([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
                cell.statuslabel.text=@"已确认";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if ([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
                cell.statuslabel.text=@"已取消";
            }else{
                
            }
//            if([_arrayYesterday[indexPath.row][@"orderPayType"] isEqualToString:@"0"] && [_arrayYesterday[indexPath.row][@"payType"] isEqualToString:@"1"] &&!([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]&&[_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]&&[_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"9"])){
//                cell.statuslabel.text=@"待支付";
//            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
//                //                cell.statuslabel.text=@"待审批";
//                
//            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
//                //                cell.statuslabel.text=@"审批中";
//                
//            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
//                cell.statuslabel.text=@"待确认";
//                
//            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
//                cell.statuslabel.text=@"已确认";
//                
//            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"5"]||[_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"7"]||[_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"8"]||[_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
//                cell.statuslabel.text=@"已取消";
//            }else {
//                
//            }
            return cell;
        }else if(indexPath.section==2){
            hotelorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[hotelorderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arrayBmonth[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayBmonth[indexPath.row][@"checkInDate"] substringWithRange:NSMakeRange(5, 5)]];
            cell.weeklabel.text=[weekday weekdaywith1:_arrayBmonth[indexPath.row][@"checkInDate"]];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_arrayBmonth[indexPath.row][@"payMoney"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@",_arrayBmonth[indexPath.row][@"hotelName"]];
            cell.namelabel.text=_arrayBmonth[indexPath.row][@"guest"];
            cell.numlabel.text=[NSString stringWithFormat:@"%@晚",_arrayBmonth[indexPath.row][@"roomNightNum"]];
           
            if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已预订";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if ([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"待确认";
            }else if ([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
                cell.statuslabel.text=@"已确认";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if ([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
                cell.statuslabel.text=@"已取消";
            }else{
                
            }
            
//            if([_arrayBmonth[indexPath.row][@"orderPayType"] isEqualToString:@"0"] && [_arrayBmonth[indexPath.row][@"payType"] isEqualToString:@"1"] &&!([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]&&[_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]&&[_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"])){
//                cell.statuslabel.text=@"待支付";
//            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
//                //                cell.statuslabel.text=@"待审批";
//                
//            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
//                //                cell.statuslabel.text=@"审批中";
//                
//            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
//                cell.statuslabel.text=@"待确认";
//                
//            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
//                cell.statuslabel.text=@"已确认";
//                
//            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"5"]||[_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]||[_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]||[_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
//                cell.statuslabel.text=@"已取消";
//            }else {
//            }
            return cell;
        }else{
            hotelorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[hotelorderCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arraySmonth[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arraySmonth[indexPath.row][@"checkInDate"] substringWithRange:NSMakeRange(5, 5)]];
            cell.weeklabel.text=[weekday weekdaywith1:_arraySmonth[indexPath.row][@"checkInDate"]];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_arraySmonth[indexPath.row][@"payMoney"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@",_arraySmonth[indexPath.row][@"hotelName"]];
            cell.namelabel.text=_arraySmonth[indexPath.row][@"guest"];
            cell.numlabel.text=[NSString stringWithFormat:@"%@晚",_arraySmonth[indexPath.row][@"roomNightNum"]];
            
            if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已预订";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if ([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"待确认";
            }else if ([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
                cell.statuslabel.text=@"已确认";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
            }else if ([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]){
                cell.statuslabel.text=@"已取消";
                
            }else if ([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
                cell.statuslabel.text=@"已取消";
            }else{
                
            }
            
//            if([_arraySmonth[indexPath.row][@"orderPayType"] isEqualToString:@"0"] && [_arraySmonth[indexPath.row][@"payType"] isEqualToString:@"1"] &&!([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]&&[_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]&&[_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"])){
//                cell.statuslabel.text=@"待支付";
//            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
//                //                cell.statuslabel.text=@"待审批";
//                
//            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
//                //                cell.statuslabel.text=@"审批中";
//                
//            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
//                cell.statuslabel.text=@"待确认";
//                
//            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3A"]){
//                cell.statuslabel.text=@"已确认";
//                
//            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"5"]||[_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"7"]||[_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"8"]||[_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"9"]){
//                cell.statuslabel.text=@"已取消";
//            }else {
//            }
            return cell;
        }
//    }
}
//cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    hotelorderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if([tableView isEqual:_tableView]){
        HotelorderlistMessVC * fmvc = [HotelorderlistMessVC new];
        fmvc.statusStr=cell.statuslabel.text;
        fmvc.orderStr= cell.celldict[@"orderNo"];
        
     [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        self.view.userInteractionEnabled=NO;
        HotelOrderInfQuery*  infquery  = [HotelOrderInfQuery new];
        infquery.OrderNo=cell.celldict[@"orderNo"];
        infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        [Hotel HotelOrderInfQuery:infquery success:^(id data) {
            [SVProgressHUD dismiss];
            self.view.userInteractionEnabled=YES;
            if ([data[@"status"] isEqualToString:@"T"]) {
                fmvc.Alldata=data;
                fmvc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:fmvc animated:NO];
            }

            } failure:^(NSError *error) {
                self.view.userInteractionEnabled=YES;

            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
        }];
    }else{
    }
}
-(void)loadData{
   
    [self initData];
    NSArray *arr  =@[@"1",@"0",@"0",@"0"];
    _array = [[NSMutableArray alloc]initWithArray:arr];
    
    _Allarray1=[NSMutableArray new];
    _Allarray2=[NSMutableArray new];
    _Allarray3=[NSMutableArray new];
    _Allarray4=[NSMutableArray new];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;

    HotelOrderQuery * Toq = [HotelOrderQuery new];
    Toq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    Toq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    Toq.Count=200;
    Toq.Start=0;
    Toq.QueryRange=@"1";
    Toq.DateType=@"1";
    //获取当前时间并转换为字符串
    NSDate * date1 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString * str  = [dateFormatter stringFromDate:date1];
    //两月前的一天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:-2];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date1 options:0];
    NSDateFormatter * dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
    NSString * str1  = [dateFormatter1 stringFromDate:newdate];
    //NSLog(@"%@",str1);
    Toq.StartDate=str1;
    Toq.EndDate=str;
    
    [Hotel HotelOrderQuery:Toq success:^(id data) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;
        if([data[@"status"] isEqualToString:@"T"]){
            _Allarray1=data[@"todayOrderList"];
            _Allarray2=data[@"yesterdayOrderList"];
            _Allarray3=data[@"selfMonthOrderList"];
            _Allarray4=data[@"preMonthOrderList"];
            _arrayTaday=_Allarray1;
            _arrayYesterday=_Allarray2;
            _arrayBmonth=_Allarray3;
            _arraySmonth=_Allarray4;
          //跳至待支付列表
            if (_num==303) {
                [self waitpay];
            }
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)butclick:(UIButton * )send{
    switch (send.tag) {
            //全部
        case 101:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            [self initData];
            _arrayTaday=_Allarray1;
            _arrayYesterday=_Allarray2;
            _arrayBmonth=_Allarray3;
            _arraySmonth=_Allarray4;
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:101];
            break;
        }
            //待审批
        case 102:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
           [self initData];
//            for (NSMutableDictionary * dict in _Allarray1) {
//                if([dict[@"orderStatus"] isEqualToString:@"A"]){
//                    [_arrayTaday addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray2) {
//                if([dict[@"orderStatus"] isEqualToString:@"A"]){
//                    [_arrayYesterday addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray3) {
//                if([dict[@"orderStatus"] isEqualToString:@"A"]){
//                    [_arrayBmonth addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray4) {
//                
//                if([dict[@"orderStatus"] isEqualToString:@"A"]){
//                    [_arraySmonth addObject:dict];
//                }
//            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:102];
            break;
        }
            //审批中
        case 103:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
           [self initData];
//            for (NSMutableDictionary * dict in _Allarray1) {
//                if([dict[@"orderStatus"] isEqualToString:@"B"]){
//                    [_arrayTaday addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray2) {
//                if([dict[@"orderStatus"] isEqualToString:@"B"]){
//                    [_arrayYesterday addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray3) {
//                if([dict[@"orderStatus"] isEqualToString:@"B"]){
//                    [_arrayBmonth addObject:dict];
//                }
//            }
//            for (NSMutableDictionary * dict in _Allarray4) {
//                
//                if([dict[@"orderStatus"] isEqualToString:@"B"]){
//                    [_arraySmonth addObject:dict];
//                }
//            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:103];
            break;
        }
            //待支付
        case 104:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(0, 0);
            
            [self initData];
            
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderPayType"] isEqualToString:@"0"] && [dict[@"payType"] isEqualToString:@"1"] &&(![dict[@"orderStatus"] isEqualToString:@"7"]&&![dict[@"orderStatus"] isEqualToString:@"8"]&&![dict[@"orderStatus"] isEqualToString:@"9"]&&![dict[@"orderStatus"] isEqualToString:@"5"])){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderPayType"] isEqualToString:@"0"] && [dict[@"payType"] isEqualToString:@"1"] &&(![dict[@"orderStatus"] isEqualToString:@"7"]&&![dict[@"orderStatus"] isEqualToString:@"8"]&&![dict[@"orderStatus"] isEqualToString:@"9"]&&![dict[@"orderStatus"] isEqualToString:@"5"])){
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderPayType"] isEqualToString:@"0"] && [dict[@"payType"] isEqualToString:@"1"] &&(![dict[@"orderStatus"] isEqualToString:@"7"]&&![dict[@"orderStatus"] isEqualToString:@"8"]&&![dict[@"orderStatus"] isEqualToString:@"9"]&&![dict[@"orderStatus"] isEqualToString:@"5"])){
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderPayType"] isEqualToString:@"0"] && [dict[@"payType"] isEqualToString:@"1"] &&(![dict[@"orderStatus"] isEqualToString:@"7"]&&![dict[@"orderStatus"] isEqualToString:@"8"]&&![dict[@"orderStatus"] isEqualToString:@"9"]&&![dict[@"orderStatus"] isEqualToString:@"5"])){
                    [_arraySmonth addObject:dict];
                }
            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:104];
            break;
        }
            // 待确认
        case 105:{
            [self waitpay];
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(80*(send.tag-102), 0);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:105];
            break;
        }
            //已确认
        case 106:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            [self initData];
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderStatus"] isEqualToString:@"3A"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderStatus"] isEqualToString:@"3A"]){
                    
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"3A"]){
                    
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderStatus"] isEqualToString:@"3A"]){
                    
                    [_arraySmonth addObject:dict];
                }
            }
            
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:106];
            break;
        }
            //已取消
        case 107:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
             [self initData];
            
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderStatus"] isEqualToString:@"5"]||[dict[@"orderStatus"] isEqualToString:@"7"]||[dict[@"orderStatus"] isEqualToString:@"8"]||[dict[@"orderStatus"] isEqualToString:@"9"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderStatus"] isEqualToString:@"5"]||[dict[@"orderStatus"] isEqualToString:@"7"]||[dict[@"orderStatus"] isEqualToString:@"8"]||[dict[@"orderStatus"] isEqualToString:@"9"]){
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"5"]||[dict[@"orderStatus"] isEqualToString:@"7"]||[dict[@"orderStatus"] isEqualToString:@"8"]||[dict[@"orderStatus"] isEqualToString:@"9"]){
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderStatus"] isEqualToString:@"5"]||[dict[@"orderStatus"] isEqualToString:@"7"]||[dict[@"orderStatus"] isEqualToString:@"8"]||[dict[@"orderStatus"] isEqualToString:@"9"]){
                    [_arraySmonth addObject:dict];
                }
            }
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:107];
            break;
        }
        default:
            break;
    }
}
//待支付
-(void)waitpay{
     [self initData];
    for (NSMutableDictionary * dict in _Allarray1) {
        if([dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayTaday addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray2) {
        if([dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayYesterday addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray3) {
        if([dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayBmonth addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray4) {
        
        if([dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arraySmonth addObject:dict];
        }
    }
}

-(void)changeButttonTitle:(int)tag{
    for (int i=101; i<108; i++) {
        if (i==tag) {
            UIButton * but = (UIButton*)[self.view viewWithTag:i];
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }else{
            UIButton * but = (UIButton*)[self.view viewWithTag:i];
            [but setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
        }
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
