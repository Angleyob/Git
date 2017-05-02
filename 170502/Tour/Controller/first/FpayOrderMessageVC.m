//
//  FpayOrderMessageVC.m
//  Tour
//
//  Created by Euet on 17/3/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "FpayOrderMessageVC.h"
#import "ForderGQmessVC.h"

#import "order1Cell.h"
#import "order2Cell.h"
#import "order3Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "check1Cell.h"
#import "CJNmessCell.h"
#import "SPmencell.h"


@interface FpayOrderMessageVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    
    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableArray * _contactarray;
    UILabel * menla;
    UILabel * numeberla;
    
    
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

@implementation FpayOrderMessageVC

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
//    backbut.tag=666;
    [view addSubview:backbut];
    UIView * viewtitle = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 64*SCREEN_RATE, 375, 50)]];
    viewtitle.backgroundColor = [UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    [self.view addSubview:viewtitle];
    UILabel * dlabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 60, 22)]];
    dlabel.text=@"已支付";
    dlabel.adjustsFontSizeToFitWidth=YES;
    dlabel.textColor=[UIColor whiteColor];
    [viewtitle addSubview:dlabel];
    UILabel * olabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(190, 15, 170, 16)]];
    olabel.textColor=[UIColor whiteColor];
    olabel.textAlignment = NSTextAlignmentCenter;
    olabel.adjustsFontSizeToFitWidth=YES;
    olabel.text=[NSString stringWithFormat:@"订单号:%@",_orderStr];
    [viewtitle addSubview:olabel];
    
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
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
    infquery.OrderNo=_orderStr;
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight FlightOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        _Messagedict=data;
        if([_Messagedict[@"businessType"] isEqualToString:@"2"]){
            isa=YES;
        }
        _FdataArray=_Messagedict[@"flightInfoList"];
        //_menarray=_Messagedict[@"passengerInfoList"];
        _menarray=[NSMutableArray new];
        for (NSMutableDictionary * dict in _Messagedict[@"passengerInfoList"]) {
            passageMenModel * model =[[passageMenModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [_menarray addObject:model];
        }
        [_tableView reloadData];
        NSLog(@"%@",_Messagedict);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)creattableview{
       _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-110) style:UITableViewStyleGrouped];
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
        return 7;
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
        cell.outdatalabel.text=_FdataArray[indexPath.row][@"outdate"];
        cell.outTime.text=[_FdataArray[indexPath.row][@"date"] substringToIndex:5];
        cell.arriveTime.text=[_FdataArray[indexPath.row][@"arrivalTime"] substringToIndex:5];
        cell.copany.text=_FdataArray[indexPath.row][@"conpany"];
        cell.copany.adjustsFontSizeToFitWidth=YES;
        cell.bettenCity.text=_FdataArray[indexPath.row][@"stopOver"];
        
        if(![_FdataArray[indexPath.row][@"meal"]isEqualToString:@""]){
            cell.meallabel.text=@"有餐食";
        }else{
            cell.meallabel.text=@"无";
        }
        cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_FdataArray[indexPath.row][@"flightMode"]];
        cell.arrviCity.text=_FdataArray[indexPath.row][@"arrivalCity"];
        cell.outCity.text=_FdataArray[indexPath.row][@"departCity"];
        NSString *str3 = [_FdataArray[indexPath.row][@"flyTime"] stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
        cell.flyTime.text=[NSString stringWithFormat:@"%@分钟",str3];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(void)SPclick:(UIButton*)send{
    
}
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO ];
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
