//
//  hotelMessageVC.m


#import "hotelMessageVC.h"
#import "RoomCell.h"
#import "hotelorderVC.h"
#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"
#import "hotelDetailsVC.h"

#import "changeDateVc.h"

#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
@interface hotelMessageVC ()<UITableViewDelegate,UITableViewDataSource,RoomCellDelegate>
{
    //table头视图的日期控件
    UILabel * view41date;
    UILabel * view41week;
    UILabel * view42date;
    UILabel * view42week;
    
    //判断组头视图的展开
    NSMutableArray * _array;
    //组头视图控件
    UILabel * roomname;
    UILabel * roommes;
    UILabel * roomprice;
    UIImageView * checkshow;
    
    NSString * backdate;
    NSString * outdate;
    //时间差
    UILabel * view4datecha;
    
}
@property(nonatomic,strong)UITableView * tableview;
@property(nonatomic,copy)NSMutableArray * dataArray;
@property(nonatomic,copy)NSMutableArray * payOnArray;
@property(nonatomic,copy)NSMutableArray * payInArray;

@property(nonatomic,copy)NSMutableArray * roomarr;

@end
@implementation hotelMessageVC

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
    self.navigationController.navigationBar.hidden  = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _array = [[NSMutableArray alloc] init];
    _dataArray=[[NSMutableArray alloc]init];
    _roomarr=[[NSMutableArray alloc]init];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view= [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 0, 375, 64)]];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(375/2-(375/4), 20, 375/2, 30)]];
    label.text=_hotelname;
    label.adjustsFontSizeToFitWidth=YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];

    backdate=_requtstdict[@"dataBack"];
    outdate=_requtstdict[@"dataOut"];
    [self loaddata];
    //创建表格视图
    [self titleview];
}
-(void)back:(UIButton*)but{
    [self.navigationController popViewControllerAnimated:NO];
   // [self dismissViewControllerAnimated:NO completion:nil];
}
-(void)loaddata{
    _payInArray=[NSMutableArray new];
    _payOnArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    RoomQuery * rq = [RoomQuery new];
    rq.HotelId=_hotelId;
    rq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    rq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
        rq.TripType=@"1";
        rq.EmpRank=@"4";
    }else{
        rq.TripType=@"2";
        rq.EmpRank=@"4";
    }
    
    rq.CheckInDate=_requtstdict[@"dataOut"];
    rq.CheckOutDate=backdate;
    [Hotel RoomQuery:rq success:^(id data) {
         [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"roomList"];
            for (NSDictionary * dict in _dataArray) {
                if ([dict[@"ratePlanList"][0][@"payType"] isEqualToString:@"0"]) {
                    [_payOnArray addObject:dict];
                }else{
                    [_payInArray addObject:dict];
                }
            }
            _dataArray=[NSMutableArray arrayWithArray:_payInArray
                        ];
            for (NSDictionary * dic in _dataArray) {
                NSLog(@"%@",dic);
                [_array addObject:@"0"];
            }
            [_tableview reloadData];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)titleview{
    _tableview=[[UITableView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 64, 375,667-64)] style:UITableViewStylePlain];
    _tableview.delegate=self;
    _tableview.dataSource=self;
    UIView * view0 = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 64, 375, 473)]];
    view0.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    // [self.view addSubview:view0];
    UIImageView * titleimage = [[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 0, 375, 180)]];
    [titleimage sd_setImageWithURL:[NSURL URLWithString:_datadict[@"imageUrl"]] placeholderImage:[UIImage imageNamed:@"banner-hotel.jpg"]];
    [view0 addSubview:titleimage];

    UIView * view1 = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 180, 375, 88)]];
    view1.backgroundColor=[UIColor whiteColor];
    [view0 addSubview:view1];
    UILabel * messagelabel  = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(20, 14, 229, 59)]];
    messagelabel.text=_datadict[@"hotelDesc"];
    messagelabel.font=[UIFont systemFontOfSize:14];
    messagelabel.textColor=[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1];
    messagelabel.lineBreakMode = UILineBreakModeWordWrap;
    messagelabel.numberOfLines = 3;
    [view1 addSubview:messagelabel];
    
    UIButton * but  = [[UIButton alloc]initWithFrame:[self newSuitFrame:CGRectMake(313, 14, 62, 59)]];
    [but addTarget:self action:@selector(messbut:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:but];
    UILabel * butlabel =[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(3, 20, 29, 16)]];
    butlabel.text=@"详情";
    butlabel.adjustsFontSizeToFitWidth=YES;
    butlabel.textColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    butlabel.font=[UIFont systemFontOfSize:14];
    [but addSubview:butlabel];
    UIImageView * butimage = [[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(37, 22, 8, 14)]];
    butimage.image=[UIImage imageNamed:@"more"];
    [but addSubview:butimage];
    UIView * viewline = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 87, 375, 1)]];
    viewline.backgroundColor=UIColorFromRGBA(0xcccccc, 1.0);
    [view1 addSubview:viewline];
    
    UIView * view2 =[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0,180+88 ,375,44)]];
    view2.backgroundColor=[UIColor whiteColor];
    [view0 addSubview:view2];
    UILabel  * view2label =[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(18,4 ,375-36,40)]];
    view2label.text=_datadict[@"address"];
    view2label.font=[UIFont systemFontOfSize:12];
    view2label.lineBreakMode = UILineBreakModeWordWrap;
    view2label.numberOfLines = 0;
    [view2 addSubview:view2label];
    
    UIView * viewline1= [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 43, 375, 1)]];
     viewline1.backgroundColor=UIColorFromRGBA(0xcccccc, 1.0);
    [view2 addSubview:viewline1];
    
    
    UIView * view3 =[[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0,180+88+44 ,375,44)]];
    view3.backgroundColor=[UIColor whiteColor];
    [view0 addSubview:view3];
    UIImageView * view3image = [[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(18, 11, 15, 16)]];
    view3image.image=[UIImage imageNamed:@"call"];
    [view3 addSubview:view3image];
   
    UILabel  * view3label =[[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(43,11,375,16)]];
    view3label.text=_datadict[@"telPhone"];
    view3label.textColor=[UIColor colorWithRed:29/255.0 green:177/255.0 blue:235/255.0 alpha:1];
    [view3 addSubview:view3label];
    UIView * viewline2= [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 43, 375, 1)]];
      viewline2.backgroundColor=UIColorFromRGBA(0xcccccc, 1.0);
    [view3 addSubview:viewline2];
    UITapGestureRecognizer *taptelPhone = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtaptelPhone:)];
    [view3 addGestureRecognizer:taptelPhone];
    
    UIView * view4 = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 185+180, 375, 44)]];
    view4.backgroundColor=[UIColor whiteColor];
    [view0 addSubview:view4];
    
    UIView * view41 = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(20, 0, 295/2, 44)]];
    view41.backgroundColor=[UIColor whiteColor];
    [view4 addSubview:view41];
    view41date =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(0, 11, 68, 18)]];
    view41date.text=outdate;
    view41date.adjustsFontSizeToFitWidth=YES;
    [view41 addSubview:view41date];
    view41week =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(70, 14, 24, 14)]];
    view41week.text=_requtstdict[@"week"];
    view41week.adjustsFontSizeToFitWidth=YES;
    [view41 addSubview:view41week];
    
    UILabel * view41rz =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(101, 14, 24, 14)]];
    view41rz.text=@"入住";
    view41rz.adjustsFontSizeToFitWidth=YES;
    [view41 addSubview:view41rz];
//    UIImageView*view41img =[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(140,16, 8, 13)]];
    
    UIImageView*view41img =[[UIImageView alloc]init];
    view41img.image=[UIImage imageNamed:@"chevron"];
    [view41 addSubview:view41img];
    [view41img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view41rz.mas_right).offset(5/SCREEN_RATE);
        make.top.equalTo(view41).offset(16/SCREEN_RATE1);
        make.height.offset(13/SCREEN_RATE1);
        make.width.offset(8/SCREEN_RATE);
    }];
    
    view41.userInteractionEnabled=NO;
    UITapGestureRecognizer *tapoutdate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtapoutdate:)];
    [view41 addGestureRecognizer:tapoutdate];

    
    NSDate * d1=  [LGLCalendarDate dateFromString:outdate];
    
    NSDate * d2=  [LGLCalendarDate dateFromString:backdate];
    
    NSInteger h=[weekday getDaysFrom:d1 To:d2];
    

     view4datecha=[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(375/2-20, 14, 40, 14)]];
    view4datecha.text=[NSString stringWithFormat:@"%ld晚",h];
    view4datecha.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
    view4datecha.textAlignment=NSTextAlignmentCenter;
    view4datecha.font=[UIFont systemFontOfSize:14];
    [view4 addSubview:view4datecha];

    
    UIView * view42 = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(375/2+20, 0, 295/2, 44)]];
    view42.backgroundColor=[UIColor whiteColor];
    [view4 addSubview:view42];
    view42date =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(20, 11, 68, 18)]];
    view42date.adjustsFontSizeToFitWidth=YES;
    view42date.text=backdate;
    [view42 addSubview:view42date];
    view42week =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(90, 14, 24, 14)]];
    view42week.text=_requtstdict[@"week1"];
    view42week.adjustsFontSizeToFitWidth=YES;
    [view42 addSubview:view42week];
    UILabel * view42rz =[[UILabel alloc ]initWithFrame:[self newSuitFrame:CGRectMake(125, 14, 24, 14)]];
    view42rz.text=@"离店";
    view42rz.adjustsFontSizeToFitWidth=YES;
    [view42 addSubview:view42rz];
//    UIImageView*view42img =[[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(164,16, 8, 13)]];
    UIImageView*view42img =[[UIImageView alloc]init];
    view42img.image=[UIImage imageNamed:@"chevron"];
    [view42 addSubview:view42img];
    
    [view42img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view42rz.mas_right).offset(5/SCREEN_RATE);
        make.top.equalTo(view42).offset(16/SCREEN_RATE1);
        make.height.offset(13/SCREEN_RATE1);
        make.width.offset(8/SCREEN_RATE);
    }];

    
    
    UITapGestureRecognizer *tapdate = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtapdate:)];
    [view42 addGestureRecognizer:tapdate];
    
    UIView * payTypeView = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 423, 375, 50)]];
    payTypeView.backgroundColor=[UIColor whiteColor];
    [view0 addSubview:payTypeView];
   
    UIButton * payTypeButton1 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 0, 375/2, 48)]];
    payTypeButton1.tag=303;
    [payTypeButton1 setTitle:@"在线付" forState:UIControlStateNormal];
    [payTypeButton1 setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
    [payTypeButton1 addTarget:self action:@selector(PayTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [payTypeView addSubview:payTypeButton1];
   
    UIView * payViewLine = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 48, 375/2, 2)]];
    payViewLine.tag=403;
    payViewLine.backgroundColor=UIColorFromRGBA(0x00afec, 1.0);
    [payTypeView addSubview:payViewLine];
    
    UIButton * payTypeButton2 = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(375/2, 0, 375/2, 48)]];
    payTypeButton2.tag=304;
    [payTypeButton2 setTitle:@"到店付" forState:UIControlStateNormal];
    [payTypeButton2 addTarget:self action:@selector(PayTypeClick:) forControlEvents:UIControlEventTouchUpInside];
    [payTypeButton2 setTitleColor:UIColorFromRGBA(0x888888, 1.0) forState:UIControlStateNormal];

    [payTypeView addSubview:payTypeButton2];
   
    UIView * payViewLine1 = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(375/2, 48, 375/2, 2)]];
    payViewLine1.tag=404;
    payViewLine1.backgroundColor=[UIColor whiteColor];
    [payTypeView addSubview:payViewLine1];
    
    _tableview.tableHeaderView=view0;
    [self.view addSubview:_tableview];
}
//设置组的头视图 这个方法会和设置组的头标题产生冲突
-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * headview = [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 0, 375, 60 )]];
    headview.backgroundColor=[UIColor whiteColor];
    roomname = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(15, 10, 160, 18)]];
    roomname.text=_dataArray[section][@"roomName"];
    roomname.adjustsFontSizeToFitWidth=YES;
    [headview addSubview:roomname];
    roommes = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(15,29, 220, 30)]];
    roommes.text=_dataArray[section][@"description"];
//    roommes.adjustsFontSizeToFitWidth=YES;
    roommes.lineBreakMode = UILineBreakModeWordWrap;
    roommes.numberOfLines = 0;
    roommes.font=[UIFont systemFontOfSize:10];
    [headview addSubview:roommes];
    
    roomprice = [[UILabel alloc]initWithFrame:[self newSuitFrame:CGRectMake(281, 19, 54, 14)]];
    roomprice.text=[NSString stringWithFormat:@"￥%@",(NSString*)_dataArray[section][@"minFacePrice"]];
    roomprice.textColor=[UIColor colorWithRed:236/255.0 green:121/255.0 blue:33/255.0 alpha:1];
    roomprice.font=[UIFont systemFontOfSize:14];
    roomprice.adjustsFontSizeToFitWidth=YES;
    [headview addSubview:roomprice];
   
    checkshow = [[UIImageView alloc]initWithFrame:[self newSuitFrame:CGRectMake(348, 21, 13, 8)]];
    if ([_array[section] isEqualToString:@"1"]) {
        checkshow.image=[UIImage imageNamed:@"chevron_hide"];
    }else{
        checkshow.image=[UIImage imageNamed:@"chevron_show"];
    }
    [headview addSubview:checkshow];
    
    UIView * viewline2= [[UIView alloc]initWithFrame:[self newSuitFrame:CGRectMake(0, 59, 375, 1)]];
    viewline2.backgroundColor=UIColorFromRGBA(0xcccccc, 1.0);
    [headview addSubview:viewline2];


    UITapGestureRecognizer *tapqq = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFqq:)];
    [headview addGestureRecognizer:tapqq];
    headview.tag=section+1;
    return headview;
}

-(void)showGFtapdate:(UITapGestureRecognizer*)tapdate{
    
//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    ctl.sss=_requtstdict[@"dataOut"];
//    ctl.isa=NO;
//    ctl.type=2;
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
//        view42week.text=[weekday weekdaywith:paramas];
//        view42date.text= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//        [self loaddata1:view42date.text];
//        
//        [_tableview reloadData];
////        NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
////        NSDate * d2=  [LGLCalendarDate dateFromString:_Hdatestrback];
////        NSInteger h=[weekday getDaysFrom:d1 To:d2];
////        _aView3.datacha.text=[NSString stringWithFormat:@"%ld晚",h];
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
//
    
    
    
//    
//    changeDateVc * cdc =[changeDateVc new];
//    cdc.outOrIn=@"out";
//    cdc.indate= _requtstdict[@"dataOut"];
//    cdc.type=@"hotel";
//    cdc.block=^(NSMutableDictionary*dict){
////        NSString * date1 = [dict[@"out"] substringWithRange:NSMakeRange(5, 5)] ;
////        NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
////       view42date.text = [NSString stringWithFormat:@"%@日",str];
//        view42date.text = dict[@"out"];
//        view42week.text=[weekday weekdaywith1:dict[@"out"]];
//        [self loaddata1:view42date.text];
//        [_tableview reloadData];
//        
//        NSDate * d1=  [LGLCalendarDate dateFromString:_requtstdict[@"dataOut"]];
//        
//        NSDate * d2=  [LGLCalendarDate dateFromString:dict[@"out"]];
//        
//        NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        
//        view4datecha.text=[NSString stringWithFormat:@"%ld晚",h];
//    };
//    [self presentViewController:cdc animated:NO completion:nil];
    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrback=@"back";
    //    cdc.outdate=_datestrOut;
    cdc.outdate=@"";
    
    cdc.type=@"flight";
    
    cdc.block=^(NSMutableDictionary*dict){
        
        NSDate * d1=  [LGLCalendarDate dateFromString:_requtstdict[@"dataOut"]];
        NSDate * d2=  [LGLCalendarDate dateFromString:dict[@"back"]];
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        if (h<0) {
            [UIAlertView showAlertWithTitle1:@"您想更改的离店日期不能早于入住日期，请重新选择！" duration:2];
        }else{
            
                    view42date.text = dict[@"out"];
                    view42week.text=[weekday weekdaywith1:dict[@"back"]];
                    [self loaddata1:view42date.text];
                    [_tableview reloadData];
            
                    NSDate * d1=  [LGLCalendarDate dateFromString:_requtstdict[@"dataOut"]];
            
                    NSDate * d2=  [LGLCalendarDate dateFromString:dict[@"out"]];
            
                    NSInteger h=[weekday getDaysFrom:d1 To:d2];
                    
                    view4datecha.text=[NSString stringWithFormat:@"%ld晚",h];

            
        }
    };
    [self presentViewController:cdc animated:NO completion:nil];
    
    
    
    
    
}
-(void)showGFtapoutdate:(UITapGestureRecognizer*)tapoutdate{
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    ctl.sss=_requtstdict[@"dataBack"];
    ctl.isa=YES;
    ctl.type=2;
    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
        NSString *str1 =paramas[@"month"];
        NSString *str2=paramas[@"day"];
        if([paramas[@"month"] intValue]<10){
            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
        }
        if([paramas[@"day"] intValue]<10){
            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
        }
        view41week.text=[weekday weekdaywith:paramas];
        
        view41date.text= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
        [self loaddata2:view41date.text];
        [_tableview reloadData];
        
    }];
    [self presentViewController:ctl animated:YES completion:nil];
}
-(void)loaddata1:(NSString*)strdate{
    _payInArray=[NSMutableArray new];
    _payOnArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];

    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    RoomQuery * rq = [RoomQuery new];
    rq.HotelId=_hotelId;
    rq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    rq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
        rq.TripType=@"1";
        rq.EmpRank=@"4";
    }else{
        rq.TripType=@"2";
        rq.EmpRank=@"4";
    }
    rq.CheckInDate=_requtstdict[@"dataOut"];
    rq.CheckOutDate=strdate;
    [Hotel RoomQuery:rq success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"roomList"];
            for (NSDictionary * dict in _dataArray) {
                if ([dict[@"ratePlanList"][0][@"payType"] isEqualToString:@"0"]) {
                    [_payOnArray addObject:dict];
                }else{
                    [_payInArray addObject:dict];
                }
            }
    _dataArray=[NSMutableArray arrayWithArray:_payInArray];
            for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
            }
            [_tableview reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
-(void)loaddata2:(NSString*)strdate{
    _payInArray=[NSMutableArray new];
    _payOnArray=[NSMutableArray new];
    _dataArray=[NSMutableArray new];
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    RoomQuery * rq = [RoomQuery new];
    rq.HotelId=_hotelId;
    rq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    rq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"1"]){
        rq.TripType=@"1";
        rq.EmpRank=@"4";
    }else{
        rq.TripType=@"2";
        rq.EmpRank=@"4";
    }
    rq.CheckInDate=strdate;
    rq.CheckOutDate=_requtstdict[@"dataBack"];
    [Hotel RoomQuery:rq success:^(id data) {
        [SVProgressHUD dismiss];
        NSLog(@"%@",data);
        if([data[@"status"] isEqualToString:@"T"]){
            _dataArray=data[@"roomList"];
            for (NSDictionary * dict in _dataArray) {
                if ([dict[@"ratePlanList"][0][@"payType"] isEqualToString:@"0"]) {
                    [_payOnArray addObject:dict];
                }else{
                    [_payInArray addObject:dict];
                }
            }
            _dataArray=[NSMutableArray arrayWithArray:_payInArray
                        ];
            for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
            }
            [_tableview reloadData];        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
#pragma mark -头部视图的点击
-(void)showGFqq:(UITapGestureRecognizer*)tapqq{
    _roomarr=[NSMutableArray new ];
    //判断 如果是1 改成0
    if ([_array[tapqq.view.tag - 1] isEqualToString:@"1"]) {
        [_array replaceObjectAtIndex:tapqq.view.tag - 1 withObject:@"0"];
    }else{
        for (int i=0;i<_array.count;i++) {
            [_array replaceObjectAtIndex:i withObject:@"0"];
        }
        //如果不是 改成1
        [_array replaceObjectAtIndex:tapqq.view.tag - 1 withObject:@"1"];
    }
    _roomarr=_dataArray[tapqq.view.tag - 1][@"ratePlanList"];
    
    [_tableview setContentOffset:CGPointMake(0,(tapqq.view.tag - 1)*60+473/SCREEN_RATE1) animated:YES];
    [_tableview reloadData];
    
}
//设置组的头视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 60/SCREEN_RATE1;
}
//设置组的尾部视图高度
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self newheightFrame:66];
}
//返回tableView的组数 每组都是从0开始的
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_array.count==0){
        return 0;
    }
    
    if ([_array[section] isEqualToString:@"0"]) {
        return 0;
    }
        return _roomarr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RoomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (!cell) {
        cell = [[RoomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
    }
    cell.delegate=self;
    cell.hzlabel.text=_roomarr[indexPath.row][@"ratePlanName"];
    cell.pricelable.text=[NSString stringWithFormat:@"￥%@",(NSString*)_roomarr[indexPath.row][@"priceList"][0][@"costPrice"]];
    if([_roomarr[indexPath.row][@"payType"] isEqualToString:@"0"]){
        if(_roomarr[indexPath.row][@"guaranteeRule"][@"ruleCode"]!=nil){
          cell.orderlabel.text=@"现付(须担保)";
        }else{
        cell.orderlabel.text=@"现付";
        }
    }else{
        cell.orderlabel.text=@"易游预付";
    }
    if([_roomarr[indexPath.row][@"firstStatus"] isEqualToString:@"2"]){
        cell.bookbut.backgroundColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
        [cell.bookbut setTitle:@"已满" forState:UIControlStateNormal];
        cell.orderlabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    }
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString:@"2"]){
        cell.gzlabel.hidden=YES;
    }else{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]isEqualToString:@"1"]) {
//            NSString *string =_roomarr[indexPath.row][@"ratePlanList"][0][@"standardDesc"];
//            NSRange startRange = [string rangeOfString:@"过"];
//            NSRange endRange = [string rangeOfString:@"元"];
//            NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
//            NSString *result = [string substringWithRange:range];
//            NSLog(@"%@",_roomarr[indexPath.row][@"ratePlanList"][0][@"ifStandard"]);
            
            if([_roomarr[0][@"ifStandard"] isEqualToString:@"1"]){
                cell.gzlabel.text=@"违规";
                cell.gzlabel.textColor=[UIColor redColor];
            }else{
                cell.gzlabel.text=@"合规";
                cell.gzlabel.textColor=[UIColor grayColor];
            }
        }else{
          cell.gzlabel.hidden=YES;
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)bookbutClick:(RoomCell *)cell{
    
    NSIndexPath * indexPath = [_tableview indexPathForCell:cell];
    if([cell.gzlabel.text isEqualToString:@"违规"]){
            NSString *title = @"提示";
            NSString *title1 = @"取消";
            NSString *okButtonTitle = @"确认预订";
            NSString *message=@"";
            message = [NSString stringWithFormat:@"违背了差旅标准：\n%@",_roomarr[0][@"standardDesc"]];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
                RuleVC * trainrulevc = [RuleVC new];
                trainrulevc.erromes=_roomarr[0][@"standardDesc"];
                trainrulevc.erro=[NSString stringWithFormat:@"违背了差旅标准：\n%@\n\n请选择您的原因：",_roomarr[0][@"standardDesc"]];
                trainrulevc.style=@"hotel";
                trainrulevc.menarray=_menarray;
//                hovc.erroID=erroID;
//                hovc.erromes=_herromes;
//                hovc.erroMessage=erroMessage;
//                hovc.errArray=_dataArray;
                trainrulevc.roomname=_dataArray[indexPath.section][@"roomName"];
                trainrulevc.roommess=_dataArray[indexPath.section][@"description"];
                trainrulevc.inhoteldate=view41date.text;
                trainrulevc.outhoteldate=view42date.text;
                trainrulevc.hotelid=_hotelId;
                trainrulevc.hotelname=_hotelname;
                trainrulevc.capacity=_dataArray[indexPath.section][@"capacity"];
                trainrulevc.roomid=_dataArray[indexPath.section][@"roomId"];
                trainrulevc.roomprice=(NSString*)_roomarr[indexPath.row][@"priceList"][0][@"costPrice"];
                trainrulevc.rucode=_roomarr[indexPath.row][@"guaranteeRule"][@"ruleCode"];
                trainrulevc.RatePlanId=_roomarr[indexPath.row][@"ratePlanId"];
                trainrulevc.payType=_roomarr[indexPath.row][@"payType"];
                trainrulevc.gxlabeltext=cell.gzlabel.text;
                trainrulevc.address=_datadict[@"address"];
                [self.navigationController  pushViewController:trainrulevc animated:YES];
            //[self presentViewController:trainrulevc animated:NO completion:nil];
            }]];
            [self presentViewController:alertController animated:YES completion:nil];
    }else{
        hotelorderVC * hovc = [hotelorderVC new];
        hovc.roomname=_dataArray[indexPath.section][@"roomName"];
        hovc.roommess=_dataArray[indexPath.section][@"description"];
        hovc.inhoteldate=view41date.text;
        hovc.outhoteldate=view42date.text;
        hovc.hotelid=_hotelId;
        hovc.hotelname=_hotelname;
        hovc.capacity=_dataArray[indexPath.section][@"capacity"];
        hovc.roomid=_dataArray[indexPath.section][@"roomId"];
        hovc.roomprice=(NSString*)_roomarr[indexPath.row][@"priceList"][0][@"costPrice"];
        hovc.RatePlanId=_roomarr[indexPath.row][@"ratePlanId"];
        hovc.payType=_roomarr[indexPath.row][@"payType"];
        hovc.rucode=_roomarr[indexPath.row][@"guaranteeRule"][@"ruleCode"];
        hovc.gxlabeltext=cell.gzlabel.text;
        hovc.menarray=_menarray;
        hovc.address=_datadict[@"address"];
        [self.navigationController  pushViewController:hovc animated:YES];
       //[self presentViewController:hovc animated:NO completion:nil];
    }
}

-(void)messbut:(UIButton*)but{
    
    hotelDetailsVC   * hvc = [hotelDetailsVC new];
    hvc.mesageStr=_datadict[@"hotelDesc"];
     [self presentViewController:hvc animated:NO completion:nil];
    
}
-(void)PayTypeClick:(UIButton*)send{
    switch (send.tag) {
        case 303:{
            _array=[NSMutableArray new];
            [send setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
            UIButton * button = (UIButton*)[self.view viewWithTag:304];
            [button setTitleColor:UIColorFromRGBA(0x888888, 1.0)
                         forState:UIControlStateNormal];
            UIView * view1 = (UIView*)[self.view viewWithTag:403];
            view1.backgroundColor=UIColorFromRGBA(0x00afec, 1.0);
            UIView * view2 = (UIView*)[self.view viewWithTag:404];
            view2.backgroundColor=[UIColor whiteColor];
            _dataArray=[NSMutableArray arrayWithArray:_payInArray
                        ];
            for (NSDictionary * dic in _dataArray) {
                
                [_array addObject:@"0"];
            }
            [_tableview reloadData];
            break;
        }
        case 304:{
            _array=[NSMutableArray new];

            [send setTitleColor:UIColorFromRGBA(0x00afec, 1.0) forState:UIControlStateNormal];
            UIButton * button = (UIButton*)[self.view viewWithTag:303];
            [button setTitleColor:UIColorFromRGBA(0x888888, 1.0) forState:UIControlStateNormal];
            UIView * view1 = (UIView*)[self.view viewWithTag:404];
            view1.backgroundColor=UIColorFromRGBA(0x00afec, 1.0);
            UIView * view2 = (UIView*)[self.view viewWithTag:403];
            view2.backgroundColor=[UIColor whiteColor];
            _dataArray=[NSMutableArray arrayWithArray:_payOnArray
                        ];
            for (NSDictionary * dic in _dataArray) {
                [_array addObject:@"0"];
            }
            [_tableview reloadData];
            break;
        }
        default:
            break;
    }
}
-(void)showGFtaptelPhone:(UITapGestureRecognizer*)taptelPhone{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",_datadict[@"telPhone"]]];// 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
- (CGFloat)newheightFrame:(CGFloat)frame
{
    CGFloat newFrame;
    newFrame=frame/SCREEN_RATE;
    return newFrame;
}
- (CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE;
    return newFrame;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
