//
//  orderPayVc.m
//  Tour
//
//  Created by Euet on 17/2/23.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "orderPayVc.h"
#import "check1Cell.h"
#import "PayCell.h"
#import "HorderCell.h"
#import "trainorder0.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"       //微信分享和微信支付
#import "UPPaymentControl.h"
@interface orderPayVc ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _thirdPayarray;
    NSMutableArray * _advancepayarray;
    BOOL isa;
}


@end

@implementation orderPayVc
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self Tabview];
    [self loaddata];
    NSLog(@"%@",_Hprice);

    
    if([_BusinessType isEqualToString:@"1"]){
        [self loadDataF];
    }else if ([_BusinessType isEqualToString:@"2"]){
        [self loadDataT];
    }else{
        [self loadDataH];
    }
   
    [self creattable];
}
#pragma mark -初始化
-(void)initview{
//_array = [[NSMutableArray alloc] init];
    isa=YES;
}
-(void)loadDataH{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    HotelOrderInfQuery*  infquery  = [HotelOrderInfQuery new];
    infquery.OrderNo=_orderstring;
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Hotel HotelOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        _Messagedict=data;
        float roomPrice = [_Messagedict[@"totalPrice"] integerValue]/[_Messagedict[@"roomNum"] integerValue]/[_Messagedict[@"roomNight"] integerValue];
       
        _Hprice=[NSString stringWithFormat:@"%lf",roomPrice];
        
//        tprice.text=[NSString stringWithFormat:@"房间价格:￥%.1f元     ×%@间",roomPrice,_Messagedict[@"roomNum"]];
//        free.text=[NSString stringWithFormat:@"入住天数:             %@晚", _Messagedict[@"roomNight"]];
        
        if([_Messagedict[@"TripType"] isEqualToString:@"1"]){
            isa=NO;
        }
                [_tableView reloadData];
//        NSLog(@"%@",_Messagedict);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)loadDataT{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainOrderInfQuery *  infquery  = [TrainOrderInfQuery new];
    infquery.OrderNo=_orderstring;
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Train TrainOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        _Messagedict=data[@"trainTicket"];
        if([_Messagedict[@"tripType"] isEqualToString:@"1"]){
            isa=NO;
        }
        _menarray=[NSMutableArray new];
        _menarray=data[@"trainBoxList"];
        _Tprice=[NSString stringWithFormat:@"%ld",([_Messagedict[@"price"] integerValue]+[_Messagedict[@"fee"] integerValue])*_menarray.count];
        [_tableView reloadData];
        NSLog(@"%@",_Messagedict);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)loadDataF{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
    infquery.OrderNo=_orderstring;
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight FlightOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        _Messagedict=data;
        if([_Messagedict[@"businessType"] isEqualToString:@"1"]){
            isa=NO;
        }
        _price=_Messagedict[@"ticketPrice"];
        _FdataArray=_Messagedict[@"flightInfoList"];
//        _menarray=[NSMutableArray new];
//        for (NSMutableDictionary * dict in _Messagedict[@"passengerInfoList"]) {
//            passageMenModel * model =[[passageMenModel alloc] init];
//            [model setValuesForKeysWithDictionary:dict];
//            [_menarray addObject:model];
//        }
        [_tableView reloadData];
        NSLog(@"%@",_Messagedict);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)loaddata{
    _advancepayarray  = [NSMutableArray new];
    _thirdPayarray = [NSMutableArray new];
    PayTypeQueryRequest * payreq = [PayTypeQueryRequest new];
    payreq.OrderNo=_orderstring ;
    payreq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    payreq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    payreq.PlatformVIP=@"VIP-ADM";
    payreq.BusinessType=_BusinessType;
    [Basic PayTypeQueryRequest:payreq success:^(id data) {
//        NSLog(@"%@",data[@"message"]);
        _thirdPayarray=data[@"thirdPayTypeList"];
        _advancepayarray =data[@"advancePayTypeList"];
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}
#pragma mark -自定义导航栏
-(void)Tabview{
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    label.text=@"订单支付";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    backbut.tag=666;
    [view addSubview:backbut];
    UIView * dataview= [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, 48)];
    dataview.backgroundColor= [UIColor colorWithRed:254/255.0 green:246/255.0 blue:222/255.0 alpha:1];
    [self.view addSubview:dataview];
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 0,deviceScreenWidth-40, 48)];
    label1.text=@"请于20:30之前完成支付，否则订单将被取消。";
    label1.adjustsFontSizeToFitWidth = YES;
    //文本居中
    label1.textAlignment =UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor blackColor];
    [dataview addSubview:label1];
}
-(void)backAndnext:(UIButton*)send{
    if(send.tag==666){
    [AlertViewManager alertWithTitle:@"温馨提示"
                             message:@"您的订单尚未支付，是否确定退出？"
                     textFieldNumber:0
                        actionNumber:2
                        actionTitles:@[@"取消",@"确定"]
                    textFieldHandler:nil
                       actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                     if (index==1) {
                                    [self.navigationController popViewControllerAnimated:YES];
//                                         self.navigationController.tabBarController.selectedIndex = 1;
//                                         [self.navigationController popToRootViewControllerAnimated:YES];
                                     }
                                 }];
    }
}

#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 120, deviceScreenWidth, deviceScreenHeight-120) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 200, 16)];
        menlabel.text=[NSString stringWithFormat:@"订单号:%@",_orderstring];
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        UILabel * paylabel = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-80, 5, 100,20)];
        paylabel.font=[UIFont systemFontOfSize:14];
        paylabel.text=@"未支付";
        paylabel.textColor=[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1];
        [view addSubview:paylabel];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 10)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
    
}
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 60)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50)];
        view1.backgroundColor=[UIColor whiteColor];
        [view addSubview:view1];
        UIButton * b1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
        b1.titleLabel.font=[UIFont systemFontOfSize:15];
        [b1 setTitle:@"订单总金额" forState:UIControlStateNormal];
        [b1 setTitleColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
        [view1 addSubview:b1];
        
        UILabel * lab1 = [[UILabel alloc]initWithFrame:CGRectMake(255, 10, 75, 20)];
        if([_BusinessType isEqualToString:@"1"]){
            lab1.text=[NSString stringWithFormat:@"￥%@",_price];
        }else if([_BusinessType isEqualToString:@"17"]){
            lab1.text=[NSString stringWithFormat:@"￥%@",_Messagedict[@"totalPrice"]];
        }else{
            lab1.text=[NSString stringWithFormat:@"￥%@",_Tprice];
        }
        lab1.font=[UIFont systemFontOfSize:14];
        lab1.textAlignment=NSTextAlignmentRight;
        lab1.textColor=pricecolor;
        [view1 addSubview:lab1];
        
                return view;
    }else
        return 0;
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        if([_BusinessType isEqualToString:@"1"]){
            return 160;
        }else if([_BusinessType isEqualToString:@"17"]){
            return 100;
        }else{
            return 100;
        }
    }else{
        if (isa==YES) {
            if (indexPath.row==0) {
                return 0.01;
            }else if (indexPath.row==1){
                return 60;
            }else{
                return 0.01;
            }
        }else{
            if (indexPath.row==0) {
                if (_advancepayarray.count==0) {
                    return 0.01;
                }else{
                    return 60;
                }
            }else if (indexPath.row==1){
                return 0.01;
            }else if (indexPath.row==2){
                return 60;
            }else{
                return 0.01;
            }
        }
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
        return 1;
    }else{
        if(isa==YES){
            return 3;
        }else{
            return 4;
        }
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0){
        if([_BusinessType isEqualToString:@"1"]){
            check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            // cell的复用
            if (!cell) {
                cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.outdatalabel.text=[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
            cell.outTime.text=[_FdataArray[indexPath.row][@"fromDatetime"] substringWithRange:NSMakeRange(11, 5)];
            cell.arriveTime.text=[_FdataArray[indexPath.row][@"toDatetime"] substringWithRange:NSMakeRange(11, 5)];
            cell.copany.text=[NSString stringWithFormat:@"%@|%@",_FdataArray[indexPath.row][@"airwayName"],_FdataArray[indexPath.row][@"flightNo"]];
            cell.bettenCity.hidden=YES;
            cell.meallabel.hidden=YES;
            cell.flyTime.hidden=YES;
            cell.zdlabel.hidden=YES;
            cell.timeimg.hidden=YES;
            cell.mealimg.hidden=YES;
//            cell.bettenCity.text=_FdataArray[indexPath.row][@"stopOver"];
//            cell.meallabel.text=_FdataArray[indexPath.row][@"meal"];
            cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_FdataArray[indexPath.row][@"planeType"]];
            cell.airNo.adjustsFontSizeToFitWidth=YES;
            cell.arrviCity.text=_FdataArray[indexPath.row][@"toCity"];
            cell.outCity.text=_FdataArray[indexPath.row][@"fromCity"];
//           cell.flyTime.text=_FdataArray[indexPath.row][@"flytime"];
            return cell;
        }else if([_BusinessType isEqualToString:@"2"]){
            trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//            cell.pricelabel.text=[NSString stringWithFormat:@"￥%@元", _seatDatadict[@"price"]];
//            cell.pricelabel.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
//            cell.freeprice.text=[NSString stringWithFormat:@"￥%@元",_freeprice];
//            cell.freeprice.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
            cell.trainNO.text=_Messagedict[@"trainNum"];
            cell.fromstation.text=_Messagedict[@"fromStationName"];
            cell.fromdata.text=_Messagedict[@"departureDate"];
            cell.fromtime.text=_Messagedict[@"departureTime"];
            cell.tostation.text=_Messagedict[@"toStationName"];
            cell.totime.text=_Messagedict[@"arrivalsTime"];
            cell.fromdata.text=[_Messagedict[@"departureDate"] substringFromIndex:5];
//            if(![_trainDatadict[@"arriveDays"] isEqualToString:@"0"]){
//                int d= [_trainDatadict[@"arriveDays"] intValue];
//                NSDateFormatter *dateFormatter1= [[NSDateFormatter alloc] init];
//                [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
//                NSDate*hDate;
//                NSDate * hde;
//                NSString*result1;
//                //由 NSString转换为 NSDate
//                hDate = [dateFormatter1 dateFromString:_trainDatadict[@"trainStartDate"]];
//                hde=[NSDate dateWithTimeInterval:d*24*60*60 sinceDate:hDate];
//                //   NSLog(@"%@",hde);
//                //由 NSDate转换为 NSString
//                result1 = [dateFormatter1 stringFromDate:hde];
//                cell.todate.text=[result1 substringFromIndex:5];
//            }else{
//                cell.todate.text=[_trainDatadict[@"trainStartDate"] substringFromIndex:5];
//            }
            cell.todate.text=[_Messagedict[@"arrivalsDate"] substringFromIndex:5];
            return cell;
        }else{
            HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.hotelnamelabel.text=_Messagedict[@"hotelName"];
            cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
            cell.roomname.text=_Messagedict[@"roomName"];
            cell.roomname.adjustsFontSizeToFitWidth=YES;
            cell.hotelmess.text=@"";
            cell.hotelmess.textColor=[UIColor grayColor];
            cell.hotelmess.adjustsFontSizeToFitWidth=YES;
            //截取字符串的前11位
            NSDate * d1 =  [LGLCalendarDate dateFromString:[_Messagedict[@"latestArrTime"] substringWithRange:NSMakeRange(0,11)]];
            
            NSDate * d2 =  [LGLCalendarDate dateFromString:_Messagedict[@"checkOutDate"]];
            
            NSInteger h=[weekday getDaysFrom:d1 To:d2];
            cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离开:%@  共%ld晚",[_Messagedict[@"latestArrTime"] substringWithRange:NSMakeRange(0,11)],_Messagedict[@"checkOutDate"],h];
            cell.datelabel.adjustsFontSizeToFitWidth=YES;
            cell.datelabel.font=[UIFont systemFontOfSize:12];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
        if (!cell) {
            cell= (PayCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PayCell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.button1.userInteractionEnabled=NO;
//        if(_advancepayarray.count!=0){
            if (isa==YES) {
                if(indexPath.row==0){
                    cell.imageView.image=[UIImage imageNamed:@"wechat_pay"];
                    cell.paylabel.text=@"微信支付";
                    cell.hidden=YES;
                }else if(indexPath.row==1){
                    cell.imageView.image=[UIImage imageNamed:@"union_pay"];
                    cell.paylabel.text=@"银联支付";
                }else{
                    cell.imageView.image=[UIImage imageNamed:@"ali_pay"];
                    cell.paylabel.text=@"支付宝支付";
                    cell.hidden=YES;
                }

            }else{
                if(indexPath.row==0){
                    cell.imageView.image=[UIImage imageNamed:@"euet_pay"];
                    if (_advancepayarray.count==0) {
                        cell.hidden=YES;
                    }
                    cell.paylabel.text=@"协议欠款";
                }else if(indexPath.row==1){
                    cell.imageView.image=[UIImage imageNamed:@"wechat_pay"];
                    cell.paylabel.text=@"微信支付";
                    cell.hidden=YES;
                }else if(indexPath.row==2){
                    cell.imageView.image=[UIImage imageNamed:@"union_pay"];
                    cell.paylabel.text=@"银联支付";
                }else{
                    cell.imageView.image=[UIImage imageNamed:@"ali_pay"];
                    cell.paylabel.text=@"支付宝支付";
                    cell.hidden=YES;

                }

            }

        return cell;
    }
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的方法
    PayCell *cell = [tableView cellForRowAtIndexPath:indexPath]
    ;
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    //STEP 1
    
    if (indexPath.section==1) {
        
        if (_price!=nil) {
            NSString *title = @"提示";
            NSString *title1 = @"取消";
            NSString *message = @"您是否确认支付？";
            NSString *okButtonTitle = @"确定";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                [SVProgressHUD showWithStatus:@"正在加载"];
                [SVProgressHUD show];
                PayRequest * pay = [PayRequest new];
                pay.PlatformVIP=@"VIP-ADM";
                pay.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
                pay.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
                pay.BusinessType=_BusinessType;
                
                if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                    //            pay.SubCode=_advancepayarray[0][@"paySubject"];
                    //            pay.PayMethod=_advancepayarray[0][@"paySubject"];
                    //            pay.PayType=@"0";
                    //             pay.PayDockCode=@"协议欠款";
                    pay.SubCode=@"1006204";
                    pay.PayMethod=@"1006204";
                    pay.PayType=@"0";
                    pay.PayDockCode=@"协议欠款";
                    
                }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                    
                    pay.SubCode=_thirdPayarray[1][@"paySubject"];
                    pay.PayDockCode=_thirdPayarray[1][@"paySubjectCode"];
                    pay.PayMethod=_thirdPayarray[1][@"paySubjectName"];
                    pay.OpenId=@"";
                    pay.PayType=@"2";
                    
                }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                    pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
                    pay.SubCode=_thirdPayarray[0][@"paySubject"];
                    pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
                    pay.OpenId=@"";
                    pay.PayType=@"2";
                }else{
                }
                NSMutableArray * arr=[NSMutableArray array];
                Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
                orderinfo.OrderNo=_orderstring;
                if([_BusinessType isEqualToString:@"1"]){
                    orderinfo.PayAmount=_price;
                }else if ([_BusinessType isEqualToString:@"2"]){
                    orderinfo.PayAmount= [_Tprice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                }else{
                    orderinfo.PayAmount=_Hprice;
                }
                [arr addObject:orderinfo];
                pay.orderInfos =[Pay_orderInfosmodel mj_keyValuesArrayWithObjectArray:arr];
                [Basic PayRequest:pay success:^(id data) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",data);
                    if([data[@"status"] isEqualToString:@"T"]){

                        if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
                            paySucceedVC* vc =[paySucceedVC new];
                            vc.orderno=_orderstring;
                            if (_price.length!=0) {
                                vc.orderprice=_price;
                                vc.type=@"1";
                            }else if (_Hprice.length!=0) {
                                vc.orderprice=_Hprice;
                                vc.type=@"3";
                            }else{
                                vc.type=@"2";
                                vc.orderprice=_Tprice;
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                            if (![data[@"msg"]isEqualToString:@""]) {
                                NSString *jsonString=data[@"msg"];
                                NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                     options:NSJSONReadingMutableContainers error:nil];
                                // 调起微信支付
                                PayReq *request = [[PayReq alloc] init];
                                request.partnerId =@"1447626402";
                                request.prepayId = dict[@"prepayid"];
                                request.package =dict[@"package"];
                                request.nonceStr = dict[@"noncestr"];
                                request.timeStamp =[dict[@"timestamp"] intValue];
                                
                                //                        //                   //生成签名
                                NSString *sign  = dict[@"paysign"];
                                //添加签名
                                request.sign = sign;
                                
                                NSLog(@"这是%@",request);
                                //调起微信开始支付！！
                                [WXApi sendReq:request];
                                NSLog(@"这是微信的打印");
                            }
                        }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                            //                    if ([[UPPaymentControl defaultControl] isPaymentAppInstalled]==1) {
                            //                    }
                            [[UPPaymentControl defaultControl] startPay:data[@"msg"]fromScheme:@"UPPay" mode:@"00" viewController:self];
                        }else{
                            [UIAlertView showAlertWithTitle1:@"正在开发中..." duration:1.2];
                        }
                    }else{
                        [UIAlertView showAlertWithTitle:data[@"message"]];
                    }
                    //  paySucceedVC* vc =[paySucceedVC new];
                    //  [self presentViewController:vc animated:YES completion:nil];
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
                }];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }else if (_Tprice!=nil){
            if ([cell.paylabel.text isEqualToString:@"微信支付"]||[cell.paylabel.text isEqualToString:@"支付宝支付"]) {
                [UIAlertView showAlertWithTitle:@"该支付方式尚未开通，请采用其它支付方式"];
            }else{
            NSString *title = @"提示";
            NSString *title1 = @"取消";
            NSString *message = @"您是否确认支付？";
            NSString *okButtonTitle = @"确定";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                
                [SVProgressHUD showWithStatus:@"正在加载"];
                [SVProgressHUD show];
                PayRequest * pay = [PayRequest new];
                pay.PlatformVIP=@"VIP-ADM";
                pay.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
                pay.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
                pay.BusinessType=_BusinessType;
                
                if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                    //            pay.SubCode=_advancepayarray[0][@"paySubject"];
                    //            pay.PayMethod=_advancepayarray[0][@"paySubject"];
                    //            pay.PayType=@"0";
                    //             pay.PayDockCode=@"协议欠款";
                    
                    pay.SubCode=@"1006204";
                    pay.PayMethod=@"1006204";
                    pay.PayType=@"0";
                    pay.PayDockCode=@"协议欠款";
                }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
//                    pay.SubCode=_thirdPayarray[1][@"paySubject"];
//                    pay.PayDockCode=_thirdPayarray[1][@"paySubjectCode"];
//                    pay.PayMethod=_thirdPayarray[1][@"paySubjectName"];
//                    pay.OpenId=@"";
//                    pay.PayType=@"2";
                }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                    pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
                    pay.SubCode=_thirdPayarray[0][@"paySubject"];
                    pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
                    pay.OpenId=@"";
                    pay.PayType=@"2";
                }else{
                }
                NSMutableArray * arr=[NSMutableArray array];
                Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
                orderinfo.OrderNo=_orderstring;
                if([_BusinessType isEqualToString:@"1"]){
                    orderinfo.PayAmount=_price;
                }else if ([_BusinessType isEqualToString:@"2"]){
                    orderinfo.PayAmount= [_Tprice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                }else{
                    orderinfo.PayAmount=_Hprice;
                }
                [arr addObject:orderinfo];
                pay.orderInfos =[Pay_orderInfosmodel mj_keyValuesArrayWithObjectArray:arr];
                [Basic PayRequest:pay success:^(id data) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",data);
                    if([data[@"status"] isEqualToString:@"T"]){
                        
                        if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
                            paySucceedVC* vc =[paySucceedVC new];
                            vc.orderno=_orderstring;
                            if (_price.length!=0) {
                                vc.orderprice=_price;
                                vc.type=@"1";
                            }else if (_Hprice.length!=0) {
                                vc.orderprice=_Hprice;
                                vc.type=@"3";
                            }else{
                                vc.type=@"2";
                                vc.orderprice=_Tprice;
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                            if (![data[@"msg"]isEqualToString:@""]) {
                                NSString *jsonString=data[@"msg"];
                                NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                     options:NSJSONReadingMutableContainers error:nil];
                                // 调起微信支付
                                PayReq *request = [[PayReq alloc] init];
                                request.partnerId =@"1447626402";
                                request.prepayId = dict[@"prepayid"];
                                request.package =dict[@"package"];
                                request.nonceStr = dict[@"noncestr"];
                                request.timeStamp =[dict[@"timestamp"] intValue];
                                
                                //                        //                   //生成签名
                                NSString *sign  = dict[@"paysign"];
                                //添加签名
                                request.sign = sign;
                                
                                NSLog(@"这是%@",request);
                                //调起微信开始支付！！
                                [WXApi sendReq:request];
                                NSLog(@"这是微信的打印");
                            }
                        }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                            
                            //                    if ([[UPPaymentControl defaultControl] isPaymentAppInstalled]==1) {
                            //                    }
                            [[UPPaymentControl defaultControl] startPay:data[@"msg"]fromScheme:@"UPPay" mode:@"00" viewController:self];
                        }else{
                            [UIAlertView showAlertWithTitle1:@"正在开发中..." duration:1.2];
                        }
                    }else{
                        [UIAlertView showAlertWithTitle:data[@"message"]];
                    }
                    //  paySucceedVC* vc =[paySucceedVC new];
                    //  [self presentViewController:vc animated:YES completion:nil];
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
                }];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
            }
        }else{
            if ([cell.paylabel.text isEqualToString:@"支付宝支付"] || [cell.paylabel.text isEqualToString:@"银联支付"] ) {
                [UIAlertView showAlertWithTitle:@"该支付方式尚未开通，请采用其它支付方式"];
            }else{
                {
                    NSString *title = @"提示";
                    NSString *title1 = @"取消";
                    NSString *message = @"您是否确认支付？";
                    NSString *okButtonTitle = @"确定";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        
                        [SVProgressHUD showWithStatus:@"正在加载"];
                        [SVProgressHUD show];
                        PayRequest * pay = [PayRequest new];
                        pay.PlatformVIP=@"VIP-ADM";
                        pay.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
                        pay.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
                        pay.BusinessType=_BusinessType;
                        
                        if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                            //            pay.SubCode=_advancepayarray[0][@"paySubject"];
                            //            pay.PayMethod=_advancepayarray[0][@"paySubject"];
                            //            pay.PayType=@"0";
                            //             pay.PayDockCode=@"协议欠款";
                            
                            pay.SubCode=@"1006204";
                            pay.PayMethod=@"1006204";
                            pay.PayType=@"0";
                            pay.PayDockCode=@"协议欠款";
                            
                        }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                            
                            pay.SubCode=_thirdPayarray[0][@"paySubject"];
                            pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
                            pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
                            pay.OpenId=@"";
                            pay.PayType=@"2";
                            
                        }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
//                            pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
//                            pay.SubCode=_thirdPayarray[0][@"paySubject"];
//                            pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
//                            pay.OpenId=@"";
//                            pay.PayType=@"2";
                        }else{
                        }
                        NSMutableArray * arr=[NSMutableArray array];
                        Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
                        orderinfo.OrderNo=_orderstring;
                        if([_BusinessType isEqualToString:@"1"]){
                            orderinfo.PayAmount=_price;
                        }else if ([_BusinessType isEqualToString:@"2"]){
                            orderinfo.PayAmount= [_Tprice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                        }else{
                            orderinfo.PayAmount=_Hprice;
                        }
                        [arr addObject:orderinfo];
                        pay.orderInfos =[Pay_orderInfosmodel mj_keyValuesArrayWithObjectArray:arr];
                        [Basic PayRequest:pay success:^(id data) {
                            [SVProgressHUD dismiss];
                            NSLog(@"%@",data);
                            if([data[@"status"] isEqualToString:@"T"]){
                                
                                if ([cell.paylabel.text isEqualToString:@"协议欠款"]) {
                                    [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
                                    paySucceedVC* vc =[paySucceedVC new];
                                    vc.orderno=_orderstring;
                                    if (_price.length!=0) {
                                        vc.orderprice=_price;
                                        vc.type=@"1";
                                    }else if (_Hprice.length!=0) {
                                        vc.orderprice=_Hprice;
                                        vc.type=@"2";
                                    }else{
                                        vc.type=@"3";
                                        vc.orderprice=_Tprice;
                                    }
                                    [self.navigationController pushViewController:vc animated:YES];
                                }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                                    if (![data[@"msg"]isEqualToString:@""]) {
                                        NSString *jsonString=data[@"msg"];
                                        NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                        NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                                             options:NSJSONReadingMutableContainers error:nil];
                                        // 调起微信支付
                                        PayReq *request = [[PayReq alloc] init];
                                        request.partnerId =@"1447626402";
                                        request.prepayId = dict[@"prepayid"];
                                        request.package =dict[@"package"];
                                        request.nonceStr = dict[@"noncestr"];
                                        request.timeStamp =[dict[@"timestamp"] intValue];
                                        
                                        //                        //                   //生成签名
                                        NSString *sign  = dict[@"paysign"];
                                        //添加签名
                                        request.sign = sign;
                                        
                                        NSLog(@"这是%@",request);
                                        //调起微信开始支付！！
                                        [WXApi sendReq:request];
                                        NSLog(@"这是微信的打印");
                                    }
                                }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                                    
                                    //                    if ([[UPPaymentControl defaultControl] isPaymentAppInstalled]==1) {
                                    //                    }
                                    [[UPPaymentControl defaultControl] startPay:data[@"msg"]fromScheme:@"UPPay" mode:@"00" viewController:self];
                                }else{
                                    [UIAlertView showAlertWithTitle1:@"正在开发中..." duration:1.2];
                                }
                            }else{
                                [UIAlertView showAlertWithTitle:data[@"message"]];
                            }
                           
                        } failure:^(NSError *error) {
                            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
                        }];
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
        }
    }

}
-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;

    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = @"发送媒体消息结果";
    }

    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        switch (resp.errCode) {
            case WXSuccess:{
                strMsg = @"恭喜您，支付成功!";
                //                [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"success"}];
                NSLog(@"%@",strMsg);
                break;
            }
            case WXErrCodeUserCancel:{
                strMsg = @"已取消支付!";
                // [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                NSLog(@"%@",strMsg);
                break;
            }
            default:{
                strMsg = [NSString stringWithFormat:@"支付失败 !"];
                //                [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
                NSLog(@"%@",strMsg);
                break;
            }
        }
        //创建通知
        NSNotification *notificationnn =[NSNotification notificationWithName:@"weixinbaotongzhi" object:nil userInfo:nil];
        //通过通知中心发送通知
        [[NSNotificationCenter defaultCenter] postNotification:notificationnn];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
