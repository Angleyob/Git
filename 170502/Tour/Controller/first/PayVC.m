//
//  PayVC.m
//  Tour
//
//  Created by Euet on 16/12/24.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "PayVC.h"
#import "check1Cell.h"
#import "PayCell.h"
#import "HorderCell.h"
#import "trainorder0.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"       //微信分享和微信支付
#import "UPPaymentControl.h"
#import "TJTCell.h"
#import "priceMesCellTableViewCell.h"
#import "PMCell.h"

@interface PayVC ()<UITableViewDelegate,UITableViewDataSource,trainorder0Delegate>
{
    UITableView * _tableView;
        NSMutableArray * _thirdPayarray;
    NSMutableArray * _advancepayarray;
    BOOL isa;
    //火车经停蒙版视图
    UIView * _JTconnetview;
    UITableView * _tableView2;
    
    //火车价格详情
    UIView * view4;
    UIView* _Bottomconnetview;
    UILabel * mennum;
    UILabel * free;
    UILabel * tprice;
    //酒店价格详情
    UIView * hview4;
    UIView * _hconnetview1;
    
    UILabel * hfree;
    UILabel * hprice;
    
    //飞机价格详情
    UITableView * _FpricetableView;


}
@end

@implementation PayVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    NSLog(@"%@",_FdataArray1);
    [self initview];
    [self Tabview];
    [self loaddata];
   [self creattable];
}
#pragma mark -初始化
-(void)initview{
//    _array = [[NSMutableArray alloc] init];
   //用于判断是否因公，因公预付款，yes为关闭;
    isa=YES;
    
    if ([_BusinessType isEqualToString:@"1"]) {
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
            isa=NO;
        }
    }else if ([_BusinessType isEqualToString:@"17"]){
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
            isa=NO;
        }
    }else{
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
            isa=NO;
        }
    }
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
        
     NSLog(@"%@",data);
        
        _thirdPayarray=data[@"thirdPayTypeList"];
       
        _advancepayarray =data[@"advancePayTypeList"];
      
        [_tableView reloadData];
                       } failure:^(NSError *error) {
                             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
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
    if([_BusinessType isEqualToString:@"1"])
    {
        label1.text=@"请于20:30之前完成支付，否则订单将被取消。";
    }else if ([_BusinessType isEqualToString:@"2"])
    {
        label1.text=@"请于25分钟之内完成支付，否则订单将被取消。";
    }else{
        label1.text=@"请于20:30之前完成支付，否则订单将被取消。";
    }
    label1.adjustsFontSizeToFitWidth = YES;
    //文本居中
    label1.textAlignment =NSTextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor blackColor];
    [dataview addSubview:label1];
}
-(void)backAndnext:(UIButton*)send{
    if(send.tag==666){
        
        [AlertViewManager alertWithTitle:@"温馨提示"
                                 message:@"您现在订单尚未支付，是否确定退出？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                     if (index==1) {
                                         self.navigationController.tabBarController.selectedIndex = 0;
                                         [self.navigationController popToRootViewControllerAnimated:YES];
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
    
    _JTconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _JTconnetview.backgroundColor=[UIColor blackColor];
    _JTconnetview.alpha=0.7;
    [self.view  addSubview:_JTconnetview];
    UIView * taview =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 150, 375, 20)]];
    UILabel * labeljt = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(152, 0, 73, 20)]];
    labeljt.text=@"经停信息";
    labeljt.font=[UIFont systemFontOfSize:15];
    labeljt.adjustsFontSizeToFitWidth=YES;
    labeljt.textColor=[UIColor whiteColor];
    [taview addSubview:labeljt];
    [_JTconnetview addSubview:taview];
    
    _tableView2= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 215, 375, 250)] style:UITableViewStylePlain];
    _tableView2.backgroundColor=[UIColor blackColor];
    // _tableView1.alpha=0.7;
    _tableView2.dataSource=self;
    _tableView2.delegate=self;
    _tableView2.bounces=NO;
    UITapGestureRecognizer *traintab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtraintab:)];
    [_tableView2 addGestureRecognizer:traintab];
    _tableView2.separatorStyle = UITableViewCellSelectionStyleNone;
    [_JTconnetview addSubview:_tableView2];
    
    _Bottomconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _Bottomconnetview.backgroundColor=[UIColor blackColor];
    _Bottomconnetview.alpha=0.7;
    [self.view  addSubview:_Bottomconnetview];
    
    view4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    tprice=[UILabel new];
    tprice.textAlignment=NSTextAlignmentCenter;
    tprice.font=[UIFont systemFontOfSize:14];
//    tprice.adjustsFontSizeToFitWidth=YES;
    tprice.text=_mestprice;
    [view4 addSubview:tprice];
    [tprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    free=[UILabel new];
    free.textAlignment=NSTextAlignmentCenter;
    free.font=[UIFont systemFontOfSize:14];
    free.text=_mesfreeprice;
    [view4 addSubview:free];
    [free mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    
    //价详情蒙版
    _hconnetview1=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _hconnetview1.backgroundColor=[UIColor blackColor];
    _hconnetview1.alpha=0.7;
    [self.view  addSubview:_hconnetview1];
    /* 票价详情*/
    hview4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    hview4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:hview4];
    hprice=[UILabel new];
    hprice.textAlignment=NSTextAlignmentCenter;
    hprice.font=[UIFont systemFontOfSize:14];

//    NSLog(@"%@",_meshprice);
    hprice.text=_meshprice;
    hprice.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [hview4 addSubview:hprice];
    
    [hprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hview4).offset(20);
        make.top.equalTo(hview4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    hfree=[UILabel new];
    hfree.textAlignment=NSTextAlignmentCenter;
    hfree.font=[UIFont systemFontOfSize:14];
    hfree.text=_meshfreeprice;
    hfree.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
//    hfree.adjustsFontSizeToFitWidth=YES;
    [hview4 addSubview:hfree];
    [hfree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hview4).offset(20);
        make.top.equalTo(hview4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    
    _FpricetableView= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 150) style:UITableViewStyleGrouped];
    _FpricetableView.dataSource=self;
    _FpricetableView.delegate=self;
    _FpricetableView.alpha=1;
    _FpricetableView.userInteractionEnabled = NO;
    _FpricetableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _FpricetableView.backgroundColor=[UIColor grayColor];

    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 0.01)];
    _FpricetableView.tableHeaderView=headView;
    [self.view addSubview:_FpricetableView];

}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView]) {
        return 40;
    }else if ([tableView isEqual:_FpricetableView]) {
        return 0;
    }else{
        return 30/SCREEN_RATE1;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([tableView isEqual:_tableView]) {
        return 40;
    }else{
         return 0;
    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
if ([tableView isEqual:_tableView]) {
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
}else if ([tableView isEqual:_FpricetableView]) {
    return 0;
}else{
      UIView * jtview = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375, 30)]];
      jtview.backgroundColor=[UIColor colorWithRed:13/255.0 green:70/255.0 blue:128/255.0 alpha:1];
      jtview.backgroundColor=[UIColor blackColor];
      UILabel * label1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(42, 7, 28, 16)]];
      label1.adjustsFontSizeToFitWidth=YES;
      label1.textAlignment=NSTextAlignmentCenter;
      label1.text=@"站次";
      label1.textColor=[UIColor whiteColor];
      label1.font=[UIFont systemFontOfSize:14];
      [jtview addSubview:label1];
      UIView * view11=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(88, 0, 1, 30)]];
      view11.backgroundColor=[UIColor whiteColor];
      [jtview addSubview:view11];
      UILabel * label2 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(108, 7, 28, 16)]];
      label2.adjustsFontSizeToFitWidth=YES;
      label2.textAlignment=NSTextAlignmentCenter;
      label2.text=@"站点";
      label2.textColor=[UIColor whiteColor];
      label2.font=[UIFont systemFontOfSize:14];
      [jtview addSubview:label2];
      UIView * view2=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(154, 0, 1, 30)]];
      view2.backgroundColor=[UIColor whiteColor];
      [jtview addSubview:view2];
      
      UILabel * label3 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(160, 7, 56, 16)]];
      label3.adjustsFontSizeToFitWidth=YES;
      label3.textAlignment=NSTextAlignmentCenter;
      label3.text=@"到站时间";
      label3.textColor=[UIColor whiteColor];
      label3.font=[UIFont systemFontOfSize:14];
      [jtview addSubview:label3];
      
      UIView * view3=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(221, 0, 1, 30)]];
      view3.backgroundColor=[UIColor whiteColor];
      [jtview addSubview:view3];
      
      UILabel * label4 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(228, 7, 56, 16)]];
      label4.adjustsFontSizeToFitWidth=YES;
      label4.textAlignment=NSTextAlignmentCenter;
      label4.text=@"出发时间";
      label4.textColor=[UIColor whiteColor];
      label4.font=[UIFont systemFontOfSize:14];
      [jtview addSubview:label4];
      
      UIView * view44=[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(287, 0, 1, 30)]];
      view44.backgroundColor=[UIColor whiteColor];
      [jtview addSubview:view44];
      
      UILabel * label5 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(295, 7, 56, 16)]];
      label5.adjustsFontSizeToFitWidth=YES;
      label5.textAlignment=NSTextAlignmentCenter;
      label5.text=@"停留时长";
      label5.textColor=[UIColor whiteColor];
      label5.font=[UIFont systemFontOfSize:14];
      [jtview addSubview:label5];
      
      UIView * vline = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 29, 335, 1)]];
      vline.backgroundColor=[UIColor whiteColor];
      [jtview addSubview:vline];
      return jtview;
 }
}
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if ([tableView isEqual:_tableView]) {
        if(section==0){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 60)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            UIView*view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 50)];
            view1.backgroundColor=[UIColor whiteColor];
            [view addSubview:view1];
            UIButton * b1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
            b1.titleLabel.font=[UIFont systemFontOfSize:13];
            [b1 setTitle:@"订单金额总价" forState:UIControlStateNormal];
            [b1 setTitleColor:UIColorFromRGBA(0x4a4a4a, 1.0) forState:UIControlStateNormal];
            [view1 addSubview:b1];
            
            UILabel * label  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(251, 14, 100, 18)]];
            label.textColor=[UIColor orangeColor];
            label.textAlignment=NSTextAlignmentRight;
            label.font=[UIFont systemFontOfSize:14];

            if([_BusinessType isEqualToString:@"1"])
            {
                NSString *s = [NSString stringWithFormat:@"%@",_price];
                UIFont *font = [UIFont fontWithName:@"Arial" size:17];
                CGSize size = CGSizeMake(375,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [label setFrame:[framsizeclass newSuitFrame:CGRectMake(245, 14, labelsize.width*SCREEN_RATE, 18)]];
                 label.text=s;
            }else if ([_BusinessType isEqualToString:@"2"])
            {
                NSString *s = [NSString stringWithFormat:@"%@",_Tprice];
                UIFont *font = [UIFont fontWithName:@"Arial" size:16];
                CGSize size = CGSizeMake(375,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [label setFrame:[framsizeclass newSuitFrame:CGRectMake(245, 14, labelsize.width*SCREEN_RATE, 18)]];
                label.text=s;
            }else{
                NSString *s = [NSString stringWithFormat:@"￥%@",_Hprice];
                UIFont *font = [UIFont fontWithName:@"Arial" size:17];
                CGSize size = CGSizeMake(375,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [label  setFrame:[framsizeclass newSuitFrame:CGRectMake(245, 14, labelsize.width*SCREEN_RATE, 18)]];
                label.text=s;
            }
            [view1 addSubview:label];
            UIButton * b2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(325, 0, 50, 50)]];
            [b2 addTarget:self action:@selector(pricebutmess:) forControlEvents:UIControlEventTouchUpInside];
            [view1 addSubview:b2];
            b2.userInteractionEnabled=NO;
            UIImageView * butimage = [[UIImageView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(18, 17, 18, 14)]];
            //butimage.image=[UIImage imageNamed:@"chevron_hide"];
            butimage.image=[UIImage imageNamed:@"chevron_show"];
            [b2 addSubview:butimage];
            UITapGestureRecognizer *pricetab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Showpricetab:)];
            [view addGestureRecognizer:pricetab];
            return view;
        }else{
            return 0;
        }
    }else if([tableView isEqual:_FpricetableView]){
        return 0 ;
    }else{
        return 0;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if(indexPath.section==0){
            if(_price.length!=0){
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
    }else if ([tableView isEqual:_FpricetableView]) {
        return 30;
    }else{
        return 30/SCREEN_RATE1;
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:_tableView]) {
        return 2;
    }else if ([tableView isEqual:_FpricetableView]) {
        if (_FdataArray1.count==1) {
            return 2;
        }else{
            return 2;
        }
        }else{
        return 1;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        if ([tableView isEqual:_tableView]) {
        if(section==0){
            return 1;
        }
            
            
        else{
            if(isa==YES){
                return 3;
            }else{
                return 4;
            }
        }
    }else if ([tableView isEqual:_FpricetableView]) {
        return 5;
    }else{
        return _StopOverarr.count;
    }
//    return 4;
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:_tableView]) {
        if(indexPath.section==0){
            if(_price.length!=0){
                check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                // cell的复用
                if (!cell) {
                    cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.outdatalabel.text=_dataArray[indexPath.row][@"outdate"];
                cell.outTime.text=_dataArray[indexPath.row][@"date"];
                cell.arriveTime.text=[_dataArray[indexPath.row][@"arrivalTime"] substringWithRange:NSMakeRange(0, 5)];
                cell.copany.text=_dataArray[indexPath.row][@"conpany"];
                if ([_dataArray[indexPath.row][@"stopOver"] isEqualToString:@"0"]) {
                    cell.bettenCity.hidden=YES;
                }else{
                    cell.bettenCity.text=@"经停";
                }
                if(![_dataArray[indexPath.row][@"meal"]isEqualToString:@""]){
                    cell.meallabel.text=@"有餐食";
                }else{
                    cell.meallabel.text=@"无";
                }
                
                cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_dataArray[indexPath.row][@"flightMode"]];
                cell.arrviCity.text=_dataArray[indexPath.row][@"arrivalCity"];
                cell.outCity.text=_dataArray[indexPath.row][@"departCity"];
                cell.flyTime.text=_dataArray[indexPath.row][@"flytime"];
                return cell;
            }else if ([_BusinessType isEqualToString:@"17"]){
                HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
                }
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.hotelnamelabel.text=_hotelname;
                cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
                cell.roomname.text=_roomname;
                cell.roomname.adjustsFontSizeToFitWidth=YES;
                cell.hotelmess.text=_roommess;
                cell.hotelmess.textColor=[UIColor grayColor];
                cell.hotelmess.adjustsFontSizeToFitWidth=YES;
                cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共0晚",_inhoteldate,_outhoteldate];
                cell.datelabel.adjustsFontSizeToFitWidth=YES;
                cell.datelabel.font=[UIFont systemFontOfSize:12];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                //cell.fromdata.text=[_trainDatadict[@"trainStartDate"] substringFromIndex:5];
                return cell;
                
            }else{
                trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                if (!cell) {
                    cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
                }
                cell.delegate=self;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.pricelabel.text=[NSString stringWithFormat:@"￥%@元", _seatDatadict[@"price"]];
                cell.pricelabel.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
                cell.freeprice.text=[NSString stringWithFormat:@"￥%@元",_freeprice];
                cell.freeprice.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
                NSString *str3 = [_trainDatadict[@"runTime"] stringByReplacingOccurrencesOfString:@":" withString:@"时"];
                cell.runtimelabel.text =[NSString stringWithFormat:@"%@分",str3];;
                cell.runtimelabel.textColor=UIColorFromRGBA(0x0075c2, 1.0);
                cell.trainNO.text=_trainDatadict[@"trainCode"];
                cell.trainNO.textColor=UIColorFromRGBA(0x0075c2, 1.0);
                cell.fromstation.text=_trainDatadict[@"fromStationName"];
                cell.fromdata.text=_trainDatadict[@"trainStartDate"];
                cell.fromtime.text=_trainDatadict[@"startTime"];
                cell.tostation.text=_trainDatadict[@"toStationName"];
                cell.totime.text=_trainDatadict[@"arriveTime"];
                cell.fromdata.text=[_trainDatadict[@"trainStartDate"] substringFromIndex:5];
                if(![_trainDatadict[@"arriveDays"] isEqualToString:@"0"]){
                    int d= [_trainDatadict[@"arriveDays"] intValue];
                    NSDateFormatter *dateFormatter1= [[NSDateFormatter alloc] init];
                    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
                    NSDate*hDate;
                    NSDate * hde;
                    NSString*result1;
                    //由 NSString转换为 NSDate
                    hDate = [dateFormatter1 dateFromString:_trainDatadict[@"trainStartDate"]];
                    hde=[NSDate dateWithTimeInterval:d*24*60*60 sinceDate:hDate];
                    //   NSLog(@"%@",hde);
                    //由 NSDate转换为 NSString
                    result1 = [dateFormatter1 stringFromDate:hde];
                    cell.todate.text=[result1 substringFromIndex:5];
                }else{
                    cell.todate.text=[_trainDatadict[@"trainStartDate"] substringFromIndex:5];
                }
                return cell;
            }
        }else{
            
            PayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
            if (!cell) {
                cell= (PayCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PayCell" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.button1.userInteractionEnabled=NO;
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
                    cell.paylabel.text=@"协议欠款";
                    if (_advancepayarray.count==0) {
                      cell.hidden=YES;
                    }
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
    }else if ([tableView isEqual:_tableView2]){
        TJTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            cell = [[TJTCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            //cell= (hotelCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"hotelCell" owner:self options:nil]  lastObject];
        }
        cell.backgroundColor=[UIColor blackColor];
        [cell setCellWithModel:_StopOverarr[indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if ([tableView isEqual:_FpricetableView]){
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
                    cell= (PMCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PMCell" owner:self options:nil]  lastObject];
                }
                if(indexPath.row==2){
                    cell.titlelab.text=@"燃油费";
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[0][@"airConstructionFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)_menArray.count];
                }else if (indexPath.row==3){
                    cell.titlelab.text=@"航意险";
                    if(_a==2){
                        cell.price.text=@"￥0.0";
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%d.0",_c];
                    }
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份",_b];
                }else if(indexPath.row==4){
                    cell.titlelab.text=@"服务费";
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[0][@"serviceFee"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)_menArray.count];
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[0][@"price"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)_menArray.count];
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
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[1][@"airConstructionFee"]];
                }else if (indexPath.row==3){
                    cell.titlelab.text=@"航意险";
                    if(_a==2){
                        cell.price.text=@"￥0.0";
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%d.0",_c];
                    }
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%d份",_b];
                }else if(indexPath.row==4){
                    cell.titlelab.text=@"服务费";
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[1][@"serviceFee"]];
                    
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%ld人", _menArray.count];
                    
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%@.0",_FdataArray1[1][@"price"]];
                    cell.Numlabel.text=[NSString stringWithFormat:@"×%ld人", _menArray.count];
                    
                }
                return cell;
            }
        }
    }else{
        return nil;
    }
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
if (indexPath.section==1) {
    //获取cell的方法
    PayCell *cell = [tableView cellForRowAtIndexPath:indexPath]
    ;
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    if (_price!=nil) {
        //STEP 1
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
                [UIAlertView showAlertWithTitle:@"支付宝支付方式，正在开发中，请采用其它支付方式"];
            }
            NSMutableArray * arr=[NSMutableArray array];
            Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
            orderinfo.OrderNo=_orderstring;
            if([_BusinessType isEqualToString:@"1"]){
                orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_price] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            }else if ([_BusinessType isEqualToString:@"2"]){
                orderinfo.PayAmount= [[NSString stringWithFormat:@"%@",_Tprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            }else{
                orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_Hprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
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
                        //                    NSLog(@"%@",_price);
                        if (_price.length!=0) {
                            vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                            vc.type=@"1";
                        }else if (_Hprice.length!=0) {
                            vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                            vc.type=@"2";
                        }else{
                            vc.type=@"3";
                            vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                        }
                        [self.navigationController pushViewController:vc animated:YES];
                    }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                        if (![data[@"msg"]isEqualToString:@""]) {
                            NSString *jsonString=data[@"msg"];
                            NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                            NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
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
                //paySucceedVC* vc =[paySucceedVC new];
                // [self presentViewController:vc animated:YES completion:nil];
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
            }];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }else if(_Tprice!=nil){
        
        NSLog(@"%@",_Tprice);

        if ([cell.paylabel.text isEqualToString:@"微信支付"]||[cell.paylabel.text isEqualToString:@"支付宝支付"]) {
            [UIAlertView showAlertWithTitle:@"该支付方式正在开发中,请采用其它支付方式"];
        }else{
            //STEP 1
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
//                        pay.SubCode=_thirdPayarray[0][@"paySubject"];
//                        pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
//                        pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
//                        pay.OpenId=@"";
//                        pay.PayType=@"2";
                }else if ([cell.paylabel.text isEqualToString:@"银联支付"]){
                        pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
                        pay.SubCode=_thirdPayarray[0][@"paySubject"];
                        pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
                        pay.OpenId=@"";
                        pay.PayType=@"2";
                }else{
                    [UIAlertView showAlertWithTitle:@"支付宝支付方式，正在开发中，请采用其它支付方式"];
                }
                NSMutableArray * arr=[NSMutableArray array];
                Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
                orderinfo.OrderNo=_orderstring;
                if([_BusinessType isEqualToString:@"1"]){
                    orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_price] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                }else if ([_BusinessType isEqualToString:@"2"]){
                    NSLog(@"%@",_Tprice);
                orderinfo.PayAmount= [[NSString stringWithFormat:@"%@",_Tprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                    
                }else{
                    orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_Hprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
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
                            //                    NSLog(@"%@",_price);
                            if (_price.length!=0) {
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                                vc.type=@"1";
                            }else if (_Hprice.length!=0) {
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                                vc.type=@"3";
                            }else{
                                vc.type=@"2";
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                            if (![data[@"msg"]isEqualToString:@""]) {
                                NSString *jsonString=data[@"msg"];
                                NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
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
    }else{
        if ([cell.paylabel.text isEqualToString:@"支付宝支付"] || [cell.paylabel.text isEqualToString:@"银联支付"]) {
            [UIAlertView showAlertWithTitle:@"该支付方式尚未开通，请使用其它支付方式"];
        }else{
            //STEP 1
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
//                    pay.PayDockCode=_thirdPayarray[0][@"paySubjectCode"];
//                    pay.SubCode=_thirdPayarray[0][@"paySubject"];
//                    pay.PayMethod=_thirdPayarray[0][@"paySubjectName"];
//                    pay.OpenId=@"";
//                    pay.PayType=@"2";
                    
                }else{
//                    [UIAlertView showAlertWithTitle:@"支付宝支付方式，正在开发中，请采用其它支付方式"];
                }
                NSMutableArray * arr=[NSMutableArray array];
                Pay_orderInfosmodel * orderinfo =[Pay_orderInfosmodel new];
                orderinfo.OrderNo=_orderstring;
                if([_BusinessType isEqualToString:@"1"]){
                    orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_price] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                }else if ([_BusinessType isEqualToString:@"2"]){
                    orderinfo.PayAmount= [[NSString stringWithFormat:@"%@",_Tprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                }else{
                    orderinfo.PayAmount=[[NSString stringWithFormat:@"%@",_Hprice] stringByReplacingOccurrencesOfString:@"￥" withString:@""];
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
                            //                    NSLog(@"%@",_price);
                            if (_price.length!=0) {
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                                vc.type=@"1";
                            }else if (_Hprice.length!=0) {
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                                vc.type=@"3";
                            }else{
                                vc.type=@"2";
                                vc.orderprice=[NSString stringWithFormat:@"%@",data[@"amount"]];
                            }
                            [self.navigationController pushViewController:vc animated:YES];
                        }else if ([cell.paylabel.text isEqualToString:@"微信支付"]){
                            if (![data[@"msg"]isEqualToString:@""]) {
                                NSString *jsonString=data[@"msg"];
                                NSString *jsonString1= [jsonString stringByReplacingOccurrencesOfString:@"\\" withString:@""];
                                NSData *jsonData = [jsonString1 dataUsingEncoding:NSUTF8StringEncoding];
                                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
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
#pragma mark - 微信支付后执行的方法
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
        //[MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"success"}];
                NSLog(@"%@",strMsg);
                break;
            }
            case WXErrCodeUserCancel:{
                strMsg = @"已取消支付!";
                //                [MYNotificationCenter postNotificationName:@"weixinPaystatusSuccess" object:nil userInfo:@{@"status":@"cancle"}];
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
#pragma mark -价格详情点击手势
-(void)Showpricetab:(UIButton*)send{
    [UIView animateWithDuration:0.01 animations:^{
        if([_BusinessType isEqualToString:@"2"])
        {
            _Bottomconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
            view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
        }else if ([_BusinessType isEqualToString:@"1"]){
            [UIView animateWithDuration:0.01 animations:^{
                _Bottomconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-150);
                if(_FdataArray1.count==1){
                    _FpricetableView.frame=CGRectMake(0, deviceScreenHeight-150,deviceScreenWidth , 150);
                }else{
                    _FpricetableView.frame=CGRectMake(0, deviceScreenHeight-300,deviceScreenWidth , 300);
                }
            }completion:nil];
        }else{
            _hconnetview1.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
            hview4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
        }
    }completion:nil];
}

#pragma mark - 点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    [UIView animateWithDuration:0.01 animations:^{
        _Bottomconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        view4.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60);
        
        _hconnetview1.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        hview4.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60);
        
        _FpricetableView.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 150);
    }completion:nil];
}

#pragma mark - 火车票经停按钮
-(void)jtbutton:(trainorder0 *)cell{
    
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
#pragma mark - 火车票经停视图点击手势
-(void)showGFtraintab:(UITapGestureRecognizer*)traintab{
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}

@end
