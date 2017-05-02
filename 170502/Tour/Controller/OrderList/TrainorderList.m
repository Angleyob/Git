//
//  TrainorderList.m
//  Tour
//
//  Created by Euet on 17/2/14.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrainorderList.h"
#import "flightordercell.h"
#import "TrainTPorderMessVC1.h"
#import "TrainorderlistMessVC.h"
#import "ForderTPmessVC.h"
#import "TrainGQorderMessVC.h"

@interface TrainorderList ()<UITableViewDelegate,UITableViewDataSource>
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

@implementation TrainorderList
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_num==202||_num==203){
        _scrollView.contentOffset=CGPointMake(deviceScreenWidth, 0);
        if (_num==202) {
            [self loadData2];
            UISegmentedControl *st = (UISegmentedControl*)[self.view viewWithTag:99];
            st.selectedSegmentIndex = 2;//设置默认选择项索引
        }else{
            UISegmentedControl *st = (UISegmentedControl*)[self.view viewWithTag:99];
            st.selectedSegmentIndex =1;//设置默认选择项索引
            [self loadData1];
        }
    }else{
        [self loadData];
        if (_num==204) {
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((3)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(80*(2), 0);
        }

    }
//    [self loadData];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;

}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden  = NO;
    self.tabBarController.tabBar.hidden=NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 100 , 30)];
    label.text=@"火车票订单";
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
-(void)back:(UIButton*)send{

    if (_back==1) {
//        OrderViewController* orc = [OrderViewController new];
//        [self.navigationController  pushViewController:orc animated:YES];
        self.navigationController.tabBarController.selectedIndex = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:NO];
    }
}
-(void)initview{
    
    UIView  * Dview = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-44/SCREEN_RATE, deviceScreenWidth, 44/SCREEN_RATE)];
    Dview.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    
    UISegmentedControl *st = [[UISegmentedControl alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(43,8, 290, 30)]];
    //添加按钮
    [st insertSegmentWithTitle:@"订购单" atIndex:0 animated:YES];
    [st insertSegmentWithTitle:@"退票单" atIndex:1 animated:YES];
    [st insertSegmentWithTitle:@"改签单" atIndex:2 animated:YES];
    
    st.selectedSegmentIndex = 0;//设置默认选择项索引
    st.tag=99;
    //设置某个按钮的宽度
    [st setWidth:97/SCREEN_RATE forSegmentAtIndex:0];
    //设置某个按钮的宽度
    [st setWidth:97/SCREEN_RATE forSegmentAtIndex:1];
    //设置某个按钮的宽度
    [st setWidth:97/SCREEN_RATE forSegmentAtIndex:2];
    
    //设置文字偏移量
    [st setContentOffset:CGSizeMake(0, 0) forSegmentAtIndex:1];
    
    //添加点击方法 添加事件
    [st addTarget:self action:@selector(Dbuttonclick:) forControlEvents:UIControlEventValueChanged];
    
    //设置镂空颜色
    st.tintColor = [UIColor whiteColor];
    [Dview addSubview:st];
    [self.view addSubview:Dview];
    
    _scrollView =[[UIScrollView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0,64*SCREEN_RATE,375,(deviceScreenHeight*SCREEN_RATE-64-44))]];
    _scrollView.contentSize= CGSizeMake(2*deviceScreenWidth, deviceScreenHeight-64-44/SCREEN_RATE);
    
    _scrollView.scrollEnabled = NO;
    //边界不滑动
    _scrollView.bounces = NO;
    _scrollView.alpha=1;
    //分页
    _scrollView.pagingEnabled = YES;
    //_scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:_scrollView];
    
    UIView * view1  = [[UIView alloc]initWithFrame:CGRectMake(deviceScreenWidth, 0, deviceScreenWidth, deviceScreenHeight-44/SCREEN_RATE-64)];
    view1.backgroundColor=[UIColor blueColor];
    _tableView1= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-64-44/SCREEN_RATE) style:UITableViewStylePlain];
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view1 addSubview:_tableView1];
    [_scrollView addSubview:view1];
    
    UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-44/SCREEN_RATE-64)];
    view.backgroundColor=[UIColor whiteColor];
    //    [self.view addSubview:view];
    _scrollView1 =[[UIScrollView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0,375,45)]];
    _scrollView1.contentSize= CGSizeMake(8*80, 45/SCREEN_RATE);
    //边界不滑动
    _scrollView1.bounces = NO;
    _scrollView1.alpha=1;
    //分页
    _scrollView1.pagingEnabled = YES;
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
    [but5 setTitle:@"已订座" forState:UIControlStateNormal];
    [but5 setTitleColor:UIColorFromRGBA(0x999999, 1.0) forState:UIControlStateNormal];
    but5.titleLabel.font=[UIFont systemFontOfSize:14];
    [_scrollView1 addSubview:but5];
    
    UIButton * but6 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(5*80,0, 80, 45)]];
    [but6 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
    but6.tag=106;
    [but6 setTitle:@"已出票" forState:UIControlStateNormal];
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
    
//    UIButton * but8 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(7*80,0,80, 45)]];
//    [but8 addTarget:self action:@selector(butclick:) forControlEvents:UIControlEventTouchUpInside];
//    but8.tag=108;
//    [but8 setTitle:@"" forState:UIControlStateNormal];
//    [but8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    but8.titleLabel.font=[UIFont systemFontOfSize:14];
//    [_scrollView1 addSubview:but8];
    
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
#pragma mark -创建列表
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
        return 101/SCREEN_RATE1;
    }else{
        return 101/SCREEN_RATE1;
    }
}

//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        
        return 4;}
    else{
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
        return _TGarray.count;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if([tableView isEqual:_tableView]){
        
        if(indexPath.section==0){
            flightordercell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[flightordercell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arrayTaday[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayTaday[indexPath.row][@"departureDate"] substringWithRange:NSMakeRange(5, 5)]];
            
            cell.weeklabel.text=[weekday weekdaywith1:_arrayTaday[indexPath.row][@"departureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_arrayTaday[indexPath.row][@"departureTime"] ];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_arrayTaday[indexPath.row][@"ticketPrice"] floatValue]+[_arrayTaday[indexPath.row][@"fee"] floatValue]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_arrayTaday[indexPath.row][@"fromStationName"],_arrayTaday[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_arrayTaday[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_arrayTaday[indexPath.row][@"trainNum"]];
            
            if([_arrayTaday[indexPath.row][@"payStatus"] isEqualToString:@"0"] && [_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"1A"]){
                cell.statuslabel.text=@"已申请";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
                cell.statuslabel.text=@"待审批";
                
            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
                cell.statuslabel.text=@"审批中";
                
            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"已订座";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已出票";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if([_arrayTaday[indexPath.row][@"orderStatus"] isEqualToString:@"3"]){
                cell.statuslabel.text=@"已取消";
                
            }else {
                
            }
            return cell;
        }else if(indexPath.section==1){
            flightordercell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[flightordercell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arrayYesterday[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayYesterday[indexPath.row][@"departureDate"] substringWithRange:NSMakeRange(5, 5)]];
            
            cell.weeklabel.text=[weekday weekdaywith1:_arrayYesterday[indexPath.row][@"departureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_arrayYesterday[indexPath.row][@"departureTime"] ];
          cell.pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_arrayYesterday[indexPath.row][@"ticketPrice"] floatValue]+[_arrayYesterday[indexPath.row][@"fee"] floatValue]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_arrayYesterday[indexPath.row][@"fromStationName"],_arrayYesterday[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_arrayYesterday[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_arrayYesterday[indexPath.row][@"trainNum"]];
            
            
            if([_arrayYesterday[indexPath.row][@"payStatus"] isEqualToString:@"0"] && [_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"1A"]){
                cell.statuslabel.text=@"已申请";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
                cell.statuslabel.text=@"待审批";
                
            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
                cell.statuslabel.text=@"审批中";
                
            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"已订座";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已出票";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if([_arrayYesterday[indexPath.row][@"orderStatus"] isEqualToString:@"3"]){
                cell.statuslabel.text=@"已取消";
                
            }else {
                
            }
            return cell;
        }else if(indexPath.section==2){
            flightordercell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[flightordercell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.celldict=_arrayBmonth[indexPath.row];
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arrayBmonth[indexPath.row][@"departureDate"] substringWithRange:NSMakeRange(5, 5)]];
            
            cell.weeklabel.text=[weekday weekdaywith1:_arrayBmonth[indexPath.row][@"departureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_arrayBmonth[indexPath.row][@"departureTime"] ];
           cell.pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_arrayBmonth[indexPath.row][@"ticketPrice"] floatValue]+[_arrayBmonth[indexPath.row][@"fee"] floatValue]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_arrayBmonth[indexPath.row][@"fromStationName"],_arrayBmonth[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_arrayBmonth[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_arrayBmonth[indexPath.row][@"trainNum"]];
            
            
            if([_arrayBmonth[indexPath.row][@"payStatus"] isEqualToString:@"0"] && [_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1A"]){
                cell.statuslabel.text=@"已申请";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
                cell.statuslabel.text=@"待审批";
                
            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
                cell.statuslabel.text=@"审批中";
                
            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"已订座";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);
                
            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已出票";
                cell.statuslabel.textColor=UIColorFromRGBA(0xee7800, 1.0);

            }else if([_arrayBmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3"]){
                cell.statuslabel.text=@"已取消";
            }else {
            }
            return cell;
        
        }else{
            flightordercell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[flightordercell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_arraySmonth[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_arraySmonth[indexPath.row][@"departureDate"] substringWithRange:NSMakeRange(5, 5)]];
            
            cell.weeklabel.text=[weekday weekdaywith1:_arraySmonth[indexPath.row][@"departureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_arraySmonth[indexPath.row][@"departureTime"] ];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%.1f",[_arraySmonth[indexPath.row][@"ticketPrice"] floatValue]+[_arraySmonth[indexPath.row][@"fee"] floatValue]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_arraySmonth[indexPath.row][@"fromStationName"],_arraySmonth[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_arraySmonth[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_arraySmonth[indexPath.row][@"trainNum"]];
            
            
            if([_arraySmonth[indexPath.row][@"payStatus"] isEqualToString:@"0"] && [_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1A"]){
                cell.statuslabel.text=@"已申请";
            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"A"]){
                cell.statuslabel.text=@"待审批";
            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"B"]){
                cell.statuslabel.text=@"审批中";
                
            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"1"]){
                cell.statuslabel.text=@"已订座";
                
            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"2"]){
                cell.statuslabel.text=@"已出票";
                
            }else if([_arraySmonth[indexPath.row][@"orderStatus"] isEqualToString:@"3"]){
                cell.statuslabel.text=@"已取消";
                
            }else {
                
            }
            return cell;
        }
    
    }else{
        flightordercell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            cell = [[flightordercell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        }
        
        cell.celldict=_TGarray[indexPath.row];
        
        if([[_TGarray[indexPath.row] allKeys] containsObject:@"trainChangeOrderList"]){
            
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_TGarray[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_TGarray[indexPath.row][@"newDepartureDate"] substringWithRange:NSMakeRange(5, 5)]];
            
            cell.weeklabel.text=[weekday weekdaywith1:_TGarray[indexPath.row][@"newDepartureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_TGarray[indexPath.row][@"newDepartureTime"] ];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_TGarray[indexPath.row][@"newPrice"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_TGarray[indexPath.row][@"fromStationName"],_TGarray[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_TGarray[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_TGarray[indexPath.row][@"newTrainNum"]];
            cell.statuslabel.text=_TGarray[indexPath.row][@"changeTypeName"];
        }
        else{
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
            cell.celldict=_TGarray[indexPath.row];
            
            cell.datelabel.text=[NSString stringWithFormat:@"%@", [_TGarray[indexPath.row][@"departureDate"] substringWithRange:NSMakeRange(5, 5)]];
            cell.weeklabel.text=[weekday weekdaywith1:_TGarray[indexPath.row][@"departureDate"] ];
            cell.timelabel.text=[NSString stringWithFormat:@"%@",_TGarray[indexPath.row][@"departureTime"] ];
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@",_TGarray[indexPath.row][@"returnTicketPrice"]];
            cell.citylabel.text=[NSString stringWithFormat:@"%@-%@",_TGarray[indexPath.row][@"fromStationName"],_TGarray[indexPath.row][@"toStationName"]];
            cell.namelabel.text=_TGarray[indexPath.row][@"passenger"];
            cell.flightnolabel.text=[NSString stringWithFormat:@"%@",_TGarray[indexPath.row][@"trainNum"]];

            cell.statuslabel.text=[_TGarray[indexPath.row][@"refundStatus"] substringWithRange:NSMakeRange(0, 3)];
        }
        //去除点击效果
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
}
//cell点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    flightordercell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if([tableView isEqual:_tableView]){
        
        TrainorderlistMessVC * fmvc = [TrainorderlistMessVC new];
        
        fmvc.statusStr=cell.statuslabel.text;
        
        fmvc.orderStr= cell.celldict[@"orderNo"];
        
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        self.view.userInteractionEnabled=NO;

        TrainOrderInfQuery *  infquery  = [TrainOrderInfQuery new];
        infquery.OrderNo=cell.celldict[@"orderNo"];
        infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        [Train TrainOrderInfQuery:infquery success:^(id data) {
            [SVProgressHUD dismiss];
            self.view.userInteractionEnabled=YES;
           fmvc.Alldata=data;
            fmvc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fmvc animated:NO];
//        [self presentViewController:fmvc animated:NO completion:nil];

        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
        }];

    }else{
        if(![[_TGarray[indexPath.row] allKeys] containsObject:@"trainChangeTicket"]){
            TrainTPorderMessVC1 * tpvc = [TrainTPorderMessVC1 new];
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            self.view.userInteractionEnabled=NO;
            tpvc.statusStr=cell.statuslabel.text;
            TrainReturnInfQuery * fcif = [TrainReturnInfQuery new];
            fcif.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            fcif.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            fcif.RefundOrderNo=cell.celldict[@"refundOrderNo"];
            [Train TrainReturnInfQuery:fcif success:^(id data) {
                 [SVProgressHUD dismiss];
                self.view.userInteractionEnabled=YES;
//                 NSLog(@"%@",data);
                if([data[@"status"] isEqualToString:@"T"]){
                    tpvc.Messagedict=data[@"trainReturnTicket"];
                    tpvc.menarray=data[@"trainReturnBoxList"];
                      tpvc.orderStr= data[@"trainReturnTicket"][@"orderNo"];
                    
                    tpvc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:tpvc animated:NO];
//                    [self presentViewController:tpvc animated:NO completion:nil];
                }
                [_tableView reloadData];
            } failure:^(NSError *error) {
                self.view.userInteractionEnabled=YES;
                  [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];
        }else{
            
        }
    }
}
//待支付
-(void)waitpay{
    _arraySmonth=[NSMutableArray new];
    _arrayBmonth=[NSMutableArray new];
    _arrayYesterday=[NSMutableArray new];
    _arrayTaday=[NSMutableArray new];
    for (NSMutableDictionary * dict in _Allarray1) {
        if([dict[@"payStatus"] isEqualToString:@"0"] && [dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayTaday addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray2) {
        if([dict[@"payStatus"] isEqualToString:@"0"] && [dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayYesterday addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray3) {
        if([dict[@"payStatus"] isEqualToString:@"0"] && [dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arrayBmonth addObject:dict];
        }
    }
    for (NSMutableDictionary * dict in _Allarray4) {
        
        if([dict[@"payStatus"] isEqualToString:@"0"] && [dict[@"orderStatus"] isEqualToString:@"1"]){
            [_arraySmonth addObject:dict];
        }
    }
   
}
-(void)loadData{
    _arraySmonth=[NSMutableArray new];
    _arrayBmonth=[NSMutableArray new];
    _arrayYesterday=[NSMutableArray new];
    _arrayTaday=[NSMutableArray new];
    
    NSArray *arr  =@[@"1",@"0",@"0",@"0"];
    _array = [[NSMutableArray alloc]initWithArray:arr];
    
    _Allarray1=[NSMutableArray new];
    _Allarray2=[NSMutableArray new];
    _Allarray3=[NSMutableArray new];
    _Allarray4=[NSMutableArray new];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;

    TrainOrderQuery * Toq = [TrainOrderQuery new];
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
    
    [Train TrainOrderQuery:Toq success:^(id data) {
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
            if (_num == 204) {
                [self waitpay];
            }
        }
        [_tableView reloadData];
        //  NSLog(@"%@",data);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)loadData1{
    _TGarray=[NSMutableArray new];
  //  _TParray=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;

    TrainReturnQuery * FRQ = [TrainReturnQuery new];
    FRQ.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    FRQ.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
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
    FRQ.EndDate=str;
    FRQ.StartDate=str1;
    FRQ.QueryRange=@"1";
    FRQ.Start=0;
    FRQ.Count=200;
    
    [Train TrainReturnQuery:FRQ success:^(id data) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            if(![[data allKeys] containsObject:@"trainReturnList"]){
                [UIAlertView showAlertWithTitle1:@"亲，您还没有退票数据哦，😊" duration:2];
            }else{
                _TGarray=data[@"trainReturnList"];
            }
        }
        [_tableView1 reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    
}
-(void)loadData2{
    _TGarray=[NSMutableArray new];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;

    TrainChangeQuery * FCQ = [TrainChangeQuery new];
    FCQ.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    FCQ.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
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
    FCQ.EndDate=str;
    FCQ.StartDate=str1;
    FCQ.Start=0;
    FCQ.Count=200;
    FCQ.Queryrange=@"1";
    [Train TrainChangeQuery:FCQ success:^(id data) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;

        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            if(![[data allKeys] containsObject:@"trainChangeOrderList"]){
                [UIAlertView showAlertWithTitle1:@"亲，您还没有改签数据哦，😊" duration:2];
            }else{
                _TGarray=data[@"trainChangeOrderList"];
            }
        }
        [_tableView1 reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)butclick:(UIButton * )send{
    switch (send.tag) {
            //全部
        case 101:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
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
            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
            
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderStatus"] isEqualToString:@"A"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                  if([dict[@"orderStatus"] isEqualToString:@"A"]){
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"A"]){
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                  if([dict[@"orderStatus"] isEqualToString:@"A"]){
                    [_arraySmonth addObject:dict];
                }
            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:102];
            break;
        }
            //审批中
        case 103:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];

            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
            
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderStatus"] isEqualToString:@"B"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderStatus"] isEqualToString:@"B"]){
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"B"]){
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderStatus"] isEqualToString:@"B"]){
                    [_arraySmonth addObject:dict];
                }
            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:103];
            
            break;
        }
            //待支付
        case 104:{
            [self waitpay];
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(0, 0);
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:104];
            break;
        }
            // 已订座
        case 105:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _scrollView1.contentOffset=CGPointMake(80*(send.tag-102), 0);
            
            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
            
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
            // NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            //改变按钮颜色
            [self changeButttonTitle:105];
            break;
        }
            //已出票
        case 106:{
            viewline.frame=[framsizeclass newSuitFrame:CGRectMake((send.tag-101)*80, 41, 80, 4)];
            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
            
            for (NSMutableDictionary * dict in _Allarray1) {
               if([dict[@"orderStatus"] isEqualToString:@"2"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderStatus"] isEqualToString:@"2"]){

                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"2"]){

                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderStatus"] isEqualToString:@"2"]){

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
            _arraySmonth=[NSMutableArray new];
            _arrayBmonth=[NSMutableArray new];
            _arrayYesterday=[NSMutableArray new];
            _arrayTaday=[NSMutableArray new];
            
            for (NSMutableDictionary * dict in _Allarray1) {
                if([dict[@"orderStatus"] isEqualToString:@"3"]){
                    [_arrayTaday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray2) {
                if([dict[@"orderStatus"] isEqualToString:@"3"]){
                    [_arrayYesterday addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray3) {
                if([dict[@"orderStatus"] isEqualToString:@"3"]){
                    [_arrayBmonth addObject:dict];
                }
            }
            for (NSMutableDictionary * dict in _Allarray4) {
                
                if([dict[@"orderStatus"] isEqualToString:@"3"]){
                    [_arraySmonth addObject:dict];
                }
            }
            //NSLog(@"%@",_arrayBmonth);
            [_tableView reloadData];
            
            //改变按钮颜色
            [self changeButttonTitle:107];
            break;
        }
        default:
            break;
    }
}
-(void)Dbuttonclick:(UISegmentedControl *)st{
    NSLog(@"st.selectIndex = %ld",(long)st.selectedSegmentIndex);
    if((long)st.selectedSegmentIndex==1||(long)st.selectedSegmentIndex==2){
        _scrollView.contentOffset=CGPointMake(deviceScreenWidth, 0);
        if((long)st.selectedSegmentIndex==1){
            [self loadData1];
        }else{
            [self loadData2];
        }
    }else{
        _scrollView.contentOffset=CGPointMake(0, 0);
        [self loadData];
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
    // Dispose of any resources that can be recreated.
}

@end
