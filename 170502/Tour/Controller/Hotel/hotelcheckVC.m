//
//  hotelcheckVC.m
//  Tour
//
//  Created by Euet on 17/1/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelcheckVC.h"
#import "HorderCell.h"
#import "checkCell.h"
#import "hotelOrderSucessVC.h"
#import "hCheckone.h"
#import "hChecktwo.h"
@interface hotelcheckVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    //蒙版视图
    UIView * _connetview;
    UITableView * _tableView1;
    
    NSMutableDictionary * dict;
    NSMutableDictionary * Messagedict;
    NSMutableArray * mendata;
    
    NSMutableArray * trainbox;
    
    
    UILabel * statuslabel;
    
    UIButton * nextbut;
    UIButton * pricebut;
    NSString * _orderstring;
    UILabel * salePrice;
    UILabel * airconFee;
    NSString * statusstr;
    
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
    
}
@property (nonatomic, strong) hCheckone*ViewOne;  //实例化一个VView的对象
@property (nonatomic, strong) hChecktwo*ViewTwo;  //实例化一个VView的对象
@end

@implementation hotelcheckVC

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
    statusstr=@"";
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
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:CGRectMake(0,22,40, 16)];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
   pricela =[[UILabel alloc]initWithFrame:CGRectMake(33,8,90, 40)];
   pricela.adjustsFontSizeToFitWidth=YES;
   pricela.text=_roomprice;
   pricela.textColor=[UIColor colorWithRed:239/255.0 green:175/255.0 blue:41/255.0 alpha:1];
    [view31 addSubview:pricela];
    UILabel * pla =[[UILabel alloc]initWithFrame:CGRectMake(90,22,40,16)];
    pla.text=@"元";
    pla.font= [UIFont systemFontOfSize:14];
    pla.textColor=[UIColor whiteColor];
    [view31 addSubview:pla];
    plaimage =[[UIImageView alloc]initWithFrame:CGRectMake(111,24,14,13)];
    plaimage.image=[UIImage imageNamed:@"show_money"];
    [view31 addSubview:plaimage];
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
    //价详情蒙版
    _connetview1=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview1.backgroundColor=[UIColor blackColor];
    _connetview1.alpha=0.7;
    [self.view  addSubview:_connetview1];
    /* 票价详情*/
    view4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    tprice=[UILabel new];
    tprice.text=_tprice;
    tprice.textAlignment=NSTextAlignmentCenter;
    tprice.adjustsFontSizeToFitWidth=YES;
    [view4 addSubview:tprice];
    [tprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    free=[UILabel new];
    free.textAlignment=NSTextAlignmentCenter;
    free.adjustsFontSizeToFitWidth=YES;
    free.text=_free;
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
    _tableView1= [[UITableView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 160) style:UITableViewStyleGrouped];
    _tableView1.dataSource=self;
    _tableView1.delegate=self;
    _tableView1.alpha=1;
    _tableView1.userInteractionEnabled = NO;
    //_tableView1.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_tableView1];
}
-(void)showGF5:(UITapGestureRecognizer*)tap5{
    [UIView animateWithDuration:0.5 animations:^{
        _connetview1.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
        view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
    }completion:nil];
    
}
-(void)loadData{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    HotelOrderInfQuery * inf = [HotelOrderInfQuery new];
    inf.OrderNo=_orderstring;
    inf.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    inf.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Hotel HotelOrderInfQuery:inf success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            Messagedict=data;
            if(![Messagedict[@"approverStatusName"] isEqualToString:@"无需审批"]){
                nextbut.hidden=NO;
                 statusstr=[NSString stringWithFormat:@"%@|待审批",data[@"orderStatus"]];
                [nextbut setTitle:@"送审" forState:UIControlStateNormal];
            }else{
                if ([_payType isEqualToString:@"0"]) {
                    nextbut.hidden=NO;
                    [nextbut setTitle:@"下一步" forState:UIControlStateNormal];
                    statusstr=[NSString stringWithFormat:@"%@|未支付",data[@"orderStatus"]];
                }else{
                    nextbut.hidden=NO;
                    [nextbut setTitle:@"支付" forState:UIControlStateNormal];
                    statusstr=[NSString stringWithFormat:@"%@|未支付",data[@"orderStatus"]];
//                   statusstr=@"未支付";
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
        
        [AlertViewManager alertWithTitle:@"温馨提示" message:@"您是否确定退出？" textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
            if (index==1) {
                [self.navigationController popToRootViewControllerAnimated:NO];
 
            }
        }];
//        //[self.navigationController popViewControllerAnimated:NO];
//        FirstViewController * vc =[FirstViewController new ];
//        vc.tabBarController.tabBar.hidden=NO;
//        [self.navigationController pushViewController:vc animated:NO];
    }else{
        if([nextbut.titleLabel.text isEqualToString:@"送审"]){
            [SVProgressHUD showWithStatus:@"正在加载"];
            [SVProgressHUD show];
            ApproveApplyRequest * approve =[ApproveApplyRequest new];
            approve.OrderNo=_orderstring;
            approve.OrderType=@"JD";
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
                        HotelorderList * fvc =[HotelorderList new];
                        fvc.back=1;
                    [self.navigationController pushViewController:fvc animated:YES] ;
                    }]];
                    //[self.navigationController pushViewController:alertController animated:YES] ;
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            // NSLog(@"%@",data);
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络设置"] duration:1.0];
            }];
        }else if([nextbut.titleLabel.text isEqualToString:@"下一步"]){
            hotelOrderSucessVC * hsvc = [hotelOrderSucessVC new];
                    hsvc.price=pricela.text;
                    hsvc.orderno=_orderstring;
                    [self.navigationController  pushViewController:hsvc animated:YES];

        }else{
            PayVC * pay  = [PayVC new];
            pay.BusinessType=@"17";
            pay.hotelname=_hotelname;
            pay.hotelid = _hotelid;
            pay.roomprice= pricela.text;
            pay.roomname=_roomname;
            pay.roommess=_roommess;
            pay.RatePlanId=_RatePlanId;
            pay.inhoteldate=_inhoteldate;
            pay.outhoteldate=_outhoteldate;
            pay.orderstring=_orderstring;
//            pay.Hprice=[_roomprice stringByReplacingOccurrencesOfString:@"￥" withString:@""];
            pay.meshprice=tprice.text;
            pay.meshfreeprice=_free;
            pay.Hprice=Messagedict[@"totalPrice"];
            NSLog(@"%@",pay.Hprice);
            [self.navigationController pushViewController:pay animated:YES];
           // [self presentViewController:pay animated:YES completion:nil];
        }
    }
}
#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 110, deviceScreenWidth, deviceScreenHeight-180) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
    //判断因公因私
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
        _ViewOne = [[hCheckone alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth*SCREEN_RATE1, 120)]];
        [_ViewOne initView];
        _ViewOne.priject.text=_project;
        _ViewOne.concent.text=_cencer;
        _ViewOne.violateItem.text=_Voitm;
        _ViewOne.violateReason.text=_Voreson;
        
        _ViewTwo = [[hChecktwo alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, deviceScreenWidth*SCREEN_RATE1, 120)]];
        [_ViewTwo initView];
        _ViewTwo.priject.text=_project;
        _ViewTwo.concent.text=_cencer;
        //判断是否开启差旅标准
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]isEqualToString:@"1"]) {
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
    return 0;
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
        return 0;
    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{    if([tableView isEqual:_tableView]){
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"order_number"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(45, 10, 160, 16)];
        menlabel.text=[NSString stringWithFormat:@"订单号:%@",_orderstring];
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        statuslabel = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth-115, 10, 120,20)];
        statuslabel.font=[UIFont systemFontOfSize:13];
        statuslabel.textAlignment=NSTextAlignmentCenter;
        statuslabel.text=statusstr;
        statuslabel.textColor=UIColorFromRGBA(0x0075c2, 1.0);
        [view addSubview:statuslabel];
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(10, 0, deviceScreenWidth, 40)];
        view.backgroundColor=[UIColor whiteColor];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(45, 10, 54/SCREEN_RATE, 20)];
        menlabel.text=@"入住人";
        menlabel.font = [UIFont systemFontOfSize:13];
        menlabel.textColor=[UIColor blackColor];
//        UILabel * menlabel1 =[[ UILabel alloc]initWithFrame:CGRectMake(140, 10, 150, 16)];
        UILabel * menlabel1 =[[ UILabel alloc]init];
        menlabel1.text=[NSString stringWithFormat:@"成人%ld人 ",_menarr.count];
        menlabel1.textColor=UIColorFromRGBA(0x999999, 1.0);
        menlabel1.font = [UIFont systemFontOfSize:13];
        [view addSubview:menlabel];
        [view addSubview:menlabel1];
        [menlabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(menlabel.mas_right).with.offset(15);
            make.top.equalTo(view).offset(10);
            make.height.offset(18);
            make.width.offset(150);
        }];
        return view;
    }else{
        return 0;
    }
}else if ([tableView isEqual:_tableView1]){
    return 0;
}else{
    return 0;
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
            if(_roommess.length==0){
                return 100;
            }else{
                return 130;
            }
        }else{
            return  60;
        }
    }else if ([tableView isEqual:_tableView1]){
        if(indexPath.section==0){
            if(_roommess.length==0){
                return 100;
            }else{
                return 130;
            }
        }else{
            return  0;}
    }else{
        return 0;
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
        return 0;
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
        return 0;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableView]){
        if(indexPath.section==0){
            HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];

            if (!cell) {
                cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
            }
            cell.hotelnamelabel.text=_hotelname;
            cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
            cell.roomname.text=_roomname;
            cell.roomname.adjustsFontSizeToFitWidth=YES;
            if (_roommess.length==0) {
                cell.hotelmess.textColor=[UIColor blackColor];
                if ([_payType isEqualToString:@"0"]) {
                    cell.hotelmess.text=@"到店付";
                    cell.hotelmess.textColor=[UIColor blackColor];
                    cell.hotelmess.font=[UIFont systemFontOfSize:14];
                }else{
                    cell.hotelmess.text=@"在线付";
                    cell.hotelmess.textColor=[UIColor blackColor];
                    cell.hotelmess.font=[UIFont systemFontOfSize:14];
                }
                cell.address.text=@"";
            }else{
                cell.hotelmess.text=_roommess;
                cell.hotelmess.textColor=[UIColor grayColor];
                cell.hotelmess.adjustsFontSizeToFitWidth=YES;
               
                if ([_payType isEqualToString:@"0"]) {
                    cell.address.text=@"到店付";
                    cell.address.textColor=[UIColor blackColor];
                    cell.address.font=[UIFont systemFontOfSize:14];
                }else{
                    cell.address.text=@"在线付";
                    cell.address.textColor=[UIColor blackColor];
                    cell.address.font=[UIFont systemFontOfSize:14];
                }
            }
            
            
            NSDate * d1=  [LGLCalendarDate dateFromString:_inhoteldate];
            
            NSDate * d2=  [LGLCalendarDate dateFromString:_outhoteldate];
            
            NSInteger h=[weekday getDaysFrom:d1 To:d2];
            
            cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共%ld晚",_inhoteldate,_outhoteldate,h];
            
            cell.datelabel.adjustsFontSizeToFitWidth=YES;
            cell.datelabel.font=[UIFont systemFontOfSize:12];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
                        return cell;
        }else{
            checkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
            if (!cell) {
                //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
                cell= (checkCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"checkCell" owner:self options:nil]  lastObject];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.namelabel.text =_menarr[indexPath.row][@"empName"];
           
            NSString * str=@"";
           
            if([_menarr[indexPath.row][@"certType"] isEqualToString:@"NI"]){
                str=@"身份证";
                cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,[secretNum IdCardtest:_menarr[indexPath.row][@"certNo"]]];

            }else if ([_menarr[indexPath.row][@"certType"] isEqualToString:@"ID"]){
                str=@"护照";
                cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,[secretNum otherCardtest:_menarr[indexPath.row][@"certNo"]]];
            }else{
                str=@"其他";
                cell.cardandnumber.text =[NSString stringWithFormat:@"%@ %@",str,_menarr[indexPath.row][@"certNo"]];

            }
            return cell;
        }
    }else{
        HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!cell) {
            cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
        }
        cell.hotelnamelabel.text=_hotelname;
        cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
        cell.roomname.text=_roomname;
        cell.roomname.adjustsFontSizeToFitWidth=YES;
        cell.hotelmess.text=_roommess;
        cell.hotelmess.textColor=[UIColor grayColor];
        cell.hotelmess.adjustsFontSizeToFitWidth=YES;
        NSDate * d1=  [LGLCalendarDate dateFromString:_inhoteldate];
        
        NSDate * d2=  [LGLCalendarDate dateFromString:_outhoteldate];
        
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        
        cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共%ld晚",_inhoteldate,_outhoteldate,h];
        
        cell.datelabel.adjustsFontSizeToFitWidth=YES;
        cell.datelabel.font=[UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//     cell.fromdata.text=[_trainDatadict[@"trainStartDate"] substringFromIndex:5];
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
            [UIView animateWithDuration:1.0 animations:^{
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
    [UIView animateWithDuration:1.0 animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        _tableView1.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 160);
    }completion:nil];
    
    [UIView animateWithDuration:1.0 animations:^{
        _connetview1.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        view4.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 60);
    }completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
