//
//  ForderGQmessVC.m
//  Tour
//
//  Created by Euet on 17/2/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "ForderGQmessVC.h"
#import "OrderChangeListmodel.h"
#import "FlightMessageVC.h"

#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"

#import "order1Cell.h"
#import "CJNmessCell.h"
#import "tgResonCell.h"


@interface ForderGQmessVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    // NSString * orderflase;
    UILabel * orderflase;
    BOOL isa;
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    UIButton * butclear;
    UIButton * butchange;
    // NSString * seatstring;
    
    NSString * resontype;
    NSString * resonmess;
    
    NSMutableArray * _arr1;
    NSMutableArray * _arr2;
    
    
    NSMutableArray * _arrNum1;
    NSMutableArray * _arrNum2;
    
    
    NSMutableArray * _arr;
}
@end

@implementation ForderGQmessVC

-(void)viewWillAppear:(BOOL)animated{
    self.tabBarController.tabBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * array1 = @[@"乘客自愿改签",@"航班延误或取消",@"因病改签"];
    NSArray * array2 = @[@"临时取消出差",@"航班延误或取消",@"领导临时安排"];
    _arr1=[NSMutableArray arrayWithArray:array1];
    _arr2=[NSMutableArray arrayWithArray:array2];
    resontype=_arr1[0];
    resonmess=_arr2[0];
    isa = NO;
    [self loadDataF];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
        view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"申请改签";
    label.textColor=[UIColor blackColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60/SCREEN_RATE, 375/SCREEN_RATE, 60/SCREEN_RATE)];
    bottomview.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:132/255.0 alpha:1];
    [self.view addSubview:bottomview];
    UILabel * button1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 20, 210, 16)]];
    button1.adjustsFontSizeToFitWidth=YES;
    button1.text=@"产生的改签费用以最终的核算为准";
    button1.textColor=[UIColor whiteColor];
    button1.textAlignment=NSTextAlignmentCenter;
    button1.font=[UIFont systemFontOfSize:14];
    [bottomview addSubview:button1];
    UIButton * button2= [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(250, 8,110, 44)]];
    button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    button2.titleLabel.font=[UIFont systemFontOfSize:14];
    [button2 setTitle:@"确认改签" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button2.tag=308;
    //剪切
    button2.clipsToBounds=YES;
    //圆角
    button2.layer.cornerRadius = 10.0;
    [bottomview addSubview:button2];
    [self creattable];
}
-(void)loadDataF{
    _FdataArray=[NSMutableArray new];
    _FdataArray=_Messagedict[@"flightInfoList"];
    
    NSLog(@"%@",_Messagedict);
    
    _menarray=[NSMutableArray new];
    _menarray1=[NSMutableArray new];
    
        _startFlyTime=[_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(11, 5)];
        _startFlydate=[_FdataArray[0][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
        _FlightNumber=_FdataArray[0][@"flightNo"];
    
        _ShipSpace=_FdataArray[0][@"seatClass"];
    
    if (_FdataArray.count==2) {
        _startFlyTime1=[_FdataArray[1][@"fromDatetime"] substringWithRange:NSMakeRange(11, 5)];
        _startFlydate1=[_FdataArray[1][@"fromDatetime"] substringWithRange:NSMakeRange(0, 10)];
        _FlightNumber1=_FdataArray[1][@"flightNo"];
        
        _ShipSpace1=_FdataArray[1][@"seatClass"];

    }
    _arrNum1=[NSMutableArray new];
    _arrNum2=[NSMutableArray new];
    for (NSMutableDictionary * dict in _Messagedict[@"passengerInfoList"]) {
        passageMenModel * model =[[passageMenModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_arrNum1 addObject:@"0"];
        [_arrNum2 addObject:@"0"];
        [_menarray addObject:model];
        [_menarray1 addObject:model];
    }
    NSLog(@"%@",_arrNum1);
    [_tableView reloadData];
    NSLog(@"%@",_Messagedict);
}
-(void)creattable{
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-124) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight);
    [self.view addSubview:effectView];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenHeight/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    effectView.hidden=YES;
    UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(0,deviceScreenHeight, self.view.frame.size.width, 40)];
    vv.userInteractionEnabled=YES;
    vv.tag=133;
    vv.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:vv];
    butclear=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butclear.tag=211;
    [butclear addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butclear setTitle:@"取消" forState:UIControlStateNormal];
    [vv addSubview:butclear];
    [butclear mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(vv).offset(10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    butchange=[[UIButton alloc]initWithFrame:CGRectMake(5,10, 30, 20)];
    butchange.tag=212;
    [butchange addTarget:self action:@selector(picker:) forControlEvents:UIControlEventTouchUpInside];
    [butchange setTitle:@"确定" forState:UIControlStateNormal];
    [vv addSubview:butchange];
    [butchange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(vv).offset(-10);
        make.top.equalTo(vv).offset(10);
        make.height.offset(20);
        make.width.offset(40);
    }];
    [self.view addSubview:pickerView];
}
#pragma mark 设置滚动选择框
-(void)picker:(UIButton*)send{
    UIView * vv=[UIView new];
    switch (send.tag) {
        case 211:
            self.tabBarController.tabBar.hidden=YES;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            break;
        case 212:
            //确定
            self.tabBarController.tabBar.hidden=YES;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            break;
        default:
            break;
    }
}
-(void)loadPickerData:(NSMutableArray*)arr{
    _arr=[NSMutableArray arrayWithArray:arr];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _arr.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
    
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    
    if([_arr[0] isEqualToString:@"乘客自愿改签"]){
        resontype=_arr[rowOne];
        [_tableView reloadData];
    }else{
        resonmess=_arr[rowOne];
        [_tableView reloadData];
    }
}

//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(_FdataArray.count==2){
        switch (section) {
            case 0:
                return 0.01;
                break;
            case 1:
                return 40;
                break;
            case 2:
                return 40;
                break;
            case 3:
                return 40;
                break;
            case 4:
                return 40;
                break;
            case 5:
                return 10;
                break;
            default:
                return 0;
                break;
        }

    }else{
        switch (section) {
            case 0:
                return 0.01;
                break;
            case 1:
                return 40;
                break;
            case 2:
                return 40;
                break;
            case 3:
                return 10;
                break;
            default:
                return 0;
                break;
        }
  
    }
    }
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_FdataArray.count==2) {
        switch (section) {
            case 0:
                return 60/SCREEN_RATE;
                break;
            case 1:
                return 0.01;
                break;
            case 2:
                return 20;
                break;
            case 3:
                return 0.01;
                break;
            case 4:
                return 0.01;
                break;
            case 5:
                return 0.01;
                break;
            default:
                return 0;
                break;
        }

    }else{
        switch (section) {
            case 0:
                return 50/SCREEN_RATE;
                break;
            case 1:
                return 0.01;
                break;
            case 2:
                return 20;
                break;
            default:
                return 0;
                break;
        }
  
    }
   }
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            UIView * view0  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50/SCREEN_RATE)];
            view0.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            view.backgroundColor=[UIColor whiteColor];
            UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 10, 122, 16)]];
            label2.font=[UIFont systemFontOfSize:14];
            label2.text=@"实际改签费用总计";
            label2.textAlignment=NSTextAlignmentCenter;
            label2.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label2];
            UILabel * pricelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(260, 10, 66, 18)]];
            pricelabel.text=[NSString stringWithFormat:@"￥%@",_Messagedict[@"ticketPrice"]];
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
   
    if(_FdataArray.count==2){
        switch (section) {
            case 0:{
                return 0;
                break;}
            case 1:{
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
                UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 15, 15, 15)]];
                menimage.image=[UIImage imageNamed:@"passenger"];
                [view addSubview:menimage];
                UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 15, 260, 16)]];
                menlabel.text=@"申请改签乘机人";
                menlabel.font = [UIFont systemFontOfSize:14];
                menlabel.textColor=[UIColor blackColor];
                [view addSubview:menlabel];
                view.backgroundColor=[UIColor whiteColor];
                return view;
                break;}
            case 2:
            {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
                view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
                UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 13, 260, 16)]];
                menlabel.text=@"期望改签为:";
                menlabel.font = [UIFont systemFontOfSize:13];
                menlabel.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
                [view addSubview:menlabel];
                return view;
                break;
            }
            case 3:{
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
                UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 15, 15, 15)]];
                menimage.image=[UIImage imageNamed:@"passenger"];
                [view addSubview:menimage];
                UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 15, 260, 16)]];
                menlabel.text=@"申请改签乘机人";
                menlabel.font = [UIFont systemFontOfSize:14];
                menlabel.textColor=[UIColor blackColor];
                [view addSubview:menlabel];
                view.backgroundColor=[UIColor whiteColor];
                return view;
                break;}
            case 4:
            {
                UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
                view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
                UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 13, 260, 16)]];
                menlabel.text=@"期望改签为:";
                menlabel.font = [UIFont systemFontOfSize:13];
                menlabel.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
                [view addSubview:menlabel];
                return view;
                break;
            }

            default:
                return 0;
                break;
        }
        
    }else{
    switch (section) {
        case 0:{
            return 0;
            break;}
        case 1:{
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 15, 15, 15)]];
            menimage.image=[UIImage imageNamed:@"passenger"];
            [view addSubview:menimage];
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 15, 260, 16)]];
            menlabel.text=@"申请改签乘机人";
            menlabel.font = [UIFont systemFontOfSize:14];
            menlabel.textColor=[UIColor blackColor];
            [view addSubview:menlabel];
            view.backgroundColor=[UIColor whiteColor];
            return view;
            break;}
        case 2:
        {
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
                       UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(10, 13, 260, 16)]];
            menlabel.text=@"期望改签为:";
            menlabel.font = [UIFont systemFontOfSize:13];
            menlabel.textColor=[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1];
            [view addSubview:menlabel];
            return view;
            break;
                }
        default:
            return 0;
            break;
    }
  }
}

//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_FdataArray.count==2){
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
            case 3:
                return 67/SCREEN_RATE;
                break;
            case 4:
                return 44/SCREEN_RATE;
                break;
            case 5:
                return 44/SCREEN_RATE;
                break;
            default:
                return 0;
                break;
        }

    }else{
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
            case 3:
                return 44/SCREEN_RATE;
                break;
            default:
                return 0;
                break;
        }

    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if(_FdataArray.count==2){
        return 6;
    }else{
        return 4;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_FdataArray.count==2){
        switch (section) {
            case 0:
                return _FdataArray.count;
                break;
            case 1:
                return _menarray.count;
                break;
           
            case 2:
                return 2;
                
                break;
                
            case 3:
                return _menarray1.count;
                break;
                
            case 4:
                return 2;
                
                break;
            case 5:
                return 2;
                break;
            default:
                return 0;
                break;
        }
    }else{
        switch (section) {
            case 0:
                return _FdataArray.count;
                break;
            case 1:
                return _menarray.count;
                break;
            case 2:
                return 2;
                break;
            case 3:
                return 2;
                break;
            default:
                return 0;
                break;
        }
    }
    
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(_FdataArray.count==2){
        switch (indexPath.section) {
            case 0:{
                order1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
                }
                cell.celloutlabel.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(indexPath.row==1){
                    cell.logoimage.image=[UIImage imageNamed:@"backward"];
                }
                cell.celloutlabel.text=[NSString stringWithFormat:@"%@",_FdataArray[indexPath.row][@"toDatetime"]];
                cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",_FdataArray[indexPath.row][@"fromCity"],_FdataArray[indexPath.row][@"toCity"]];
                return cell;
                break;
            }
            case 1:{
                CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
                if (!cell) {
                    cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if([_arrNum1[indexPath.row] isEqualToString:@"0"])
                {
                    cell.disledimage.image=[UIImage imageNamed:@"check_off"];
                }else{
                    cell.disledimage.image=[UIImage imageNamed:@"check_on"];
                }
                
                [cell setCellWithModel:_menarray[indexPath.row]];
                //            cell.namelabel.text=_menarray[indexPath.row][@"passengerName"];
                //            cell.label3.hidden=YES;
                //            cell.IdNumlabel.hidden=YES;
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
                
                if(indexPath.row==0){
                    cell.headlabel.text=@"改签时间";
                    cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@",_startFlydate,_startFlyTime];
                }else{
                    cell.headlabel.text=@"改签航班";
                     cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@起飞 %@",_FlightNumber,_startFlyTime,_ShipSpace];
                }
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
                break;
            }
            case 3:{
                CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
                if (!cell) {
                    cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if([_arrNum2[indexPath.row] isEqualToString:@"0"])
                {
                    cell.disledimage.image=[UIImage imageNamed:@"check_off"];
                }else{
                    cell.disledimage.image=[UIImage imageNamed:@"check_on"];
                }
                
                [cell setCellWithModel:_menarray1[indexPath.row]];
                // cell.namelabel.text=_menarray[indexPath.row][@"passengerName"];
                //cell.label3.hidden=YES;
                //cell.IdNumlabel.hidden=YES;
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
            case 4:{
                tgResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdctg"];
                if (!cell) {
                    cell = [[tgResonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdctg"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if(indexPath.row==0){
                    cell.headlabel.text=@"改签时间";
                    cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@",_startFlydate1,_startFlyTime1];

                }else{
                    cell.headlabel.text=@"改签航班";
                    cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@起飞 %@",_FlightNumber1,_startFlyTime1,_ShipSpace1];

                }
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
                break;
            }
            case 5:{
                tgResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdctg"];
                if (!cell) {
                    cell = [[tgResonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdctg"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if(indexPath.row==0){
                    cell.headlabel.text=@"改签类型";
                    cell.resonlabel.text=resontype;
                }else{
                    cell.headlabel.text=@"改签原因";
                    cell.resonlabel.text=resonmess;
                }
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
    }else{
        switch (indexPath.section) {
            case 0:{
                order1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
                }
                cell.celloutlabel.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                cell.backgroundColor=[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if(indexPath.row==1){
                    cell.logoimage.image=[UIImage imageNamed:@"backward"];
                }
                cell.celloutlabel.text=[NSString stringWithFormat:@"%@",_FdataArray[indexPath.row][@"toDatetime"]];
                cell.airlabel.text=[NSString stringWithFormat:@"%@-%@",_FdataArray[indexPath.row][@"fromCity"],_FdataArray[indexPath.row][@"toCity"]];
                return cell;
                break;
            }
            case 1:{
                CJNmessCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdcjn"];
                if (!cell) {
                    cell = [[CJNmessCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdcjn"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if([_arrNum1[indexPath.row] isEqualToString:@"0"])
                {
                    cell.disledimage.image=[UIImage imageNamed:@"check_off"];
                }else{
                    cell.disledimage.image=[UIImage imageNamed:@"check_on"];
                }
                [cell setCellWithModel:_menarray[indexPath.row]];
                //cell.namelabel.text=_menarray[indexPath.row][@"passengerName"];
                //cell.label3.hidden=YES;
                //cell.IdNumlabel.hidden=YES;
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
                if(indexPath.row==0){
                    cell.headlabel.text=@"改签时间";
                    cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@",_startFlydate,_startFlyTime];
                }else{
                    cell.headlabel.text=@"改签航班";
                    cell.resonlabel.text=[NSString stringWithFormat:@"%@ %@起飞 %@",_FlightNumber,_startFlyTime,_ShipSpace];
                }
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
                return cell;
                break;
            }
            case 3:{
                tgResonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdctg"];
                if (!cell) {
                    cell = [[tgResonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellIdctg"];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                if(indexPath.row==0){
                    cell.headlabel.text=@"退票类型";
                    cell.resonlabel.text=resontype;
                }else{
                    cell.headlabel.text=@"退票原因";
                    cell.resonlabel.text=resonmess;
                }
                //去除点击效果
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
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
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(_FdataArray.count==2){
        if(indexPath.section==5){
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.hidden=YES;
                effectView.hidden=NO;
                // 设置view弹出来的位置
                pickerView.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3, self.view.frame.size.width, self.view.frame.size.height/3);
                UIView * vv =(UIView*)[self.view viewWithTag:133];
                vv.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3-40, self.view.frame.size.width, 40);
            }];
            if(indexPath.row==0){
                [self loadPickerData:_arr1];
            }else{
                [self loadPickerData:_arr2];
            }
        }else if (indexPath.section==3){
                if ([_arrNum2[indexPath.row] isEqualToString:@"0"]) {
                    _arrNum2[indexPath.row]=@"1";
                }else{
                    _arrNum2[indexPath.row]=@"0";
                }
                [_tableView reloadData];
        }else if (indexPath.section==1){
            
                if ([_arrNum1[indexPath.row] isEqualToString:@"0"]) {
                    _arrNum1[indexPath.row]=@"1";
                }else{
                    _arrNum1[indexPath.row]=@"0";
                }
                [_tableView reloadData];
        }else if (indexPath.section==2){
            if(indexPath.row==0){
            LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
                [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
                    NSString *str1 =paramas[@"month"];
                    NSString *str2=paramas[@"day"];
                    if([paramas[@"month"] intValue]<10){
                        str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
                    }
                    if([paramas[@"day"] intValue]<10){
                        str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
                    }
                    _startFlydate= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
                    [_tableView reloadData];

                }];
                //[self.navigationController  pushViewController:ctl animated:YES];
                [self presentViewController:ctl animated:YES completion:nil];
            }else{
                FlightMessageVC * fmvc = [FlightMessageVC new];
                fmvc.gqYESorNO=YES;
                fmvc.fromcity=_FdataArray[0][@"fromCityCharacter"];
                fmvc.tocity=_FdataArray[0][@"toCityCharacter"];
                fmvc.fromdate=_startFlydate;

                fmvc.block=^(NSMutableDictionary *
                             datadict,NSString * flightnum,NSString * stratFlytime,NSString * fromdata){
                    _FlightNumber=flightnum;
                    _ShipSpace=datadict[@"cabinName"];
                    _startFlyTime=stratFlytime;
                    _startFlydate=fromdata;
                    [_tableView reloadData];
                };
                 [self presentViewController:fmvc animated:NO completion:nil];
            }
        }else if (indexPath.section==4){
            if(indexPath.row==0){
                LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
                [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
                    NSString *str1 =paramas[@"month"];
                    NSString *str2=paramas[@"day"];
                    if([paramas[@"month"] intValue]<10){
                        str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
                    }
                    if([paramas[@"day"] intValue]<10){
                        str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
                    }
                    //NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
                    _startFlydate1= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
                    [_tableView reloadData];
                }];
                //[self.navigationController  pushViewController:ctl animated:YES];
                [self presentViewController:ctl animated:YES completion:nil];
            }else{
                FlightMessageVC * fmvc = [FlightMessageVC new];
                fmvc.gqYESorNO=YES;
                fmvc.fromcity=_FdataArray[1][@"fromCityCharacter"];
                fmvc.tocity=_FdataArray[1][@"toCityCharacter"];
                fmvc.fromdate=_startFlydate1;
                
                fmvc.block=^(NSMutableDictionary *
                             datadict,NSString * flightnum,NSString * stratFlytime,NSString * fromdata){
                    _FlightNumber1=flightnum;
                    _ShipSpace1=datadict[@"cabinName"];
                    _startFlyTime1=stratFlytime;
                    _startFlydate1=fromdata;

                    [_tableView reloadData];

                };
                [self presentViewController:fmvc animated:NO completion:nil];

            }
        }else{
            
        }
    }else{
        if(indexPath.section==3){
            [UIView animateWithDuration:0.5 animations:^{
                self.tabBarController.tabBar.hidden=YES;
                effectView.hidden=NO;
                // 设置view弹出来的位置
                pickerView.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3, self.view.frame.size.width, self.view.frame.size.height/3);
                UIView * vv =(UIView*)[self.view viewWithTag:133];
                vv.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3-40, self.view.frame.size.width, 40);
            }];
            
            if(indexPath.row==0){
                [self loadPickerData:_arr1];
            }else{
                [self loadPickerData:_arr2];
            }
        }else if (indexPath.section==1){
                if ([_arrNum1[indexPath.row] isEqualToString:@"0"]) {
                    _arrNum1[indexPath.row]=@"1";
                }else{
                    _arrNum1[indexPath.row]=@"0";
                }
                [_tableView reloadData];
        }else if (indexPath.section==2){
            if(indexPath.row==0){
                LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
                [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
                    NSString *str1 =paramas[@"month"];
                    NSString *str2=paramas[@"day"];
                    if([paramas[@"month"] intValue]<10){
                        str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
                    }
                    if([paramas[@"day"] intValue]<10){
                        str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
                    }
                    // NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
                    _startFlydate= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
                    [_tableView reloadData];
                }];
                
//                [self.navigationController  pushViewController:ctl animated:YES];
                [self presentViewController:ctl animated:YES completion:nil];
            }else{
                FlightMessageVC * fmvc = [FlightMessageVC new];
                fmvc.gqYESorNO=YES;
                fmvc.fromcity=_FdataArray[0][@"fromCityCharacter"];
                fmvc.tocity=_FdataArray[0][@"toCityCharacter"];
                fmvc.fromdate=_startFlydate;
                fmvc.block=^(NSMutableDictionary *
                             datadict,NSString * flightnum,NSString * stratFlytime,NSString * fromdata){
                    _FlightNumber=flightnum;
                    _ShipSpace=datadict[@"cabinName"];
                    _startFlyTime=stratFlytime;
                    _startFlydate=fromdata;
                    [_tableView reloadData];
                };
                [self.navigationController  pushViewController:fmvc animated:YES];

//                [self presentViewController:fmvc animated:NO completion:nil];
            }
        }else{
        }
    }
}
-(void)SPclick:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    self.view.userInteractionEnabled=NO;
    FlightOrderChange * changegq = [FlightOrderChange new];
    changegq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    changegq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    changegq.OrderNo=_orderStr;
    NSMutableArray * arr  = [NSMutableArray new];
    for ( int i=0;i<_arrNum1.count;i++) {
        if ([_arrNum1[i] isEqualToString:@"1"]){
            OrderChangeListmodel * passnger = [OrderChangeListmodel new];
            passageMenModel * model =[[passageMenModel alloc] init];
            model=_menarray[i];
            passnger.PassengerId=model.passengerId;
            passnger.FlightId=_FdataArray[0][@"airRangeId"];
            passnger.FlightNumber=_FlightNumber;
            passnger.ShipSpace=_ShipSpace;
            [arr addObject:passnger];
        }
    }
    if(_FdataArray.count==2){
        for ( int i=0;i<_arrNum2.count;i++) {
            if ([_arrNum2[i] isEqualToString:@"1"])
            {
                OrderChangeListmodel * passnger = [OrderChangeListmodel new];
                passageMenModel * model =[[passageMenModel alloc] init];
                model=_menarray[i];
                passnger.PassengerId=model.passengerId;
                passnger.FlightId=_FdataArray[1][@"airRangeId"];
                passnger.FlightNumber=_FlightNumber1;
                passnger.ShipSpace=_ShipSpace1;
                [arr addObject:passnger];
            }
        }
    }
    changegq.OrderChangeList =[OrderChangeListmodel mj_keyValuesArrayWithObjectArray:arr];
    //Freturn.ReasonName=@"";
    //Freturn.RefundReason=@"";
    changegq.ChangeReason=resonmess;
    for (int i=0; i<_arr2.count; i++) {
        if([_arr2[i] isEqualToString:resonmess]){
    changegq.ChangeReasonCode=[NSString stringWithFormat:@"%d",i+1];
        }
    }
   
    [Flight FlightOrderChange:changegq success:^(id data) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;
        
        //                NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
//            FlightorderList * vc = [FlightorderList new];
//            [self presentViewController:vc animated:NO completion:nil];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
