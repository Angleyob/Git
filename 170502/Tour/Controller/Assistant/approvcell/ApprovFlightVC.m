//
//  ApprovFlightVC.m
//  Tour
//
//  Created by Euet on 17/2/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "ApprovFlightVC.h"
#import "HotelVC.h"

#import "order1Cell.h"
#import "order2Cell.h"
#import "order3Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "check1Cell.h"
#import "trainorder0.h"
#import "HorderCell.h"

#import "CJNmessCell.h"
#import "SPmencell.h"
#import "priceMesCellTableViewCell.h"
#import "PMCell.h"
@interface ApprovFlightVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    
    NSMutableArray * _Hmenarray;

    //底部视图
    UIView * bottomview;
    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableArray * _contactarray;
    UILabel * menla;
    UILabel * numeberla;

    //酒店预订详情
    UITableView * _htableView;
    //火车预订详情
    UITableView * _ttableView;
    //机票预订详情
    UITableView * _ftmesableView;
    //机票价格详情
    UITableView * _ftableView;

    
    //保险类型1：强制，2：赠送 3：默认（可选）
    int a;
    //保险份数
    int b;
    //保险单份价格
    int c;
    //保险总价 d=c*b*人数
    int d;
    //保险总价 d=c*b*人数
    int m;

    
    //火车价格详情
    UIView * view4;
    UIView* _Bottomconnetview;
    UILabel * mennum;
    UILabel * free;
    UILabel * tprice;

    
    //酒店价格详情
    UIView * hview4;
    UILabel * hfree;
    UILabel * htprice;
    
    BOOL isa;
}
@end

@implementation ApprovFlightVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden=YES;
    self.tabBarController.tabBar.hidden=YES;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    isa = NO;
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"审批详情";
    label.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back_chevron1"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
    
    UIButton * lookUpBut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-90, 10, 60, 44)];
    if([_orderType isEqualToString:@"机票"]){
        [lookUpBut setTitle:@"航班查询" forState:UIControlStateNormal];
    }else if ([_orderType isEqualToString:@"火车票"]){
        [lookUpBut setTitle:@"车次查询" forState:UIControlStateNormal];
    }else{
        [lookUpBut setTitle:@"酒店查询" forState:UIControlStateNormal];
    }
    lookUpBut.titleLabel.font=[UIFont systemFontOfSize:13];
    [lookUpBut setTitleColor:[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1] forState:UIControlStateNormal];
    [lookUpBut addTarget:self action:@selector(lookUpBut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lookUpBut];
    
    UIView * viewtitle = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE, 375, 50)]];
    viewtitle.backgroundColor = [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:viewtitle];
    UILabel * dlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 60, 22)]];
    if([_DandYStr isEqualToString:@"D"]){
        dlabel.text=@"待审批";
    }else{
        dlabel.text=@"已审批";
    }
    dlabel.adjustsFontSizeToFitWidth=YES;
    dlabel.textColor=[UIColor whiteColor];
    [viewtitle addSubview:dlabel];
    UILabel * olabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(190, 15, 170, 16)]];
    olabel.textColor=[UIColor whiteColor];
    olabel.textAlignment = NSTextAlignmentCenter;
    olabel.adjustsFontSizeToFitWidth=YES;
    olabel.text=[NSString stringWithFormat:@"订单号:%@",_orderStr];
    [viewtitle addSubview:olabel];
    
     bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
    [self.view addSubview:bottomview];
    
    if([_DandYStr isEqualToString:@"D"]){
        bottomview.hidden=NO;
    }else{
        bottomview.hidden=YES;
    }
    UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, (deviceScreenWidth-45)/2, 44)];
    //剪切
    button1.clipsToBounds=YES;
    //圆角
    button1.layer.cornerRadius = 5.0;
    [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
    [button1.layer setBorderWidth:1];
    [button1 setTitle:@"不通过" forState:UIControlStateNormal];
    button1.tag=301;
    [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];

    [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
    [bottomview addSubview:button1];
    UIButton * button2= [[UIButton alloc]initWithFrame:CGRectMake(15+(deviceScreenWidth-45)/2+15, 8, (deviceScreenWidth-45)/2, 44)];
    button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    [button2 setTitle:@"通过" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.tag=302;
    //剪切
    button2.clipsToBounds=YES;
    //圆角
    button2.layer.cornerRadius = 10.0;
    [bottomview addSubview:button2];
    [self creattableview];
    NSLog(@"%@",_orderType);
    if([_orderType isEqualToString:@"机票"]){
        [self loadDataF];
    }else if ([_orderType isEqualToString:@"火车票"]){
        [self loadDataT];
    }else{
        [self loadDataH];
    }
    [self loadDatamen];
    
}
-(void)loadDatamen{
    OrderApprovalRecordsQueryRequest * oaq = [OrderApprovalRecordsQueryRequest new];
    oaq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    oaq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    oaq.OrderNo=_orderStr;
    if([_orderType isEqualToString:@"机票"]){
        oaq.OrderType=@"1";
    }else if ([_orderType isEqualToString:@"火车票"]){
        oaq.OrderType=@"2";
    }else{
        oaq.OrderType=@"3";
    }
    oaq.Count=20;
    oaq.Start=0;
    [Approval OrderApprovalRecordsQuery:oaq success:^(id data) {
//        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
//            NSLog(@"%@",data[@"data"]);
            _SPmen=data[@"data"];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
//          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)loadDataF{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    _Messagedict=[NSMutableDictionary new];
    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
    infquery.OrderNo=_orderStr;
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight FlightOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
//        NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            _Messagedict=data;
            _FdataArray=_Messagedict[@"flightInfoList"];
//             NSLog(@"%@",_FdataArray);
            _menarray=[NSMutableArray new];
            for (NSMutableDictionary * dict in _Messagedict[@"passengerInfoList"]) {
                passageMenModel * model =[[passageMenModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_menarray addObject:model];
            }
            m=(long)_menarray.count;
            c=[_Messagedict[@"passengerInfoList"][0][@"insurPrice"] intValue];
            b=[_Messagedict[@"passengerInfoList"][0][@"insurNumber"] intValue];

        }
        [_tableView reloadData];
        [_ftableView reloadData];
        [_ftmesableView reloadData];

        NSLog(@"%@",_Messagedict);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)loadDataT{
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    _Messagedict=[NSMutableDictionary new];

    TrainOrderInfQuery * inf = [TrainOrderInfQuery new];
    inf.OrderNo=_orderStr;
    inf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    inf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Train TrainOrderInfQuery:inf success:^(id data) {
        [SVProgressHUD dismiss];
         NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _Messagedict=data[@"trainTicket"];
            _menarray=[NSMutableArray new];
            if([_Messagedict[@"orderStatus"] isEqualToString:@"1"]||[_Messagedict[@"orderStatus"] isEqualToString:@"A"]||[_Messagedict[@"orderStatus"] isEqualToString:@"B"]){
                bottomview.hidden=NO;
            }else{
                bottomview.hidden=YES;
            }
            for (NSMutableDictionary * dict in data[@"trainBoxList"]) {
                passageTrainMenModel * model =[[passageTrainMenModel alloc] init];
                [model setValuesForKeysWithDictionary:dict];
                [_menarray addObject:model];
            }
            tprice.text=[NSString stringWithFormat:@"票价:￥%.2f元/人        %ld人",[data[@"trainBoxList"][0][@"price"] floatValue],_menarray.count];
            free.text=[NSString stringWithFormat:  @"服务费:￥%.2f元/人    %ld人",[_Messagedict[@"fee"] floatValue],_menarray.count];
        }
        [_tableView reloadData];
        [_ttableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)loadDataH{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    _Hmenarray = [NSMutableArray new];
    _Messagedict=[NSMutableDictionary new];

    HotelOrderInfQuery * inf = [HotelOrderInfQuery new];
    inf.OrderNo=_orderStr;
    inf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    inf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Hotel HotelOrderInfQuery:inf success:^(id data) {
        [SVProgressHUD dismiss];
//       NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _Messagedict=data;
            NSArray * arr  = [_Messagedict[@"nameList"] componentsSeparatedByString:@","];
            _Hmenarray=[NSMutableArray arrayWithArray:arr];
        }
        htprice.text=[NSString stringWithFormat:@"房间价格:￥%.1f元     ×%@间",[_Messagedict[@"totalPrice"] floatValue]/[_Messagedict[@"roomNight"] floatValue]/[_Messagedict[@"roomNum"] floatValue],_Messagedict[@"roomNum"]];
        hfree.text=[NSString stringWithFormat:@"入住天数:             %@晚",_Messagedict[@"roomNight"]];
      
        [_tableView reloadData];
        [_htableView reloadData];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
 }
-(void)creattableview{
    if([_DandYStr isEqualToString:@"D"]){
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
    }else{
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-110) style:UITableViewStyleGrouped];
    }
    //_tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];

    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];

    _tableView1= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.alpha=1;
    _tableView1.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView1];
    
    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    
    _htableView= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _htableView.dataSource=self;
    _htableView.delegate=self;
    _htableView.alpha=1;
    _htableView.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_htableView];
    
    _ttableView= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _ttableView.dataSource=self;
    _ttableView.delegate=self;
    _ttableView.alpha=1;
    _ttableView.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_ttableView];

    _ftableView= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _ftableView.dataSource=self;
    _ftableView.delegate=self;
    _ftableView.alpha=1;
    _ftableView.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_ftableView];
    
    _ftmesableView= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _ftmesableView.dataSource=self;
    _ftmesableView.delegate=self;
    _ftmesableView.alpha=1;
    _ftmesableView.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_ftmesableView];


#pragma mark -火车价格详情
    view4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    tprice=[UILabel new];
    tprice.font=[UIFont systemFontOfSize:14];
    tprice.textAlignment=NSTextAlignmentCenter;
    
    //    tprice.text=[NSString stringWithFormat:@"票价:￥%d元/人     人数%ld",[[@"price"] intValue],_menarray.count];
    [view4 addSubview:tprice];
    [tprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    free=[UILabel new];
    free.font=[UIFont systemFontOfSize:14];
    free.textAlignment=NSTextAlignmentCenter;;
    //free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
    [view4 addSubview:free];
    [free mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
#pragma mark -酒店价格详情
    hview4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    hview4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:hview4];
    htprice=[UILabel new];
    htprice.font=[UIFont systemFontOfSize:14];
    htprice.textAlignment=NSTextAlignmentCenter;
    [hview4 addSubview:htprice];
    [htprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hview4).offset(20);
        make.top.equalTo(hview4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    hfree=[UILabel new];
    hfree.font=[UIFont systemFontOfSize:14];
    hfree.textAlignment=NSTextAlignmentCenter;
    [hview4 addSubview:hfree];
    [hfree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hview4).offset(20);
        make.top.equalTo(hview4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        
            if (section==0) {
                return 0.1;
            }else if(section==1){
                if([_orderType isEqualToString:@"机票"]){
                    return 40;
                }else if([_orderType isEqualToString:@"火车票"]){
                    return 40;
                }else{
                    return 40;
                }
            }
            else if(section==6){
                return 50;
            }else if(section==5){
                            if(_Messagedict[@"violateReason"]==nil){
                                return 0.01;
                            }else{
                                return 10;
                            }
            }else{
                return 10;
            }
    }
    else{
        return 1;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if (section==0) {
            return 60;
        }else if(section==1){
            if([_orderType isEqualToString:@"机票"]){
                return 40;
            }else if([_orderType isEqualToString:@"火车票"]){
                return 40;
            }else{
                return 40;
            }
        }
//        }else if(section==5){
//            if(_Messagedict[@"violateReason"]==nil){
//                return 0;
//            }else{
//                return 10;
//            }
        else
            return 0.01;
    }else{
        return 0.01;
    }
}
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([tableView isEqual:_tableView]){
        if(section==0){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 60)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50)];
            view1.backgroundColor=[UIColor whiteColor];
            [view addSubview:view1];
            
            UIButton * b1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 80, 20)];
            b1.titleLabel.font=[UIFont systemFontOfSize:13];
            [b1 setTitle:@"订单总金额" forState:UIControlStateNormal];
            [b1 setTitleColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
            [view1 addSubview:b1];
            
            UIView*view2=[[UIView alloc]initWithFrame:CGRectMake(deviceScreenWidth-100, 15, 80, 20)];
            view2.backgroundColor=[UIColor whiteColor];
            [view addSubview:view2];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
            lab.font=[UIFont systemFontOfSize:13];
            lab.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
            if([_orderType isEqualToString:@"机票"]){
                lab.text=[NSString stringWithFormat:@"￥%@",_Messagedict[@"ticketPrice"]];
            }else if ([_orderType isEqualToString:@"火车票"]){
                lab.text=[NSString stringWithFormat:@"￥%.2f",[_Messagedict[@"price"] floatValue]+[_Messagedict[@"fee"] floatValue]];
            }else{
                lab.text=[NSString stringWithFormat:@"￥%@",_Messagedict[@"totalPrice"]];
            }
            [view2 addSubview:lab];
            UITapGestureRecognizer *tablprice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtablprice:)];
            [view2 addGestureRecognizer:tablprice];
            return view;
        }
        else if(section==1){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 18, 16, 16)]];
            menimage.image=[UIImage imageNamed:@""];
            [view addSubview:menimage];
            UILabel * menmessagelabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(48, 16, 45, 18)]];
            menmessagelabel.text=@"联系人";
            menmessagelabel.adjustsFontSizeToFitWidth=YES;
            menmessagelabel.font = [UIFont systemFontOfSize:13];
            menmessagelabel.textColor=[UIColor grayColor];
            [view addSubview:menmessagelabel];
            menla =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(172, 16, 65, 18)]];
            if([_orderType isEqualToString:@"机票"]){
                menla.text=_Messagedict[@"contact"];
            }else if ([_orderType isEqualToString:@"火车票"]){
                menla.text=_Messagedict[@"contactName"];
            }else{
                menla.text=_Messagedict[@"linkInfoList"][0][@"contactName"];
            }
            menla.font = [UIFont systemFontOfSize:13];
            menla.textColor=[UIColor blackColor];
            [view addSubview:menla];
            numeberla =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(245, 16, 108, 18)]];
                      if([_orderType isEqualToString:@"机票"]){
                numeberla.text=_Messagedict[@"mobile"];
            }else if ([_orderType isEqualToString:@"火车票"]){
                numeberla.text=_Messagedict[@"contactPhone"];
            }else{
                numeberla.text=_Messagedict[@"linkInfoList"][0][@"mobile"];
            }
            numeberla.font = [UIFont systemFontOfSize:13];
            numeberla.textColor=[UIColor blackColor];
            [view addSubview:numeberla];
            view.backgroundColor=[UIColor whiteColor];
            if([_orderType isEqualToString:@"机票"]){
            }else if([_orderType isEqualToString:@"火车票"]){
            }else{
//                menla.hidden=YES;
//                numeberla.hidden=YES;
//                menmessagelabel.hidden=YES;
            }
            return view;
        }else{
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            return view;
        }
    }else{
        return 0;
    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{ if([tableView isEqual:_tableView]){
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
    else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 52, 16)];
        if([_orderType isEqualToString:@"机票"]){
            menlabel.text=@"乘机人";}
        else if ([_orderType isEqualToString:@"火车票"]){
            menlabel.text=@"乘车人";}
        else{
            menlabel.text=@"入住人";}
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        view.backgroundColor=[UIColor whiteColor];
        if([_orderType isEqualToString:@"机票"]){
        }else if([_orderType isEqualToString:@"火车票"]){
        }else{
//            menimage.hidden=YES;
//            menlabel.hidden=YES;
        }
        return view;
    }else if(section==6){
        UIView*view0=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50)];
        view0.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
      
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 10, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"alert"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 72, 16)];
        menlabel.text=@"审批情况";
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        view.backgroundColor=[UIColor whiteColor];
        [view0 addSubview:view];
        return view0;
    }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
}else{
    return 0;
}
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        
            if(indexPath.section==0){
                if([_orderType isEqualToString:@"机票"]){
                return 80;
                }else if([_orderType isEqualToString:@"火车票"]){
                    return 100;
                }else{
                    return 100;
                }
            }else if(indexPath.section==1){
                return 67/SCREEN_RATE;
            }
            else if(indexPath.section==6){
                   return 60/SCREEN_RATE;
            }else{
                return 60;
            }
    }else if([tableView isEqual:_ftableView]){
        return 30;
    }else if([tableView isEqual:_ttableView]){
        return 100;
    }else if([tableView isEqual:_htableView]){
       return 100;
    }else if([tableView isEqual:_ftmesableView]){
        return 160;
    }else{
        if(indexPath.section==0){
            return 160;
        }else{
            return  0;
        }
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return 7;
    }else if([tableView isEqual:_ftableView]){
        return _FdataArray.count;
    }else{
        return 1;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if (section==0) {
            if ([_orderType isEqualToString:@"机票"]) {
                return _FdataArray.count;
            }else{
                return 1;
            }
        }else if(section==2){
            return 1;
        }
        else if(section==1){
            if ([_orderType isEqualToString:@"机票"]) {
                return _menarray.count;
            }else if ([_orderType isEqualToString:@"火车票"]){
                return _menarray.count;
            }else{
                return _Hmenarray.count;
            }
        }
        else if(section==5){
         if([_orderType isEqualToString:@"机票"]){
             if(_FdataArray.count==2){
                return 4;
                }else{
                if([_Messagedict[@"violateReason"] isEqualToString:@""]){
                    return 0;
                }else{
                    return 2;
                }
                }
         }else if ([_orderType isEqualToString:@"火车票"]){
             if([_Messagedict[@"violateReason"] isEqualToString:@""]){
                 return 0;
             }else{
                 return 2;
             }
         }else{
             if([_Messagedict[@"violateReason"] isEqualToString:@""]){
                 return 0;
             }else{
                 return 2;
             }
            }
        }else if(section==6){
            return _SPmen.count;
        }else{
        return 1;
        }
    }else if([tableView isEqual:_ftableView]){
    return 5;
    }else if([tableView isEqual:_ttableView]){
        return 1;
    }else if([tableView isEqual:_htableView]){
        return 1;
    }else if([tableView isEqual:_ftmesableView]){
        return _FdataArray.count;
    } else{
        if (section==0) {
            return _FdataArray.count;
        }else{
            return 0;
        }
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
              if([_orderType isEqualToString:@"机票"]){
                order1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(indexPath.row==1){
                    cell.logoimage.image=[UIImage imageNamed:@"backward"];
                }
                cell.celloutlabel.text=[NSString stringWithFormat:@"%@",_FdataArray[indexPath.row][@"toDatetime"]];
                cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",_FdataArray[indexPath.row][@"fromCity"],_FdataArray[indexPath.row][@"toCity"]];
                return cell;
              }else if([_orderType isEqualToString:@"火车票"]){
                  trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                  // cell的复用
                  if (!cell) {
                      cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
                  }
                  cell.selectionStyle = UITableViewCellSelectionStyleNone;
                  cell.Pricetitle.hidden=YES;
                  cell.pricelabel.hidden=YES;
                  cell.freetitle.hidden=YES;
                  cell.freeprice.hidden=YES;
                  cell.jtbutton.hidden=YES;
                  cell.tgbutton.hidden=YES;
                  cell.viewline.hidden=YES;
                  
                  cell.trainNO.text=_Messagedict[@"trainNum"];
                  cell.fromstation.text=_Messagedict[@"fromStationName"];
                  cell.fromdata.text=[_Messagedict[@"departureDate"] substringFromIndex:5];
                  cell.fromtime.text=_Messagedict[@"departureTime"];
                  cell.tostation.text=_Messagedict[@"toStationName"];
                  cell.totime.text=_Messagedict[@"arrivalsTime"];
                  cell.todate.text=[_Messagedict[@"arrivalsDate"] substringFromIndex:5];
                  return cell;
              }else{
                  HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                  // cell的复用
                  if (!cell) {
                      cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
                  }
                  cell.hotelnamelabel.text=_Messagedict[@"hotelName"];
                  cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
                  cell.roomname.text=_Messagedict[@"roomName"];
                  cell.roomname.adjustsFontSizeToFitWidth=YES;
                  cell.hotelmess.hidden=YES;
//                  cell.hotelmess.textColor=[UIColor grayColor];
//                  cell.hotelmess.adjustsFontSizeToFitWidth=YES;
                  NSDate * d1=  [LGLCalendarDate dateFromString:_Messagedict[@"priceInfoList"][0][@"date"]];
                  
                  NSDate * d2=  [LGLCalendarDate dateFromString:_Messagedict[@"checkOutDate"]];
                  
                  NSInteger h=[weekday getDaysFrom:d1 To:d2];
                  cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共%ld晚",_Messagedict[@"priceInfoList"][0][@"date"],_Messagedict[@"checkOutDate"],h];
                  cell.datelabel.adjustsFontSizeToFitWidth=YES;
                  cell.datelabel.font=[UIFont systemFontOfSize:12];
                  cell.selectionStyle = UITableViewCellSelectionStyleNone;
                  return cell;
              }
        }else if(indexPath.section==1){
            CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
            if (!cell) {
                cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.disledimage.hidden=YES;
            if([_orderType isEqualToString:@"机票"]){
            [cell setCellWithModel:_menarray[indexPath.row]];
            }else if ([_orderType isEqualToString:@"火车票"]){
            [cell setCellWithModelT:_menarray[indexPath.row]];
            }else{
                cell.namelabel.text=_Hmenarray[indexPath.row];
                cell.typelabel.text=@"成人";
                cell.label3.hidden=YES;
            }
            switch (indexPath.row) {
                case 0:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_1"];
                    break;
                case 1:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_2"];
                    break;
                case 2:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_3"];
                    break;
                case 3:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_4"];
                    break;
                case 4:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_5"];
                    break;
                case 5:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_6"];
                    break;
                case 6:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_7"];
                    break;
                case 7:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_8"];
                    break;
                case 8:
                    cell.rightimage.image=[UIImage imageNamed:@"flag_9"];
                    break;
                default:
                    break;
            }
            return cell;
        }else if(indexPath.section==2){
            
            if([_orderType isEqualToString:@"机票"]){
                order3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId3"];
                if (!cell) {
                    cell= (order3Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order3Cell" owner:self options:nil]  lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.rightbut.hidden=YES;
               
                passageMenModel * model =[[passageMenModel alloc] init];
                model=_menarray[indexPath.row];
                if([[NSString stringWithFormat:@"%@",model.insurPrice] isEqualToString:@"0"]){
                    if ([[NSString stringWithFormat:@"%@",model.insurNumber] isEqualToString:@"0"]) {
                          cell.insurelabel.text=@"(赠送)";
                    }else{
                    cell.insurelabel.text=[NSString stringWithFormat:@"(赠送)%@份x%ld人",model.insurNumber,_menarray.count];
                    }
                    }else{
                      cell.insurelabel.text=[NSString stringWithFormat:@"￥%@×%@份x%ld人",model.insurPrice,model.insurNumber,_menarray.count];
    
                }
//                if(a==2){
//                    cell.insurelabel.text=[NSString stringWithFormat:@"%d份/人",b];
//                }else if (a==1){
//                    cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%d份/人",c,b];
//                }else{
//                    // NSLog(@"%d",a);
//                    cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%d份/人",c,b];
//                }
               
                return cell;
            }else if ([_orderType isEqualToString:@"火车票"]){
                order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
                }
                cell.MsszgeLabel.textAlignment=NSTextAlignmentRight;
                cell.MsszgeLabel.text=[NSString stringWithFormat:@"￥%@元/人",_Messagedict[@"fee"]];
                cell.wblabel.text=@"服务费";
                return cell;
            }else{
                order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
                }
                cell.MsszgeLabel.textAlignment=NSTextAlignmentRight;
              
                NSLog(@"%@",_Messagedict[@"payType"]);
                
                if([_Messagedict[@"payType"] isEqualToString:@"0"]){
                    cell.MsszgeLabel.text=@"预付酒店";
                    cell.MsszgeLabel.textColor=[UIColor blackColor];
                }else{
                    cell.MsszgeLabel.text=@"现付酒店";
                    cell.MsszgeLabel.textColor=[UIColor blackColor];
                }
                cell.wblabel.text=@"支付类型";
                return cell;
            }
        }else if(indexPath.section==3||indexPath.section==4){
            order4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId4"];
            if (!cell) {
                cell= (order4Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order4Cell" owner:self options:nil]  lastObject];
            }
            cell.rightbut.hidden=YES;

            if (isa==YES) {
                cell.hidden=YES;
            }
            if (indexPath.section==3) {
                cell.titlelabel.adjustsFontSizeToFitWidth = YES;
                cell.costlabel.adjustsFontSizeToFitWidth = YES;
                cell.titlelabel.text=@"项目";
                if(deviceScreenWidth==320){
                cell.costlabel.font =[UIFont systemFontOfSize:13];
                }
                cell.costlabel.textAlignment=NSTextAlignmentRight;
                if([_orderType isEqualToString:@"机票"]){
                    cell.costlabel.text=_Messagedict[@"project"];
                }else if ([_orderType isEqualToString:@"火车票"]){
                    cell.costlabel.text=_Messagedict[@"projectName"];
                }else{
                    cell.costlabel.text=_Messagedict[@"projectName"];
                }
            }else{
                cell.costlabel.adjustsFontSizeToFitWidth = YES;
                cell.titlelabel.adjustsFontSizeToFitWidth = YES;
                cell.titleimage.image=[UIImage imageNamed:@"center"];
                cell.titlelabel.text=@"成本中心";
                cell.costlabel.textAlignment=NSTextAlignmentRight;
                if(deviceScreenWidth==320){
                    cell.costlabel.font =[UIFont systemFontOfSize:13];
                }
            cell.costlabel.text=_Messagedict[@"costCenterName"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.section==6){
            SPmencell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdSP"];
            if (!cell) {
                cell = [[SPmencell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdSP"];
            }
            cell.menlabel.text=[NSString stringWithFormat:@"审批人%ld",indexPath.row+1];
            cell.mennamelabel.text=_SPmen[(_SPmen.count-1)-(indexPath.row)][@"empName"];
//            cell.messageLabel.text=_SPmen[indexPath.row][@"approvalopinion"];

            if([_SPmen[(_SPmen.count-1)-(indexPath.row)][@"approveStatus"] isEqualToString:@""]){
                   cell.messageLabel.text=@"待审批";
            }else if([_SPmen[(_SPmen.count-1)-(indexPath.row)][@"approveStatus"] isEqualToString:@"1"])
            {
                        cell.messageLabel.text=@"已通过";
            }else{
                        cell.messageLabel.text=@"不通过";
            }
             return cell;
        }
        else{
            order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId5"];
            if (!cell) {
                cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
            }
            if (isa==YES) {
                cell.hidden=YES;
            }else{
//                if([[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"] isEqualToString:@"hg"]){
//                 cell.hidden=YES;
//                }
            }
            if(_FdataArray.count!=2){
                if(indexPath.row==0){
                    if([_orderType isEqualToString:@"机票"]){
                        cell.wblabel.adjustsFontSizeToFitWidth = YES;
                        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                        cell.wblabel.text=@"违背事项";
                        cell.MsszgeLabel.text=_Messagedict[@"violateItem"];
                        if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                        }
                    }else if ([_orderType isEqualToString:@"火车票"]){
                        cell.wblabel.adjustsFontSizeToFitWidth = YES;
                        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                        cell.MsszgeLabel.text=_Messagedict[@"violateReason"];
                        cell.wblabel.text=@"违背事项";
                        if(deviceScreenWidth==320){
                            cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                        }
                    }else{
                        cell.wblabel.adjustsFontSizeToFitWidth = YES;
                        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                        cell.wblabel.text=@"违背事项";
                        cell.MsszgeLabel.text=_Messagedict[@"violateItem"];
                        if(deviceScreenWidth==320){
                            cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                        }  
                        
                    }
                }else{
                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.text=_Messagedict[@"violateReason"];
                    cell.wblabel.text=@"违背原因";
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.titleimage.image=[UIImage imageNamed:@""];
                  //cell.MsszgeLabel.text=_erroMessage;
                }
            }else{
                if(indexPath.row==0){
                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背事项(去程)";
                    cell.MsszgeLabel.text=_Messagedict[@"contact"];
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                }else if(indexPath.row==1){
                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背原因(去程)";
                    cell.titleimage.image=[UIImage imageNamed:@""];
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                }else if(indexPath.row==2){
                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背事项(回程)";
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                }else if(indexPath.row==3){
                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背原因(回程)";
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.titleimage.image=[UIImage imageNamed:@""];
                    cell.MsszgeLabel.text=_FdataArray[1][@"erroMessage"];
                }
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if ([tableView isEqual:_ftableView]){
        if(indexPath.section==0){
            if(indexPath.row==0){
                priceMesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                    cell= (priceMesCellTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"priceMesCellTableViewCell" owner:self options:nil]  lastObject];
                }
                return cell;
            }else{
                PMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                    cell= (PMCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PMCell" owner:self options:nil]  lastObject];
                }
                if(indexPath.row==2){
                    cell.titlelab.text=@"机建燃油费";
                   
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_Messagedict[@"airConstructionFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
                    
                }else if (indexPath.row==3){
                    cell.titlelab.text=@"航意险";
                    if(a==2){
                        cell.price.text=@"￥0.0";
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%d.0",c];
                    }
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份",b*m];
                }else if(indexPath.row==4){
                    cell.titlelab.text=@"服务费";
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_Messagedict[@"serviceFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_Messagedict[@"settlePrice"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
                }
                return cell;
            }
        }else{
            if(indexPath.row==0){
                priceMesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                    cell= (priceMesCellTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"priceMesCellTableViewCell" owner:self options:nil]  lastObject];
                }
                cell.qcimage.image=[UIImage imageNamed:@"backward"];
                cell.qclabel.text=@"返程";
                return cell;
            }else{
                PMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                    cell= (PMCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PMCell" owner:self options:nil]  lastObject];
                }
                if(indexPath.row==2){
                    cell.titlelab.text=@"机建燃油";
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray[1][@"airConstructionFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份", m];
                    
                }else if (indexPath.row==3){
                    cell.titlelab.text=@"航意险";
                    if(a==2){
                        cell.price.text=@"￥0.0";
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%d.0",c];
                    }
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份",b];
                }else if(indexPath.row==4){
                    cell.titlelab.text=@"服务费";
                    cell.price.text=[NSString stringWithFormat:@"￥%@",_FdataArray[0][@"serviceFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
                    
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray[1][@"price"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份", m];
                }
                return cell;
            }
        }
        
    }else if ([tableView isEqual:_ttableView]){
        trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Pricetitle.hidden=YES;
        cell.pricelabel.hidden=YES;
        cell.freetitle.hidden=YES;
        cell.freeprice.hidden=YES;
        cell.jtbutton.hidden=YES;
        cell.tgbutton.hidden=YES;
        cell.viewline.hidden=YES;
        
        cell.trainNO.text=_Messagedict[@"trainNum"];
        cell.fromstation.text=_Messagedict[@"fromStationName"];
        cell.fromdata.text=[_Messagedict[@"departureDate"] substringFromIndex:5];
        cell.fromtime.text=_Messagedict[@"departureTime"];
        cell.tostation.text=_Messagedict[@"toStationName"];
        cell.totime.text=_Messagedict[@"arrivalsTime"];
        cell.todate.text=[_Messagedict[@"arrivalsDate"] substringFromIndex:5];
        return cell;
    }else if ([tableView isEqual:_htableView]){
        HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
        }
        cell.hotelnamelabel.text=_Messagedict[@"hotelName"];
        cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
        cell.roomname.text=_Messagedict[@"roomName"];
        cell.roomname.adjustsFontSizeToFitWidth=YES;
        cell.hotelmess.hidden=YES;
        //                  cell.hotelmess.textColor=[UIColor grayColor];
        //                  cell.hotelmess.adjustsFontSizeToFitWidth=YES;
        NSDate * d1=  [LGLCalendarDate dateFromString:_Messagedict[@"priceInfoList"][0][@"date"]];
        NSDate * d2=  [LGLCalendarDate dateFromString:_Messagedict[@"checkOutDate"]];
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共%ld晚",_Messagedict[@"priceInfoList"][0][@"date"],_Messagedict[@"checkOutDate"],h];
        cell.datelabel.adjustsFontSizeToFitWidth=YES;
        cell.datelabel.font=[UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if ([tableView isEqual:_ftmesableView]){
        check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            cell.titleimage.image=[UIImage imageNamed:@"backward"];
        }
        cell.outdatalabel.text=[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
        cell.outTime.text=[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(11, 5)];
        cell.arriveTime.text=[_FdataArray[indexPath.row][@"toDatetime"] substringWithRange:NSMakeRange(11, 5)];
        cell.copany.text=[NSString stringWithFormat:@"%@|%@",_FdataArray[indexPath.row][@"airwayName"],_FdataArray[indexPath.row][@"flightNo"]];
        cell.copany.adjustsFontSizeToFitWidth=YES;
      
        cell.bettenCity.text=_FdataArray[indexPath.row][@"stopOver"];
        
        if(![_FdataArray[indexPath.row][@"meal"]isEqualToString:@""]){
            cell.meallabel.text=@"有餐食";
        }else{
            cell.meallabel.text=@"无";
        }
        cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_FdataArray[indexPath.row][@"planeType"]];
        cell.arrviCity.text=_FdataArray[indexPath.row][@"toCity"];
        cell.outCity.text=_FdataArray[indexPath.row][@"fromCity"];
//        cell.arrviCity.text=[NSString stringWithFormat:@"%@ %@",_FdataArray[indexPath.row][@"toCity"],_FdataArray[indexPath.row][@"toTerminal"]];
//        cell.outCity.text=[NSString stringWithFormat:@"%@ %@",_FdataArray[indexPath.row][@"fromCity"],_FdataArray[indexPath.row][@"fromTerminal"]];
//
        
        //        NSString *str3 = [_FdataArray[indexPath.row][@"flyTime"] stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
//        cell.flyTime.text=[NSString stringWithFormat:@"%@分钟",str3];
        cell.flyTime.hidden=YES;
        cell.airNo.hidden=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        return nil;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([tableView isEqual:_tableView]){
        if (indexPath.row==0) {
            if ([_orderType isEqualToString:@"火车票"]) {
                _ttableView.frame=CGRectMake(0, deviceScreenHeight-100, deviceScreenWidth, 100);
                _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
            }else if  ([_orderType isEqualToString:@"酒店"]) {
                _htableView.frame=CGRectMake(0, deviceScreenHeight-100, deviceScreenWidth, 100);
                _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
            }else{
                _ftmesableView.frame=CGRectMake(0, deviceScreenHeight-130, deviceScreenWidth, 130);
                _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
            }
        }
    }
}
-(void)SPclick:(UIButton*)send{
    ApproveRequest * aal = [ApproveRequest new];
    aal.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    aal.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    aal.OrderNo=_orderStr;
    //获取当前时间并转换为字符串
    NSDate * date1 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* dateString = [dateFormatter stringFromDate:date1];
    aal.AprvDatetime=dateString;
    if([_orderType isEqualToString:@"机票"]){
        aal.OrderType=@"1";
    }else if ([_orderType isEqualToString:@"火车票"]){
        aal.OrderType=@"5";
    }else{
        aal.OrderType=@"4";
    }
    if(send.tag==301){
        aal.AprvStatus=@"0";
        NSString *title =@"审批备注";
       NSString *message =@"请填写驳回的原因(选填)";
        NSString *cancelButtonTitle = @"取消";
        NSString *otherButtonTitle = @"确定";
        
       UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
        }];
        [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder=@"如：费用过高";
            textField.secureTextEntry = NO;
        }];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            // 读取文本框的值显示出来
            UITextField * mess = alertController.textFields.firstObject;
            aal.AprvContent= mess.text;
  //      NSLog(@"%@",mess.text);
            [Approval Approve:aal success:^(id data) {
            NSLog(@"%@",data);
                if([data[@"status"] isEqualToString:@"T"]){
                    [UIAlertView showAlertWithTitle1:data[@"message"] duration:2];
                    [self.navigationController popViewControllerAnimated:NO];
                    // [self dismissViewControllerAnimated:NO completion:nil];
                }
            } failure:^(NSError *error) {
            }];
        }];
        
        [alertController addAction:cancelAction];
        [alertController addAction:otherAction];
        [self presentViewController:alertController animated:YES completion:nil];
        }else{
        aal.AprvStatus=@"1";
        [Approval Approve:aal success:^(id data) {
            if([data[@"status"] isEqualToString:@"T"]){
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:2];
                [self.navigationController popViewControllerAnimated:NO];
//               [self dismissViewControllerAnimated:NO completion:nil];
            }
        } failure:^(NSError *error) {
        }];
    }
}
#pragma mark -查询航班，车次 ，酒店
-(void)lookUpBut:(UIButton*)send{
    
    if([_orderType isEqualToString:@"机票"]){
        FlightMessageVC * flight  = [FlightMessageVC new];
        flight.FdataArray=_FdataArray;
        flight.hidesBottomBarWhenPushed=YES;
        flight.Approval=YES;
        [self.navigationController  pushViewController:flight animated:YES];
    }else if ([_orderType isEqualToString:@"火车票"]){
        TrainVC * train  = [TrainVC new];
        train.TdataDict=_Messagedict;
        train.hidesBottomBarWhenPushed=YES;
        train.Approval=YES;
        [self.navigationController  pushViewController:train animated:YES];
    }else{
        HotelVC * hotel  = [HotelVC new];
        hotel.HdataDict=_Messagedict;
        hotel.hidesBottomBarWhenPushed=YES;
        hotel.Approval=YES;
        [self.navigationController  pushViewController:hotel animated:YES];
    }
}
#pragma mark -返回
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO];
// [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)showGFtablprice:(UITapGestureRecognizer *)tablprice{
     if([_orderType isEqualToString:@"机票"]){
    [UIView animateWithDuration:0.2 animations:^{
        _ftableView.frame=CGRectMake(0, deviceScreenHeight-160, deviceScreenWidth, 160);
        _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
     }else if([_orderType isEqualToString:@"火车票"]){
         [UIView animateWithDuration:0.1 animations:^{
             view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
             _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
         }completion:nil];
     }else{
         [UIView animateWithDuration:0.1 animations:^{
             hview4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
             _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
         }completion:nil];
 
     }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.2 animations:^{
        _ttableView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 100);
        _htableView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 100);
        _ftableView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160);
        _ftmesableView.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160);
        view4.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60);
        hview4.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60);
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);

    }completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
