
//  OrderVC.m
//  Tour
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "OrderVC.h"
#import <QuartzCore/QuartzCore.h>
#import "order1Cell.h"
#import "order2Cell.h"
#import "order3Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "check1Cell.h"
#import "priceMesCellTableViewCell.h"
#import "PMCell.h"
#import "flightInsuranceVC.h"
#import "projectChangeVC.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

#define insureMess1 @"保险名称：合众航意险20（7天）\r\n\n保险金额：航空意外保险责任保额80万元、意外医疗保险责任保额20万元\r\n\n保险费：20元\r\n\n保险生效时间：7天\r\n\n限购份数：未成年人最高投保1份，成年人最高投保2份\r\n\n投保范围：30天-80周岁身体健康者，均可以作为被保险人，由本人或对其具有保险利益的其他人作为投保人向本公司投保本保险。\r\n\n证件类型：身份证、军人证等有效证件\r\n\n受益人：法定\r\n\n退保规则:保险责任正式开始之前可全额退保\r\n\n其他保险说明：\r\n\n如果保险产品内容或购买后有疑问，可拨打合众人寿客服热线95515，将有专人为您解答。\r\n\n使用条款及报备文号：合众附加综合交通工具意外伤害医疗保险(2013修订)-飞机，合众综合交通工具意外伤害保险（2013修订）（飞机）\r\n\n撤单条件：您可在本保险生效日之前申请撤单，撤单成功后保险费将划转到原交费帐户；起飞生效后不得申请撤单 。保险咨询、理赔报案电话： 合众人寿保险公司客服电话95515或登录http://www.unionlife.com.cn/";
#define insureMess2 @" 保险名称：都邦航意险 \r\n\n限购份数：限购2份\r\n\n 保额：保额50万，10天有效 \r\n\n保险金额额：20元 \r\n\n被保人年龄限制：28天至75周岁\r\n\n保险生效时间：次日凌晨\r\n\n理赔验证流程：登录www.dbic.com.cn进行查询";


@interface OrderVC ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate,order1CellDelegate,order2CellDelegate,order3CellDelegate>
{
    
    UIView * view3;
    UIButton * nextbut;
    UIView * view31;
    
    UIView * viewmes;

    //价格详情
    UITableView * _tableView2;
    UIView* _Bottomconnetview;
    
    UIView * _infoconnetview;
    UILabel* tglabel1;

    //退改详情
     UIView * _connetview1;
    UILabel*connetviewlabel;
    UILabel*connetviewlabel1;
    UILabel*connetviewlabel2;
    UILabel*connetviewlabel3;


    //蒙版订单详情视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    UITableView * _tableView;
    NSMutableArray * _array;
    
    NSMutableArray * _contactarray;

    NSMutableArray * insurearray;
     NSMutableArray * projectarray;
     NSMutableArray * costarray;
    
    NSString * projectNo;
    NSString * projectName;
    NSString * projectRmk;

    
    NSString * costName;
    NSString * costNo;

    UILabel * menla;
    UILabel * numeberla;
    NSMutableArray * _menlist;
    
    
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
    NSMutableArray * _arr;
    
    //保险类型1：强制，2：赠送 3：默认（可选）
    int a;
    //保险份数
    int b;
    //保险单份价格
    int c;
    //保险总价 d=c*b*人数
    int d;
    
    //人数
    int m;

    UILabel * pricela;
    UIImageView* plaimage;
    NSMutableArray * numarray;
   
    
    //保险信息查询
    NSString *messageInsur;
    //保险简述
    NSString *mesInsur;

    UIScrollView *scrollView;
    
    BOOL isa;
}
@end

@implementation OrderVC
-(void)viewWillDisappear:(BOOL)animated {

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_dataArray);
  
    [self initview];
    [self loadData1];
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
    [self loadData];
    }
//    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"]);

//    NSLog(@"%@",_menarray);
    if (_menarray.count==0) {
        _menarray= [NSMutableArray new];
        NSMutableDictionary * mendict = [NSMutableDictionary new];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"] forKey:@"empName"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"] forKey:@"certNo"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] forKey:@"certType"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"mobile"] forKey:@"mobile"];

        [_menarray addObject:mendict];
       
        m=(int)_menarray.count;
        
        [_tableView reloadData];
        [_tableView2 reloadData];
    }
    m=(int)_menarray.count;
    NSLog(@"%d",m);
    
    mesInsur=@"该险种最高保额7天50万";

    [self Tabview];
    [self creattable];
}
#pragma mark -初始化
-(void)initview{
   // NSLog(@"%@",_dataArray[0][@"price"]);
// _dataArray=[NSMutableArray array];
    _array = [[NSMutableArray alloc] init];
    insurearray=[[NSMutableArray alloc] init];
    projectarray=[[NSMutableArray alloc] init];
    costarray=[[NSMutableArray alloc] init];
    NSArray * na =@[@"0",@"1",@"2",@"3",@"4",@"5"];
    a=-1;
//m=0;
    numarray=[NSMutableArray arrayWithArray:na];
    isa=YES;
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"FYw"]isEqualToString:@"1"]){
        isa=NO;
    }
}
#pragma mark -自定义导航栏
-(void)Tabview{
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20,deviceScreenWidth/3, 30)];
    label.text=@"填写订单";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    backbut.tag=666;
    [view addSubview:backbut];
    
    UIView * dataview= [[UIView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, 48)];
    dataview.backgroundColor= [UIColor colorWithRed:254/255.0 green:246/255.0 blue:222/255.0 alpha:1];
    [self.view addSubview:dataview];
    
    UILabel * label1 = [[UILabel alloc]initWithFrame:CGRectMake(20, 5,deviceScreenWidth-40, 42)];
    label1.text=@"您当前的预定的是促销产品，行程单上的价格会与预定价格会不相符！";
    label1.numberOfLines = 0; // 最关键
    label1.font=[UIFont systemFontOfSize:13];
    label1.textColor=[UIColor blackColor];
    [dataview addSubview:label1];

    
    view3= [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
    view3.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    //UIButton * pricebut  =[[UIButton alloc]initWithFrame:CGRectMake(20,8,120, 44)];
    view31=[[UIView alloc]initWithFrame:CGRectMake(20,8,140, 44)];
    
    view31.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:CGRectMake(0,22,40, 16)];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
    
    pricela =[[UILabel alloc]initWithFrame:CGRectMake(33,8,90, 40)];
    pricela.adjustsFontSizeToFitWidth=YES;
    
    
    if(a!=2){
       d=c*b*m;
    }else{
        d=0;
    }
    [self calculateprice];
    
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF:)];
    [view31 addGestureRecognizer:tap];
        nextbut  =[[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-100,8,90, 44)];
    nextbut.backgroundColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [nextbut setTitle:@"下一步" forState:UIControlStateNormal];
    [nextbut.layer setMasksToBounds:YES ];
    [nextbut.layer setCornerRadius:10.0];
    nextbut.tag=888;
    [nextbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    nextbut.userInteractionEnabled=YES;
    [view3 addSubview:nextbut];
    [self.view addSubview:view3];
    
        }
-(void) showGF:(UITapGestureRecognizer *)tap{
    view31.userInteractionEnabled=NO;
    _tableView.userInteractionEnabled=NO;
    nextbut.userInteractionEnabled=NO;
    [UIView animateWithDuration:1.0 animations:^{
        _Bottomconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-120);
        if(_dataArray.count==1){
        _tableView2.frame=CGRectMake(0, deviceScreenHeight-150,deviceScreenWidth , 150);
        }else{
        _tableView2.frame=CGRectMake(0, deviceScreenHeight-300,deviceScreenWidth , 300);
        }
    }completion:nil];
}
-(void)calculateprice{
    if (isa==NO) {
        if(_dataArray.count==2){
            pricela.text=[NSString stringWithFormat:@"￥%lu",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue]+[_dataArray[1][@"serviceFee"] intValue])*_menarray.count+d*2];
            
        }else{
            pricela.text=[NSString stringWithFormat:@"￥%lu",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue])*_menarray.count+d];
        }
    }else{
        if(_dataArray.count==2){
            pricela.text=[NSString stringWithFormat:@"￥%lu",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue]+[_dataArray[1][@"serviceFee"] intValue])*_menarray.count+d*2];
            
        }else{
            pricela.text=[NSString stringWithFormat:@"￥%lu",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue])*_menarray.count+d];
        }
    }
}
-(void)loadData1{
   
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    
    InsureGivingQueryRequest * igqr =[InsureGivingQueryRequest new];
    igqr.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    igqr.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    igqr.Count=20;
    igqr.Start=0;
    
    [Basic InsureGivingQueryRequest:igqr success:^(id data) {
         [SVProgressHUD dismiss];
        NSLog(@"%@",data[@"paraMember"]);
        a=[data[@"paraMember"][@"paraValue2"] intValue];
        b=[data[@"paraMember"][@"paraValue1"] intValue];
        if(a!=2){
            d=c*b*m;
            mesInsur=@"该险种最高保额7天100万";
        }else{
            mesInsur=@"该险种最高保额7天50万";
            messageInsur =insureMess2;
            
            NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
            
            tglabel1.attributedText=att;
            CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
            
            NSLog(@"%f",labelsize.height);
            
            viewmes.frame = CGRectMake(20, 0, deviceScreenWidth-40, labelsize.height+400/SCREEN_RATE1);
            scrollView.contentSize = CGSizeMake(0,labelsize.height+400/SCREEN_RATE1);
            d=0;
        }
        [self calculateprice];
        
        [_tableView reloadData];
        [_tableView2 reloadData];
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    //保险查询
    InsureQueryRequest * insure  = [InsureQueryRequest new];
    insure.Sycp=@"0100";
    insure.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    insure.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic InsureQueryRequest:insure success:^(id data) {
         NSLog(@"%@",data);
        insurearray=data[@"insuranceSpecieList"];
        c=[data[@"insuranceSpecieList"][0][@"price"] intValue];
        
//        if(a!=2){
//            d=c*b*m;
//        }else{
//            d=0;
//        }
        [self calculateprice];
        
        if (a==2) {
            _InsuranceCode=data[@"insuranceSpecieList"][1][@"insuranceCode"];
        }else{
            _InsuranceCode=data[@"insuranceSpecieList"][0][@"insuranceCode"];
        }
        [_tableView reloadData];
         [_tableView2 reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)loadData{
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"]);
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    //项目
    ProjectQueryRequest *  project =[ProjectQueryRequest new];
    project.Start =0;
    project.Count=100;
    project.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    project.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic ProjectQueryRequest:project success:^(id data) {
        NSLog(@"%@",data);
         [SVProgressHUD dismiss];
        projectarray=data[@"projectList"];
        projectNo=projectarray[0][@"projectNo"];
        projectName=projectarray[0][@"projectName"];
       // NSLog(@"%@",data);
        [_tableView reloadData];

    } failure:^(NSError *error) {
    }];
    //成本中心
    CostCenterQueryRequest * cost = [CostCenterQueryRequest new];
    cost.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    cost.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic CostCenterQueryRequest:cost success:^(id data) {
        NSLog(@"%@",data);
        [SVProgressHUD dismiss];

        costarray=data[@"costList"];
        costName=costarray[0][@"costName"];
        costNo=costarray[0][@"costNo"];
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)backAndnext:(UIButton*)send{
    if(send.tag==666){
            [AlertViewManager alertWithTitle:@"温馨提示"
                                     message:@"你是否确定退出？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                         if (index==1) {
                                             if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
                                             FlightMessageVC * vc = [FlightMessageVC new ];
                                             vc.arr=nil;
                                                [self.navigationController popViewControllerAnimated:NO];
                                             }else{
                                                 [self.navigationController popToRootViewControllerAnimated:NO];
                                             }
                                         }
                                     }];
    }else if (send.tag==888){
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        FlightOrder * order= [FlightOrder new];
        order.ContactMobile=numeberla.text;
        order.ContactName=menla.text;
        order.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        order.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
            order.TravelStaType=@"1";
            order.TravelSta=@"1";
        }else{
            order.TravelStaType=@"2";
            order.TravelSta=@"2";
        }
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
            order.LegType=@"2";
        }else{
            order.LegType=@"1";
        }
        order.ProjectRmk=projectRmk;
        order.InsuranceCode=_InsuranceCode;
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
            order.ViolationReasonCode=_dataArray[0][@"erroMessage"];
            order.ViolationItem =_dataArray[0][@"erromes"];
            order.ViolationReason=_dataArray[0][@"erroID"];
            order.SecViolationReasonCode=_dataArray[1][@"erroMessage"];
            order.SecViolationItem =_dataArray[1][@"erromes"];
            order.SecViolationReason=_dataArray[1][@"erroID"];
            order.ProjectId=projectNo;
            order.CostCenter=costNo;
            }else{
                order.ViolationReasonCode=@"";
                order.ViolationItem =@"";
                order.ViolationReason=@"";
                order.SecViolationReasonCode=@"";
                order.SecViolationItem =@"";
                order.SecViolationReason=@"";
                order.ProjectId=@"";
                order.CostCenter=@"";
            }
        }else{
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
                order.ViolationReasonCode=_erroMessage;
                order.ViolationItem =_erromes;
                order.ViolationReason=_erroID;
                order.ProjectId=projectNo;
                order.CostCenter=costNo;
            }else{
                order.ViolationReasonCode=@"";
                order.ViolationItem =@"";
                order.ViolationReason=@"";
                order.SecViolationReasonCode=@"";
                order.SecViolationItem =@"";
                order.SecViolationReason=@"";
                order.ProjectId=@"";
                order.CostCenter=@"";
            }
        }
        NSMutableArray * arr=[NSMutableArray array];
        for (NSMutableDictionary * dictw in _dataArray) {
            leglistmodel * leglist = [leglistmodel new];
            leglist.Cabin=dictw[@"Cabin"];
            leglist.FlightNo=dictw[@"flightNo"];
            leglist.SessionId=dictw[@"sessionId"];
            leglist.PolicyId=dictw[@"policyId"];
            [arr addObject:leglist];
        }
        order.LegList =[leglistmodel mj_keyValuesArrayWithObjectArray:arr];
        NSMutableArray * arr1=[NSMutableArray array];
        for (NSMutableDictionary * dic in _menarray) {
            PassengerListmodel * passnger = [PassengerListmodel new];
            passnger.DocName=dic[@"certNo"];
            passnger.DocType=dic[@"certType"];
            passnger.Insurance=[NSString stringWithFormat:@"%d",b];
            passnger.Name=dic[@"empName"];
            passnger.PassenType=@"1";
            passnger.MobileNum=dic[@"mobile"];
            if (a==2) {
            passnger.Insurance=@"0";
            }else{
            passnger.Insurance=[NSString stringWithFormat:@"%d",b];
            }
            [arr1 addObject:passnger];
        };
        order.PassengerList =[PassengerListmodel mj_keyValuesArrayWithObjectArray:arr1];
        
        [Flight FlightOrder:order success:^(id data) {
            [SVProgressHUD dismiss];
           NSLog(@"%@",data[@"message"]);
            NSLog(@"%@",data[@"bookTicketList"]);
            if([data[@"status"] isEqualToString:@"T"]){
                CheckVC * check = [CheckVC new];
                check.bookTicketList=data[@"bookTicketList"];
                check.dataArray1=_dataArray;
                check.dataArray=_cabinArray;
                check.menarr=_menarray;
               
                if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
                    check.Voreson=_erroMessage;
                    check.Voitm=_erromes;
                }
                if (projectRmk.length==0) {
                    check.project=projectName;
                }else{
                    check.project=projectRmk;
                }
                check.cencer=costName;
                check.a=a;
                check.b=b;
                check.c=c;
                check.d=d;
  [self.navigationController pushViewController:check animated:NO];

                // [self presentViewController:check animated:NO completion:nil];
                
            }else{
                [UIAlertView showAlertWithTitle:data[@"message"]];
            }
         } failure:^(NSError *error) {
             [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
         }];
    }else{
    }
}
#pragma mark -创建列表
-(void)creattable{
//    NSLog(@"%@",_dataArray);
    if (_dataArray.count==2) {
        if([_dataArray[0][@"policyType"] isEqualToString:@"CPS_TJZC"]||[_dataArray[1][@"policyType"] isEqualToString:@"CPS_TJZC"]){
            _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-180) style:UITableViewStyleGrouped];
        }else{
        _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-142) style:UITableViewStyleGrouped];
        }
        
    }else{
        if([_dataArray[0][@"policyType"] isEqualToString:@"CPS_TJZC"]){
            _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-180) style:UITableViewStyleGrouped];
        }else{
            _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-142) style:UITableViewStyleGrouped];
        }
    }
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    [self.view addSubview:effectView];
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenHeight/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
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
    
    _infoconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _infoconnetview.backgroundColor=[UIColor blackColor];
    _infoconnetview.alpha=0.7;
    [self.view  addSubview:_infoconnetview];
    
    // UIView * taview1 =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight-60)]];
    scrollView = [[UIScrollView alloc] initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 60, 375, deviceScreenHeight)]];
    
    viewmes = [[UIView alloc]init];
    [scrollView addSubview:viewmes];
    
    
    tglabel1 = [[UILabel alloc]init];
    //    tglabel1.font=[UIFont systemFontOfSize:13];
    tglabel1.textColor=[UIColor whiteColor];
    //自动折行设置
    tglabel1.lineBreakMode = UILineBreakModeWordWrap;
    tglabel1.numberOfLines = 0;
    messageInsur =insureMess1;
    
    NSAttributedString *att = [[NSAttributedString alloc]initWithString:messageInsur];
    
    tglabel1.attributedText=att;
    CGSize labelsize = [self attributeString:att boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT)];
    
    NSLog(@"%f",labelsize.height);
    
    viewmes.frame = CGRectMake(20, 0, deviceScreenWidth-40, labelsize.height+400/SCREEN_RATE1);
    scrollView.contentSize = CGSizeMake(0,labelsize.height+400/SCREEN_RATE1);
    
    [viewmes addSubview:tglabel1];
    
    [tglabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@(10));
        make.width.mas_equalTo(@(deviceScreenWidth-40));
        make.centerX.equalTo(viewmes);
    }];
    UITapGestureRecognizer *tab2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab2:)];
    [scrollView addGestureRecognizer:tab2];
    [_infoconnetview addSubview:scrollView];
}
-(CGSize)attributeString:(NSAttributedString *)attString boundingRectWithSize:(CGSize)size {
    if (!attString) {
        return CGSizeZero;
    }
    return [attString boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
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
            if (![_arr[0] isKindOfClass:[NSDictionary class]]) {
//                 NSLog(@"%d,%d,%d",b,c,d);
                if(_dataArray.count==2){
                    pricela.text=[NSString stringWithFormat:@"￥%.lf",([_dataArray[0][@"price"] floatValue]+[_dataArray[1][@"price"] floatValue]+[_dataArray[0][@"airConstructionFee"] floatValue]+[_dataArray[1][@"airConstructionFee"] floatValue]+[_dataArray[0][@"serviceFee"] floatValue]+[_dataArray[1][@"serviceFee"] floatValue])*m+d];
                }else{
                    pricela.text=[NSString stringWithFormat:@"￥%.1lf",([_dataArray[0][@"price"] floatValue]+[_dataArray[0][@"airConstructionFee"] floatValue]+[_dataArray[0][@"serviceFee"] floatValue])*m+d];
                }
                [_tableView2 reloadData];
                [_tableView reloadData];
            }else{
                [_tableView reloadData];
            }
            
            break;
        default:
            break;
    }
}
-(void)chick{
        [UIView animateWithDuration:0.01 animations:^{
        effectView.hidden=NO;
        // 设置view弹出来的位置
        pickerView.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3, self.view.frame.size.width, self.view.frame.size.height/3);
        UIView * vv =(UIView*)[self.view viewWithTag:133];
        vv.frame = CGRectMake(0, deviceScreenHeight-deviceScreenHeight/3-40, self.view.frame.size.width, 40);
    }];
}
-(void)loadPickerData:(NSMutableArray*)arr{
 //_arr=@[@"不限",@"经济舱",@"公务舱",@"头等舱",@"明珠舱"];
   // NSLog(@"%@",projectarray);
    _arr=[NSMutableArray arrayWithArray:arr];
    [pickerView reloadAllComponents];
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
    if ([_arr[row] isKindOfClass:[NSDictionary class]]) {
        if(_arr[row][@"projectName"]!=nil){
            return _arr[row][@"projectName"];
        }else if(_arr[row][@"costName"]!=nil){
            return _arr[row][@"costName"];
        }else{
            return _arr[row][@"reasonName"];
        }
    }
    else{
       return _arr[row];
    }
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
//    [pickerView selectRow:0 inComponent:0 animated:NO];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    if ([_arr[rowOne] isKindOfClass:[NSDictionary class]]) {
    if(_arr[rowOne][@"projectName"]!=nil){
//        seatstring = _arr[rowOne][@"projectName"];
        projectNo=_arr[rowOne][@"projectNo"];
        projectName=_arr[rowOne][@"projectName"];;
    }else if(_arr[rowOne][@"costName"]!=nil){
//        seatstring = _arr[rowOne][@"costName"];
        costName=_arr[rowOne][@"costName"];
        costNo=_arr[rowOne][@"costNo"];
//        [_tableView reloadData];
    }
    else{
        seatstring = _arr[row][@"reasonName"];
        _erroMessage= seatstring;
        [_tableView reloadData];
    }
    }
    else{
        b=[_arr[rowOne] intValue];
        d=c*b*m;
        NSLog(@"%d,%d,%d",b,c,d);
        
        
    }
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if([tableView isEqual:_tableView]){
        if(isa==YES){
            if (section==3||section==4||section==5||section==6) {
            return 0.01;
            }else if(section==1){
            return 40;
            }
            else{
            return 10;
            }
        }
        else{
            if (section==0) {
            return 0.1;
            }else if(section==1){
            return 40;
            }
            else
            return 10;
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
        else if(section==2){
            return 0.01;
        }else
            return 0.01;
    }else if([tableView isEqual:_tableView2]){
        return 1;
    }
    else{
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
        UIButton * b1 = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 80, 20)];
        b1.titleLabel.font=[UIFont systemFontOfSize:13];
        [b1 setTitle:@"退改签规则" forState:UIControlStateNormal];
        [b1 addTarget:self action:@selector(onClick111:) forControlEvents:UIControlEventTouchUpInside];
        [b1 setTitleColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1] forState:UIControlStateNormal];
        [view1 addSubview:b1];
        return view;
    }
    else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UILabel * menmessagelabel =[[ UILabel alloc]initWithFrame:CGRectMake(20, 12, 80, 16)];
        menmessagelabel.text=@"联系人信息";
        menmessagelabel.font = [UIFont systemFontOfSize:13];
        menmessagelabel.textColor=[UIColor grayColor];
        [view addSubview:menmessagelabel];
        menla =[[ UILabel alloc]initWithFrame:CGRectMake(110, 12, 52, 16)];
        if( _contactarray.count==0){
            menla.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"];
        }else{
           menla.text=_contactarray[0][@"name"];
        }
        menla.font = [UIFont systemFontOfSize:13];
        menla.textColor=[UIColor blackColor];
        [view addSubview:menla];
        numeberla =[[ UILabel alloc]initWithFrame:CGRectMake(167, 12, 100, 16)];
        if( _contactarray.count==0){
            numeberla.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"mobile"];
        }else{
            numeberla.text=_contactarray[0][@"mobile"];;
        }
        numeberla.font = [UIFont systemFontOfSize:13];
        numeberla.textColor=[UIColor blackColor];
        [view addSubview:numeberla];
        
        UIButton * menimagebut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-30, 10, 20, 20)];
        [menimagebut setImage:[UIImage imageNamed:@"contect"] forState:UIControlStateNormal];
        [menimagebut addTarget:self action:@selector(changLmen:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:menimagebut];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }
    else if(section==2){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
    UILabel * bxlabel =[[ UILabel alloc]initWithFrame:CGRectMake(20, 5, deviceScreenWidth-40, 34)];
        bxlabel.text=@"该险种只保7天，您的行程已经超过7天有效期，您可能需购买两份保险。";
        bxlabel.font = [UIFont systemFontOfSize:12];
        bxlabel.numberOfLines = 0; // 最关键
        bxlabel.textColor=[UIColor blackColor];
        [view addSubview:bxlabel];
        if(![bxlabel.text isEqualToString:@""]){
        view.hidden=YES;
        }
        view.backgroundColor=[UIColor yellowColor];
        return view;
    }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor blueColor];
        return view;
    }}
    else if([tableView isEqual:_tableView2]){
        return 0;
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
        UIButton * butchangeman = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-120, 5, 100,30)];
        [butchangeman.layer setMasksToBounds:YES];
        [butchangeman.layer setCornerRadius:10.0];
        butchangeman.titleLabel.font=[UIFont systemFontOfSize:13];
        [butchangeman addTarget:self action:@selector(changmenclick:) forControlEvents:UIControlEventTouchUpInside];
        [butchangeman setTitle:@"选择乘机人" forState:UIControlStateNormal];
        [butchangeman setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [butchangeman setBackgroundColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1]];
         
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
                if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"FYw"]isEqualToString:@"1"]) {
                    butchangeman.hidden=YES;
                }
            }
        [view addSubview:butchangeman];
        view.backgroundColor=[UIColor whiteColor];
        return view;
        }else{
            UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
            view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
            return view;
        }
    } else if([tableView isEqual:_tableView2]){
        return 0;
    }else{
        return 0;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
if([tableView isEqual:_tableView]){
    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]){
    if(indexPath.section==0||indexPath.section==1||indexPath.section==2){
    return 80;
    }else
        return 0.01;
    }else{
        if(indexPath.section==0||indexPath.section==1){
            return 80;
        }else{
            if(indexPath.section==5){
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]) {
                //            NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"]);
                if([[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"] isEqualToString:@"hg"]){
                    return 0.01;
                }else{
                    return 60;
                }
            }else{
                return 0.01;
            }
            }else{
                return 60;
            }
        }
    }
}
else if([tableView isEqual:_tableView2]){
    return 30;
}else{
        if(indexPath.section==0){
            return 160;
        }else{
            return  0;}
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([tableView isEqual:_tableView]){
        return 6;
    }
    else if([tableView isEqual:_tableView2]){
        if(_dataArray.count==1){
            return 1;
        }else{
            return 2;
        }
    }else{
            return 1;
        }
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
if([tableView isEqual:_tableView]){
    if (section==0) {
        return _dataArray.count;
    }else if(section==2){
        return 1;
    }
    else if(section==1){
        return _menarray.count;
    }
    else if(section==5){
        if(_dataArray.count==2){
            
            //是否往返两者都违规
            if ((![[_dataArray[0] allKeys] containsObject:@"erromes"])||(![[_dataArray[1] allKeys] containsObject:@"erromes"])) {
                return 2;
            }else{
                return 4;
            }
        }else{
            return 2;
        }
    }else{
    return 1;
    }
} else if([tableView isEqual:_tableView2]){
            return 5;
}else{
        if (section==0) {
        return _dataArray.count;
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
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
            cell= (order1Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order1Cell" owner:self options:nil]  lastObject];
        }
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row==1){
            cell.logoimage.image=[UIImage imageNamed:@"backward"];
        }
        cell.celloutlabel.text=[NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"outdate"],_dataArray[indexPath.row][@"date"]];
        cell.airlabel.text=[NSString stringWithFormat:@"%@ %@-%@ %@",_dataArray[indexPath.row][@"departCity"],_dataArray[indexPath.row][@"departTerminal"],_dataArray[indexPath.row][@"arrivalCity"],_dataArray[indexPath.row][@"arrivalTerminal"]];
    
        return cell;
    }else if(indexPath.section==1){
        order2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId2"];
        if (!cell) {
            cell= (order2Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order2Cell" owner:self options:nil]  lastObject];
        }
        cell.delegate=self;
        cell.cellbut.hidden=YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(_menarray.count==0){
            cell.namelabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"];
            NSString * str= @"";
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] isEqualToString:@"NI"]){
                str=@"身份证";
                cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,[secretNum IdCardtest:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"]]];
            }else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] isEqualToString:@"ID"]){
                str=@"护照";
                cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,[secretNum otherCardtest:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"]]];
            }else{
                str=@"其它";
                cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"]];
            }
        }else{
            cell.namelabel.text= _menarray[indexPath.row][@"empName"];
            NSString * str = @"";
            if([_menarray[indexPath.row][@"certType"] isEqualToString:@"NI"]){
                str=@"身份证";
                 cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,[secretNum IdCardtest:_menarray[indexPath.row][@"certNo"]]];
            }else if ([_menarray[indexPath.row][@"certType"] isEqualToString:@"ID"]){
                str=@"护照";
                 cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,[secretNum otherCardtest:_menarray[indexPath.row][@"certNo"]]];
            }else{
                str=@"其它";
                 cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,_menarray[indexPath.row][@"certNo"]];
            }
        }
        return cell;
    }
    else if(indexPath.section==2){
        order3Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId3"];
        if (!cell) {
            cell= (order3Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order3Cell" owner:self options:nil]  lastObject];
        }
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.messageLbel.text=mesInsur;
    if(a!=0){
        if(a==2){
            cell.insurelabel.text=[NSString stringWithFormat:@"(赠送)%d份×%lu人",b,(unsigned long)_menarray.count];
        }else if (a==1){
            cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%lu人×%d份",c,(unsigned long)_menarray.count,b];
        }else{
            cell.insurelabel.text=[NSString stringWithFormat:@"￥%d×%lu人×%d份",c,(unsigned long)_menarray.count,b];
        }
        }
        return cell;
    }
    else if(indexPath.section==3||indexPath.section==4){
        order4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId4"];
        if (!cell) {
            cell= (order4Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order4Cell" owner:self options:nil]  lastObject];
                    }
        if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]) {
            cell.hidden=YES;
        }
        if (indexPath.section==3) {
            cell.titlelabel.adjustsFontSizeToFitWidth = YES;
            cell.costlabel.adjustsFontSizeToFitWidth = YES;
            cell.titlelabel.text=@"项目";
            if(deviceScreenWidth==320){
                cell.costlabel.font =[UIFont systemFontOfSize:13];
            }
            if (projectRmk.length==0) {
                cell.costlabel.text=projectName;
            }else{
                 cell.costlabel.text=projectRmk;
            }
        }else{
            cell.costlabel.adjustsFontSizeToFitWidth = YES;
            cell.titlelabel.adjustsFontSizeToFitWidth = YES;
            cell.titleimage.image=[UIImage imageNamed:@"center"];
            cell.titlelabel.text=@"成本中心";
            if(deviceScreenWidth==320){
                cell.costlabel.font =[UIFont systemFontOfSize:13];
            }
            cell.costlabel.text=costName;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
else{
        order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId5"];
        if (!cell) {
            cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
        }
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]) {
        cell.hidden=YES;
    }else{
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]) {
//            NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"]);
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"wh"] isEqualToString:@"hg"]){
                cell.hidden=YES;
            }
        }else{
            cell.hidden=YES;
        }
    }
    if(_dataArray.count!=2){
        if(indexPath.row==0){
//        cell.wblabel.adjustsFontSizeToFitWidth = YES;
        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
        cell.wblabel.text=@"违背事项";
            if(deviceScreenWidth==320){
                cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
            }
        cell.MsszgeLabel.text=_erromes;
        }else{
//        cell.wblabel.adjustsFontSizeToFitWidth = YES;
        cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
        cell.wblabel.text=@"违背原因";
            if(deviceScreenWidth==320){
                cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
            }
        cell.titleimage.image=[UIImage imageNamed:@""];
        cell.MsszgeLabel.text=_erroMessage;
        }
    }else{
        if ((![[_dataArray[0] allKeys] containsObject:@"erromes"])||(![[_dataArray[1] allKeys] containsObject:@"erromes"])) {
            //判断去，回的违规
            if (![[_dataArray[0] allKeys] containsObject:@"erromes"]) {
                if(indexPath.row==0){
//                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背事项(回)";
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.MsszgeLabel.text=_dataArray[1][@"erromes"];
                }else{
//                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背原因(回)";
                    cell.titleimage.image=[UIImage imageNamed:@""];
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.MsszgeLabel.text=_dataArray[1][@"erroMessage"];
                }
            }else{
                if(indexPath.row==0){
//                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背事项(去)";
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.MsszgeLabel.text=_dataArray[0][@"erromes"];
                }else if(indexPath.row==1){
//                    cell.wblabel.adjustsFontSizeToFitWidth = YES;
                    cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                    cell.wblabel.text=@"违背原因(去)";
                    cell.titleimage.image=[UIImage imageNamed:@""];
                    if(deviceScreenWidth==320){
                        cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                    }
                    cell.MsszgeLabel.text=_dataArray[0][@"erroMessage"];
                }
            }
        }else{
            if(indexPath.row==0){
//                cell.wblabel.adjustsFontSizeToFitWidth = YES;
                cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                cell.wblabel.text=@"违背事项(去)";
                if(deviceScreenWidth==320){
                    cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                }
                cell.MsszgeLabel.text=_dataArray[0][@"erromes"];
            }else if(indexPath.row==1){
//                cell.wblabel.adjustsFontSizeToFitWidth = YES;
                cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                cell.wblabel.text=@"违背原因(去)";
                cell.titleimage.image=[UIImage imageNamed:@""];
                if(deviceScreenWidth==320){
                    cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                }
                cell.MsszgeLabel.text=_dataArray[0][@"erroMessage"];
                
            }else if(indexPath.row==2){
//                cell.wblabel.adjustsFontSizeToFitWidth = YES;
                cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                cell.wblabel.text=@"违背事项(回)";
                if(deviceScreenWidth==320){
                    cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                }
                cell.MsszgeLabel.text=_dataArray[1][@"erromes"];
            }else if(indexPath.row==3){
//                cell.wblabel.adjustsFontSizeToFitWidth = YES;
                cell.MsszgeLabel.adjustsFontSizeToFitWidth = YES;
                cell.wblabel.text=@"违背原因(回)";
                if(deviceScreenWidth==320){
                    cell.MsszgeLabel.font =[UIFont systemFontOfSize:12];
                }
                cell.titleimage.image=[UIImage imageNamed:@""];
                cell.MsszgeLabel.text=_dataArray[1][@"erroMessage"];
            }
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}else if([tableView isEqual:_tableView2]){
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
                //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                cell= (PMCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"PMCell" owner:self options:nil]  lastObject];
            }
            if(indexPath.row==2){
                cell.titlelab.text=@"燃油费";
                cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[0][@"airConstructionFee"]];
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];

            }else if (indexPath.row==3){
                 cell.titlelab.text=@"航意险";
                if(a==2){
                    cell.price.text=@"￥0.0";
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%d.0",c];
                }
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d份×%d人",b,m];
            }else if(indexPath.row==4){
                cell.titlelab.text=@"服务费";
                cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[0][@"serviceFee"]];
             cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
            }else{
            cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[0][@"price"]];
             cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
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
                cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[1][@"airConstructionFee"]];
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d份", m];
            }else if (indexPath.row==3){
                cell.titlelab.text=@"航意险";
                if(a==2){
                    cell.price.text=@"￥0.0";
                }else{
                    cell.price.text=[NSString stringWithFormat:@"￥%d.0",c];
                }
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d份",b];
            }else if(indexPath.row==4){
                cell.titlelab.text=@"服务费";
                cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[0][@"serviceFee"]];
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d人", m];
                
            }else{
                cell.price.text=[NSString stringWithFormat:@"￥%@.0",_dataArray[1][@"price"]];
                cell.Numlabel.text=[NSString stringWithFormat:@"×%d份", m];
            }
            return cell;
        }
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
    cell.outdatalabel.text=_dataArray[indexPath.row][@"outdate"];
    cell.outTime.text=[_dataArray[indexPath.row][@"date"] substringToIndex:5];
    cell.arriveTime.text=[_dataArray[indexPath.row][@"arrivalTime"] substringToIndex:5];
    cell.copany.text=_dataArray[indexPath.row][@"conpany"];
    cell.copany.adjustsFontSizeToFitWidth=YES;
    
    cell.zdlabel.text=[NSString stringWithFormat:@"准点率:%.1f%%",  [_dataArray[indexPath.row][@"punctualityRate"] floatValue]*100];

//    cell.bettenCity.text=_dataArray[indexPath.row][@"stopOver"];
    cell.bettenCity.hidden=YES;
    if(![_dataArray[indexPath.row][@"meal"]isEqualToString:@""]){
        cell.meallabel.text=@"有餐食";
    }else{
        cell.meallabel.text=@"无";
    }
    cell.airNo.text=[NSString stringWithFormat:@"机型:%@",_dataArray[indexPath.row][@"flightMode"]];
    cell.arrviCity.text=[NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"arrivalCity"],_dataArray[indexPath.row][@"arrivalTerminal"]];
    cell.outCity.text=[NSString stringWithFormat:@"%@ %@",_dataArray[indexPath.row][@"departCity"],_dataArray[indexPath.row][@"departTerminal"]];
    NSString *str3 = [_dataArray[indexPath.row][@"flyTime"] stringByReplacingOccurrencesOfString:@":" withString:@"小时"];
    cell.flyTime.text=[NSString stringWithFormat:@"%@分钟",str3];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}
-(void)MessageClick:(order1Cell *)cell{
    
    view31.userInteractionEnabled=NO;
    _tableView.userInteractionEnabled=NO;
    nextbut.userInteractionEnabled=NO;
    if(_dataArray.count==2){
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
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //获取cell的方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
            
            view31.userInteractionEnabled=NO;
            _tableView.userInteractionEnabled=NO;
            nextbut.userInteractionEnabled=NO;
            
            if(_dataArray.count==2){
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
        }else if(indexPath.section==3){
//            [self loadPickerData:projectarray];
//            [self chick];
            projectChangeVC * pvc = [projectChangeVC new];
              pvc.block=^(NSMutableDictionary*dict){
                  if ([[dict allKeys] containsObject:@"projectNo"]) {
                      projectNo=dict[@"projectNo"];
                      projectName=dict[@"projectName"];
                  }else{
                     projectRmk=dict[@"projectName"];
                    projectNo=@"";
                    projectName=@"";
                  }
                   [_tableView reloadData];
                };
            [self.navigationController  pushViewController:pvc animated:YES];
            
        }else if(indexPath.section==4){
            [self loadPickerData:costarray];
            [self chick];
        }else if(indexPath.section==5){
            if (indexPath.row==1||indexPath.row==3) {
                [self loadPickerData:_errArray];
                [self chick];
            }
        }else if(indexPath.section==2){
            if(a==3){
                flightInsuranceVC * fivc = [flightInsuranceVC new];
                if(_insuranceType.length==0||[_insuranceType isEqualToString:@"1"]){
                    fivc.insuranceType=@"1";
                }else{
                    fivc.insuranceType=@"2";
                }
                fivc.Num=[NSString stringWithFormat:@"%d",b];
               
                fivc.block=^(NSMutableDictionary*dict){
                   
                    if (![dict[@"inprice"] isEqualToString:@""]) {
                        if ([dict[@"insuranceType"] isEqualToString:@"2"]) {
                            _insuranceType=@"2";
                            c=[dict[@"inprice"] intValue];
                            b=[dict[@"num"] intValue];
                            d=c*b*m;
                         messageInsur = insureMess2;
                         mesInsur=@"该险种最高保额7天50万";
                        }else{
                             mesInsur=@"该险种最高保额7天100万";
                         messageInsur = insureMess1;
                            _insuranceType=@"1";
                            c=[dict[@"inprice"] intValue];
                            b=[dict[@"num"] intValue];
                            d=c*b*m;
                        }
                    }else{
                            if ([dict[@"insuranceType"] isEqualToString:@"2"]) {
                                _insuranceType=@"2";
                                c=[dict[@"inprice"] intValue];
                                b=[dict[@"num"] intValue];
                                d=c*b*m;
                                messageInsur = insureMess2;
                                mesInsur=@"该险种最高保额7天50万";
                            }else{
                                _insuranceType=@"1";
                                messageInsur = insureMess1;
                                mesInsur=@"该险种最高保额7天100万";
                                c=[dict[@"inprice"] intValue];
                                b=[dict[@"num"] intValue];
                                d=c*b*m;
                            }
                    }
                    _InsuranceCode=dict[@"insuranceCode"];
                    if(_dataArray.count==2){
                        pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue]+[_dataArray[1][@"serviceFee"] intValue])*_menarray.count+d*2];
                    }else{
                        pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue])*_menarray.count+d];
                    }
                    [_tableView reloadData];
                    [_tableView2 reloadData];
                    tglabel1.text=messageInsur;
                    CGSize labelsize =[messageInsur boundingRectWithSize:CGSizeMake(375/SCREEN_RATE,MAXFLOAT) options:0 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
                    scrollView.contentSize = CGSizeMake(0, labelsize.height);
                };
                [self presentViewController:fivc animated:NO completion:nil];
            }
        }else{
        }
    }
}
-(void)onClick111:(UIButton *)button{

    [UIView animateWithDuration:0.01 animations:^{
        _connetview1.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    connetviewlabel1.text=[NSString stringWithFormat:@"去程：%@",_dataArray[0][@"noteSimp"]];
    if(_dataArray.count==2){
       connetviewlabel2.text=[NSString stringWithFormat:@"返程：%@",_dataArray[1][@"noteSimp"]];
    }else{
         connetviewlabel2.text=@"";
    }
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
        _tableView2.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 120);

    }completion:nil];
    [UIView animateWithDuration:0.01 animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 160);
    }completion:nil];
}
-(void)changmenclick:(UIButton*)send{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=1;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
       
        _menarray=array;

        m=(int)_menarray.count;
        
        if(a!=2){
            d=c*b*(int)(_menarray.count);
        }else{
            d=0;
        }
        if(_dataArray.count==2){
            pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue]+[_dataArray[1][@"serviceFee"] intValue])*_menarray.count+d*2];
            
        }else{
            pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue])*_menarray.count+d];
        }
        [_tableView2 reloadData];
        [_tableView reloadData];
    };
    [self presentViewController:changmen animated:YES completion:nil];
}
-(void)changmenclick1{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=1;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
        
        _menarray=array;
        
        m=(int)_menarray.count;
        
        if(a!=2){
            d=c*b*(int)(_menarray.count);
        }else{
            d=0;
        }
        if(_dataArray.count==2){
            pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue]+[_dataArray[1][@"serviceFee"] intValue])*_menarray.count+d*2];
            
        }else{
            pricela.text=[NSString stringWithFormat:@"￥%ld",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[0][@"serviceFee"] intValue])*_menarray.count+d];
        }
        [_tableView2 reloadData];
        [_tableView reloadData];
    };
    [self presentViewController:changmen animated:YES completion:nil];
}

-(void)DeleatbutClick:(order2Cell *)cell{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"pubAndpri"] isEqualToString:@"1"]) {
        if (_menarray.count==1) {
            [AlertViewManager alertWithTitle:@"温馨提示"
                                     message:@"已经是最后一位乘机人，删除后将重新查询，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                         if (index==1) {
                                              [self.navigationController popToRootViewControllerAnimated:NO];
                                         }
                                     }];
        }else{
            NSMutableArray * array = [NSMutableArray new];
            if([_menarray isKindOfClass:[NSArray class]]){
                array=[NSMutableArray arrayWithArray:_menarray];
                // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
                [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"empName"] isEqualToString:cell.namelabel.text]) {
                        [array removeObject:obj];
                        _menarray=[array copy];
                        [_tableView reloadData];
                    }
                }];
            }else{
                // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
                [_menarray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"empName"] isEqualToString:cell.namelabel.text]) {
                        [_menarray removeObject:obj];
                        [_tableView reloadData];
                    }
                }];
            }
        }
    }else{
        if (_menarray.count==1) {
            [AlertViewManager alertWithTitle:@"温馨提示"
                                     message:@"已经是最后一位乘机人，删除后将重新选择乘机人，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                         if (index==1) {
                                             [self changmenclick1];
                                         }
                                     }];
        }else{
            NSMutableArray * array = [NSMutableArray new];
            if([_menarray isKindOfClass:[NSArray class]]){
                array=[NSMutableArray arrayWithArray:_menarray];
                // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
                [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"empName"] isEqualToString:cell.namelabel.text]) {
                        [array removeObject:obj];
                        _menarray=[array copy];
                        [_tableView reloadData];
                    }
                }];
            }else{
                // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
                [_menarray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    if ([obj[@"empName"] isEqualToString:cell.namelabel.text]) {
                        [_menarray removeObject:obj];
                        [_tableView reloadData];
                    }
                }];
        }
    }
}
    
    m=(int)_menarray.count;
    if(a!=2){
        d=c*b*(int)(_menarray.count);
    }else{
        d=0;
    }
    if(_dataArray.count==2){
        pricela.text=[NSString stringWithFormat:@"￥%d",([_dataArray[0][@"price"] intValue]+[_dataArray[1][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue]+[_dataArray[1][@"airConstructionFee"] intValue])*m+d];
    }else{
        pricela.text=[NSString stringWithFormat:@"￥%d",([_dataArray[0][@"price"] intValue]+[_dataArray[0][@"airConstructionFee"] intValue])*m+d];
    }
    [_tableView reloadData];
    [_tableView2 reloadData];
}
-(void)infobutClick:(order3Cell *)cell{
    [UIView animateWithDuration:0.01 animations:^{
        _infoconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)showGFtab2:(UITapGestureRecognizer *)tab2{

    [UIView animateWithDuration:0.01 animations:^{
        _infoconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
}
-(void)changLmen:(UIButton*)send{
    contactVC * contact =[contactVC new];
    contact.block=^(NSMutableArray * contactarr1){
        _contactarray=contactarr1;
        [_tableView reloadData];
    };
     [self presentViewController:contact animated:YES completion:nil];
}

@end
