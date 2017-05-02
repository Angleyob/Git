//
//  CheckVC.m
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "CheckVC.h"
#import "checkCell.h"
#import "check1Cell.h"
#import "MJExtension.h"
#import "AppDelegate.h"
#import "priceMesCellTableViewCell.h"
#import "PMCell.h"
#import "FlightorderList.h"
#import "OrderViewController.h"

#import "fcheckview1.h"
#import "fcheckview2.h"
#import "fcheckview3.h"
#import "Fcheckview4.h"


@interface CheckVC ()<UITableViewDelegate,UITableViewDataSource,UIApplicationDelegate>
{
    //订单状态
    UILabel * paylabel;
    UILabel * paylabel1;

    
    
    UIView * view31;
    //价格详情
    UITableView * _tableView2;
    UIView* _Bottomconnetview;
//    //保险类型1：强制，2：赠送 3：默认（可选）
//    int a;
//    //保险份数
//    int b;
//    //保险单份价格
//    int c;
//    //保险总价 d=c*b*人数
//    int d;
    UILabel * pricela;
    UIImageView* plaimage;
    NSMutableArray * numarray;
    
    
    
    //退改详情
    UIView * _connetview1;
    UILabel*connetviewlabel;
    UILabel*connetviewlabel1;
    UILabel*connetviewlabel2;
    UILabel*connetviewlabel3;

    UITableView * _tableView;
    
    //蒙版视图
    UIView * _connetview;
    UITableView * _tableView1;

    NSMutableDictionary * dict;
    NSMutableDictionary * Messagedict;
    NSMutableDictionary * Messagedict1;
    NSMutableArray * mendata;
    UIButton * nextbut;
    UIButton * pricebut;
    NSString * _orderstring;
    NSString * priceback;
    NSString * priceout;


    UILabel * salePrice;
    UILabel * airconFee;
    BOOL isa;
    
    NSString * secVoitm;
    NSString * secVoreson;
   
    
}

@property (nonatomic, strong) Fcheckview1*ViewOne;  //实例化一个VView的对象
@property (nonatomic, strong) Fcheckview2*ViewTwo;  //实例化一个VView的对象
@property (nonatomic, strong) fcheckview3*ViewThree;  //实例化一个VView的对象
@property (nonatomic, strong) Fcheckview4*ViewFour;  //实例化一个VView的对象


@end
@implementation CheckVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initview];
    [self inf];
//    if (_bookTicketList.count==2) {
//        [self inf1];
//    }
    [self creattable];
    [self Tabview];

}
#pragma mark -初始化
-(void)initview{
     dict  =[NSMutableDictionary new];
    _orderstring=_bookTicketList[0][@"orderNo"];
    // orderlabel=[UILabel new];
    //_dataArray=[NSMutableArray array];
    //    NSLog(@"%@",_dataArray);
    //    NSLog(@"%@",_menarr);
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
    
    view31=[[UIView alloc]initWithFrame:CGRectMake(20,8,140, 44)];
    
    view31.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:CGRectMake(0,22,40, 16)];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
    pricela =[[UILabel alloc]initWithFrame:CGRectMake(33,8,90, 40)];
    pricela.adjustsFontSizeToFitWidth=YES;
    if(_a!=2){
        _d=_c*_b*(int)(_menarr.count);
    }else{
        _d=0;
    }
//    NSLog(@"%@",_dataArray1);
    if(_dataArray1.count==2){
        pricela.text=[NSString stringWithFormat:@"￥%d",[_dataArray1[0][@"price"] intValue]+[_dataArray1[1][@"price"] intValue]+_d*2];
    }else{
       pricela.text=[NSString stringWithFormat:@"￥%d",[_dataArray1[0][@"price"] intValue]+_d];
    }
    pricela.textColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [view31 addSubview:pricela];
    UILabel * pla =[[UILabel alloc]initWithFrame:CGRectMake(95,22,14,16)];
    pla.text=@"元";
    pla.font= [UIFont systemFontOfSize:14];
    pla.textColor=[UIColor whiteColor];
    [view31 addSubview:pla];
    plaimage =[[UIImageView alloc]initWithFrame:CGRectMake(111,25,13,11)];
    plaimage.image=[UIImage imageNamed:@"show_money"];
    [view31 addSubview:plaimage];
    [view3 addSubview:view31];
    
    UITapGestureRecognizer *tap10 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF10:)];
    [view31 addGestureRecognizer:tap10];
    
//     pricebut=[[UIButton alloc]initWithFrame:CGRectMake(20,8,120, 44)];
//    pricebut.titleLabel.adjustsFontSizeToFitWidth = YES;
//     [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%@元",_dataArray[0][@"price"]] forState:UIControlStateNormal];
//    pricebut.backgroundColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
//    [pricebut.layer setMasksToBounds:YES ];
//    [pricebut.layer setCornerRadius:10.0];
//    [view3 addSubview:pricebut];
    
    
    nextbut =[[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-100,8,90, 44)];
    nextbut.backgroundColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [nextbut setTitle:@"支付" forState:UIControlStateNormal];
    [nextbut.layer setMasksToBounds:YES ];
    [nextbut.layer setCornerRadius:10.0];
    nextbut.tag=888;
    [nextbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    [view3 addSubview:nextbut];
    [self.view addSubview:view3];
    
    _connetview1=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview1.backgroundColor=[UIColor blackColor];
    _connetview1.alpha=0.7;
    [self.view  addSubview:_connetview1];
    connetviewlabel=[UILabel new];
    connetviewlabel.text=@"退改签规则";
    connetviewlabel.textColor=[UIColor whiteColor];
    [_connetview1 addSubview:connetviewlabel];
    [connetviewlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview1).offset(deviceScreenWidth/2-40);
        make.top.equalTo(_connetview1).offset(100);
        make.height.offset(40);
        make.width.offset(100);
    }];
    connetviewlabel1=[UILabel new];
    connetviewlabel1.text=@"退票说明：";
    connetviewlabel1.adjustsFontSizeToFitWidth = YES;
    connetviewlabel1.textColor=[UIColor whiteColor];
    [_connetview1 addSubview:connetviewlabel1];
    [connetviewlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview1).offset(40);
        make.top.equalTo(_connetview1).offset(130);
        make.height.offset(80);
        make.right.equalTo(_connetview1).offset(-40);
    }];
    
    connetviewlabel2=[UILabel new];
    connetviewlabel2.adjustsFontSizeToFitWidth = YES;
    connetviewlabel2.text=@"变更说明：";
    connetviewlabel2.textColor=[UIColor whiteColor];
    [_connetview1 addSubview:connetviewlabel2];
    [connetviewlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview1).offset(40);
        make.top.equalTo(_connetview1).offset(220);
        make.right.equalTo(_connetview1).offset(-40);
        make.height.offset(80);
    }];
    
    connetviewlabel3=[UILabel new];
    connetviewlabel3.text=@"温馨提示：仅供参考，最终以航司规定为准！";
    connetviewlabel3.adjustsFontSizeToFitWidth = YES;
    connetviewlabel3.textColor=[UIColor whiteColor];
    [_connetview1 addSubview:connetviewlabel3];
    [connetviewlabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_connetview1).offset(40);
        make.top.equalTo(_connetview1).offset(300);
        make.height.offset(40);
        make.right.equalTo(_connetview1).offset(-40);
    }];


    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    _Bottomconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _Bottomconnetview.backgroundColor=[UIColor blackColor];
    _Bottomconnetview.alpha=0.7;
    [self.view  addSubview:_Bottomconnetview];
    _tableView1= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.alpha=1;
    _tableView1.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView1];
       _tableView2= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 150) style:UITableViewStyleGrouped];
    _tableView2.dataSource=self;
    _tableView2.delegate=self;
    _tableView2.alpha=1;
    _tableView2.userInteractionEnabled = NO;
    _tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView2.backgroundColor=[UIColor grayColor];
    [self.view addSubview:_tableView2];
    }
-(void)loadData{
}
-(void)inf1{
    Messagedict1=[NSMutableDictionary new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
    infquery.OrderNo=_bookTicketList[1][@"orderNo"];
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight FlightOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        Messagedict1=data;
        
        if([Messagedict1[@"approveStatusName"] isEqualToString:@"未审批"]){
            [nextbut setTitle:@"送审" forState:UIControlStateNormal];
        }else{
            [nextbut setTitle:@"下一步" forState:UIControlStateNormal];
        }
        //                NSLog(@"%@",priceout);

        //        priceback=Messagedict1[@"ticketPrice"];
        pricela.text=[NSString stringWithFormat:@"￥%.0f",([Messagedict[@"ticketPrice"] floatValue]+[Messagedict1[@"ticketPrice"] floatValue])];
        
//         [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%.1f元",([Messagedict[@"ticketPrice"] floatValue]+[Messagedict1[@"ticketPrice"] floatValue])]forState:UIControlStateNormal];
        
//        [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%.1f元",([priceback floatValue]+ [priceout floatValue]+[_dataArray1[0][@"airConstructionFee"] floatValue]+[_dataArray1[0][@"serviceFee"] floatValue])*_menarr.count+_menarr.count*_c]forState:UIControlStateNormal];
//        NSLog(@"%f*****%f",[Messagedict[@"ticketPrice"] floatValue],[Messagedict1[@"ticketPrice"] floatValue]);
//        salePrice.text=[NSString stringWithFormat:@"￥%.1lf",([  Messagedict[@"passengerInfoList"][0][@"salePrice"] floatValue]+[  Messagedict1[@"passengerInfoList"][0][@"salePrice"] floatValue])];
        [_tableView reloadData];
        [_tableView1 reloadData];
        [_tableView2 reloadData];
        NSLog(@"%@",Messagedict1);
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)inf{
    mendata=[NSMutableArray new];
    Messagedict=[NSMutableDictionary new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    FlightOrderInfQuery *  infquery  = [FlightOrderInfQuery new];
    infquery.OrderNo=_bookTicketList[0][@"orderNo"];
    infquery.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    infquery.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Flight FlightOrderInfQuery:infquery success:^(id data) {
        [SVProgressHUD dismiss];
        Messagedict=data;
        NSLog(@"%@",Messagedict);
        
        mendata=Messagedict[@"passengerInfoList"];
        
        if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
            [nextbut setTitle:@"送审" forState:UIControlStateNormal];
        }
//        priceout=Messagedict[@"ticketPrice"];
//        [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%.1f元", [priceout floatValue]*_menarr.count+[_dataArray1[0][@"airConstructionFee"] floatValue]*_menarr.count+[_dataArray1[0][@"serviceFee"] floatValue]*_menarr.count+_menarr.count*_c]forState:UIControlStateNormal];
              pricela.text=[NSString stringWithFormat:@"￥%.0f",([Messagedict[@"ticketPrice"] floatValue])];
//    [pricebut setTitle:[NSString stringWithFormat:@"总价:￥%.1f元",[Messagedict[@"ticketPrice"] floatValue] ]forState:UIControlStateNormal];
//    salePrice.text=[NSString stringWithFormat:@"￥%.1lf",[Messagedict[@"ticketPrice"] floatValue]];
        
        [_tableView reloadData];
        [_tableView1 reloadData];
        [_tableView2 reloadData];
      
        if (_bookTicketList.count==2) {
            [self inf1];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
}
-(void)backAndnext:(UIButton*)send{
    if(send.tag==666){
   
        [AlertViewManager alertWithTitle:@"温馨提示"
                                 message:@"订单已经下单成功，即将返回查询页面，是否确定返回？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                     if (index==1) {
                                          [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
                                     }
                                 }];
    }else{
        if([nextbut.titleLabel.text isEqualToString:@"送审"]){
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            if (_bookTicketList.count==2) {
                [self songshen:_bookTicketList[0][@"orderNo"]];
                [self songshen:_bookTicketList[1][@"orderNo"]];
            }else{
                [self songshen:_orderstring];
            }
        }else if([nextbut.titleLabel.text isEqualToString:@"下一步"]){

//            self.navigationController.tabBarController.selectedIndex = 1;
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            OrderViewController * ovc =[OrderViewController new ];
//            ovc.tabBarController.tabBar.hidden=NO;
//            ovc.navigationController.navigationBar.hidden=NO;
//            [self.navigationController pushViewController:ovc animated:NO];
            
            FlightorderList * fvc = [FlightorderList new];
            fvc.back=1;
            fvc.tabBarController.tabBar.hidden=YES;
            fvc.navigationController.navigationBar.hidden=YES;
            //                        fvc.hidesBottomBarWhenPushed=YES;
            //       fvc.navigationController.navigationBar.hidden=NO;
            [self.navigationController pushViewController:fvc animated:YES] ;
    }else{
         PayVC * pay  = [PayVC new];
            pay.dataArray=_dataArray;
            pay.BusinessType=@"1";
            pay.orderstring=_orderstring;
            pay.price=pricela.text;
            pay.FdataArray1=_dataArray1;
            pay.menArray=mendata;
            pay.a=_a;
            pay.b=_b;
            pay.c=_c;
            pay.d=_d;
            [self.navigationController pushViewController:pay animated:YES];
        }
    }
}
#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-180) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]) {
        _ViewOne = [[Fcheckview1 alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewOne initView];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]) {
            if (_Voitm.length==0) {
                _ViewOne.SecondviolateItem.text=_dataArray1[1][@"erromes"];
                _ViewOne.SecondviolateReason.text=_dataArray1[1][@"erroMessage"];
                _ViewOne.violateItem.text=_dataArray1[0][@"erromes"];
                _ViewOne.violateReason.text=_dataArray1[0][@"erroMessage"];
            }else{
                _ViewOne.violateItem.text=_Voitm;
                _ViewOne.violateReason.text=_Voreson;
            }
        }else{
            _ViewOne.violateItem.text=_Voitm;
            _ViewOne.violateReason.text=_Voreson;
        }
        
        _ViewOne.priject.text=_project;
        _ViewOne.concent.text=_cencer;
        
        _ViewTwo = [[Fcheckview2 alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewTwo initView];
        
        if (_Voitm.length!=0) {
            _ViewTwo.violateItem.text=_Voitm;
            _ViewTwo.violateReason.text=_Voreson;
        }else{
            _ViewTwo.violateItem.text=_dataArray1[0][@"erromes"];
            _ViewTwo.violateReason.text=_dataArray1[0][@"erroMessage"];
        }
        _ViewTwo.priject.text=_project;
        _ViewTwo.concent.text=_cencer;
        
        _ViewFour = [[Fcheckview4 alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewFour initView];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]) {
            if (_Voitm.length!=0) {
                _ViewFour.violateItem.text=_Voitm;
                _ViewFour.violateReason.text=_Voreson;
            }else{
                _ViewFour.violateItem.text=_dataArray1[1][@"erromes"];
                _ViewFour.violateReason.text=_dataArray1[1][@"erroMessage"];
            }
        }else{
            _ViewFour.violateItem.text=_Voitm;
            _ViewFour.violateReason.text=_Voreson;
        }
        _ViewFour.priject.text=_project;
        _ViewFour.concent.text=_cencer;
        
        _ViewThree = [[fcheckview3 alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth, 120)]];
        [_ViewThree initView];

        _ViewThree.priject.text=_project;
        _ViewThree.concent.text=_cencer;
        
    }
    //是否因公，因私
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]) {
        //判断是否开启差旅标准
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]) {
            //是否往返
            if(_dataArray1.count==2){
                if ((![[_dataArray1[0] allKeys] containsObject:@"erromes"])||(![[_dataArray1[1] allKeys] containsObject:@"erromes"])) {
                    if ((![[_dataArray1[0] allKeys] containsObject:@"erromes"])) {
                        _tableView.tableFooterView=_ViewFour;
                    }else{
                        _tableView.tableFooterView=_ViewTwo;
                    }
                }else{
                    _tableView.tableFooterView=_ViewOne;
                }
            }else{
                //是否合规
                if([[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"] isEqualToString:@"hg"]){
                    _tableView.tableFooterView=_ViewThree;
                }else{
                    _tableView.tableFooterView=_ViewTwo;
                }
            }
        }else{
            _tableView.tableFooterView=_ViewThree;
        }
    }
    [self.view addSubview:_tableView];
}
-(void) showGF10:(UITapGestureRecognizer *)tap10{
    view31.userInteractionEnabled=NO;
    _tableView.userInteractionEnabled=NO;
    nextbut.userInteractionEnabled=NO;
    [UIView animateWithDuration:0.01 animations:^{
        _Bottomconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-150);
        if(_dataArray1.count==1){
            _tableView2.frame=CGRectMake(0, deviceScreenHeight-150,deviceScreenWidth , 150);
        }else{
            if (_bookTicketList.count==1) {
                _tableView2.frame=CGRectMake(0, deviceScreenHeight-150,deviceScreenWidth , 150);
            }else{
                _tableView2.frame=CGRectMake(0, deviceScreenHeight-300,deviceScreenWidth , 300);
            }
        }
    }completion:nil];
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{   if([tableView isEqual:_tableView]){
        if(section==0){
            if(_bookTicketList.count==2){
                return 80;
            }else{
                return 40;
            }
        }else{
            return 40;
        }
   
    }else if ([tableView isEqual:_tableView1]){
        return 1;
    }
    else if([tableView isEqual:_tableView2]){
        return 1;
    }else{
        return 0;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if(section==0){
            return 60;
        }else{
            return 0;
        }
    }else if ([tableView isEqual:_tableView1]){
        return 0;
    }else if([tableView isEqual:_tableView2]){
        return 1;
    }else{
        return 0;
    }

}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    if([tableView isEqual:_tableView]){
    if(section==0){
        if(_bookTicketList.count==2){
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 80)];
            UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
            menimage.image=[UIImage imageNamed:@"order_number"];
            [view addSubview:menimage];
            UIImageView * menimage1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 30, 15, 15)];
            menimage1.image=[UIImage imageNamed:@"order_number"];
            [view addSubview:menimage1];
            UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 200, 16)];
            menlabel.text=[NSString stringWithFormat:@"(去)订单号:%@", _bookTicketList[0][@"orderNo"]];
            menlabel.font = [UIFont systemFontOfSize:14];
            menlabel.textColor=[UIColor blackColor];
            [view addSubview:menlabel];
            UILabel * menlabel1 =[[ UILabel alloc]initWithFrame:CGRectMake(35, 36, 200, 16)];
            menlabel1.text=[NSString stringWithFormat:@"(回)订单号:%@", _bookTicketList[1][@"orderNo"]];
            menlabel1.font = [UIFont systemFontOfSize:14];
            menlabel1.textColor=[UIColor blackColor];
            [view addSubview:menlabel1];
           paylabel = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-80, 5, 100,20)];
            paylabel.font=[UIFont systemFontOfSize:14];
            paylabel.text=@"未支付";
            paylabel.textColor=[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1];
            if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
                paylabel.text=@"未审批";
            }else{
                paylabel.text=@"未支付";
            }
            [view addSubview:paylabel];
            paylabel1 = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-80, 30, 100,20)];
            paylabel1.font=[UIFont systemFontOfSize:14];
            if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
                paylabel1.text=@"未审批";
            }else{
                paylabel1.text=@"未支付";
            }
            //paylabel1.text=@"未支付";
            paylabel1.textColor=[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1];
            [view addSubview:paylabel1];
            view.backgroundColor=[UIColor whiteColor];
            return view;
        }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 200, 16)];
        menlabel.text=[NSString stringWithFormat:@"订单号:%@",_orderstring];
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        paylabel = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-80, 5, 100,20)];
        paylabel.font=[UIFont systemFontOfSize:14];
            if([Messagedict[@"approveStatusName"] isEqualToString:@"未审批"]){
                paylabel.text=@"未审批";
            }else{
                paylabel.text=@"未支付";
            }
        //paylabel.text=@"未支付";
        paylabel.textColor=[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1];
        [view addSubview:paylabel];
            view.backgroundColor=[UIColor whiteColor];
            return view;
        }
    }
    else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, deviceScreenWidth, 40)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 100, 20)];
        menlabel.text=@"乘机人";
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
    }
    else if([tableView isEqual:_tableView2]){
        return nil;
    }else{
        return 0;
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
        UIButton * b1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
        b1.titleLabel.font=[UIFont systemFontOfSize:13];
        [b1 setTitle:@"退改签规则" forState:UIControlStateNormal];
         [b1 addTarget:self action:@selector(onClick111:) forControlEvents:UIControlEventTouchUpInside];
        [b1 setTitleColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
        [view1 addSubview:b1];
        
        
//        UILabel * price1 =[UILabel new];
//        price1.text=@"票价:";
//        price1.font=[UIFont systemFontOfSize:14];
//        [view addSubview:price1];
//        [price1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(deviceScreenWidth/2-20);
//            make.top.equalTo(view).offset(10);
//            make.height.offset(20);
//            make.width.offset(35);
//        }];
//        salePrice =[UILabel new];
//        salePrice.textColor= [UIColor orangeColor];
//        //salePrice.text=@"￥12345元";
//        salePrice.text=[NSString stringWithFormat:@"￥%.0lf",([  Messagedict[@"passengerInfoList"][0][@"salePrice"] floatValue]+[  Messagedict1[@"passengerInfoList"][0][@"salePrice"] floatValue])];
////        salePrice.text=[NSString stringWithFormat:@"￥%@",Messagedict[@"salePrice"]];
//        salePrice.font=[UIFont systemFontOfSize:14];
//        [view addSubview:salePrice];
//        [salePrice mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(deviceScreenWidth/2+15);
//            make.top.equalTo(view).offset(10);
//            make.height.offset(20);
//            make.width.offset(70);
//        }];
//        UILabel * price2 =[UILabel new];
//        price2.text=@"燃油费:";
//        price2.font=[UIFont systemFontOfSize:14];
//        [view addSubview:price2];
//        [price2 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(deviceScreenWidth/2+80);
//            make.top.equalTo(view).offset(10);
//            make.height.offset(20);
//            make.width.offset(35);
//        }];
//        
//        airconFee =[UILabel new];
//        //airconFee.text=@"￥1000元";
//         airconFee.text=[NSString stringWithFormat:@"￥%ld",[Messagedict[@"passengerInfoList"][0][@"airconFee"] intValue]*_menarr.count];
//        airconFee.textColor= [UIColor orangeColor];
//        airconFee.font=[UIFont systemFontOfSize:14];
//        [view addSubview:airconFee];
//        [airconFee mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(view).offset(deviceScreenWidth/2+115);
//            make.top.equalTo(view).offset(10);
//            make.height.offset(20);
//            make.width.offset(60);
//        }];
        return view;
    }else
        return nil;
        }else if ([tableView isEqual:_tableView1]){
            return nil;
        }else{
            return nil;
        }
}
-(void)onClick111:(UIButton *)button{
    //    NSLog(@"%@",_dataArray);
    [UIView animateWithDuration:0.01 animations:^{
        _connetview1.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    connetviewlabel1.text=[NSString stringWithFormat:@"去程：%@",_dataArray1[0][@"noteSimp"]];
    if(_dataArray.count==2){
        connetviewlabel2.text=[NSString stringWithFormat:@"返程：%@",_dataArray1[1][@"noteSimp"]];
    }else{
        connetviewlabel2.text=@"";
    }
    // connetviewlabel2.text=[NSString stringWithFormat:@"改签规定：起飞前2小时（含）%@",[_dataArray[0][@"noteSimp"] substringToIndex:3]];
}

//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
            return 160;
        }else{
            return  60;}
    }else if ([tableView isEqual:_tableView1]){
        if(indexPath.section==0){
            return 160;
        }else{
            return  0;}
    }else{
        return 30;
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
        if(_dataArray1.count==1){
            return 1;
        }else{
            return 2;
        }

    }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if(section==0){
            return _dataArray1.count;
        }else{
            return mendata.count;
        }
    }else if ([tableView isEqual:_tableView1]){
        
        if(section==0){
            return _dataArray1.count;
        }
        else{
            return 0;
        }
    }else{
            return 5;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
    if(indexPath.section==0){
        check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
        } 
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            cell.titleimage.image=[UIImage imageNamed:@"backward"];
        }
        cell.outdatalabel.text=_dataArray1[indexPath.row][@"outdate"];
        cell.outTime.text=[_dataArray1[indexPath.row][@"date"] substringToIndex:5];
        cell.arriveTime.text=[_dataArray1[indexPath.row][@"arrivalTime"] substringToIndex:5];
        cell.copany.adjustsFontSizeToFitWidth=YES;
        cell.copany.text=_dataArray1[indexPath.row][@"conpany"];
      
        cell.zdlabel.adjustsFontSizeToFitWidth=YES;
        cell.zdlabel.text=[NSString stringWithFormat:@"准点率:%.1f%%",  [_dataArray1[indexPath.row][@"punctualityRate"] floatValue]*100];
        
        if ([_dataArray1[indexPath.row][@"stopOver"] isEqualToString:@"0"]) {
            cell.bettenCity.hidden=YES;
        }else{
            cell.bettenCity.text=@"经停";
        }
        if(![_dataArray1[indexPath.row][@"meal"]isEqualToString:@""]){
            cell.meallabel.text=@"有餐食";
        }else{
            cell.meallabel.text=@"无";
        }
        
        
        cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_dataArray1[indexPath.row][@"flightMode"]];
        cell.arrviCity.text=_dataArray1[indexPath.row][@"arrivalCity"];
        cell.outCity.text=_dataArray1[indexPath.row][@"departCity"];
         NSString *str3 = [_dataArray1[indexPath.row][@"flyTime"]
                           stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
        cell.flyTime.text=[NSString stringWithFormat:@"%@分钟",str3];
        return cell;
    }else{
        checkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
        if (!cell) {
            cell= (checkCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"checkCell" owner:self options:nil]  lastObject];
        }
        NSString * str=@"";
        if([_menarr[indexPath.row][@"certType"] isEqualToString:@"NI"]){
            str=@"身份证";
            cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,[secretNum IdCardtest:mendata[indexPath.row][@"idNo"]]];
        }else if ([_menarr[indexPath.row][@"certType"] isEqualToString:@"ID"]){
            str=@"护照";
            cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,[secretNum otherCardtest:mendata[indexPath.row][@"idNo"]]];
        }else{
            str=@"其他";
            cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,mendata[indexPath.row][@"idNo"]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.namelabel.text =mendata[indexPath.row][@"passengerName"];
        return cell;
    }
    }else if ([tableView isEqual:_tableView1]){
        check1Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (check1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"check1Cell" owner:self options:nil]  lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            cell.titleimage.image=[UIImage imageNamed:@"backward"];
        }
        cell.outdatalabel.text=_dataArray1[indexPath.row][@"outdate"];
        cell.outTime.text=[_dataArray1[indexPath.row][@"date"] substringToIndex:5];
        cell.arriveTime.text=[_dataArray1[indexPath.row][@"arrivalTime"] substringToIndex:5];
        cell.copany.text=_dataArray1[indexPath.row][@"conpany"];
        cell.copany.adjustsFontSizeToFitWidth=YES;
        cell.bettenCity.text=_dataArray1[indexPath.row][@"stopOver"];
        
        cell.zdlabel.adjustsFontSizeToFitWidth=YES;
        cell.zdlabel.text=[NSString stringWithFormat:@"准点率:%.1f%%",  [_dataArray1[indexPath.row][@"punctualityRate"] floatValue]*100];
        
        if(![_dataArray1[indexPath.row][@"meal"]isEqualToString:@""]){
            cell.meallabel.text=@"有餐食";
        }else{
            cell.meallabel.text=@"无";
        }
        cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_dataArray1[indexPath.row][@"flightMode"]];
        cell.arrviCity.text=_dataArray1[indexPath.row][@"arrivalCity"];
        cell.outCity.text=_dataArray1[indexPath.row][@"departCity"];
        NSString *str3 = [_dataArray1[indexPath.row][@"flyTime"] stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
        cell.flyTime.text=[NSString stringWithFormat:@"%@分钟",str3];
        return cell;
    }else{
            if(indexPath.section==0){
                if(indexPath.row==0){
                    priceMesCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                    if (!cell) {
                        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                        cell= (priceMesCellTableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"priceMesCellTableViewCell" owner:self options:nil]  lastObject];
                    }
                    if (_bookTicketList.count==1) {
                        cell.qcimage.hidden=YES;
                        cell.qclabel.hidden=@"航程";
                    }
                    return cell;
                }else{
                    PMCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
                    if (!cell) {
                        //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                        cell= (PMCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PMCell" owner:self options:nil]  lastObject];
                    }
                    if(indexPath.row==2){
                        cell.titlelab.text=@"燃油费";
                        if (_bookTicketList.count==2) {
                            cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray1[0][@"airConstructionFee"]];
                        }else{
                       cell.price.text=[NSString stringWithFormat:@"￥%d.0",[_dataArray1[0][@"airConstructionFee"] intValue]*2];
                        }
                        cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)mendata.count];

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
                        cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray1[0][@"serviceFee"]];
                        cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)mendata.count];
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%@.0",Messagedict[@"passengerInfoList"][0][@"salePrice"]];
                        cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", (int)mendata.count];
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
                        cell.titlelab.text=@"燃油费";
                        cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray1[1][@"airConstructionFee"]];
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
                        cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray1[1][@"serviceFee"]];
                        cell.Numlabel.text=[NSString stringWithFormat:@"×%ld人", mendata.count];
                        
                    }else{
                        cell.price.text=[NSString stringWithFormat:@"￥%@.0",Messagedict1[@"passengerInfoList"][0][@"salePrice"]];
                        cell.Numlabel.text=[NSString stringWithFormat:@"×%ld人", mendata.count];

                    }
                    return cell;
                }
            }
        return nil;
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
             if(_dataArray1.count==2){
                 [UIView animateWithDuration:0.01 animations:^{
                     _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-320);
                     _tableView1.frame=CGRectMake(0, deviceScreenHeight-320,deviceScreenWidth , 320);
                     [_tableView1 reloadData];
                 }completion:nil];
             }else{
                 [UIView animateWithDuration:0.01 animations:^{
                     _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-160);
                     _tableView1.frame=CGRectMake(0, deviceScreenHeight-160,deviceScreenWidth , 160);
                     [_tableView1 reloadData];
                 }completion:nil];
             }
         }
    }
}

#pragma mark - 送审
-(void)songshen:(NSString*)orderNO{
    ApproveApplyRequest * approve =[ApproveApplyRequest new];
    approve.OrderNo=orderNO;
    approve.OrderType=@"JP";
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
                FlightorderList * fvc = [FlightorderList new];
                fvc.back=1;
                fvc.tabBarController.tabBar.hidden=YES;
                fvc.navigationController.navigationBar.hidden=YES;
                [self.navigationController pushViewController:fvc animated:YES] ;
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
    }];
 
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    view31.userInteractionEnabled=YES;
    nextbut.userInteractionEnabled=YES;
    _tableView.userInteractionEnabled=YES;
    
    [UIView animateWithDuration:0.01 animations:^{
        _connetview1.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    //价格详情视图
    [UIView animateWithDuration:0.01 animations:^{
        _Bottomconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        _tableView2.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 150);
    }completion:nil];

    [UIView animateWithDuration:0.01 animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
         _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 160);
    }completion:nil];
    
}
@end
