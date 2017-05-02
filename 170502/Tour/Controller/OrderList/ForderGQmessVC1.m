//
//  ForderGQmessVC1.m
//  Tour
//
//  Created by Euet on 17/2/28.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "ForderGQmessVC1.h"

#import "order1Cell.h"
#import "CJNmessCell.h"
#import "tgResonCell.h"

@interface ForderGQmessVC1 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    // NSString * orderflase;
    UILabel * orderflase;
    BOOL isa;
    NSMutableArray *flightarr;
    
}
@end

@implementation ForderGQmessVC1
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
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
    [backbut addTarget:self action:@selector(gqback:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    UIView * viewtitle = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE, 375, 50)]];
    viewtitle.backgroundColor = [UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:viewtitle];
    UILabel * dlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 60, 22)]];
    dlabel.text=_statusStr;
    dlabel.adjustsFontSizeToFitWidth=YES;
    dlabel.textColor=[UIColor whiteColor];
    [viewtitle addSubview:dlabel];
//    NSLog(@"%@-%@--%@",_Messagedict[@"ifCancel"],_Messagedict[@"isPay"],_paychangeAmount);
    if([_Messagedict[@"ifCancel"] isEqualToString:@"0"]&&([_Messagedict[@"isPay"] isEqualToString:@"1"]||[_Messagedict[@"isPay"] isEqualToString:@""])&&([_paychangeAmount intValue]>0)){
        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
        [self.view addSubview:bottomview];
        
        UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, (deviceScreenWidth-45)/2, 44)];
        //剪切
        button1.clipsToBounds=YES;
        //圆角
        button1.layer.cornerRadius = 5.0;
        [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
        [button1.layer setBorderWidth:1];
        [button1 setTitle:@"支付" forState:UIControlStateNormal];
        button1.tag=301;
        [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
        [bottomview addSubview:button1];
        UIButton * button2= [[UIButton alloc]initWithFrame:CGRectMake(15+(deviceScreenWidth-45)/2+15, 8, (deviceScreenWidth-45)/2, 44)];
        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        [button2 setTitle:@"取消改签" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.tag=302;
        //剪切
        button2.clipsToBounds=YES;
        //圆角
        button2.layer.cornerRadius = 10.0;
        [bottomview addSubview:button2];
    }else if([_Messagedict[@"ifCancel"] isEqualToString:@"0"]&&([_paychangeAmount intValue]<=0)){
        if (([_Messagedict[@"isPay"] isEqualToString:@"1"]||[_Messagedict[@"isPay"] isEqualToString:@""])) {
            UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
            [self.view addSubview:bottomview];
            UIButton * button1= [[UIButton alloc]initWithFrame:CGRectMake(15, 8, deviceScreenWidth-30, 44)];
            //剪切
            button1.clipsToBounds=YES;
            //圆角
            button1.layer.cornerRadius = 5.0;
            [button1.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
            [button1.layer setBorderWidth:1];
            [button1 setTitle:@"取消改签" forState:UIControlStateNormal];
            button1.tag=303;
            [button1 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
            
            [button1 setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
            [bottomview addSubview:button1];
            }
    }else{
//        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60/SCREEN_RATE, 375/SCREEN_RATE, 60/SCREEN_RATE)];
//        [self.view addSubview:bottomview];
//        UILabel * button1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 20, 210, 16)]];
//                button1.adjustsFontSizeToFitWidth=YES;
//        button1.text=@"改签失败";
//        [bottomview addSubview:button1];
//        UIButton * button2= [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(250, 8,110, 44)]];
//        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
//        button2.titleLabel.font=[UIFont systemFontOfSize:14];
//        [button2 setTitle:@"重新申请" forState:UIControlStateNormal];
//        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
//        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        button2.tag=308;
//        //剪切
//        button2.clipsToBounds=YES;
//        //圆角
//        button2.layer.cornerRadius = 10.0;
//        [bottomview addSubview:button2];
    }
    [self creattable];
    [self loadData];
}
-(void)SPclick:(UIButton*)send{
    switch (send.tag) {
        case 301:{
            //支付
            orderPayVc *pvc =[orderPayVc new];
            pvc.orderstring=_orderStr;
            pvc.BusinessType=@"1";
            //pvc.price=_Messagedict[@"ticketPrice"];
            [self presentViewController:pvc animated:NO completion:nil];
            break;
        }
        case 302:{
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            FlightEndorseTicketCancel * fetc = [FlightEndorseTicketCancel new];
            fetc.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            fetc.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            fetc.OrderNo=_orderStr;
            [Flight FlightEndorseTicketCancel:fetc success:^(id data) {
                [SVProgressHUD dismiss];
                if ([data[@"status"] isEqualToString:@"T"]) {
                [UIAlertView showAlertWithTitle:@"取消改签成功"];
                }
            } failure:^(NSError *error) {
              [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];
            break;
        }
        case 303:{
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            FlightEndorseTicketCancel * fetc = [FlightEndorseTicketCancel new];
            fetc.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            fetc.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            fetc.OrderNo=_orderStr;
            [Flight FlightEndorseTicketCancel:fetc success:^(id data) {
                [SVProgressHUD dismiss];
                if ([data[@"status"] isEqualToString:@"T"]) {
                    [UIAlertView showAlertWithTitle:@"取消改签成功"];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];

            break;
        }
        case 308:{
            
            break;
        }
        default:
            break;
    }
}
-(void)loadData{
//    [SVProgressHUD showWithStatus:@"正在加载"];
//    [SVProgressHUD show];
//    FlightChangeInfQuery * fcif = [FlightChangeInfQuery new];
//    fcif.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
//    fcif.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
//    fcif.ChangeOrderNo=_orderStr;
//    [Flight FlightChangeInfQuery:fcif success:^(id data) {
//         [SVProgressHUD dismiss];
NSLog(@"%@",_Messagedict);
//        if([data[@"status"] isEqualToString:@"T"]){
//           _Messagedict=data;
    
        _menarray=_Messagedict[@"ticketList"];
        _FdataArray=_Messagedict[@"flightInfo"];
//        }
        [_tableView reloadData];
    
//    } failure:^(NSError *error) {
//    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
//    }];
}
-(void)creattable{
//    if([_statusStr isEqualToString:@"已取消"]){
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
//    }else{
//        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-110) style:UITableViewStyleGrouped];
//    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0.01;
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 10;
            break;
        default:
            return 0;
            break;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 90/SCREEN_RATE;
            break;
        case 1:
            return 0.01;
            break;
        case 2:
            return 0.01;
            break;
        default:
            return 0;
            break;
    }
    
}
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            
            UIView * view0  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 90/SCREEN_RATE)];
            view0.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 80/SCREEN_RATE)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel * label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 12, 245, 16)]];
            label1.font=[UIFont systemFontOfSize:14];
            label1.textAlignment=NSTextAlignmentCenter;
            
            label1.text=[NSString stringWithFormat:@"申请改签时间:%@",_Messagedict[@"applyTime"]];
            label1.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label1];
            
            UIView * viewline  = [[UIView alloc]initWithFrame:CGRectMake(20/SCREEN_RATE, 35/SCREEN_RATE, deviceScreenWidth-20, 1/SCREEN_RATE)];
            viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            [view addSubview:viewline];
            
            UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 48, 122, 16)]];
            label2.font=[UIFont systemFontOfSize:14];
            label2.text=@"实际改签费用总计";
            label2.textAlignment=NSTextAlignmentCenter;
            label2.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label2];
            
            UILabel * pricelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(260, 48, 66, 18)]];
            pricelabel.text=[NSString stringWithFormat:@"￥%@",_paychangeAmount];
            pricelabel.adjustsFontSizeToFitWidth=YES;
            [view addSubview:pricelabel];
            
            UIButton * pricemesbut = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(336, 0, 50, 40)]];
            [view addSubview:pricemesbut];
            [view0 addSubview:view];
            
            return view0;
            
            break;}
        case 1:{
            
            return 0;
            break;}
        case 2:
            return 0;
            break;
        default:
            return 0;
            break;
    }
    
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 0;
            break;}
        case 1:{
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 10, 15, 15)]];
            menimage.image=[UIImage imageNamed:@"passenger"];
            [view addSubview:menimage];
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 18, 118, 16)]];
            menlabel.text=@"申请改签乘机人";
            menlabel.font = [UIFont systemFontOfSize:14];
            menlabel.textColor=[UIColor blackColor];
            [view addSubview:menlabel];
            view.backgroundColor=[UIColor whiteColor];
            return view;
            break;}
        case 2:
            return 0;
            break;
        default:
            return 0;
            break;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            return 80;
            break;
        case 1:
            return 67/SCREEN_RATE;
            break;
        case 2:
            return 44/SCREEN_RATE;
            break;
        default:
            return 0;
            break;
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if( _FdataArray.count==2){
                return 4;
            }else{
                return 2;
            }
            break;
            
        case 1:
            return _menarray.count;
            break;
        case 2:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:{
            order1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            // cell的复用
            if (!cell) {
                cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
            }
            //            cell.celloutlabel.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            //            cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            if(_FdataArray.count==1){
                if(indexPath.row==0){
                    cell.orderlabel.text=[NSString stringWithFormat:@"新订单号:%@",_Messagedict[@"changeOrderNo"]];
                    NSString * wstr=[weekday weekdaywith1:_FdataArray[indexPath.row][@"newFromDate"]];
                    
                    cell.celloutlabel.text=[NSString stringWithFormat:@"%@  %@  %@",_FdataArray[indexPath.row][@"newFromDate"],wstr,[_FdataArray[indexPath.row][@"newFromDatetime"] substringWithRange:NSMakeRange(0,5)]];
                    NSString * strout =@"";
                    NSString * strback =@"";
                    for (FlightModel * model  in flightarr) {
                        if([_FdataArray[indexPath.row][@"newDepartAirport"]  isEqualToString:model.AirportCode]){
                            strout=model.AirportName;
                        }
                        if([_FdataArray[indexPath.row][@"newArrivalAirport"] isEqualToString:model.AirportCode]){
                            strback=model.AirportName;
                        }
                    }
                    cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",strout,strback];
                }else{
                    //去除点击效果
                    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                    
                    cell.celloutlabel.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    cell.orderlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
                    cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                    
                    cell.orderlabel.text=[NSString stringWithFormat:@"原订单号:%@",_Messagedict[@"orderNo"]];
                    
                    NSString * wstr=[weekday weekdaywith1:_FdataArray[indexPath.row-1][@"oldFromDate"]];
                    
                    cell.celloutlabel.text=[NSString stringWithFormat:@"%@  %@  %@",_FdataArray[indexPath.row-1][@"oldFromDate"],wstr,[_FdataArray[indexPath.row-1][@"oldFromDatetime"] substringWithRange:NSMakeRange(0,5)]];
                    NSString * strout =@"";
                    NSString * strback =@"";
                    for (FlightModel * model  in flightarr) {
                        if([_FdataArray[indexPath.row-1][@"oldDepartAirport"]  isEqualToString:model.AirportCode]){
                            strout=model.AirportName;
                        }
                        if([_FdataArray[indexPath.row-1][@"oldArrivalAirport"] isEqualToString:model.AirportCode]){
                            strback=model.AirportName;
                        }
                    }
                    cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",strout,strback];
                }
            }else{
                if(indexPath.row==1||indexPath.row==3){
                    cell.logoimage.image=[UIImage imageNamed:@"backward"];
                }
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            break;
        }
        case 1:{
            CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
            if (!cell) {
                cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.namelabel.text=_menarray[indexPath.row][@"passengerName"];
            if([_menarray[indexPath.row][@"idType"] isEqualToString:@"NI"]){
                cell.label3.text=@"身份证";
            }else if([_menarray[indexPath.row][@"idType"] isEqualToString:@"ID"]){
                cell.label3.text=@"护照";
            }else{
                cell.label3.text=@"其它";
            }
            cell.disledimage.hidden=YES;
            cell.IdNumlabel.text=_menarray[indexPath.row][@"idCardNo"];
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
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
            
            break;
        }
        case 2:{
            tgResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdctg"];
            if (!cell) {
                cell = [[tgResonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdctg"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //            if(indexPath.row==0){
            //                cell.headlabel.text=@"改变类型";
            //                cell.resonlabel.text=_Messagedict[@"refundReasonA"];
            //            }else{
            
            cell.headlabel.text=@"改变原因";
            cell.resonlabel.text=_Messagedict[@"changeReason"];
            //            }
            
            return cell;
            
            break;
        }
        default:{
            CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
            if (!cell) {
                cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
            break;
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)gqback:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO];
  //  [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
