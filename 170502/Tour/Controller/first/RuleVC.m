//
//  RuleVC.m
//  Tour
//
//  Created by Euet on 16/12/29.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RuleVC.h"
#import "RuleCell.h"
#import "hotelorderVC.h"

@interface RuleVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    
    NSString * erroID;
    NSString * erroMessage;

}
@end
@implementation RuleVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",_menarray);
    self.tabBarController.tabBar.hidden=YES;

    self.view.backgroundColor= [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1] ;
    [self creatvtabar];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    BreachReasonQueryRequest * breach =[BreachReasonQueryRequest new];
    breach.Start=0;
    breach.Count=20;
    if(_trainDatadict!=nil){
        breach.Type=@"312011606tr";
    }else if(_requtstdict!=nil){
        breach.Type=@"312011602tk";
    }else{
        breach.Type=@"312011605ht";
    }
    breach.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    breach.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic BreachReasonQueryRequest:breach success:^(id data) {
        [SVProgressHUD dismiss];
        NSArray *arr=data[@"reasonList"];
        NSMutableArray * arry = [NSMutableArray arrayWithArray:arr];
        NSMutableArray * arry1=[NSMutableArray new];
        for(int i=0;i<arry.count;i++){
            NSMutableDictionary * mutDic2 = [[NSMutableDictionary alloc]initWithDictionary:arry[i]];
            [mutDic2 setValue:@"1" forKey:@"num"];
            [arry1 addObject:mutDic2];
        }
        _dataArray=[NSMutableArray arrayWithArray:arry1];
        NSLog(@"%@",_dataArray);
        [_tableView reloadData];
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, _messageView.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    [_messageView addSubview:_tableView];
   
    if ([_style isEqualToString:@"hotel"]) {
        _erroLabel.text=_herromes;
    }
    _erroLabel.text=_erro;
    _erroLabel.numberOfLines = 0; // 最关键的一句
    [_okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_okbut addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    _okbut.hidden=YES;
}
-(void)creatvtabar{
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"违背原因";
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
}
-(void)back:(UIButton*)send{
    [self.navigationController popViewControllerAnimated:YES];
//    [self dismissViewControllerAnimated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RuleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    //  cell的复用
    if (!cell) {
        cell= (RuleCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"RuleCell" owner:self options:nil]  lastObject];
    }
    if([_dataArray[indexPath.row][@"num"] isEqualToString:@"0"]){
        cell.delisdimage.image=[UIImage imageNamed:@"radio_on"];
    }else{
      cell.delisdimage.image=[UIImage imageNamed:@"radio_off"];
    }
    cell.errolabel.text=_dataArray[indexPath.row][@"reasonName"];
    return cell;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //获取cell的方法
//    RuleCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    erroID=_dataArray[indexPath.row][@"reasonId"];
    erroMessage=_dataArray[indexPath.row][@"reasonName"];
    for (int i=0;i<_dataArray.count;i++) {
        _dataArray[i][@"num"]=@"1";
    }
    _dataArray[indexPath.row][@"num"]=@"0";
    [_tableView reloadData];
    if([_style isEqualToString:@"train"]){
        TrainorderVC *  toc = [TrainorderVC new];
        toc.erroID=erroID;
        toc.count=_Tcount;
        toc.menarray=_menarray;
        toc.erromes=_erromes;
        toc.erroMessage=erroMessage;
        toc.trainDatadict=_trainDatadict;
        toc.seatDatadict=_seatDatadict;
        toc.errArray=_dataArray;
        toc.requtstdict=_requtstdict;
        toc.seatarr=_seatarr;
        toc.StopOverarr=_StopOverarr;
        toc.gxlabeltext=_gxlabeltext;
        toc.username_12306=_username_12306;
        toc.pssageWord_12306=_pssageWord_12306;
        [self.navigationController  pushViewController:toc animated:YES];
        //       [self presentViewController:toc animated:NO completion:nil];
        
    }else if([_style isEqualToString:@"hotel"]){
        
        hotelorderVC * hovc = [hotelorderVC new];
        hovc.erroID=erroID;
        hovc.menarray=_menarray;
        hovc.erromes=_erromes;
        hovc.erroMessage=erroMessage;
        hovc.errArray=_dataArray;
        hovc.roomname=_roomname;
        hovc.roommess=_roommess;
        hovc.inhoteldate=_inhoteldate;
        hovc.outhoteldate=_outhoteldate;
        hovc.hotelid=_hotelid;
        hovc.hotelname=_hotelname;
        hovc.capacity=_capacity;
        hovc.roomid=_roomid;
        hovc.roomprice=_roomprice;
        hovc.RatePlanId=_RatePlanId;
        hovc.payType=_payType;
        hovc.gxlabeltext=_gxlabeltext;
        hovc.rucode=_rucode;
        hovc.address=_address;
        [self.navigationController  pushViewController:hovc animated:YES];
        
        //        [self presentViewController:hovc animated:NO completion:nil];
    }else{
        if( [[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
            if(_dataArr.count==1){
                [_dataArr[0] setValue:erroID forKey:@"erroID"];
                [_dataArr[0] setValue:erroMessage forKey:@"erroMessage"];
                [_dataArr[0] setValue:_erromes forKey:@"erromes"];
                NSMutableArray * arry = [NSMutableArray new];
                arry=_dataArr;
                NSLog(@"%@",arry);
                FlightMessageVC * vc =[FlightMessageVC new];
                vc.arr1=arry;
                vc.menarray=_menarray;
                vc.requtstdict=_requtstdict;
                vc.to=YES;
                [self.navigationController pushViewController:vc animated:YES];
                //                      [self presentViewController:vc animated:YES completion:nil];
            }else{
                [_dataArr[1] setValue:erroID forKey:@"erroID"];
                [_dataArr[1] setValue:erroMessage forKey:@"erroMessage"];
                [_dataArr[1] setValue:_erromes forKey:@"erromes"];
                OrderVC * orc = [OrderVC new];
                orc.errArray=_dataArray;
                orc.dataArray=_dataArr;
                orc.cabinArray=_cabinArray;
                orc.menarray=_menarray;
                //[self presentViewController:orc animated:YES completion:nil];
                [self.navigationController pushViewController:orc animated:YES];
            }
        }else{
            OrderVC * orc = [OrderVC new];
            orc.errArray=_dataArray;
            orc.erroMessage=erroMessage;
            orc.erroID=erroID;
            orc.dataArray=_dataArr;
            orc.cabinArray=_cabinArray;
            orc.erromes=_erromes;
            orc.menarray=_menarray;
            [self.navigationController pushViewController:orc animated:YES];
            //    [self presentViewController:orc animated:YES completion:nil];
        }
    }
    
}
-(void)onClick:(UIButton*)send{
}
@end
