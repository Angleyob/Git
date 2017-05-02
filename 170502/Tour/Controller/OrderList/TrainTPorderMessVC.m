//
//  TrainTPorderMessVC.m
//  Tour
//
//  Created by Euet on 17/2/17.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrainTPorderMessVC.h"
#import "trainorder0.h"
#import "CJNmessCell.h"
#import "tgResonCell.h"
#import "tReturnmodel.h"

@interface TrainTPorderMessVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITableView * _tableView;
    NSMutableArray * _array;
    
    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableArray * _contactarray;
    UILabel * menla;
    UILabel * numeberla;
    
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

    
    NSMutableArray * _arr;

    BOOL isa;

}
@end

@implementation TrainTPorderMessVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray * array1 = @[@"乘客自愿退票",@"航班延误或取消",@"因病退票"];
    NSArray * array2 = @[@"临时取消",@"航班延误或取消",@"领导临时安排"];
    _arr1=[NSMutableArray arrayWithArray:array1];
    _arr2=[NSMutableArray arrayWithArray:array2];

    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"退票申请";
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
    
        UIView * bottomview  = [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60/SCREEN_RATE, 375/SCREEN_RATE, 60/SCREEN_RATE)];
        [self.view addSubview:bottomview];
        UILabel * button1= [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 20, 210, 16)]];
        button1.adjustsFontSizeToFitWidth=YES;
        button1.text=@"产生的退票费用以最终的核算为准";
        button1.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        button1.textAlignment=NSTextAlignmentCenter;
        button1.font=[UIFont systemFontOfSize:14];
        [bottomview addSubview:button1];
        UIButton * button2= [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(250, 8,110, 44)]];
        button2.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        button2.titleLabel.font=[UIFont systemFontOfSize:14];
        [button2 setTitle:@"确定退票" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(SPclick:) forControlEvents:UIControlEventTouchUpInside];
        [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button2.tag=308;
        //剪切
        button2.clipsToBounds=YES;
        //圆角
        button2.layer.cornerRadius = 10.0;
        [bottomview addSubview:button2];
    
    [self creattable];
    
    [self loadData];
    
}
-(void)loadData{
    _arrNum1=[NSMutableArray new];
   _menarray=[NSMutableArray new];
 
    _Messagedict=_Alldata[@"trainTicket"];
    
//    NSLog(@"%@",_Messagedict);
    
    for (NSMutableDictionary * dict in _Alldata[@"trainBoxList"]) {
        passageTrainMenModel * model =[[passageTrainMenModel alloc] init];
        [model setValuesForKeysWithDictionary:dict];
        [_arrNum1 addObject:@"0"];
        [_menarray addObject:model];
    }
    NSLog(@"%@",_menarray);
    
    [_tableView reloadData];
    
//    TrainReturnInfQuery * fcif = [TrainReturnInfQuery new];
//    fcif.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
//    fcif.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
//    fcif.RefundOrderNo=_orderStr;
//    [Train TrainReturnInfQuery:fcif success:^(id data) {
//        // NSLog(@"%@",data);
//        if([data[@"status"] isEqualToString:@"T"]){
//            _Messagedict=data[@"trainChangeTicket"];
//            _menarray=data[@"trainChangeBoxList"];
//        //_FdataArray=data[@"flightInfo"];
//        }
//        [_tableView reloadData];
//    } failure:^(NSError *error) {
//    }];
}
-(void)creattable{
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-170) style:UITableViewStyleGrouped];
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
    //_arr=@[@"不限",@"经济舱",@"公务舱",@"头等舱",@"明珠舱"];
    // NSLog(@"%@",projectarray);
    _arr=[NSMutableArray arrayWithArray:arr];
    //    NSLog(@"%@",_arr[0][@"costName"]);
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
    
    if([_arr[0] isEqualToString:@"乘客自愿退票"]){
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
            return 50/SCREEN_RATE;
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
            
            UIView * view0  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50/SCREEN_RATE)];
            view0.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            
            UIView * view  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40/SCREEN_RATE)];
            view.backgroundColor=[UIColor whiteColor];

            
//            UILabel * label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 12, 245, 16)]];
//            label1.font=[UIFont systemFontOfSize:14];
//            label1.textAlignment=NSTextAlignmentCenter;
//            label1.text=[NSString stringWithFormat:@"申请改签时间:%@",_Messagedict[@"retrunDate"]];
//            label1.adjustsFontSizeToFitWidth=YES;
//            [view addSubview:label1];
//            UIView * viewline  = [[UIView alloc]initWithFrame:CGRectMake(20/SCREEN_RATE, 35/SCREEN_RATE, deviceScreenWidth-20, 1/SCREEN_RATE)];
//            viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
//            [view addSubview:viewline];
            
            
            UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 10, 122, 16)]];
            label2.font=[UIFont systemFontOfSize:14];
            label2.text=@"实际退票费用总计";
            label2.textAlignment=NSTextAlignmentCenter;
            label2.adjustsFontSizeToFitWidth=YES;
            [view addSubview:label2];

            
            UILabel * pricelabel = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(260, 10, 66, 18)]];
            pricelabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
            pricelabel.text=[NSString stringWithFormat:@"￥%.1lf",[_Messagedict[@"fee"] floatValue]+[_Messagedict[@"price"] floatValue]];
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
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(40, 18, 110, 16)]];
            menlabel.text=@"申请退票乘车人";
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
            
            cell.orderlabel.text=[NSString stringWithFormat:@"新订单号:%@",_Messagedict[@"orderId"]];
                
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
            passageTrainMenModel * model =[[passageTrainMenModel alloc] init];
            model=_menarray[indexPath.row];
            
            cell.namelabel.text=model.passengerName;
            cell.label3.text=@"身份证";
            cell.IdNumlabel.text=model.passportNo;
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
            if(indexPath.row==1){
                cell.headlabel.text=@"退票原因";
                cell.resonlabel.text=resonmess;
            }else{
                cell.headlabel.text=@"退票类型";
                cell.resonlabel.text=resontype;
            }
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
   
    if(indexPath.section==2){
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
    }else{
        
    }
}
-(void)SPclick:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainOrderReturn * treturn = [TrainOrderReturn new];
    
    treturn.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    treturn.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    
    treturn.OrderNo=_Messagedict[@"orderId"];
    
    NSMutableArray * arr  = [NSMutableArray new];
    for ( int i=0;i<_arrNum1.count;i++) {
        if ([_arrNum1[i] isEqualToString:@"1"])
        {
            tReturnmodel * passnger = [tReturnmodel new];

            passageTrainMenModel * model =[[passageTrainMenModel alloc] init];
            model=_menarray[i];
            
            passnger.PassportsEno=model.passportNo;
            passnger.PassengerName=model.passengerName;
            passnger.PassportTypeseId=model.passportType;
            passnger.TicketNo=model.ticketNo;
            [arr addObject:passnger];
        }
    }
    treturn.Retruntickets =[tReturnmodel mj_keyValuesArrayWithObjectArray:arr];
    
    [Train TrainOrderReturn:treturn success:^(id data) {
        [SVProgressHUD dismiss];
        self.view.userInteractionEnabled=YES;

        if([data[@"status"] isEqualToString:@"T"]){
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.2];
            [self dismissViewControllerAnimated:NO completion:nil];

//            TrainorderList * vc = [TrainorderList new];
//            [self presentViewController:vc animated:NO completion:nil];            
        }else{
            [UIAlertView showAlertWithTitle1:data[@"message"] duration:1.5];
        }
        
    } failure:^(NSError *error) {
        self.view.userInteractionEnabled=YES;

          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:NO completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
