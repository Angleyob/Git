//
//  TrainorderVC.m
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "TrainorderVC.h"
#import "TraincheckVC.h"
#import "trainorder0.h"
#import "order2Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "traincell2.h"
#import "voModel.h"
#import "Tjtmodel.h"
#import "TJTCell.h"

#import "projectChangeVC.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface TrainorderVC ()<order2CellDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate,trainorder0Delegate>
{
    UITableView * _tableView;
    NSMutableArray * _array;
//    NSMutableArray * _menarray;
    NSMutableArray * _contactarray;
    
    NSMutableArray * insurearray;
    NSMutableArray * projectarray;
    NSMutableArray * costarray;
    
    NSString * projectNo;
    NSString * projectName;
    NSString * projectRmk;

    
    NSString * costName;
    NSString * costNo;
    NSString * freeprice1str;

    
    UILabel * menla;
    UILabel * numeberla;
    NSMutableArray * _menlist;
    
    
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
    NSMutableArray* _arr;
    
    //服务价格
    int a;
    //票价
    int b;
    
    UILabel * pricela;
    UIImageView* plaimage;
    NSMutableArray * numarray;
    //价格详情
    UIView * view4;
    UIView* _Bottomconnetview;
     UILabel * mennum;
     UILabel * free;
     UILabel * tprice;
    
    //经停蒙版视图
    UIView * _JTconnetview;
    UITableView * _tableView1;
    
    //退改签蒙版视图
    UIView * _tgconnetview;
    UILabel * tglabel1;
    
    NSString * seatname;
    NSString * seatprice;
    NSString * seatprice1;

    

    BOOL isa;
}

@end

@implementation TrainorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initview];
    
    NSLog(@"%@",_trainDatadict);
    
    if (_menarray.count==0) {
        
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"]);
        _menarray= [NSMutableArray new];
        NSMutableDictionary * mendict = [NSMutableDictionary new];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"] forKey:@"empName"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"] forKey:@"certNo"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] forKey:@"certType"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empId"] forKey:@"empId"];

        [_menarray addObject:mendict];
        [_tableView reloadData];
        [_tableView1 reloadData];
    }
    [self loadData1];
    [self Tabview];
    [self creattable];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
#pragma mark -初始化

-(void)initview{
    
 //  NSLog(@"%@",_StopOverarr);
//    NSLog(@"%@",_seatarr );
//    NSMutableArray * array = [NSMutableArray new];
//    
//    if([_seatarr isKindOfClass:[NSArray class]]){
//        array=[NSMutableArray arrayWithArray:_seatarr];
//        // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
//        [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            if ([obj[@"count"] isEqualToString:@"0"]) {
//                [array removeObject:obj];
//                _seatarr=[array copy];
//            }
//        }];
//    }else{
//        // 遍历数组是操作数组（会崩溃），应采用下列Block方式实现删除和替换
//        [_seatarr enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//            if ([obj[@"count"] isEqualToString:@"0"]) {
//                [_seatarr removeObject:obj];
//            }
//        }];
//    }
    
    NSMutableArray * array = [NSMutableArray new];

    for (int i=0; i<_seatarr.count; i++) {
        if ([_seatarr[i][@"count"] isEqualToString:@"0"]||[_seatarr[i][@"count"] isEqualToString:@"无"]) {
        }else{
            [array addObject:_seatarr[i]];
        }
    }
    _seatarr=[NSMutableArray arrayWithArray:array];
    
    
    seatname=_seatDatadict[@"seatTypeName"];
    seatprice1=[NSString stringWithFormat:@"￥%@",_seatDatadict[@"price"]];

    _array = [[NSMutableArray alloc] init];
    insurearray=[[NSMutableArray alloc] init];
    projectarray=[[NSMutableArray alloc] init];
    costarray=[[NSMutableArray alloc] init];
    NSArray * na =@[@"1",@"2",@"3"];
    numarray=[NSMutableArray arrayWithArray:na];
    
    isa=YES;
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"TpubAndpri"] isEqualToString:@"1"]&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]){
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
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(backAndnext:) forControlEvents:UIControlEventTouchUpInside];
    backbut.tag=666;
    [view addSubview:backbut];
    
    UIView * view3= [[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60)];
    view3.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    //UIButton * pricebut  =[[UIButton alloc]initWithFrame:CGRectMake(20,8,120, 44)];
    UIView * view31=[[UIView alloc]initWithFrame:CGRectMake(20,8,140, 44)];
    view31.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0,22,40, 16)]];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
    pricela =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(33,8,90, 40)]];
    pricela.textAlignment=NSTextAlignmentLeft;
    pricela.font=[UIFont systemFontOfSize:18];
   
    if(_menarray.count!=0){
        NSString *s = [NSString stringWithFormat:@"￥%.1f",([_seatDatadict[@"price"] floatValue]+b)*(long)_menarray.count];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }else{
        NSString *s = [NSString stringWithFormat:@"￥%.1f",[_seatDatadict[@"price"] floatValue]+b];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }
    
    pricela.textColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [view31 addSubview:pricela];
    
//UILabel * pla =[[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(105,22,40,16)]];
    
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
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF4:)];
    [view31 addGestureRecognizer:tap4];
    UIButton * nextbut  =[[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-100,8,90, 44)];
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
-(void)showGF4:(UITapGestureRecognizer*)tap4{
    [UIView animateWithDuration:0.01 animations:^{
       _Bottomconnetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
       view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
    }completion:nil];
}
-(void)showGFtab:(UITapGestureRecognizer *)tab{
    [UIView animateWithDuration:0.01 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
}
-(void)showGFtab1:(UITapGestureRecognizer *)tab1{
    
    [UIView animateWithDuration:0.01 animations:^{
        _tgconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [UIView animateWithDuration:0.02 animations:^{
        _tgconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
    [UIView animateWithDuration:0.02 animations:^{
        _JTconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    }completion:nil];
    
    [UIView animateWithDuration:0.02 animations:^{
        _Bottomconnetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        view4.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 60);
    }completion:nil];
}

-(void)loadData1{
    
    TGQApproveQuery * tgq = [TGQApproveQuery new ];
    tgq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tgq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    
    [Train TGQApproveQuery:tgq success:^(id data) {
        //   NSLog(@"%@",data);
        tglabel1.text=data[@"data"];
        
    } failure:^(NSError *error) {
    }];
    // 服务费
    TrainServiceFeeQuery * tsf =[TrainServiceFeeQuery new];
    tsf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    tsf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    tsf.ticketPrice=[NSString stringWithFormat:@"%.1f",[_seatDatadict[@"price"] floatValue]];
    [Train TrainServiceFeeQuery:tsf success:^(id data) {
        if([data[@"status"] isEqualToString:@"T"]){
            freeprice1str= (NSString*)data[@"trainServicePrice"];
            b=[freeprice1str intValue];
            NSLog(@"%@",_menarray);
            if(_menarray.count!=0){
                NSString *s = [NSString stringWithFormat:@"￥%.1lf",([_seatDatadict[@"price"] floatValue]+b)*(long)_menarray.count];
                UIFont *font = [UIFont fontWithName:@"Arial" size:20];
                CGSize size = CGSizeMake(320,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
                pricela.text=s;
            }else{
                NSString *s = [NSString stringWithFormat:@"￥%.1f",[_seatDatadict[@"price"] floatValue]+b];
                UIFont *font = [UIFont fontWithName:@"Arial" size:20];
                CGSize size = CGSizeMake(320,2000);
                CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
                [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
                pricela.text=s;
            }
            free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
        }
        [_tableView reloadData];
    } failure:^(NSError *error) {
    } ];
    //项目
    ProjectQueryRequest *  project =[ProjectQueryRequest new];
    project.Start =0;
    project.Count=100;
    project.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    project.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic ProjectQueryRequest:project success:^(id data) {
       // NSLog(@"%@",data);
        projectarray=data[@"projectList"];
        projectNo=projectarray[0][@"projectNo"];
        projectName=projectarray[0][@"projectName"];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
    }];
    //成本中心
    CostCenterQueryRequest * cost = [CostCenterQueryRequest new];
    cost.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    cost.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic CostCenterQueryRequest:cost success:^(id data) {
        NSLog(@"%@",data);
        costarray=data[@"costList"];
        costName=costarray[0][@"costName"];
        costNo=costarray[0][@"costNo"];
        [_tableView reloadData];
    } failure:^(NSError *error) {
    }];
}
-(void)backAndnext:(UIButton*)but{
    if(but.tag==888){
         if (_count<_menarray.count) {
             [UIAlertView showAlertWithTitle:@"乘机人数多于剩余票数，请重新预定"];
            }else{
                [SVProgressHUD showWithStatus:@"正在加载"];
                [SVProgressHUD show];
                TrainOrder * order  = [TrainOrder new];
                order.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
                order.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
                //NSLog(@"%@",_trainDatadict);
                if(![_trainDatadict[@"arriveDays"] isEqualToString:@"0"]){
                    int d= [_trainDatadict[@"arriveDays"] intValue];
                    NSDateFormatter *dateFormatter1= [[NSDateFormatter alloc] init];
                    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
                    NSDate*hDate;
                    NSDate * hde;
                    NSString*result1;
                    //由 NSString转换为 NSDate
                    hDate = [dateFormatter1 dateFromString:_requtstdict[@"dataOut"]];
                    hde=[NSDate dateWithTimeInterval:d*24*60*60 sinceDate:hDate];
                    //由 NSDate转换为 NSString
                    result1 = [dateFormatter1 stringFromDate:hde];
                    order.ArrivalsDate=result1;
                }else{
                    order.ArrivalsDate=_requtstdict[@"dataOut"];;
                }
                order.ProjectRmk=projectRmk;
                order.ArrivalsTime=_trainDatadict[@"arriveTime"];
                order.ContactName=menla.text;
                order.CostCode=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"costCenterCode"];
                order.FromStationCode=(NSString*)_trainDatadict[@"fromStationCode"];
                order.FromStationName=_trainDatadict[@"fromStationName"];
                order.Matter=@"";
                order.ApprovalId=@"";
                order.Mobile=numeberla.text;
                order.ToStationCode=_trainDatadict[@"toStationCode"];
                order.ToStationName=_trainDatadict[@"toStationName"];
                order.TrainDate=_requtstdict[@"dataOut"];
                order.TrainNum=_trainDatadict[@"trainCode"];
                order.TrainTime=_trainDatadict[@"startTime"];
                order.ViolationReason=@"";
                order.ProjectId=projectNo;
                
                voModel * vo = [voModel new];
                vo.ViolationItemCode=@"";
                vo.ViolationItemReason=@"";
                order.Violations=vo.mj_keyValues;
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
                    order.TripType=@"1";
                    order.ViolationReason=_erromes;
                    order.ProjectId=projectNo;
                    voModel * vo = [voModel new];
                    vo.ViolationItemCode=_erroID;
                    vo.ViolationItemReason=_erroMessage;
                    order.Violations=vo.mj_keyValues;
                }else{
                    order.TripType=@"2";
                }
                NSMutableArray * arr1=[NSMutableArray array];
                for (NSMutableDictionary * dic in _menarray) {
                    TrainPassengerList * passnger = [TrainPassengerList new];
                    if (_username_12306!=nil) {
                        passnger.UserName=_username_12306;
                        passnger.password=_pssageWord_12306;
                    }
                    passnger.TicketType=@"1";
                    passnger.SeatCode=_seatDatadict[@"seatCode"];
                    passnger.Price=[[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue] ;
                    passnger.PassportTypeId=@"1";
                    passnger.PassportNo=dic[@"certNo"];
                    passnger.PassengerName=dic[@"empName"];
                    passnger.PassengerId=dic[@"empId"];
                    [arr1 addObject:passnger];
                };
                order.TrainPassengerList =[TrainPassengerList mj_keyValuesArrayWithObjectArray:arr1];
                [Train TrainOrder:order success:^(id data) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@",data);
                    if([data[@"status"] isEqualToString:@"T"]){
                        TraincheckVC * tcvc =[TraincheckVC new];
                        tcvc.bookTicketList=data[@"trainOrderList"][0][@"orderNo"];
                        tcvc.trainDatadict=_trainDatadict;
                        tcvc.seatDatadict=_seatDatadict;
                        tcvc.menarr=_menarray;
                        tcvc.StopOverarr=_StopOverarr;
                    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
                        if([_gxlabeltext isEqualToString:@"合规"]){
                          tcvc.Voitm=@"";
                          tcvc.Voreson=@"";
                            if (projectRmk.length==0) {
                                tcvc.project=projectName;
                            }else{
                                tcvc.project=projectRmk;
                            }
                          tcvc.cencer=costName;
                        }else{
                         tcvc.Voitm=_erromes;
                         tcvc.Voreson=_erroMessage;
                            if (projectRmk.length==0) {
                                tcvc.project=projectName;
                            }else{
                                tcvc.project=projectRmk;
                            }
                            tcvc.cencer=costName;
                            }
                    }
                        tcvc.pricestr=[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""];
                        tcvc.freeprice=[NSString stringWithFormat:@"%d",b];
                        [self.navigationController  pushViewController:tcvc animated:YES];
                    }else{
                        [UIAlertView showAlertWithTitle:data[@"message"]];
                    }
                } failure:^(NSError *error) {
                    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
                }];
            }
    }else{
        [AlertViewManager alertWithTitle:@"温馨提示" message:@"您是否确定退出？" textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
            if (index==1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
}
#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-122) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
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
    tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[_seatDatadict[@"price"] floatValue],_menarray.count];
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
    free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
    [view4 addSubview:free];
    [free mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(30);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
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
    
    _JTconnetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _JTconnetview.backgroundColor=[UIColor blackColor];
    _JTconnetview.alpha=0.7;
    [self.view  addSubview:_JTconnetview];
    UIView * taview =[[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 150, 375, 20)]];
    UILabel * label = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(152, 0, 73, 20)]];
    label.text=@"经停信息";
    label.font=[UIFont systemFontOfSize:15];
    label.adjustsFontSizeToFitWidth=YES;
    label.textColor=[UIColor whiteColor];
    [taview addSubview:label];
    [_JTconnetview addSubview:taview];
    
    _tableView1= [[UITableView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 215, 375, 250)] style:UITableViewStylePlain];
    _tableView1.backgroundColor=[UIColor blackColor];
    // _tableView1.alpha=0.7;
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.bounces=NO;
    UITapGestureRecognizer *tab = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab:)];
    [_tableView1 addGestureRecognizer:tab];
    _tableView1.separatorStyle = UITableViewCellSelectionStyleNone;
    [_JTconnetview addSubview:_tableView1];

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
    scrollView.contentSize = CGSizeMake(355/SCREEN_RATE, 1000/SCREEN_RATE1);;
    [scrollView addSubview:tglabel1];
    UITapGestureRecognizer *tab1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtab1:)];
    [scrollView addGestureRecognizer:tab1];
    [_tgconnetview addSubview:scrollView];
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
            seatprice1=seatprice;
            [_tableView reloadData];
            break;
        default:
            break;
    }
}
-(void)chick{
    [UIView animateWithDuration:0.01 animations:^{
        self.tabBarController.tabBar.hidden=YES;
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
    //NSLog(@"%@",_arr[0][@"costName"]);
    
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
        }else if(_arr[row][@"seatTypeName"]!=nil){
            if([_arr[row][@"count"] isEqualToString:@"有"]||[_arr[row][@"count"] isEqualToString:@"无"]){
            
                return [NSString stringWithFormat:@"%@    ￥%.1f    %@",_arr[row][@"seatTypeName"],[_arr[row][@"price"] floatValue],_arr[row][@"count"]];
            }else{
                return [NSString stringWithFormat:@"%@    ￥%.1f    余%@张",_arr[row][@"seatTypeName"],[_arr[row][@"price"] floatValue],_arr[row][@"count"]];

            }
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
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
//    [pickerView selectRow:0 inComponent:0 animated:NO];

    if ([_arr[rowOne] isKindOfClass:[NSDictionary class]]) {
        if(_arr[rowOne][@"projectName"]!=nil){
            //seatstring = _arr[rowOne][@"projectName"];
            projectNo=_arr[rowOne][@"projectNo"];
            projectName=_arr[rowOne][@"projectName"];;
//            [_tableView reloadData];
            
        }else if(_arr[rowOne][@"costName"]!=nil){
            //seatstring = _arr[rowOne][@"costName"];
            costName=_arr[rowOne][@"costName"];
            costNo=_arr[rowOne][@"costNo"];
//            [_tableView reloadData];
            
        }else if(_arr[row][@"seatTypeName"]!=nil){
            if(![_arr[row][@"count"] isEqualToString:@"0"]){
                if (![_arr[row][@"count"] isEqualToString:@"有"]) {
                    if ([_arr[row][@"count"] intValue]<_menarray.count) {
                        butchange.userInteractionEnabled=NO;
                        [UIAlertView showAlertWithTitle1:@"剩余票数不足，请重新选择座位!" duration:1.5];
                    }else{
                        butchange.userInteractionEnabled=YES;
                        seatname=_arr[row][@"seatTypeName"];
                        seatprice=[NSString stringWithFormat:@"￥%@",_arr[row][@"price"]];
                        if(_menarray.count!=0){
                            pricela.text=[NSString stringWithFormat:@"￥%.1lf",([_arr[row][@"price"] floatValue]+b)*(long)_menarray.count];
                        }else{
                            pricela.text=[NSString stringWithFormat:@"￥%.1f",([_arr[row][@"price"] floatValue]+b)];
                        }
                        tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[_arr[row][@"price"] floatValue],_menarray.count];
  
                    }
                }else{
                    butchange.userInteractionEnabled=YES;

                    seatname=_arr[row][@"seatTypeName"];
                    seatprice=[NSString stringWithFormat:@"￥%@",_arr[row][@"price"]];
                    if(_menarray.count!=0){
                        pricela.text=[NSString stringWithFormat:@"￥%.1lf",([_arr[row][@"price"] floatValue]+b)*(long)_menarray.count];
                    }else{
                        pricela.text=[NSString stringWithFormat:@"￥%.1f",([_arr[row][@"price"] floatValue]+b)];
                    }
                    tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[_arr[row][@"price"] floatValue],_menarray.count];
                }
            }
        }
        else{
            seatstring = _arr[row][@"reasonName"];
            _erroMessage= seatstring;
        }
    }
    else{
        
    }
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 if([tableView isEqual:_tableView]){

    if(section==2){
        return 40;
    }else if(section==3){
        return 10;
    }
    else{
        return 0.01;
    }
 }else{
        return 30/SCREEN_RATE1;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
     if([tableView isEqual:_tableView]){
    if (section==2) {
        return 40;
    }else{
        return 10;
    }
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
        return view;
    }
    else if(section==2){
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
    }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }}else{
        return 0;
    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
if([tableView isEqual:_tableView]){
 
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
    else if(section==2){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(35, 10, 52, 16)];
        menlabel.text=@"乘车人";
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        UIButton * butchangeman = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-120, 5, 100,30)];
        [butchangeman.layer setMasksToBounds:YES];
        [butchangeman.layer setCornerRadius:10.0];
        butchangeman.titleLabel.font=[UIFont systemFontOfSize:13];
        [butchangeman addTarget:self action:@selector(changmenclick:) forControlEvents:UIControlEventTouchUpInside];
        [butchangeman setTitle:@"选择乘车人" forState:UIControlStateNormal];
        [butchangeman setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [butchangeman setBackgroundColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1]];
        [view addSubview:butchangeman];
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TYw"]isEqualToString:@"1"]) {
                butchangeman.hidden=YES;
            }
        }
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
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
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  if([tableView isEqual:_tableView]){
    if(isa==YES){
        if(indexPath.section==1||indexPath.section==4||indexPath.section==5){
            return 60;
        }else if(indexPath.section==0){
            return 144;
        }else if(indexPath.section==6){
            return 0.01;
        }else if(indexPath.section==3){
            return 60;
        }else{
            return 80;
        }
    }else{
        if(indexPath.section==1||indexPath.section==4||indexPath.section==5){
            return 60;
        }else if(indexPath.section==0){
            return 144;
        }else if(indexPath.section==6){
            return 60;
        }else if(indexPath.section==3){
            return 60;
        }else{
            return 80;
        }
    }}else{
        return 30/SCREEN_RATE1;
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
        return 1;
    }
    else if(section==2){
        return _menarray.count;
    }
    else if(section==6){
            return 2;
    }else{
        return 1;
    }
}else{
    return _StopOverarr.count;
    }
}
//创建cell
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
if([tableView isEqual:_tableView]){
    if(indexPath.section==0){
        trainorder0 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (trainorder0 *)[[[NSBundle  mainBundle]  loadNibNamed:@"trainorder0" owner:self options:nil]  lastObject];
        }
        cell.delegate=self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.Pricetitle.hidden=YES;
        cell.pricelabel.hidden=YES;
        cell.freetitle.hidden=YES;
        cell.freeprice.hidden=YES;
        
//        NSLog(@"%@",_trainDatadict);
//        NSLog(@"%@",_seatDatadict);
//        cell.ratinimage.image=[UIImage imageNamed:@"railway"];
        
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
        [cell.jtbutton setTitleColor:UIColorFromRGBA(0x0075c2, 1.0) forState:UIControlStateNormal];
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
 
    }else if(indexPath.section==2){
        order2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order2Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order2Cell" owner:self options:nil]  lastObject];
        }
        cell.delegate=self;
        cell.cellbut.hidden=YES;
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
        return cell;
    }else if(indexPath.section==4||indexPath.section==5){
        order4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order4Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order4Cell" owner:self options:nil]  lastObject];
        }
        if (isa==YES) {
            cell.hidden=YES;
        }
        if (indexPath.section==4){
            cell.titlelabel.adjustsFontSizeToFitWidth = YES;
            cell.costlabel.adjustsFontSizeToFitWidth = YES;
            cell.titlelabel.text=@"项目";
            if(deviceScreenWidth==320){
                cell.costlabel.font =[UIFont systemFontOfSize:13];
            }
            cell.costlabel.text=projectName;

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
    else if(indexPath.section==1){
        traincell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (traincell2 *)[[[NSBundle  mainBundle]  loadNibNamed:@"traincell2" owner:self options:nil]  lastObject];
        }
        cell.seatlabel.text=seatname;
        cell.price.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
        cell.price.text=seatprice1;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
        }
        if(indexPath.section==3){
            cell.MsszgeLabel.adjustsFontSizeToFitWidth=YES;
            cell.MsszgeLabel.textAlignment=NSTextAlignmentRight;
            cell.MsszgeLabel.textColor=UIColorFromRGBA(0x333333, 1.0);
            cell.MsszgeLabel.text=[NSString stringWithFormat:@"￥%@/人x%ld人        ",freeprice1str,(long)_menarray.count];
            cell.wblabel.text=@"服务费";
            cell.titleimage.image=[UIImage imageNamed:@"tips"];
        }else{
            if (isa==YES) {
            cell.hidden=YES;
            }else{
                if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"TYw"] isEqualToString: @"1"]) {
                if([_gxlabeltext isEqualToString:@"合规"]){
                    cell.hidden=YES;
                    }
                }else{
                   cell.hidden=YES; 
                }
            }
            if(indexPath.row==1){
            cell.MsszgeLabel.adjustsFontSizeToFitWidth=YES;
            cell.MsszgeLabel.text=_erroMessage;
            cell.titleimage.hidden=YES;
            }else{
                cell.MsszgeLabel.adjustsFontSizeToFitWidth=YES;
                cell.wblabel.text=@"违背事项";
                cell.MsszgeLabel.text=_erromes;
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
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
//取消选中效果
//cell.selectionStyle = UITableViewCellSelectionStyleNone;
}
//点击cell触发此方法
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   //获取cell的方法
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"cell.textLabel.text = %@",cell.textLabel.text);
    if(indexPath.section==4){
//        [self loadPickerData:projectarray];
//        [self chick];

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
        
    }else if(indexPath.section==5){
        [self loadPickerData:costarray];
        [self chick];
    }
    else if(indexPath.section==1){
        [self loadPickerData:_seatarr];
        [self chick];
    }else if(indexPath.section==6){
        if (indexPath.row==1||indexPath.row==3) {
            [self loadPickerData:_errArray];
            [self chick];
        }
    }else if(indexPath.section==2){
        if(a==3){
            [self loadPickerData:numarray];
            [self chick];
        }
    }else{
    }
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
-(void)changmenclick:(UIButton*)send{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=2;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
        _menarray=array;
       // NSLog(@"%@",_menarray);
        
        NSString *s = [NSString stringWithFormat:@"￥%.1f",([[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue]+b)*(long)_menarray.count];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
        
        tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue],_menarray.count];
        free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
    
        [_tableView reloadData];
        [_tableView1 reloadData];

    };
    //[self.navigationController pushViewController:changmen animated:YES];
    [self presentViewController:changmen animated:YES completion:nil];
}
-(void)changmenclick1{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=2;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
        _menarray=array;
        // NSLog(@"%@",_menarray);
        
        NSString *s = [NSString stringWithFormat:@"￥%.1f",([[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue]+b)*(long)_menarray.count];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(375/SCREEN_RATE,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
        
        tprice.text=[NSString stringWithFormat:@"票价:￥%.1f元/人     人数%ld",[[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue],_menarray.count];
        free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
        
        [_tableView reloadData];
        [_tableView1 reloadData];
        
    };
    //[self.navigationController pushViewController:changmen animated:YES];
    [self presentViewController:changmen animated:YES completion:nil];
}


-(void)DeleatbutClick:(order2Cell *)cell{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"TpubAndpri"] isEqualToString:@"1"]) {
        if (_menarray.count==1) {
            [AlertViewManager alertWithTitle:@"温馨提示"
                                     message:@"已经是最后一位乘车人，删除后将重新查询，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                         if (index==1) {
                                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];

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
                                     message:@"已经是最后一位乘车人，删除后将重新选择乘车人，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
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
    
        if(_menarray.count!=0){
        NSString *s = [NSString stringWithFormat:@"￥%.1lf",([[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue]+b)*(long)_menarray.count];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(320,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }else{
        NSString *s = [NSString stringWithFormat:@"￥%.1f",[[seatprice1 stringByReplacingOccurrencesOfString:@"￥" withString:@""] floatValue]+b];
        UIFont *font = [UIFont fontWithName:@"Arial" size:20];
        CGSize size = CGSizeMake(320,2000);
        CGSize labelsize = [s sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
        [ pricela setFrame:CGRectMake(33,15, labelsize.width, 20)];
        pricela.text=s;
    }
    free.text=[NSString stringWithFormat:@"服务费:￥%d元/人   人数%ld",b,_menarray.count];
}
-(void)changLmen:(UIButton*)send{
    contactVC * contact =[contactVC new];
    contact.block=^(NSMutableArray * contactarr1){
        _contactarray=contactarr1;
        [_tableView reloadData];
    };
    //[self.navigationController pushViewController:contact animated:YES];
    [self presentViewController:contact animated:YES completion:nil];
}

@end
