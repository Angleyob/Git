//
//  TrainTPorderMessVC1.m
//  Tour
//
//  Created by Euet on 17/2/21.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrainTPorderMessVC1.h"

#import "trainorder0.h"
#import "CJNmessCell.h"
#import "tgResonCell.h"
@interface TrainTPorderMessVC1 ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    
    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableArray * _contactarray;
    UILabel * menla;
    UILabel * numeberla;
    
    BOOL isa;
    
}


@end

@implementation TrainTPorderMessVC1
-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    
    
    if(![_statusStr isEqualToString:@"已取消"]&&![_statusStr isEqualToString:@"退票成功"]){
        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60/SCREEN_RATE, 375/SCREEN_RATE, 60/SCREEN_RATE)];
        [self.view addSubview:bottomview];
        
        UILabel * button1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 20, 210, 16)]];
        button1.adjustsFontSizeToFitWidth=YES;
        button1.text=@"退票失败";
        button1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        button1.textAlignment=NSTextAlignmentCenter;
        button1.font=[UIFont systemFontOfSize:14];
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
    [self creattable];
    
    [self loadData];
}
-(void)loadData{
}
-(void)creattable{
    if([_statusStr isEqualToString:@"已取消"]||[_statusStr isEqualToString:@"退票成功"]){
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
    }else{
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-110) style:UITableViewStyleGrouped];
    }
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
            return 40;
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
            
            label1.text=[NSString stringWithFormat:@"申请退票时间:%@",_Messagedict[@"retrunDate"]];
            label1.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label1];
            
            UIView * viewline  = [[UIView alloc]initWithFrame:CGRectMake(20/SCREEN_RATE, 35/SCREEN_RATE, deviceScreenWidth-20, 1/SCREEN_RATE)];
            viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            [view addSubview:viewline];
            
            UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 48, 122, 16)]];
            label2.font=[UIFont systemFontOfSize:14];
            label2.text=@"实际退票费用总计";
            label2.textAlignment=NSTextAlignmentCenter;
            label2.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label2];
            
            UILabel * pricelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(260, 48, 66, 18)]];
            pricelabel.text=[NSString stringWithFormat:@"￥%@",_menarray[0][@"returnTicketPrice"]];
            pricelabel.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
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
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            view.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            UILabel * labe = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 170/SCREEN_RATE, 20/SCREEN_RATE1)];
            labe.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            labe.text=[NSString stringWithFormat:@"原订单号：%@",_orderStr];
            labe.textColor=[UIColor colorWithRed:171/255.0 green:171/255.0 blue:171/255.0 alpha:1];
            labe.font=[UIFont systemFontOfSize:13];
            [view addSubview:labe];
            return view;
            break;}
        case 1:{
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 10, 15, 15)]];
            menimage.image=[UIImage imageNamed:@"passenger"];
            [view addSubview:menimage];
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 18, 110, 16)]];
            menlabel.text=@"申请改签乘车人";
            menlabel.font = [UIFont systemFontOfSize:14];
            menlabel.textColor=[UIColor blackColor];
            [view addSubview:menlabel];
            UILabel * citylabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(160, 18, 123, 16)]];
            citylabel.text=[NSString stringWithFormat:@"%@-%@",_Messagedict[@"fromStationName"],_Messagedict[@"toStationName"]];
            citylabel.font = [UIFont systemFontOfSize:14];
            citylabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
            [view addSubview:citylabel];
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
            return 100;
            break;
        case 1:
            return 67/SCREEN_RATE1;
            break;
        case 2:
            return 44/SCREEN_RATE1;
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
            return 1;
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
            trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            // cell的复用
            if (!cell) {
                cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
            }
            //去除点击效果
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
//            cell.orderlabel.text=[NSString stringWithFormat:@"原订单号:%@",_orderStr];
            cell.orderlabel.hidden=YES;
            
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
            cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
            return cell;
            break;
        }
            
        case 1:{
            CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
            if (!cell) {
                cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.namelabel.text=_menarray[indexPath.row][@"passenger"];
            cell.label3.hidden=YES;
            cell.disledimage.hidden=YES;
// cell.IdNumlabel.text=_menarray[indexPath.row][@"passportNo"];
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
            cell.headlabel.text=@"退票原因";
//            cell.resonlabel.text=_Messagedict[@"changeReason"];
            return cell;
            break;
        }
        default:{
            //暂无用途
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
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:NO];
//    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
