//
//  TraincheckVC.m
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TraincheckVC.h"
#import "checkCell.h"
#import "trainorder0.h"
#import "TrainorderList.h"
#import "TcheckViewone.h"
#import "TcheckViewtwo.h"
#import "voModel.h"
#import "Tjtmodel.h"
#import "TJTCell.h"
@interface TraincheckVC ()<UITableViewDelegate,UITableViewDataSource,trainorder0Delegate>
{
    //订单状态
    UILabel * paylabel;
    
    UITableView * _tableView;
    //蒙版视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableDictionary * dict;
    NSMutableDictionary * Messagedict;
    NSMutableArray * mendata;

    NSMutableArray * trainbox;

    
    UIButton * nextbut;
    UIButton * pricebut;
    NSString * _orderstring;    
    UILabel * salePrice;
    UILabel * airconFee;
  

    BOOL isa;
    
    
    //服务价格
    int a;
    //票价
    int b;
    
    UILabel * pricela;
    UIImageView* plaimage;
    NSMutableArray * numarray;
    //价格详情
    UIView * view4;
    UILabel * mennum;
    UIView * _connetview1;
    UILabel * free;
    UILabel * tprice;
    
    
    
    
    //经停蒙版视图
    UIView * _JTconnetview;
    UITableView * _tableView2;
    
    //退改签蒙版视图
    UIView * _tgconnetview;
    UILabel * tglabel1;
    
    NSString * seatname;
    NSString * seatprice;
    NSString * seatprice1;

}
@property (nonatomic, strong) TcheckViewone*ViewOne;  //实例化一个VView的对象
@property (nonatomic, strong) TcheckViewtwo*ViewTwo;  //实例化一个VView的对象

@end

@implementation TraincheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self loadData];
    [self creattable];
    [self Tabview];
}
#pragma mark -初始化
-(void)initview{
    dict  =[NSMutableDictionary new];
    Messagedict  =[NSMutableDictionary new];

    _orderstring=_bookTicketList;
    trainbox=[NSMutableArray new];
    
     //NSLog(@"%@",_trainDatadict);
   // NSLog(@"%@",_seatDatadict);
    // orderlabel=[UILabel new];
    //_dataArray=[NSMutableArray array];
    //    NSLog(@"%@",_dataArray);
        NSLog(@"%@",_menarr);
    //    NSLog(@"%@",_ContactName);
    //    NSLog(@"%@",_ContactMobile);
    isa=YES;
}
#pragma mark -自定义导航栏
-(void)Tabview{
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    label.text=@"核对订单";
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
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 2,deviceScreenWidth-40, 48)];
    label1.text=@"请仔细核对订单详情，以免耽误行程。";
    //文本居中
    label1.textAlignment =UITextAlignmentCenter;
    label1.font=[UIFont systemFontOfSize:14];
    label1.textColor=[UIColor blackColor];
    [dataview addSubview:label1];
    UIView * view3= [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
    view3.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];

//    pricebut=[[UIButton alloc]initWithFrame:CGRectMake(20,8,120, 44)];
//    pricebut.titleLabel.adjustsFontSizeToFitWidth = YES;
//    [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%@元",_dataArray[0][@"price"]] forState:UIControlStateNormal];
//    pricebut.backgroundColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
//    [pricebut.layer setMasksToBounds:YES ];
//    [pricebut.layer setCornerRadius:10.0];
//    [view3 addSubview:pricebut];
    
    UIView * view31=[[UIView alloc]initWithFrame:CGRectMake(20,8,140, 44)];
    view31.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:CGRectMake(0,22/SCREEN_RATE1,40, 16)];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
    pricela =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(33,8,90, 40)]];
    pricela.textAlignment=NSTextAlignmentLeft;
    pricela.font=[UIFont systemFontOfSize:18];
    
    if(_menarr.count!=0){
        NSString *s = [NSString stringWithFormat:@"￥%.2f",([_pricestr floatValue]+[_freeprice floatValue])*(long)_menarr.count];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }else{
        NSString *s = [NSString stringWithFormat:@"￥%.2f",[_pricestr floatValue]+b];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }
    pricela.textColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [view31 addSubview:pricela];
    UILabel * pla =[[UILabel alloc]init];
    pla.text=@"元";
    pla.font= [UIFont systemFontOfSize:14];
    pla.textColor=[UIColor whiteColor];
    [view31 addSubview:pla];
    [pla mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pricela.mas_right).offset(1);
        make.top.equalTo(view31).offset(22/SCREEN_RATE1);
        make.height.offset(16/SCREEN_RATE1);
        make.width.offset(16/SCREEN_RATE);
    }];
    plaimage =[[UIImageView alloc]init];
    plaimage.image=[UIImage imageNamed:@"show_money"];
    [view31 addSubview:plaimage];
    [plaimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pla.mas_right).offset(2);
        make.top.equalTo(view31).offset(25/SCREEN_RATE1);
        make.height.offset(10/SCREEN_RATE1);
        make.width.offset(11/SCREEN_RATE);
    }];
    [view3 addSubview:view31];
    UITapGestureRecognizer *tap5 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF5:)];
    [view31 addGestureRecognizer:tap5];
    
    nextbut =[[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-100,8,90, 44)];
    nextbut.backgroundColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
//    [nextbut setTitle:@"支付" forState:UIControlStateNormal];
    [nextbut.layer setMasksToBounds:YES ];
    [nextbut.layer setCornerRadius:10.0];
    nextbut.tag=888;
    nextbut.hidden=YES;
    [nextbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:nextbut];
    [self.view addSubview:view3];
    /* 票价详情*/
    view4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    tprice=[UILabel new];
    tprice.textAlignment=NSTextAlignmentCenter;
    tprice.font=[UIFont systemFontOfSize:14];
//    tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[_pricestr floatValue],_menarr.count];
    [view4 addSubview:tprice];
    [tprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    free=[UILabel new];
//    free.adjustsFontSizeToFitWidth=YES;
    free.font=[UIFont systemFontOfSize:14];
    free.textAlignment=NSTextAlignmentCenter;
//    free.text=[NSString stringWithFormat:@"服务费:￥%d元/人    人数%ld",[_freeprice intValue],_menarr.count];
    [view4 addSubview:free];
    [free mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
     /* **        ***        ****      ***     ** */
    
    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    
    //票价详情蒙版
    _connetview1=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview1.backgroundColor=[UIColor blackColor];
    _connetview1.alpha=0.7;
    [self.view  addSubview:_connetview1];

    _tableView1= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.alpha=1;
    _tableView1.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView1];
    
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
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab:)];
    [_tableView2 addGestureRecognizer:tab];
    _tableView2.separatorStyle = UITableViewCellSelectionStyleNone;
    [_JTconnetview addSubview:_tableView2];
    
    _tgconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _tgconnetview.backgroundColor=[UIColor blackColor];
    _tgconnetview.alpha=0.7;
    [self.view  addSubview:_tgconnetview];
    
    // UIView * taview1 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight-60)]];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight-60)]];
    tglabel1 = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 0, 335, 1000)]];
    //tglabel1.text=@"信息";
    tglabel1.font=[UIFont systemFontOfSize:13];
    //tglabel1.adjustsFontSizeToFitWidth=YES;
    tglabel1.textColor=[UIColor whiteColor];
    //自动折行设置
    tglabel1.lineBreakMode = UILineBreakModeWordWrap;
    tglabel1.numberOfLines = 0;
    scrollView.contentSize = CGSizeMake(355/SCREEN_RATE, 1000/SCREEN_RATE);;
    [scrollView addSubview:tglabel1];
    UITapGestureRecognizer *tab1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab1:)];
    [scrollView addGestureRecognizer:tab1];
    [_tgconnetview addSubview:scrollView];
    
}
-(void)showGF5:(UITapGestureRecognizer*)tap5{
    [UIView animateWithDuration:0.1 animations:^{
        _connetview1.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
        view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
    }completion:nil];
}
-(void)loadData{
    
    TGQApproveQuery * tgq = [TGQApproveQuery new ];
    tgq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tgq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    
    [Train TGQApproveQuery:tgq success:^(id data) {
        //   NSLog(@"%@",data);
        tglabel1.text=data[@"data"];
        
    } failure:^(NSError *error) {
    }];
    
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    TrainOrderInfQuery * inf = [TrainOrderInfQuery new];
    inf.OrderNo=_orderstring;
    inf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    inf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    
        [Train TrainOrderInfQuery:inf success:^(id data) {
            [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            trainbox=data[@"trainBoxList"];
            Messagedict=data[@"trainTicket"];

            tprice.text=[NSString stringWithFormat:@"票价:  ￥%.2f元/人     人数%ld",[_pricestr floatValue],_menarr.count];
            free.text=[NSString stringWithFormat:@"服务费:  ￥%.2f元/人    人数%ld",[Messagedict[@"fee"]  floatValue]/_menarr.count,_menarr.count];

            if(_menarr.count!=0){
                
                _price=[NSString stringWithFormat:@"￥%.2f",([_pricestr floatValue]+[Messagedict[@"fee"] floatValue]/_menarr.count)*(long)_menarr.count];
                
                NSString *s = [NSString stringWithFormat:@"￥%.2f",([_pricestr floatValue]+[Messagedict[@"fee"] floatValue]/_menarr.count)*(long)_menarr.count];
                UIFont *font = [UIFont fontWithName:@"Arial" size:20];
                CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
                pricela.text=s;
            }else{
                 _price=[NSString stringWithFormat:@"￥%.2f",([_pricestr floatValue]+[Messagedict[@"fee"] floatValue]/_menarr.count)*(long)_menarr.count];
                NSString *s = [NSString stringWithFormat:@"￥%.2f",[_pricestr floatValue]+b];
                UIFont *font = [UIFont fontWithName:@"Arial" size:20];
                CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
                pricela.text=s;
            }
            
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TpubAndpri"] isEqualToString:@"2"]) {
                nextbut.hidden=NO;
                [nextbut setTitle:@"支付" forState:UIControlStateNormal];
            }else{
                if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
                    nextbut.hidden=NO;
                    [nextbut setTitle:@"送审" forState:UIControlStateNormal];
                }else{
                    nextbut.hidden=NO;
                    [nextbut setTitle:@"支付" forState:UIControlStateNormal];
                }
            }
                   }
            [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)backAndnext:(UIButton*)send{

    if(send.tag==666){
        [AlertViewManager alertWithTitle:@"温馨提示"
                                 message:@"您的订单已生成，是否确定退出？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                     if (index==1) {
                                         [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
                                     }
                                 }];
    }else{
           [self loadData];
        if ([Messagedict[@"approveStatusName"] isEqualToString:@"已取消"]){
            NSString *title = @"温馨提示";
            NSString *okButtonTitle = @"确定";
            NSString *message=@"订单已被取消，请到重新预订";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                FirstViewController * vc =[FirstViewController new ];
                vc.tabBarController.tabBar.hidden=NO;
                [self.navigationController pushViewController:vc animated:NO];
            }]];
           
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
        if([nextbut.titleLabel.text isEqualToString:@"送审"]){
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            ApproveApplyRequest * approve =[ApproveApplyRequest new];
            approve.OrderNo=_orderstring;
            approve.OrderType=@"HCP";
            approve.approveWay=@"ALL";
            approve.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
            approve.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
            [Approval ApproveApply:approve success:^(id data) {
                [SVProgressHUD dismiss];
                if([data[@"status"] isEqualToString:@"T"]){
                    NSString *title = @"送审提示";
                    NSString *okButtonTitle = @"我知道了";
                    NSString *message=@"订单已提交送审，请到订单管理查看最新动态";
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                        TrainorderList * tvc =[TrainorderList new];
                        tvc.back=1;
                        tvc.hidesBottomBarWhenPushed=YES;
                        [self.navigationController pushViewController:tvc animated:NO] ;
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                // NSLog(@"%@",data);
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
            }];
        }else{
            PayVC * pay  = [PayVC new];
           // pay.dataArray=_dataArray;
            pay.BusinessType=@"2";
            pay.trainDatadict=_trainDatadict;
            pay.seatDatadict=_seatDatadict;
            pay.freeprice=_freeprice;
            pay.orderstring=_orderstring;
            pay.Tprice=_price;
            pay.mestprice=tprice.text;
            pay.mesfreeprice= free.text;
            pay.StopOverarr=_StopOverarr;
        [self.navigationController pushViewController:pay animated:YES];
//            [self presentViewController:pay animated:YES completion:nil];
        }
        }
    }
}
#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-180) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    //判断因公因私
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
        _ViewOne = [[TcheckViewone alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewOne initView];
        _ViewOne.priject.text=_project;
        _ViewOne.concent.text=_cencer;
        _ViewOne.violateItem.text=_Voitm;
        _ViewOne.violateReason.text=_Voreson;
        
        _ViewTwo = [[TcheckViewtwo alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewTwo initView];
        _ViewTwo.priject.text=_project;
        _ViewTwo.concent.text=_cencer;
        //判断是否开启差旅标准
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]) {
            if ([_Voitm isEqualToString:@""]) {
                _tableView.tableFooterView=_ViewTwo;
            }else{
                _tableView.tableFooterView=_ViewOne;
            }
        }else{
            _tableView.tableFooterView=_ViewTwo;
        }
    }
    [self.view addSubview:_tableView];

}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{   if([tableView isEqual:_tableView]){
            return 40;
    }else if ([tableView isEqual:_tableView1]){
        return 1;
    }else{
        return 30/SCREEN_RATE1;
    }
}
//设置组的尾视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if(section==0){
            return 10;
        }else{
            return 10;
        }
    }else if ([tableView isEqual:_tableView1]){
        return 0;
    }else{
        return 0.01;
    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    if([tableView isEqual:_tableView]){
    if(section==0){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
            menimage.image=[UIImage imageNamed:@"order_number"];
            [view addSubview:menimage];
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 200, 16)];
            menlabel.text=[NSString stringWithFormat:@"订单号:%@",_orderstring];
            menlabel.font = [UIFont systemFontOfSize:14];
            menlabel.textColor=[UIColor blackColor];
            [view addSubview:menlabel];
            paylabel = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-80, 5, 100,20)];
            paylabel.font=[UIFont systemFontOfSize:14];
        if (![Messagedict[@"approveStatusName"] isEqualToString:@"已取消"]) {
            if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
                paylabel.text=@"未审批";
            }else{
                paylabel.text=@"未支付";
            }
        }else{
            paylabel.text=@"已取消";
            paylabel.textColor=[UIColor redColor];
        }
            paylabel.textColor=[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1];
            [view addSubview:paylabel];
            view.backgroundColor=[UIColor whiteColor];
            return view;
        }else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, deviceScreenWidth, 40)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 100, 20)];
        menlabel.text=@"乘车人";
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        UILabel * menlabel1 =[[ UILabel alloc]initWithFrame:CGRectMake(140, 10, 150, 16)];
        menlabel1.text=[NSString stringWithFormat:@"成人%ld人",_menarr.count];
        menlabel1.textColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        menlabel1.font = [UIFont systemFontOfSize:12];
        menlabel1.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        [view addSubview:menlabel1];
        return view;
        }else{
        return 0;
        }
    }else if ([tableView isEqual:_tableView1]){
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
//设置组的尾部视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if([tableView isEqual:_tableView]){
        if(section==0){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 10)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            return view;
        }else
            return nil;
    }else if ([tableView isEqual:_tableView1]){
        return nil;
    }else{
        return nil;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
            return 144;
        }else{
            return  60;
        }
    }else if ([tableView isEqual:_tableView1]){
        if(indexPath.section==0){
            return 144;
        }else{
            return  0;
        }
    }else{
        return 30/SCREEN_RATE1;
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return 2;
    }else if ([tableView isEqual:_tableView1]){
        return 1;
    }else{
        return 1;
    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if(section==0){
            return 1;
        }else{
            return _menarr.count;
        }
    }else if ([tableView isEqual:_tableView1]){
        
        if(section==0){
            return 1;
        }
        else{
            return 0;
        }
    }else{
        return _StopOverarr.count;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
            trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate=self;
            cell.pricelabel.text=[NSString stringWithFormat:@"￥%.2f元", [_pricestr floatValue]];
            cell.pricelabel.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
            cell.freeprice.text=[NSString stringWithFormat:@"￥%@元",Messagedict[@"fee"]];
            cell.freeprice.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
            cell.Pricetitle.hidden=YES;
            cell.pricelabel.hidden=YES;
            cell.freetitle.hidden=YES;
            cell.freeprice.hidden=YES;

            [cell.jtbutton setTitleColor:UIColorFromRGBA(0x0075c2, 1.0) forState:UIControlStateNormal];
            cell.trainNO.text=_trainDatadict[@"trainCode"];
            cell.trainNO.textColor=UIColorFromRGBA(0x0075c2, 1.0);
            NSString *str3 = [_trainDatadict[@"runTime"] stringByReplacingOccurrencesOfString:@":" withString:@"时"];
            cell.runtimelabel.text =[NSString stringWithFormat:@"%@分",str3];;
            cell.runtimelabel.textColor=UIColorFromRGBA(0x0075c2, 1.0);
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
 
        }else {
            checkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (checkCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"checkCell" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.namelabel.text =_menarr[indexPath.row][@"empName"];
            NSString * str;
            if([_menarr[indexPath.row][@"certType"] isEqualToString:@"NI"]){
                str=@"身份证";
                cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,[secretNum IdCardtest:_menarr[indexPath.row][@"certNo"]]];
            }
            return cell;
        }
    }else if([tableView isEqual:_tableView1]){
        trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.pricelabel.text=[NSString stringWithFormat:@"￥%@元", _seatDatadict[@"price"]];
        cell.pricelabel.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
        cell.freeprice.text=[NSString stringWithFormat:@"￥%@元",Messagedict[@"fee"]];
        cell.freeprice.textColor=[UIColor colorWithRed:237/255.0 green:174/255.0 blue:58/255.0 alpha:1];
        
        cell.Pricetitle.hidden=YES;
        cell.pricelabel.hidden=YES;
        cell.freetitle.hidden=YES;
        cell.freeprice.hidden=YES;

        [cell.jtbutton setTitleColor:UIColorFromRGBA(0x0075c2, 1.0) forState:UIControlStateNormal];
        cell.trainNO.text=_trainDatadict[@"trainCode"];
        cell.trainNO.textColor=UIColorFromRGBA(0x0075c2, 1.0);
        NSString *str3 = [_trainDatadict[@"runTime"] stringByReplacingOccurrencesOfString:@":" withString:@"时"];
        cell.runtimelabel.text =[NSString stringWithFormat:@"%@分",str3];;
        cell.runtimelabel.textColor=UIColorFromRGBA(0x0075c2, 1.0);
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
    }else{
            TJTCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                cell = [[TJTCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                //cell= (hotelCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"hotelCell" owner:self options:nil]  lastObject];
            }
            cell.backgroundColor=[UIColor blackColor];
            [cell setCellWithModel:_StopOverarr[indexPath.row]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
    }
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //获取cell的方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
                [UIView animateWithDuration:0.01 animations:^{
                    _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-144);
                    _tableView1.frame=CGRectMake(0, deviceScreenHeight-144,deviceScreenWidth , 144);
                    [_tableView1 reloadData];
                }completion:nil];
        }
    }
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.02  animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 160);
    }completion:nil];
    
    [UIView animateWithDuration: 0.02  animations:^{
        _connetview1.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        view4.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 60);
    }completion:nil];
    
    
    [UIView animateWithDuration:0.02 animations:^{
        _tgconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}

-(void)tgbuttonClick:(trainorder0 *)cell{
    // NSLog(@"%@",tglabel1.text);
    [UIView animateWithDuration:0.02 animations:^{
        _tgconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)jtbutton:(trainorder0 *)cell{
    
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)showGFtab:(UITapGestureRecognizer *)tab{
    
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)showGFtab1:(UITapGestureRecognizer *)tab1{
    [UIView animateWithDuration:0.02 animations:^{
        _tgconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
