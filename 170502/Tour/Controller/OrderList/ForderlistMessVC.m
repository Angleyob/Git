//
//  ForderlistMessVC.m
//  Tour
//
//  Created by Euet on 17/2/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "ForderlistMessVC.h"
#import "orderPayVc.h"

#import "ForderTPmessVC.h"
#import "ForderGQmessVC.h"

#import "order1Cell.h"
#import "order2Cell.h"
#import "order3Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "check1Cell.h"
#import "CJNmessCell.h"
#import "SPmencell.h"

@interface ForderlistMessVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    
    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableArray * _contactarray;
    UILabel * menla;
    UILabel * numeberla;
    
    UIView * bottomview;
    //保险类型1：强制，2：赠送 3：默认（可选）
    int a;
    //保险份数
    int b;
    //保险单份价格
    int c;
    //保险总价 d=c*b*人数
    int d;
    
    BOOL isa;
  
}
@end

@implementation ForderlistMessVC
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    isa = NO;
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"订单详情";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    UIView * viewtitle = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE, 375, 50)]];
    viewtitle.backgroundColor = [UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:viewtitle];
    UILabel * dlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 60, 22)]];
    dlabel.text=_statusStr;
    dlabel.adjustsFontSizeToFitWidth=YES;
    dlabel.textColor=[UIColor whiteColor];
    [viewtitle addSubview:dlabel];
    UILabel * olabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(190, 15, 170, 16)]];
    olabel.textColor=[UIColor whiteColor];
    olabel.textAlignment = NSTextAlignmentCenter;
    olabel.adjustsFontSizeToFitWidth=YES;
    olabel.text=[NSString stringWithFormat:@"订单号:%@",_orderStr];
    [viewtitle addSubview:olabel];
    
//    if([_DandYStr isEqualToString:@"D"]){
//        bottomview.hidden=NO;
//    }else{
//        bottomview.hidden=YES;
//    }
    
   bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
    [self.view addSubview:bottomview];
    
    if([_Messagedict[@"ifCancel"] isEqualToString:@"0"]&&[_Messagedict[@"ifSendApprove"] isEqualToString:@"0"]&&[_Messagedict[@"ifPay"] isEqualToString:@"1"]){
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
//        [self.view addSubview:bottomview];
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, (deviceScreenWidth-45)/2, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"取消订单" forState:UIControlStateNormal];
        button1.tag=301;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        UIButton * button2= [[UIButton alloc]initWithFrame:CGRectMake(15+(deviceScreenWidth-45)/2+15, 8, (deviceScreenWidth-45)/2, 44)];
        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        [button2 setTitle:@"送审" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.tag=302;
        //剪切
        button2.clipsToBounds=YES;
        //圆角
        button2.layer.cornerRadius = 10.0;
        [bottomview addSubview:button2];
    }else if ([_Messagedict[@"ifCancel"] isEqualToString:@"0"]&&[_Messagedict[@"ifSendApprove"] isEqualToString:@"1"]&&[_Messagedict[@"ifPay"] isEqualToString:@"1"]){
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
//        [self.view addSubview:bottomview];
//        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, deviceScreenWidth-30, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"取消订单" forState:UIControlStateNormal];
        button1.tag=303;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        
    }else if ([_Messagedict[@"ifCancel"] isEqualToString:@"1"]&&[_Messagedict[@"ifSendApprove"] isEqualToString:@"1"]&&[_Messagedict[@"ifPay"] isEqualToString:@"0"]){
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
//        [self.view addSubview:bottomview];
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, deviceScreenWidth-30, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"支付" forState:UIControlStateNormal];
        button1.tag=305;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        
    }else if ([_Messagedict[@"ifCancel"] isEqualToString:@"0"]&&[_Messagedict[@"ifSendApprove"] isEqualToString:@"1"]&&[_Messagedict[@"ifPay"] isEqualToString:@"0"]){
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, (deviceScreenWidth-45)/2, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"取消订单" forState:UIControlStateNormal];
        button1.tag=304;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        UIButton * button2= [[UIButton alloc]initWithFrame:CGRectMake(15+(deviceScreenWidth-45)/2+15, 8, (deviceScreenWidth-45)/2, 44)];
        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        [button2 setTitle:@"支付" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.tag=305;
        //剪切
        button2.clipsToBounds=YES;
        //圆角
        button2.layer.cornerRadius = 10.0;
        [bottomview addSubview:button2];
    }else if ([_Messagedict[@"ifRefund"] isEqualToString:@"0"]&&[_Messagedict[@"ifChange"] isEqualToString:@"1"]){
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
//        [self.view addSubview:bottomview];
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, deviceScreenWidth-30, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"申请退票" forState:UIControlStateNormal];
        button1.tag=306;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];

        
    }else if ([_Messagedict[@"ifRefund"] isEqualToString:@"0"]&&[_Messagedict[@"ifChange"] isEqualToString:@"0"]){
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
//        [self.view addSubview:bottomview];
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, (deviceScreenWidth-45)/2, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"申请退票" forState:UIControlStateNormal];
        button1.tag=306;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        UIButton * button2= [[UIButton alloc]initWithFrame:CGRectMake(15+(deviceScreenWidth-45)/2+15, 8, (deviceScreenWidth-45)/2, 44)];
        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        [button2 setTitle:@"申请改签" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.tag=307;
        //剪切
        button2.clipsToBounds=YES;
        //圆角
        button2.layer.cornerRadius = 5.0;
        [button2.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button2.layer setBorderWidth:1];

        [bottomview addSubview:button2];
    }else {
       if([_statusStr isEqualToString:@"已取消"]) {
//           UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60/SCREEN_RATE, 375/SCREEN_RATE, 60/SCREEN_RATE)];
//           [self.view addSubview:bottomview];
           
           UILabel * button1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 20, 210, 16)]];
           //        //剪切
           //        button1.clipsToBounds=YES;
           //        //圆角
           //        button1.layer.cornerRadius = 5.0;
           //        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
           //        [button1.layer setBorderWidth:1];
           button1.adjustsFontSizeToFitWidth=YES;
           button1.text=@"订单审批不通过，请与审批人沟通";
           [bottomview addSubview:button1];
           UIButton * button2= [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(250, 8,110, 44)]];
           button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
           button2.titleLabel.font=[UIFont systemFontOfSize:14];
           [button2 setTitle:@"重新申请" forState:UIControlStateNormal];
           [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
           [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
           button2.tag=308;
           //剪切
           button2.clipsToBounds=YES;
           //圆角
           button2.layer.cornerRadius = 10.0;
           [bottomview addSubview:button2];
        }
    }
    [self creattableview];
    [self loadDataF];
    [self loadDatamen];
}
-(void)loadDatamen{
    OrderApprovalRecordsQueryRequest * oaq = [OrderApprovalRecordsQueryRequest new];
    oaq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    oaq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    oaq.OrderNo=_orderStr;
    oaq.OrderType=@"1";
    oaq.Count=20;
    oaq.Start=0;
    [Approval OrderApprovalRecordsQuery:oaq success:^(id data) {
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            NSLog(@"%@",data[@"data"]);
            _SPmen=data[@"data"];
        }
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
    
    
}
-(void)loadDataF{
//    [SVProgressHUD showWithStatus:@"正在加载"];
//    [SVProgressHUD show];
//    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
//    infquery.OrderNo=_orderStr;
//    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
//    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
//    [Flight FlightOrderInfQuery:infquery success:^(id data) {
//        [SVProgressHUD dismiss];
//        _Messagedict=data;
        if([_Messagedict[@"businessType"] isEqualToString:@"2"]){
            isa=YES;
        }
        _FdataArray=_Messagedict[@"flightInfoList"];
        _menarray=[NSMutableArray new];
        for (NSMutableDictionary * dict in _Messagedict[@"passengerInfoList"]) {
            passageMenModel * model =[[passageMenModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_menarray addObject:model];
        }
        [_tableView reloadData];
//        NSLog(@"%@",_Messagedict);
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
//    }];
}
-(void)creattableview{
//    if([_DandYStr isEqualToString:@"D"]){
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
//    }else{
//        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-110) style:UITableViewStyleGrouped];
//    }
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
}

//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        
     if(isa==YES){
         if (section==0) {
             return 0.1;
         }else if(section==1){
             
             return 40;
         }
         else if(section==6){
             return 50;
         }else if(section==5||section==4||section==3){
             return 0.01;
         }else{
             return 10;
         }
     }
      else{
        if (section==0) {
            return 0.1;
        }else if(section==1){
            
                return 40;
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
                return 40;
                    }
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
            [view1 addSubview:view2];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 20)];
            lab.font=[UIFont systemFontOfSize:13];
            lab.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
            NSLog(@"%@",_Messagedict);
            lab.text=[NSString stringWithFormat:@"￥%ld元",[_Messagedict[@"salePrice"] intValue]+([_Messagedict[@"airConstructionFee"] intValue]+[_Messagedict[@"serviceFee"] intValue]+[_Messagedict[@"passengerInfoList"][0][@"insurPrice"] intValue])*_menarray.count];
            [view2 addSubview:lab];
         return view;
        }
        else if(section==1){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 18, 16, 16)]];
            menimage.image=[UIImage imageNamed:@""];
            [view addSubview:menimage];
            UILabel * menmessagelabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 16, 45, 18)]];
            menmessagelabel.text=@"联系人";
            menmessagelabel.adjustsFontSizeToFitWidth=YES;
            menmessagelabel.font = [UIFont systemFontOfSize:13];
            menmessagelabel.textColor=[UIColor grayColor];
            [view addSubview:menmessagelabel];
            menla =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(172, 16, 65, 18)]];
            menla.text=_Messagedict[@"contact"];
            menla.font = [UIFont systemFontOfSize:13];
            menla.textColor=[UIColor blackColor];
            [view addSubview:menla];
            numeberla =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(245, 16, 108, 18)]];
            
            numeberla.text=_Messagedict[@"mobile"];
            numeberla.font = [UIFont systemFontOfSize:13];
            numeberla.textColor=[UIColor blackColor];
            [view addSubview:numeberla];
            view.backgroundColor=[UIColor whiteColor];
            
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
            menlabel.text=@"乘机人";
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        view.backgroundColor=[UIColor whiteColor];
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
        if(isa==YES){
            if(indexPath.section==0){
                return 80;
            }else if(indexPath.section==1){
                return 67/SCREEN_RATE;
            }
            else if(indexPath.section==6){
                return 60/SCREEN_RATE;
            }else if(indexPath.section==4||indexPath.section==3||indexPath.section==5){
                return 0.01;
            }else{
                return 60;
            }
        }else{
            if(indexPath.section==0){
                return 80;
            }else if(indexPath.section==1){
                return 67/SCREEN_RATE;
            }
            else if(indexPath.section==6){
                return 60/SCREEN_RATE;
            }else{
                return 60;
            }        }
 
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
        if ([_statusStr isEqualToString:@"审批中"]||[_statusStr isEqualToString:@"待审批"]) {
            return 7;
        }else{
            return 6;
        }
    }else{
        return 1;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if (section==0) {
                return _FdataArray.count;
            
        }else if(section==2){
            return 1;
        }
        else if(section==1){
            return _menarray.count;
        }
        else if(section==5){
                if(_FdataArray.count==2){
                    return 4;
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
    }else{
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
                order1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
                }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(indexPath.row==1){
                    cell.logoimage.image=[UIImage imageNamed:@"backward"];
                }
                cell.celloutlabel.text=[NSString stringWithFormat:@"%@",_FdataArray[indexPath.row][@"toDatetime"]];
                cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",_FdataArray[indexPath.row][@"fromCity"],_FdataArray[indexPath.row][@"toCity"]];
                return cell;
        
        }else if(indexPath.section==1){
            CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
            if (!cell) {
                cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.disledimage.hidden=YES;
            [cell setCellWithModel:_menarray[indexPath.row]];
        
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
                        order3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId3"];
                if (!cell) {
                    cell= (order3Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order3Cell" owner:self options:nil]  lastObject];
                }
            
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.rightbut.hidden=YES;
                if(a!=0){
                    if(a==2){
                        cell.insurelabel.text=[NSString stringWithFormat:@"%d份/人",b];
                    }else if (a==1){
                        cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%d份/人",c,b];
                    }else{
                        // NSLog(@"%d",a);
                        cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%d份/人",c,b];
                    }
                }
                return cell;
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
                    cell.costlabel.text=_Messagedict[@"project"];
                
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
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            cell.menlabel.text=[NSString stringWithFormat:@"审批人%ld",indexPath.row+1];
            cell.mennamelabel.text=_SPmen[indexPath.row][@"empName"];
            
//            if([_DandYStr isEqualToString:@"D"]){
//                cell.messageLabel.text=@"待审批";
//            }else{
//                cell.messageLabel.text=@"已通过";
//            }
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
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            if(_FdataArray.count!=2){
                if(indexPath.row==0){
                        cell.wblabel.adjustsFontSizeToFitWidth = YES;
                        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                        cell.wblabel.text=@"违背事项";
                        cell.MsszgeLabel.text=_Messagedict[@"violateItem"];
                        if(deviceScreenWidth==320){
                            cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
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
    }else{
        check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            cell.titleimage.image=[UIImage imageNamed:@"backward"];
        }
        
        NSString * weerstr =[weekday weekdaywith1:[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)]];
        cell.outdatalabel.text=[NSString stringWithFormat:@"%@ %@",[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)],weerstr];
        cell.outTime.text=[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(11, 5)];
        cell.arriveTime.text=[_FdataArray[indexPath.row][@"toDatetime"] substringWithRange:NSMakeRange(11, 5)];
        cell.copany.text=_FdataArray[indexPath.row][@"airwayName"];
        cell.copany.adjustsFontSizeToFitWidth=YES;
        
        cell.bettenCity.hidden=YES;
        cell.meallabel.hidden=YES;
        cell.airNo.hidden=YES;
        cell.timeimg.hidden=YES;
        cell.mealimg.hidden=YES;
        cell.flyimage.hidden=YES;
//
//        if(![_FdataArray[indexPath.row][@"meal"]isEqualToString:@""]){
//            cell.meallabel.text=@"有餐食";
//        }else{
//            cell.meallabel.text=@"无";
//        }

        cell.arrviCity.text=_FdataArray[indexPath.row][@"toCity"];
        cell.outCity.text=_FdataArray[indexPath.row][@"fromCity"];
//        NSString *str3 = [_FdataArray[indexPath.row][@"flyTime"] stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
        cell.flyTime.text=[NSString stringWithFormat:@"%@",_FdataArray[indexPath.row][@"flightNo"]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_tableView]) {
        if (indexPath.section==0){
            if (indexPath.row==0) {
                if(_FdataArray.count==2){
                    [UIView animateWithDuration:0.01 animations:^{
                        _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-260);
                        _tableView1.frame=CGRectMake(0, deviceScreenHeight-260,deviceScreenWidth , 260);
                        bottomview.userInteractionEnabled=NO;
                        [_tableView1 reloadData];
                    }completion:nil];
                }else{
                    [UIView animateWithDuration:0.01 animations:^{
                        _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-130);
                        _tableView1.frame=CGRectMake(0, deviceScreenHeight-130,deviceScreenWidth , 130);
                        bottomview.userInteractionEnabled=NO;
                        
                        [_tableView1 reloadData];
                    }completion:nil];
                }
                
            }

        }
            }else{
        bottomview.userInteractionEnabled=YES;
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , deviceScreenHeight);
  
    }
    
}
-(void)SPclick:(UIButton*)send{
    if(send.tag==301||send.tag==303||send.tag==304){
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        self.view.userInteractionEnabled=NO;
        //取消订单
        FlightOrderCancel *  foc =[FlightOrderCancel new];
        foc.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        foc.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        foc.OrderID=_orderStr;
        [Flight FlightOrderCancel:foc success:^(id data) {
             [SVProgressHUD dismiss];
            self.view.userInteractionEnabled=YES;

            if([data[@"status"] isEqualToString:@"T"]){
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
                [self.navigationController popViewControllerAnimated:NO];

//                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
            }
        } failure:^(NSError *error) {
              [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
    }else if (send.tag==302){
       //送审
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        self.view.userInteractionEnabled=NO;

        ApproveApplyRequest * approve =[ApproveApplyRequest new];
        approve.OrderNo=_orderStr;
        approve.OrderType=@"JP";
        approve.approveWay=@"ALL";
        approve.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        approve.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        [Approval ApproveApply:approve success:^(id data) {
             [SVProgressHUD dismiss];
            self.view.userInteractionEnabled=YES;

            if([data[@"status"] isEqualToString:@"T"]){
                [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
                [self.navigationController popViewControllerAnimated:NO];

//                [self dismissViewControllerAnimated:YES completion:nil];
            }
        } failure:^(NSError *error) {
              [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
    }else if(send.tag==305){
    //支付
    orderPayVc *pvc =[orderPayVc new];
        pvc.orderstring=_orderStr;
        pvc.BusinessType=@"1";
//   pvc.price=_Messagedict[@"ticketPrice"];
        pvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController  pushViewController:pvc animated:YES];
//        [self presentViewController:pvc animated:NO completion:nil];
    }else if(send.tag==306){
      //申请退票
        ForderTPmessVC * ftpvc = [ForderTPmessVC new];
            ftpvc.statusStr=_statusStr;
            ftpvc.orderStr=_orderStr;
            ftpvc.Messagedict=_Messagedict;
        ftpvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController  pushViewController:ftpvc animated:YES];
//            [self presentViewController:ftpvc animated:NO completion:nil];
    }else if(send.tag==307){
      //申请改签
        ForderGQmessVC * ftpvc = [ForderGQmessVC new];
        ftpvc.statusStr=_statusStr;
        ftpvc.orderStr=_orderStr;
        ftpvc.Messagedict=_Messagedict;
        ftpvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController  pushViewController:ftpvc animated:YES];

//        [self presentViewController:ftpvc animated:NO completion:nil];

    }else if(send.tag==308){
      //重新申请
        self.navigationController.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        FirstViewController * fir = [FirstViewController new];
        fir.num=1;
        fir.hidesBottomBarWhenPushed=NO;
        [self.navigationController pushViewController:fir animated:NO];
//         [self presentViewController:fir animated:NO completion:nil];
    }else{
    }
   
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    bottomview.userInteractionEnabled=YES;
    _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , deviceScreenHeight);
}
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
