//
//  hotelorderVC.m
//  Tour
//
//  Created by Euet on 17/1/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelorderVC.h"
#import "HorderCell.h"
#import "order2Cell.h"
#import "order4Cell.h"
#import "order5Cell.h"
#import "CheckInInfo.h"
#import "CheckInRoomList.h"
#import "Linkinfo.h"
#import "PsgInfoList.h"
#import "hotelcheckVC.h"
#import "hotelOrderSucessVC.h"
#import "HotelorderList.h"
#import "DbViewController.h"
#import "projectChangeVC.h"
@interface hotelorderVC ()<order2CellDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource, UIPickerViewDelegate>
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
    
    //入住天数
    NSInteger w;
    //服务价格
    int a;
    //房间数
    NSString * b;
    NSMutableArray * numarray;

    //最晚时间
    NSString * lasttime;
    NSMutableArray * lasttimeArr;

    
    UILabel * pricela;
    UIImageView* plaimage;
    //价格详情
    UIView * view4;
    UIView* _connetview;
    UILabel * mennum;
    UILabel * free;
    UILabel * tprice;
    
    BOOL isa;
    //用于判断是否显示担保
    BOOL Dbshow;
}
@end

@implementation hotelorderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",_menarray);
    
    [self initview];
    [self loadData1];
    [self Tabview];
    [self creattable];
}
#pragma mark -初始化
-(void)initview{
    //NSLog(@"%@",_dataArray );
    // NSLog(@"%@",_cabinArray );
    // _dataArray=[NSMutableArray array];
    _array = [[NSMutableArray alloc] init];
    insurearray=[[NSMutableArray alloc] init];
    projectarray=[[NSMutableArray alloc] init];
    costarray=[[NSMutableArray alloc] init];
    NSArray * num =@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    numarray=[NSMutableArray arrayWithArray:num];
    NSArray * time1 =@[@"20:00",@"23:59",@"06:00"];
    lasttimeArr=[NSMutableArray arrayWithArray:time1];
    
    isa=YES;
    Dbshow=NO;
    b=@"1";
    NSDate * d1=  [LGLCalendarDate dateFromString:_inhoteldate];
    
    NSDate * d2=  [LGLCalendarDate dateFromString:_outhoteldate];
    
    w=[weekday getDaysFrom:d1 To:d2];
   
    lasttime=@"20:00";
    
if (_menarray.count==0) {
        _menarray= [NSMutableArray new];
        NSMutableDictionary * mendict = [NSMutableDictionary new];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"empName"] forKey:@"empName"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certNo"] forKey:@"certNo"];
        [mendict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"userInf"][@"empList"][0][@"certType"] forKey:@"certType"];
        [_menarray addObject:mendict];
        [_tableView reloadData];
    }
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
        isa=NO;
    }
    
    if ([_payType isEqualToString:@"0"]) {
        if (_rucode!=nil) {
            Dbshow=YES;
        }
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
    UILabel * pricebutlabel =[[UILabel alloc]initWithFrame:CGRectMake(0,22,40, 16)];
    pricebutlabel.text=@"总价:";
    pricebutlabel.font= [UIFont systemFontOfSize:14];
    pricebutlabel.textColor=[UIColor whiteColor];
    [view31 addSubview:pricebutlabel];
    pricela =[[UILabel alloc]initWithFrame:CGRectMake(33,8,90, 40)];
    pricela.adjustsFontSizeToFitWidth=YES;
   
    pricela.text=[NSString stringWithFormat:@"￥%ld",[_roomprice intValue]*[b intValue]* w];
    
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
    
    [UIView animateWithDuration:1.0 animations:^{
        _connetview.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight-60);
        view4.frame=CGRectMake(0, deviceScreenHeight-60, deviceScreenWidth, 60);
    }completion:nil];
    
}
//点击屏幕触发此方法
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:1.0 animations:^{
        _connetview.frame=CGRectMake(0, deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
        view4.frame=CGRectMake(0, deviceScreenHeight,deviceScreenWidth , 60);
    }completion:nil];
}
-(void)loadData1{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    //项目
    ProjectQueryRequest *  project =[ProjectQueryRequest new];
    project.Start =0;
    project.Count=100;
    project.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    project.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic ProjectQueryRequest:project success:^(id data) {
        // NSLog(@"%@",data);
         [SVProgressHUD dismiss];
        projectarray=data[@"projectList"];
        projectNo=projectarray[0][@"projectNo"];
        projectName=projectarray[0][@"projectName"];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    //成本中心
    CostCenterQueryRequest * cost = [CostCenterQueryRequest new];
    cost.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    cost.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    [Basic CostCenterQueryRequest:cost success:^(id data) {
         [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        costarray=data[@"costList"];
        costName=costarray[0][@"costName"];
        costNo=costarray[0][@"costNo"];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)backAndnext:(UIButton*)but{
if(but.tag==888){
if(_menarray.count==0){
    [UIAlertView showAlertWithTitle1:@"你还没有填写入住人信息" duration:1.2];
}else{
    if([b intValue]>_menarray.count){
        [UIAlertView showAlertWithTitle:@"预订房间数目不得多于入住人数,请重新预定"];
    }else{
        [SVProgressHUD showWithStatus:@"正在加载"];
        [SVProgressHUD show];
        //  NSLog(@"%@",lasttime);
        HotelOrder * ho = [HotelOrder new];
        ho.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
        ho.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
        CheckInInfo *  cif =[CheckInInfo new];
        if([_payType isEqualToString:@"0"]){
            cif.FaceId=@"31200808";
        }else{
            cif.FaceId=@"31200820";
        }
        cif.RoomNum=b;
        cif.RatePlanId=_RatePlanId;
        cif.RoomId =_roomid;
        NSMutableArray * arr =[NSMutableArray new];
        CheckInRoomList * roomlist =[CheckInRoomList new];
        roomlist.RoomNum=b;
        NSMutableArray * arr1 =[NSMutableArray new];
        for (NSMutableDictionary * dict in _menarray) {
            PsgInfoList * pil = [PsgInfoList new];
            pil.Mobile=dict[@"mobile"];
            pil.Name=dict[@"empName"];
            pil.PassengerType=@"D";
            [arr1 addObject:pil];
        }
        roomlist.PsgInfoList =[PsgInfoList mj_keyValuesArrayWithObjectArray:arr1];
        [arr addObject:roomlist];
        cif.CheckInRoomList=[CheckInRoomList mj_keyValuesArrayWithObjectArray:arr];
        ho.CheckInInfo=cif;
        Linkinfo * lif =[Linkinfo new];
        lif.ContactName=menla.text;
        //lif.Email=@"67676887@qq.com";
        lif.Mobile=numeberla.text;
        ho.Linkinfo=lif;
        ho.CheckOutDate=_outhoteldate;
        ho.CheckInDate=_inhoteldate;
        ho.LatestArrTime=lasttime;
        ho.ViolationItem=_erromes;
        ho.ViolationReasonCode=_erroID;
        ho.ViolationReason=_erroMessage;
        ho.ProjectRmk=projectNo;
        if([lasttime isEqualToString:@"20:00"]){
            ho.EarliestArrTime=@"19:00";
        }else if ([lasttime isEqualToString:@"23:59"]){
            ho.EarliestArrTime=@"20:00";
        }else{
            ho.EarliestArrTime=@"06:00";
        }
        ho.CostCode=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"empList"][0][@"costCenterCode"];
        ho.IfGuarantee=@"N";
        ho.HotelId=_hotelid;
        //ho.Matters=@"";
        ho.OrderFrom=@"3120139014";
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
            ho.TripType=@"1";
            ho.ProjectId=projectNo;
        }else{
            ho.TripType=@"2";
        }
        [Hotel HotelOrder:ho success:^(id data1) {
            [SVProgressHUD dismiss];

            if ([data1[@"status"] isEqualToString:@"T"]) {
                hotelcheckVC * hcvc =[hotelcheckVC new];
                hcvc.hotelname=_hotelname;
                hcvc.hotelid = _hotelid;
                hcvc.roomprice= pricela.text;
                hcvc.roomname=_roomname;
                hcvc.roommess=_roommess;
                hcvc.RatePlanId=_RatePlanId;
                hcvc.inhoteldate=_inhoteldate;
                hcvc.outhoteldate=_outhoteldate;
                hcvc.bookTicketList =data1[@"orderNo"];
                hcvc.menarr=_menarray;
                // 价格详情
                hcvc.pricela=pricela.text;
                hcvc.tprice=tprice.text;
                hcvc.free=free.text;
                hcvc.payType=_payType;
                if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString:@"1"]){
                    if([_gxlabeltext isEqualToString:@"合规"]){
                        hcvc.Voitm=@"";
                        hcvc.Voreson=@"";
                        if (projectRmk.length==0) {
                            hcvc.project=projectName;
                        }else{
                            hcvc.project=projectRmk;
                        }
                        hcvc.cencer=costName;
                    }else{
                        hcvc.Voitm=_erromes;
                        hcvc.Voreson=_erroMessage;
                        if (projectRmk.length==0) {
                            hcvc.project=projectName;
                        }else{
                            hcvc.project=projectRmk;
                        }
                        hcvc.cencer=costName;
                    }
                }
                [self.navigationController  pushViewController:hcvc animated:YES];
                [UIAlertView showAlertWithTitle1:data1[@"message"] duration:1.2];
            }else{
                [UIAlertView showAlertWithTitle1:data1[@"message"] duration:1.2];
            }
        } failure:^(NSError *error) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
        }];
    }
}
    }else{
        [AlertViewManager alertWithTitle:@"温馨提示" message:@"您是否确定退出？" textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
            if (index==1) {
                [SVProgressHUD dismiss];
                [self.navigationController popViewControllerAnimated:NO];
              }
        }];
    }
}
#pragma mark -创建列表
-(void)creattable{
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, deviceScreenWidth, deviceScreenHeight-124) style:UITableViewStyleGrouped];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    _tableView.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:_tableView];
    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    view4 =[[UIView alloc]initWithFrame:CGRectMake(0, deviceScreenHeight, deviceScreenWidth, 60)];
    view4.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view4];
    tprice=[UILabel new];
    tprice.font=[UIFont systemFontOfSize:14];
    tprice.textAlignment=NSTextAlignmentCenter;
    tprice.text=[NSString stringWithFormat:@"房间价格:￥%d.0元     ×%@间/晚",[_roomprice intValue],b];
    [view4 addSubview:tprice];
    [tprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4).offset(20);
        make.top.equalTo(view4).offset(0);
        make.height.offset(30);
        make.width.offset(deviceScreenWidth-40);
    }];
    free=[UILabel new];
    free.font=[UIFont systemFontOfSize:14];
    free.textAlignment=NSTextAlignmentCenter;
    free.text=[NSString stringWithFormat:@"入住天数:             %ld晚",(long)w];
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
               [_tableView reloadData];

            break;
        default:
            break;
    }
}
-(void)chick{
    [UIView animateWithDuration:0.5 animations:^{
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
    _arr=[NSMutableArray arrayWithArray:arr];
    [pickerView reloadAllComponents];
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
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
//    [pickerView selectRow:0 inComponent:0 animated:NO];

    if ([_arr[rowOne] isKindOfClass:[NSDictionary class]]) {
        if(_arr[rowOne][@"projectName"]!=nil){
            //seatstring = _arr[rowOne][@"projectName"];
            projectNo=_arr[rowOne][@"projectNo"];
            projectName=_arr[rowOne][@"projectName"];;
            
        }else if(_arr[rowOne][@"costName"]!=nil){
            //seatstring = _arr[rowOne][@"costName"];
            costName=_arr[rowOne][@"costName"];
            costNo=_arr[rowOne][@"costNo"];
            
        }
        else{
            seatstring = _arr[row][@"reasonName"];
            _erroMessage= seatstring;
        }
    }
    else{
        if([_arr[0] isEqualToString:@"1"]){
            b=_arr[rowOne];
            pricela.text=[NSString stringWithFormat:@"￥%ld",[_roomprice intValue]*[b intValue]*w];
            tprice.text=[NSString stringWithFormat:@"房间价格:￥%d.0元     ×%@间/晚",[_roomprice intValue],b];
        }else{
            lasttime=_arr[rowOne];
        }
    }
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section==1){
        return 40;
    }else if(section==2){
        return 10;
    }
    else if(section==0){
        return 10;
    }
    else{
        return 0.01;
    }
}
//设置组的wei视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==1) {
        return 40;
    }else{
        return 10;
    }
}
//设置组的wei视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==1){
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
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 10)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;    }
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section==0){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 30)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
    else if(section==1){
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 40)];
        UIImageView * menimage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 10, 15, 15)];
        menimage.image=[UIImage imageNamed:@"passenger"];
        [view addSubview:menimage];
        UILabel * menlabel =[[ UILabel alloc]initWithFrame:CGRectMake(45, 10, 52, 16)];
        menlabel.text=@"入住人";
        menlabel.font = [UIFont systemFontOfSize:14];
        menlabel.textColor=[UIColor blackColor];
        [view addSubview:menlabel];
        UIButton * butchangeman = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-120, 5, 100,30)];
        [butchangeman.layer setMasksToBounds:YES];
        [butchangeman.layer setCornerRadius:10.0];
        butchangeman.titleLabel.font=[UIFont systemFontOfSize:13];
        [butchangeman addTarget:self action:@selector(changmenclick:) forControlEvents:UIControlEventTouchUpInside];
        [butchangeman setTitle:@"选择入住人" forState:UIControlStateNormal];
        [butchangeman setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [butchangeman setBackgroundColor:[UIColor colorWithRed:90/255.0 green:203/255.0 blue:241/255.0 alpha:1]];
        [view addSubview:butchangeman];
        
        
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]isEqualToString:@"1"]) {
                butchangeman.hidden=YES;
            }
        }
        view.backgroundColor=[UIColor whiteColor];
        return view;
    }else{
        UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 10)];
        view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        return view;
    }
}
//设置行高 默认是44高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(isa==YES){
        if(indexPath.section==1){
            return 80;
        }else if(indexPath.section==0){
            if(_roommess.length==0){
                return 100;
            }else{
                return 130;
            }
        }else if(indexPath.section==6||indexPath.section==4||indexPath.section==5){
            return 0.01;
        }else if(indexPath.section==3){
            if (Dbshow==NO) {
                return 0.01;
            }else{
              return 60;
            }
        }else{
            return 60;
        }
    }else{
        if(indexPath.section==1){
            return 80;
        }else if(indexPath.section==0){
            if(_roommess.length==0){
                return 100;
            }else{
                return 130;
            }
        }else if(indexPath.section==6){
            return 60;
        }else if(indexPath.section==3){
            if (Dbshow==NO||[_payType isEqualToString:@"1"]) {
                return 0.01;
            }else{
                return 60;
            }
        }
        else{
            return 60;
        }
    }
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 7;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }
    else if(section==1){
        return _menarray.count;
    }
    else if(section==6||section==2){
        return 2;
    }else{
        return 1;
    }
}
//创建cell，
-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.section==0){
        HorderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (HorderCell *)[[[NSBundle  mainBundle]  loadNibNamed:@"HorderCell" owner:self options:nil]  lastObject];
        }
        cell.hotelnamelabel.text=_hotelname;
        cell.hotelnamelabel.adjustsFontSizeToFitWidth=YES;
        cell.roomname.text=_roomname;
        cell.roomname.adjustsFontSizeToFitWidth=YES;
        
        if (_roommess.length==0) {
            cell.hotelmess.textColor=[UIColor blackColor];
            cell.hotelmess.text=_address;
            cell.address.text=@"";
        }else{
            cell.hotelmess.text=_roommess;
            cell.address.text=_address;
         }
        
        cell.hotelmess.textColor=[UIColor grayColor];
        cell.hotelmess.adjustsFontSizeToFitWidth=YES;
        NSDate * d1=  [LGLCalendarDate dateFromString:_inhoteldate];
        
        NSDate * d2=  [LGLCalendarDate dateFromString:_outhoteldate];
        
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        cell.datelabel.text=[NSString stringWithFormat:@"入住:%@ 离店:%@  共%ld晚",_inhoteldate,_outhoteldate,h];
        cell.datelabel.adjustsFontSizeToFitWidth=YES;
        cell.datelabel.font=[UIFont systemFontOfSize:12];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section==1){
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
            NSString * card = [secretNum IdCardtest:_menarray[indexPath.row][@"certNo"]];
            cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,card];

        }else if ([_menarray[indexPath.row][@"certType"] isEqualToString:@"ID"]){
            str=@"护照";
            NSString * card = [secretNum otherCardtest:_menarray[indexPath.row][@"certNo"]];
            cell.menMessagecell.text=[NSString stringWithFormat:@"%@ %@",str,card];
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
    }else if(indexPath.section==2){
        order4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order4Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order4Cell" owner:self options:nil]  lastObject];
        }
        if(indexPath.row==0){
            cell.titlelabel.adjustsFontSizeToFitWidth=YES;
            cell.titlelabel.text=@"预订间数";
            cell.costlabel.text=b;
            cell.titleimage.image=[UIImage imageNamed:@"room_number"];
        }else{
            cell.titlelabel.adjustsFontSizeToFitWidth=YES;
            cell.titlelabel.text=@"最晚到店时间";
            cell.costlabel.text=lasttime;
            cell.titleimage.image=[UIImage imageNamed:@"last_checkin"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section==3){
        order4Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order4Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order4Cell" owner:self options:nil]  lastObject];
        }
        if (Dbshow==NO||[_payType isEqualToString:@"1"]) {
            cell.hidden=YES;
        }
        cell.titlelabel.adjustsFontSizeToFitWidth=YES;
        cell.titlelabel.text=@"担保信息";
        cell.costlabel.hidden=YES;
        cell.titleimage.image=[UIImage imageNamed:@"guarantee"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        order5Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        // cell的复用
        if (!cell) {
            cell= (order5Cell *)[[[NSBundle  mainBundle]  loadNibNamed:@"order5Cell" owner:self options:nil]  lastObject];
        }
        if (isa==YES) {
            cell.hidden=YES;
        }else{
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]isEqualToString:@"1"]) {
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
            cell.MsszgeLabel.textColor=UIColorFromRGBA(0xd0011b, 1.0);
            cell.titleimage.hidden=YES;
        }else{
            cell.MsszgeLabel.adjustsFontSizeToFitWidth=YES;
            cell.wblabel.text=@"违背事项";
            cell.MsszgeLabel.textColor=UIColorFromRGBA(0xd0011b, 1.0);
            cell.MsszgeLabel.text=_erromes;
        }
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
    }else if(indexPath.section==6){
        if (indexPath.row==1||indexPath.row==3) {
            [self loadPickerData:_errArray];
            [self chick];
        }
    }else if(indexPath.section==2){
        if(indexPath.row==0){
            [self loadPickerData:numarray];
            [self chick];
        }else{
            [self loadPickerData:lasttimeArr];
            [self chick];
        }
    }else if(indexPath.section==3){
        DbViewController * avc = [DbViewController new];
    [self presentViewController:avc animated:NO completion:nil];
    }else{
        
    }
}
-(void)changmenclick:(UIButton*)send{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=3;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
        _menarray=array;
        //pricela.text=[NSString stringWithFormat:@"￥%d",[_roomprice intValue]*[b intValue]];
        NSLog(@"%@",_capacity);
        if(_menarray.count<=[_capacity intValue]){
            b=@"1";
        }else{
            if ((_menarray.count % [_capacity intValue])!=0) {
                
                b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])+1];
            }else{
                b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])];
            }
        }
        pricela.text=[NSString stringWithFormat:@"￥%ld",[_roomprice intValue]*[b intValue]*w];
        tprice.text=[NSString stringWithFormat:@"房间价格:￥%d.0元     ×%@间/晚",[_roomprice intValue],b];
        
                [_tableView reloadData];
    };
    //[self.navigationController pushViewController:changmen animated:YES];
    [self presentViewController:changmen animated:YES completion:nil];
}
-(void)changmenclick1{
    ChangeMenViewController *  changmen = [ChangeMenViewController new];
    changmen.type=3;
    changmen.menarry=_menarray;
    changmen.block=^(NSMutableArray *array){
        _menarray=array;
        //pricela.text=[NSString stringWithFormat:@"￥%d",[_roomprice intValue]*[b intValue]];
        NSLog(@"%@",_capacity);
        if(_menarray.count<=[_capacity intValue]){
            b=@"1";
        }else{
            if ((_menarray.count % [_capacity intValue])!=0) {
                
                b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])+1];
            }else{
                b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])];
            }
        }
        pricela.text=[NSString stringWithFormat:@"￥%ld",[_roomprice intValue]*[b intValue]*w];
        tprice.text=[NSString stringWithFormat:@"房间价格:￥%d.0元     ×%@间/晚",[_roomprice intValue],b];
        
        [_tableView reloadData];
    };
    //[self.navigationController pushViewController:changmen animated:YES];
    [self presentViewController:changmen animated:YES completion:nil];
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
-(void)DeleatbutClick:(order2Cell *)cell{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"HpubAndpri"] isEqualToString:@"1"]) {
        if (_menarray.count==1) {
            [AlertViewManager alertWithTitle:@"温馨提示"
                                     message:@"已经是最后一位入住人，删除后将重新查询，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
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
                                     message:@"已经是最后一位入住人，删除后将重新选择入住人，你是否确定删除？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
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
    
        if(_menarray.count<=[_capacity intValue]){
        b=@"1";
    }else{
        if ((_menarray.count % [_capacity intValue])!=0) {
            
            b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])+1];
        }else{
            b=[NSString stringWithFormat:@"%ld",(_menarray.count/[_capacity intValue])];
        }
    }
    pricela.text=[NSString stringWithFormat:@"￥%ld",[_roomprice intValue]*[b intValue]*w];
    tprice.text=[NSString stringWithFormat:@"房间价格:￥%d.0元     ×%@间/晚",[_roomprice intValue],b];
    
    [_tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
