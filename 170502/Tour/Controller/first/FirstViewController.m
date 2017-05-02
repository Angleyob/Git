//
//  FirstViewController.m
//  Tour
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "FirstViewController.h"
#import "flightView.h"
#import "trainView.h"
#import "hotelView.h"
#import "insuranceView.h"
#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"
#import "TrianCityVC.h"
#import "TraincityMotel.h"
#import "HotelcityVC.h"
#import "HotelVC.h"
#import "HotelModel.h"
#import "HotelChangeVC.h"

#import "changeDateVc.h"

#import "flightcityViewController.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

@interface FirstViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
{
    
    UIButton * _flightbut;
    UIImageView *_flightimage;
    UIImageView *_trainmage;
    UIImageView *_hotletimage;

    UIButton * _trainbut;
    UIButton * _hotlebut;
    UIButton * _insurancebut;
    
    UILabel * flightlabel;
    UILabel * trainlabel;
    UILabel * hotlelabel;
    UILabel * insurancelabel;
    UIScrollView*_scrollView;
    UIImageView *_vi;
    
    NSMutableArray *hotelarr;

    NSMutableArray *flightarr;
    NSMutableArray *menarr;

    NSArray*_arr;
    UIPickerView *pickerView;
    UIVisualEffectView *effectView;
    UIButton * butclear;
    UIButton * butchange;
    NSString * seatstring;
    
    //蒙版视图
    UIView * _connetview;
    
    // 酒店商业圈选择字典
    NSMutableDictionary * hoteldict;
}

@property (nonatomic,copy)flightView*aView1;
@property (nonatomic,copy)trainView*aView2;
@property (nonatomic,copy)hotelView*aView3;
@property (nonatomic,copy)insuranceView*aView4;
@end
@implementation FirstViewController

//-(void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"%d",_num);
    if (_num!=0) {
        _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(_num-1), 0);
        _vi.frame=CGRectMake((deviceScreenWidth/3)*(_num-1), 126 , deviceScreenWidth/3, 2);
        self.tabBarController.tabBar.hidden=NO;
        _num=0;
    }
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    //注册观察者
    //接收任意对象发送的kNotificationChangeStatus通知
    [nc addObserver:self selector:@selector(changeLabelText:) name:@"num" object:nil];
    
    
    NSNotificationCenter *hotel = [NSNotificationCenter defaultCenter];
    //注册观察者
    //接收任意对象发送的kNotificationChangeStatus通知
    [nc addObserver:self selector:@selector(changehostory:) name:@"hostory" object:nil];
    

    
    _connetview=[[UIView alloc]initWithFrame:CGRectMake(0,deviceScreenHeight , deviceScreenWidth, deviceScreenHeight)];
    _connetview.backgroundColor=[UIColor blackColor];
    _connetview.alpha=0.7;
    [self.view  addSubview:_connetview];
    UIImageView  * imv = [[UIImageView alloc]initWithFrame:CGRectMake(10, 70, deviceScreenWidth-20,402/SCREEN_RATE1)];
    imv.image=[UIImage imageNamed:@"mask"];
    [_connetview addSubview:imv];
  
        self.tabBarController.tabBar.hidden=NO;

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        self.tabBarController.tabBar.hidden=YES;
        _connetview.frame=CGRectMake(0,0 , deviceScreenWidth, deviceScreenHeight);
        _flightbut.hidden=YES;
        _hotlebut.hidden=YES;
        _trainbut.hidden=YES;
        NSLog(@"第一次启动");
    }else{
        self.tabBarController.tabBar.hidden=NO;
        NSLog(@"不是第一次启动");
    }
//    self.hidesBottomBarWhenPushed=YES;
    self.navigationController.navigationBar.hidden  = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
        NSString*filePath=[[NSBundle mainBundle] pathForResource:@"flight"ofType:@"txt"];
    NSString *content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSData * data =[content dataUsingEncoding:NSUTF8StringEncoding];
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    flightarr = [NSMutableArray array];
        for (NSMutableDictionary * dic in json) {
            FlightModel * model = [FlightModel mj_objectWithKeyValues:dic];
            [flightarr addObject:model];
        }
    NSString*filePath1=[[NSBundle mainBundle] pathForResource:@"hotelcuty"ofType:@"txt"];
    NSString *content1 = [NSString stringWithContentsOfFile:filePath1 encoding:NSUTF8StringEncoding error:nil];
    NSString * str;
    str = [content1 stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSData * data1 =[str dataUsingEncoding:NSUTF8StringEncoding];
    id  json1 = [NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:nil];
    hotelarr = [NSMutableArray array];
    for (NSMutableDictionary * dic in json1) {
        HotelModel * model = [HotelModel mj_objectWithKeyValues:dic];
        [hotelarr addObject:model];
    }
    UIView * titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 128)];
    titleView.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:titleView];
    UIImageView * logoView =[UIImageView new];
    logoView.image=[UIImage imageNamed:@"logo"];
    [titleView addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset((deviceScreenWidth-80)/2);
        make.top.equalTo(titleView).offset(32);
        make.height.offset(20);
        make.width.offset(80);
    }];
    
    _flightbut=[UIButton new];
    [_flightbut addTarget:self action:@selector(changviewClick:) forControlEvents:UIControlEventTouchUpInside];
    _flightbut.tag=100;
    [titleView addSubview:_flightbut];
    [_flightbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(0);
        make.top.equalTo(titleView).offset(79);
        make.height.offset(37);
        make.width.offset(deviceScreenWidth/3);
    }];

    _flightimage=[UIImageView new];
    _flightimage.image=[UIImage imageNamed:@"airplane-checked"];
//    [_flightbut setBackgroundImage:[UIImage imageNamed:@"airplane-checked"] forState:UIControlStateNormal];
    [_flightbut addSubview:_flightimage];
        [_flightimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_flightbut).offset((deviceScreenWidth/3)/2-10);
            make.top.equalTo(_flightbut).offset(0);
            make.height.offset(20);
            make.width.offset(20);
        }];
    flightlabel=[UILabel new];
    flightlabel.text=@"机票";
    flightlabel.textAlignment=NSTextAlignmentCenter;
    flightlabel.textColor=[UIColor whiteColor];
    flightlabel.font=[UIFont systemFontOfSize:15];
//    flightlabel.tag=200;
    [_flightbut addSubview:flightlabel];
    [flightlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_flightbut).offset(23);
        make.height.offset(14);
        make.width.offset(50);
        make.centerX.equalTo(_flightbut);
    }];
    
    
    _trainbut=[UIButton new];
    [_trainbut addTarget:self action:@selector(changviewClick:) forControlEvents:UIControlEventTouchUpInside];
    _trainbut.tag=101;
    [titleView addSubview:_trainbut];
    [_trainbut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(deviceScreenWidth/3);
        make.top.equalTo(titleView).offset(79);
        make.height.offset(37);
        make.width.offset(deviceScreenWidth/3);
    }];
    
    _trainmage=[UIImageView new];
    _trainmage.image=[UIImage imageNamed:@"railway"];
    [_trainbut addSubview:_trainmage];
    [_trainmage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_trainbut).offset((deviceScreenWidth/3)/2-10);
        make.top.equalTo(_trainbut).offset(0);
        make.height.offset(20);
        make.width.offset(20);
    }];

    trainlabel=[UILabel new];
    trainlabel.text=@"火车票";
    trainlabel.textAlignment=NSTextAlignmentCenter;

    trainlabel.textColor=[UIColor grayColor];
    trainlabel.font=[UIFont systemFontOfSize:15];
    [_trainbut addSubview:trainlabel];
    [trainlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_trainbut);
        make.top.equalTo(_trainbut).offset(23);
        make.height.offset(14);
        make.width.offset(76);
    }];
    
    _hotlebut=[UIButton new];
    [_hotlebut addTarget:self action:@selector(changviewClick:) forControlEvents:UIControlEventTouchUpInside];
    _hotlebut.tag=102;
    [titleView addSubview:_hotlebut];
    [_hotlebut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleView).offset(2*(deviceScreenWidth/3));
        make.top.equalTo(titleView).offset(79);
        make.height.offset(37);
        make.width.offset(deviceScreenWidth/3);
    }];

    _hotletimage=[UIImageView new];
    _hotletimage.image=[UIImage imageNamed:@"hotel"];
    [_hotlebut addSubview:_hotletimage];
    [_hotletimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_hotlebut).offset((deviceScreenWidth/3)/2-10);
        make.top.equalTo(_hotlebut).offset(0);
        make.height.offset(20);
        make.width.offset(20);
    }];

    hotlelabel =[UILabel new];
    hotlelabel.text=@"酒店";
    hotlelabel.textAlignment=NSTextAlignmentCenter;
    hotlelabel.textColor=[UIColor grayColor];
    hotlelabel.font=[UIFont systemFontOfSize:13];
    [_hotlebut addSubview:hotlelabel];
    [hotlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_hotlebut);
        make.top.equalTo(_hotlebut).offset(23);
        make.height.offset(14);
        make.width.offset(50);
    }];
//   _insurancebut =[UIButton new];
//    _insurancebut.tag=103;
//    [_insurancebut addTarget:self action:@selector(changviewClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_insurancebut setBackgroundImage:[UIImage imageNamed:@"insurance"] forState:UIControlStateNormal];
//    [titleView addSubview:_insurancebut];
//    [_insurancebut mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleView).offset(deviceScreenWidth/4*3+((deviceScreenWidth/4)/2-10));
//        make.top.equalTo(titleView).offset(79);
//        make.height.offset(20);
//        make.width.offset(20);
//    }];
//    insurancelabel =[UILabel new];
//    insurancelabel.text=@"保险";
//    insurancelabel.textColor=[UIColor whiteColor];
//    insurancelabel.font=[UIFont systemFontOfSize:10];
//    insurancelabel.tag=203;
//    [titleView addSubview:insurancelabel];
//    [insurancelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(titleView).offset(deviceScreenWidth/4*3+((deviceScreenWidth/4)/2-10));
//        make.top.equalTo(titleView).offset(102);
//        make.height.offset(14);
//        make.width.offset(24);
//    }];
    _vi= [[UIImageView alloc]initWithFrame:CGRectMake(0, 126, deviceScreenWidth/3, 2)];
    _vi.image=[UIImage imageNamed:@"bar"];
    [titleView addSubview:_vi];
    [self creatScr];
}
-(void)changviewClick:(UIButton*)send{
    
    self.tabBarController.tabBar.hidden=NO;
    _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(send.tag-100), 0);
    _vi.frame=CGRectMake((deviceScreenWidth/3)*(send.tag-100), 126 , deviceScreenWidth/3, 2);
    switch (send.tag) {
       
        case 100:
            _flightimage.image=[UIImage imageNamed:@"airplane-checked"];
            flightlabel.textColor=[UIColor whiteColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel"];
            hotlelabel.textColor=[UIColor grayColor];
            _trainmage.image=[UIImage imageNamed:@"railway"];
            trainlabel.textColor=[UIColor grayColor];
            break;
        case 101:
            _flightimage.image=[UIImage imageNamed:@"airplane"];
            flightlabel.textColor=[UIColor grayColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel"];
            hotlelabel.textColor=[UIColor grayColor];
            _trainmage.image=[UIImage imageNamed:@"railway-checked"];
            trainlabel.textColor=[UIColor whiteColor];
            break;
        case 102:
            _flightimage.image=[UIImage imageNamed:@"airplane"];
            flightlabel.textColor=[UIColor grayColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel-checked"];
            hotlelabel.textColor=[UIColor whiteColor];
            _trainmage.image=[UIImage imageNamed:@"railway"];
            trainlabel.textColor=[UIColor grayColor];
            break;
        default:
            break;
    }
}
-(void)creatScr{
    _scrollView =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 128, self.view.frame.size.width, self.view.frame.size.height-128)];
    _scrollView.contentSize= CGSizeMake(3 * self.view.frame.size.width, self.view.frame.size.height-44-128);
    //边界不滑动
    _scrollView.bounces = NO;
    //分页
    _scrollView.pagingEnabled = YES;
    // _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    _aView1=[[flightView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, self.view.frame.size.height-128)];
    [_aView1 initwithview];
    [_aView1.menbut addTarget:self action:@selector(changemen) forControlEvents:UIControlEventTouchUpInside];
    [_aView1.seatbut addTarget:self action:@selector(chick) forControlEvents:UIControlEventTouchUpInside];
    [_aView1.dataOutbut addTarget:self action:@selector(changeOutdata:) forControlEvents:UIControlEventTouchUpInside];
    NSString *strUrl = [_aView1.dataOutlabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *strUrl1 = [strUrl stringByReplacingOccurrencesOfString:@"日" withString:@""];
    _datestrOut=[NSString stringWithFormat:@"%ld-%@",_aView1.year,strUrl1];
    NSString *strUr3 = [_aView1.databacklabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *strUrl4 = [strUr3 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    _datestrback=[NSString stringWithFormat:@"%ld-%@",_aView1.year,strUrl4];
    
    [_aView1.databackbut addTarget:self action:@selector(changeBackdata:) forControlEvents:UIControlEventTouchUpInside];
    [_aView1.outCitybut addTarget:self action:@selector(outCitybut:) forControlEvents:UIControlEventTouchUpInside];
     [_aView1.backCitybut addTarget:self action:@selector(backCitybut:) forControlEvents:UIControlEventTouchUpInside];
    [_aView1.lookupBut addTarget:self action:@selector(lookupBut:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF:)];
    [_aView1.changeMen addGestureRecognizer:tap];
    [_scrollView addSubview:_aView1];
#pragma mark —— 火车票首页
    _aView2=[[trainView alloc]initWithFrame:CGRectMake(deviceScreenWidth, 0, deviceScreenWidth, self.view.frame.size.height-128)];
    [_aView2 initwithview];
    [_aView2.menbut addTarget:self action:@selector(changemen) forControlEvents:UIControlEventTouchUpInside];
    [_aView2.dataOutbut addTarget:self action:@selector(TchangeOutdata:) forControlEvents:UIControlEventTouchUpInside];
    NSString *strUrl5 = [_aView2.dataOutlabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *strUrl6 = [strUrl5 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    _TdatestrOut=[NSString stringWithFormat:@"%ld-%@",_aView2.year,strUrl6];
    [_aView2.outCitybut addTarget:self action:@selector(ToutCitybut:) forControlEvents:UIControlEventTouchUpInside];
    [_aView2.backCitybut addTarget:self action:@selector(TbackCitybut:) forControlEvents:UIControlEventTouchUpInside];
    [_aView2.lookupBut addTarget:self action:@selector(TlookupBut:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF2:)];
    [_aView2.changeMen addGestureRecognizer:tap1];
    [_scrollView addSubview:_aView2];
#pragma mark ——酒店首页
    _aView3=[[hotelView alloc]initWithFrame:CGRectMake(deviceScreenWidth*2, 0, deviceScreenWidth, self.view.frame.size.height-128)];
    [_aView3 initwithview];
    [_scrollView addSubview:_aView3];
    [_aView3.outCitybut addTarget:self action:@selector(hotelcity:) forControlEvents:UIControlEventTouchUpInside];
     [_aView3.seatbut addTarget:self action:@selector(hotelseatbut:) forControlEvents:UIControlEventTouchUpInside];
    [_aView3.menbut addTarget:self action:@selector(changemen) forControlEvents:UIControlEventTouchUpInside];
    [_aView3.dataOutbut addTarget:self action:@selector(HchangeOutdata:) forControlEvents:UIControlEventTouchUpInside];
    [_aView3.databackbut addTarget:self action:@selector(HchangeBackdata:) forControlEvents:UIControlEventTouchUpInside];
    NSString *strUrl7 = [_aView3.dataOutlabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *strUrl8 = [strUrl7 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    _HdatestrOut=[NSString stringWithFormat:@"%ld-%@",_aView3.year,strUrl8];
    NSString *strUr9 = [_aView1.databacklabel.text stringByReplacingOccurrencesOfString:@"月" withString:@"-"];
    NSString *strUrl10 = [strUr9 stringByReplacingOccurrencesOfString:@"日" withString:@""];
    _Hdatestrback=[NSString stringWithFormat:@"%ld-%@",_aView3.year,strUrl10];
    [_aView3.lookupBut addTarget:self action:@selector(HlookupBut:) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGF3:)];
    [_aView3.changeMen addGestureRecognizer:tap3];
    [self.view addSubview:_scrollView];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.alpha=0.5;
    effectView.userInteractionEnabled=YES;
    effectView.frame=CGRectMake(0, 0, deviceScreenWidth, deviceScreenHeight);
    _scrollView.userInteractionEnabled=YES;
    [_scrollView addSubview:effectView];
    
    pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, deviceScreenHeight+40, self.view.frame.size.width,deviceScreenWidth/3+60)];
    [pickerView setBackgroundColor:[UIColor whiteColor]];
    [pickerView setDataSource:self];
    [pickerView setDelegate:self];
    [pickerView setShowsSelectionIndicator:YES];
    [self loadPickerData];
    effectView.hidden=YES;
    UIView * vv = [[UIView alloc] initWithFrame:CGRectMake(0,deviceScreenHeight, self.view.frame.size.width, 40)];
    vv.userInteractionEnabled=YES;
    vv.tag=133;
    vv.backgroundColor=[UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [_scrollView addSubview:vv];
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
    [_scrollView addSubview:pickerView];
    //添加KVO
    [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    
   }
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if (object == _scrollView && [keyPath isEqualToString:@"contentOffset"]) {
        //获取contentOffset
        NSValue * pointValue = change[@"new"];
        CGFloat point;
        [pointValue getValue:&point];
    _vi.frame=CGRectMake((deviceScreenWidth/3)*(point/deviceScreenWidth), 126, deviceScreenWidth/3, 2);
        if ((point/deviceScreenWidth)==0) {
            _flightimage.image=[UIImage imageNamed:@"airplane-checked"];
            flightlabel.textColor=[UIColor whiteColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel"];
            hotlelabel.textColor=[UIColor grayColor];
            _trainmage.image=[UIImage imageNamed:@"railway"];
            trainlabel.textColor=[UIColor grayColor];
        }else if ((point/deviceScreenWidth)==1){
            _flightimage.image=[UIImage imageNamed:@"airplane"];
            flightlabel.textColor=[UIColor grayColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel"];
            hotlelabel.textColor=[UIColor grayColor];
            _trainmage.image=[UIImage imageNamed:@"railway-checked"];
            trainlabel.textColor=[UIColor whiteColor];
        }else if ((point/deviceScreenWidth)==2){
            _flightimage.image=[UIImage imageNamed:@"airplane"];
            flightlabel.textColor=[UIColor grayColor];
            _hotletimage.image=[UIImage imageNamed:@"hotel-checked"];
            hotlelabel.textColor=[UIColor whiteColor];
            _trainmage.image=[UIImage imageNamed:@"railway"];
            trainlabel.textColor=[UIColor grayColor];
        }else{
            
        }
        
    }
}
#pragma mark -机票事件触发
-(void)changeOutdata:(UIButton*)send{
//LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    if(![_aView1.databacklabel.text isEqualToString:@"返程日期"]){
//    ctl.sss=_datestrback;
//    ctl.isa=YES;
//    ctl.type=1;
//    }
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
//        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        _aView1.dataOutlabel.text = date;
//        _aView1.weekOutlabel.text=[weekday weekdaywith:paramas];
//        _datestrOut= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//         if(![_aView1.databacklabel.text isEqualToString:@"返程日期"]){
//        NSDate * d1=  [LGLCalendarDate dateFromString:_datestrOut];
//        
//        NSDate * d2=  [LGLCalendarDate dateFromString:_datestrback];
//        
//        NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        
//        _aView1.datacha.text=[NSString stringWithFormat:@"%ld天",h];
//         }
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"] isEqualToString:@"two"]){
        changeDateVc * cdc =[changeDateVc new];
        cdc.outOrback=@"out";
        cdc.type=@"flight";
        cdc.block=^(NSMutableDictionary*dict){
            NSString * date = [dict[@"out"] substringWithRange:NSMakeRange(5, 5)] ;
            NSString * string =[date stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            _aView1.dataOutlabel.text = [NSString stringWithFormat:@"%@日",string];
            _datestrOut=dict[@"out"];
            _aView1.weekOutlabel.text=[weekday weekdaywith1:dict[@"out"]];
            NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
            NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            _aView1.databacklabel.text = [NSString stringWithFormat:@"%@日",str];
            _datestrback=dict[@"back"];
            _aView1.weekbacklabel.hidden=NO;
            _aView1.weekbacklabel.text=[weekday weekdaywith1:dict[@"back"]];
            _aView1.datacha.text=[NSString stringWithFormat:@"%d天",[dict[@"num"] intValue]+1];
        };
        [self presentViewController:cdc animated:NO completion:nil];
    }else{
        changeDateVc * cdc =[changeDateVc new];
        cdc.outOrback=@"back";
        cdc.outdate=@"";
        cdc.type=@"flight";
        cdc.block=^(NSMutableDictionary*dict){
            NSString * date = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
            NSString * string =[date stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            _aView1.dataOutlabel.text = [NSString stringWithFormat:@"%@日",string];
            _datestrOut=dict[@"back"];
        _aView1.weekOutlabel.text=[weekday weekdaywith1:dict[@"back"]];
            
        };
        [self presentViewController:cdc animated:NO completion:nil];
    }
}
-(void)changeBackdata:(UIButton*)send{
//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    ctl.sss=_datestrOut;
//    ctl.isa=NO;
//     ctl.type=1;
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//       
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
//        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        _aView1.databacklabel.text = date;
//        _aView1.weekbacklabel.hidden=NO;
//        _aView1.weekbacklabel.text=[weekday weekdaywith:paramas];
//        _datestrback= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//        
//        NSDate * d1=  [LGLCalendarDate dateFromString:_datestrOut];
//        
//        NSDate * d2=  [LGLCalendarDate dateFromString:_datestrback];
//        
//        NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        
//        _aView1.datacha.text=[NSString stringWithFormat:@"%ld天",h];
//        
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrback=@"back";
//    cdc.outdate=_datestrOut;
    cdc.outdate=@"";

    cdc.type=@"flight";
    
    cdc.block=^(NSMutableDictionary*dict){
        
        NSDate * d1=  [LGLCalendarDate dateFromString:_datestrOut];
        NSDate * d2=  [LGLCalendarDate dateFromString:dict[@"back"]];
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        if (h<0) {
            [UIAlertView showAlertWithTitle1:@"你的返回日期不能早于出发日期，请重新选择！" duration:1.5];
        }else{
            NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
            NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
            _aView1.databacklabel.text = [NSString stringWithFormat:@"%@日",str];
            _aView1.weekbacklabel.hidden=NO;
            _aView1.weekbacklabel.text=[weekday weekdaywith1:dict[@"back"]];
            _datestrback=dict[@"back"];
            NSDate * d1=  [LGLCalendarDate dateFromString:_datestrOut];
            NSDate * d2=  [LGLCalendarDate dateFromString:_datestrback];
            NSInteger h=[weekday getDaysFrom:d1 To:d2];
            _aView1.datacha.text=[NSString stringWithFormat:@"%ld天",h+1];
        }
    };
    [self presentViewController:cdc animated:NO completion:nil];
 
    
}
-(void)changemen{
    ChangeMenViewController * men = [ChangeMenViewController new];
    men.type=1;
//NSLog(@"%@",_aView1.Mendataarr);
    men.menarry=_aView1.Mendataarr;
    
    men.block=^(NSMutableArray *array){
        menarr=array;
        _aView1.Mendataarr=menarr;
        [_aView1.menconView reloadData];
    };
    //[self.navigationController  pushViewController:men animated:YES];
    [self presentViewController:men animated:YES completion:nil];
}
-(void)picker:(UIButton*)send{
    UIView * vv=[UIView new];
    switch (send.tag) {
        case 211:
            self.tabBarController.tabBar.hidden=NO;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight-30, self.view.frame.size.width,deviceScreenWidth/3+60);
           vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
                  break;
             case 212:
            self.tabBarController.tabBar.hidden=NO;
            effectView.hidden=YES;
            pickerView.frame=CGRectMake(0, deviceScreenHeight-30, self.view.frame.size.width,deviceScreenWidth/3+60);
            vv =(UIView*)[self.view viewWithTag:133];
            vv.frame = CGRectMake(0, deviceScreenHeight, self.view.frame.size.width, self.view.frame.size.width/3+80);
            _aView1.seatlabel.text=seatstring;
            break;
        default:
            break;
    }
}
#pragma mark 设置滚动选择框
-(void)chick{
    [UIView animateWithDuration:0.5 animations:^{
        self.tabBarController.tabBar.hidden=YES;
        effectView.hidden=NO;
        // 设置view弹出来的位置
        pickerView.frame = CGRectMake(0, deviceScreenHeight-320, self.view.frame.size.width, self.view.frame.size.width/3+80);
        UIView * vv =(UIView*)[self.view viewWithTag:133];
        vv.frame = CGRectMake(0, deviceScreenHeight-360, self.view.frame.size.width, 40);
    }];
}
-(void)loadPickerData{
    _arr=@[@"舱位不限",@"经济舱",@"公务舱",@"头等舱",@"明珠舱"];
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
    return _arr[row];
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView reloadComponent:0];
//    [pickerView selectRow:0 inComponent:0 animated:NO];
    NSInteger rowOne = [pickerView selectedRowInComponent:0];
    seatstring = _arr[rowOne];
//NSLog(@"%@",seatstring);
}
-(void)backCitybut:(UIButton*)send{
    flightcityViewController * city = [flightcityViewController new ];
    city.block=^(NSString *citystr){
          [_aView1.backCitybut setTitle:citystr forState:UIControlStateNormal];
    };
    
   // [self.navigationController  pushViewController:city animated:YES];
    city.outcity=_aView1.outCitybut.titleLabel.text;
    
    [self presentViewController:city animated:YES completion:nil];
}
-(void)outCitybut:(UIButton*)send{
    flightcityViewController * city = [flightcityViewController new ];
    city.block=^(NSString *citystr){
        [_aView1.outCitybut setTitle:citystr forState:UIControlStateNormal];
    };
    city.backcity=_aView1.backCitybut.titleLabel.text;
    //[self.navigationController  pushViewController:city animated:YES];

    [self presentViewController:city animated:YES completion:nil];
}
-(void)lookupBut:(UIButton*)send{
   
    if (![_aView1.outCitybut.titleLabel.text isEqualToString:@"出发地"]&&![_aView1.backCitybut.titleLabel.text isEqualToString:@"目的地"]){
        if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]){

    NSString * strout =@"";
    NSString * strback =@"";
    FlightMessageVC * mvc = [FlightMessageVC new];
   
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString: @"1"]&&[[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]){
        mvc.menarray=_aView1.Mendataarr;
    }
    for (FlightModel * model  in flightarr) {
        if([_aView1.outCitybut.titleLabel.text isEqualToString:model.CityName]){
            strout=model.AirportCode;
        }
        if([_aView1.backCitybut.titleLabel.text isEqualToString:model.CityName]){
            strback=model.AirportCode;
        }
    }
            
    NSString  *seat=@"";
    if([_aView1.seatlabel.text isEqualToString:@"经济舱"]){
        seat=@"1";
    }else if([_aView1.seatlabel.text isEqualToString:@"舱位不限"]){
        seat=@"";
    }else if([_aView1.seatlabel.text isEqualToString:@"公务舱"]){
        seat=@"3";
    }else if([_aView1.seatlabel.text isEqualToString:@"头等舱"]){
        seat=@"4";
    }else{
        seat=@"2";
    }

    NSMutableDictionary * dict  =[NSMutableDictionary new];
    [dict setValue:strout forKey:@"outcity"];
    [dict setValue:strback forKey:@"backcity"];
   
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]){
        [dict setValue:_datestrback forKey:@"dataBack"];
    }
            
    [dict setValue:_datestrOut forKey:@"dataOut"];
    [dict setValue:_aView1.weekOutlabel.text forKey:@"week"];
    [dict setValue:_aView1.weekbacklabel.text forKey:@"week1"];
    [dict setValue:seat forKey:@"CabinType"];
    [dict setValue:_aView1.outCitybut.titleLabel.text forKey:@"outcityname"];
    [dict setValue:_aView1.backCitybut.titleLabel.text forKey:@"backcityname"];
    mvc.requtstdict=dict;
    mvc.publicNo=_aView1.publicNo;
    mvc.outcity=_aView1.outCitybut.titleLabel.text;
    mvc.backcity=_aView1.backCitybut.titleLabel.text;
        mvc.hidesBottomBarWhenPushed=YES;
//    [self presentViewController:mvc animated:NO completion:nil];
   [self.navigationController  pushViewController:mvc animated:YES];
   }else{
        NSString * strout =@"";
        NSString * strback =@"";
        FlightMessageVC * mvc = [FlightMessageVC new];
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"pubAndpri"] isEqualToString: @"1"]&&[[[NSUserDefaults standardUserDefaults] objectForKey:@"FYw"] isEqualToString: @"1"]){
        mvc.menarray=_aView1.Mendataarr;
    }
        for (FlightModel * model  in flightarr) {
            if([_aView1.outCitybut.titleLabel.text isEqualToString:model.CityName]){
                strout=model.AirportCode;
            }
            if([_aView1.backCitybut.titleLabel.text isEqualToString:model.CityName]){
                strback=model.AirportCode;
            }
        }
        NSString  *seat=@"";
        if([_aView1.seatlabel.text isEqualToString:@"经济舱"]){
            seat=@"1";
        }else if([_aView1.seatlabel.text isEqualToString:@"舱位不限"]){
            seat=@"";
        }else if([_aView1.seatlabel.text isEqualToString:@"公务舱"]){
            seat=@"3";
        }else if([_aView1.seatlabel.text isEqualToString:@"头等舱"]){
            seat=@"4";
        }else{
            seat=@"2";
        }
        NSMutableDictionary * dict  =[NSMutableDictionary new];
        [dict setValue:strout forKey:@"outcity"];
        [dict setValue:strback forKey:@"backcity"];
        [dict setValue:_datestrOut forKey:@"dataOut"];
        [dict setValue:_aView1.weekOutlabel.text forKey:@"week"];
        [dict setValue:_aView1.weekbacklabel.text forKey:@"week1"];
        [dict setValue:seat forKey:@"CabinType"];
        [dict setValue:_aView1.outCitybut.titleLabel.text forKey:@"outcityname"];
        [dict setValue:_aView1.backCitybut.titleLabel.text forKey:@"backcityname"];
        mvc.requtstdict=dict;
        mvc.publicNo=_aView1.publicNo;
        mvc.outcity=_aView1.outCitybut.titleLabel.text;
        mvc.backcity=_aView1.backCitybut.titleLabel.text;
         mvc.hidesBottomBarWhenPushed=YES;
        [self.navigationController  pushViewController:mvc animated:YES];
        }
    }else{
        if ([_aView1.outCitybut.titleLabel.text isEqualToString:@"出发地"]) {
            [UIAlertView showAlertWithTitle1:@"请选择出发地" duration:1.2];
        }else{
            [UIAlertView showAlertWithTitle1:@"请选择目的地" duration:1.2];
        }
    }
    NSString * twoAndoneStr =@"";
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"twoAndone"]isEqualToString:@"two"]) {
        twoAndoneStr=@"往返";
    }else{
        twoAndoneStr=@"单程";
    }
    
    NSMutableDictionary * dict =[NSMutableDictionary new];
    [dict setValue:_aView1.outCitybut.titleLabel.text forKey:@"outCityname"];
    [dict setValue: _aView1.backCitybut.titleLabel.text forKey:@"backCityname"];
    [dict setValue:twoAndoneStr forKey:@"twoAndOne"];
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"lookupBut"]];
    
    if (arr.count == 5) {
        [arr removeObjectAtIndex:0];
    }
    [arr addObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"lookupBut"];
    NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"lookupBut"];
   _aView1.lastarr=[NSMutableArray arrayWithArray:arr1];
    [_aView1.collectionView2 reloadData];
    
}
-(void)showGF:(UITapGestureRecognizer *)tap{
    ChangeMenViewController * men = [ChangeMenViewController new];
    men.type=1;
    men.menarry=_aView1.Mendataarr;
    men.block=^(NSMutableArray *array){
        menarr=array;
        _aView1.Mendataarr=menarr;
        [_aView1.menconView reloadData];
    };
    [self presentViewController:men animated:NO completion:nil];
   //[self.navigationController  pushViewController:men animated:YES];
}
#pragma mark - 火车票触发
-(void)TchangeOutdata:(UIButton*)send{
//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//        [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
//    NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        _aView2.dataOutlabel.text = date;
//        _aView2.weekOutlabel.text=[weekday weekdaywith:paramas];
//        _TdatestrOut= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    
    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrback=@"back";
    cdc.outdate=@"";
    cdc.type=@"flight";
    cdc.block=^(NSMutableDictionary*dict){
        NSString * date1 = [dict[@"back"] substringWithRange:NSMakeRange(5, 5)] ;
        NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
        _aView2.dataOutlabel.text = [NSString stringWithFormat:@"%@日",str];
        _aView2.weekOutlabel.text=[weekday weekdaywith1:dict[@"back"]];
        _TdatestrOut=dict[@"back"];
    };
    [self presentViewController:cdc animated:NO completion:nil];
    
}
-(void)ToutCitybut:(UIButton*)send{
    TrianCityVC * trivc= [TrianCityVC new];
    trivc.block=^(NSString *citystr,NSArray*arr){
        [_aView2.outCitybut setTitle:citystr forState:UIControlStateNormal];
        _traincity=arr;
    };
    trivc.backcity=_aView2.backCitybut.titleLabel.text;

      [self presentViewController:trivc animated:NO completion:nil];
   // [self.navigationController pushViewController:trivc animated:YES];
}
-(void)TbackCitybut:(UIButton*)send{
    TrianCityVC * trivc= [TrianCityVC new];
    trivc.block=^(NSString *citystr,NSArray*arr){
        [_aView2.backCitybut setTitle:citystr forState:UIControlStateNormal];
        _traincity=arr;
    };
    trivc.outcity=_aView2.outCitybut.titleLabel.text;
      [self presentViewController:trivc animated:NO completion:nil];
   //[self.navigationController pushViewController:trivc animated:YES];
}
-(void)TlookupBut:(UIButton*)send{
 
    if (![_aView2.outCitybut.titleLabel.text isEqualToString:@"出发地"]&&![_aView2.backCitybut.titleLabel.text isEqualToString:@"目的地"]) {
        TrainVC* tvc=[TrainVC new];
        NSString * strout =@"";
        NSString * strback =@"";
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"TpubAndpri"] isEqualToString: @"1"]&&[[[NSUserDefaults standardUserDefaults] objectForKey:@"TYw"] isEqualToString: @"1"]){
            tvc.menarray=_aView2.Mendataarr;
        }
        
        NSMutableArray* _arry =[NSMutableArray new];
        NSArray *arrcity =[[NSUserDefaults standardUserDefaults]objectForKey:@"tcity"];
       
        if (arrcity.count!=0) {
            for (int i=0; i<arrcity.count; i++) {
                TraincityMotel * model = [TraincityMotel mj_objectWithKeyValues:arrcity[i]];
                [ _arry addObject:model];
            }
            for (TraincityMotel * model  in _arry) {
                if([_aView2.outCitybut.titleLabel.text isEqualToString:model.stationName]){
                    strout=model.stationCode;
                }
                if([_aView2.backCitybut.titleLabel.text isEqualToString:model.stationName]){
                    strback=model.stationCode;
                }
            }
        }else{
            for (TraincityMotel * model  in _traincity) {
                if([_aView2.outCitybut.titleLabel.text isEqualToString:model.stationName]){
                    strout=model.stationCode;
                }
                if([_aView2.backCitybut.titleLabel.text isEqualToString:model.stationName]){
                    strback=model.stationCode;
                }
            }
  
        }
        
        NSMutableDictionary * dict  =[NSMutableDictionary new];
        [dict setValue:strout forKey:@"outcity"];
        [dict setValue:strback forKey:@"backcity"];
        [dict setValue:_TdatestrOut forKey:@"dataOut"];
        [dict setValue:_aView2.weekOutlabel.text forKey:@"week"];
        //[dict setValue:_aView2.weekbacklabel.text forKey:@"week1"];
        [dict setValue:_aView2.outCitybut.titleLabel.text forKey:@"outcityname"];
        [dict setValue:_aView2.backCitybut.titleLabel.text forKey:@"backcityname"];
        tvc.cityarr=[NSMutableArray arrayWithArray:_traincity];
        tvc.requtstdict=dict;
        tvc.outcity=_aView2.outCitybut.titleLabel.text;
        tvc.backcity=_aView2.backCitybut.titleLabel.text;
        tvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController  pushViewController:tvc animated:YES];
//        [self presentViewController:tvc animated:NO completion:nil];
       
        NSMutableDictionary * dict1 =[NSMutableDictionary new];
      
        [dict1 setValue:_aView2.outCitybut.titleLabel.text forKey:@"outCityname"];
        [dict1 setValue: _aView2.backCitybut.titleLabel.text forKey:@"backCityname"];
        
        NSMutableArray * arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"tlookupBut"]];
       
        if (arr.count == 5) {
            [arr removeObjectAtIndex:0];
        }
        
        
        [arr addObject:dict1];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"tlookupBut"];
        NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"tlookupBut"];
        _aView2.lastarr=[NSMutableArray arrayWithArray:arr1];
        
        [_aView2.collectionView2 reloadData];

    }else{
        if ([_aView2.outCitybut.titleLabel.text isEqualToString:@"出发地"]) {
            [UIAlertView showAlertWithTitle1:@"请选择出发地" duration:1.2];
        }else{
            [UIAlertView showAlertWithTitle1:@"请选择目的地" duration:1.2];
        }
    }
}
-(void)showGF2:(UITapGestureRecognizer *)tap{
    ChangeMenViewController * men = [ChangeMenViewController new];
    men.type=2;
    men.menarry=_aView2.Mendataarr;
    men.block=^(NSMutableArray *array){
        menarr=array;
        _aView2.Mendataarr=menarr;
        [_aView2.menconView reloadData];
    };
    [self presentViewController:men animated:NO completion:nil];
}
#pragma mark -酒店点击
//入住日期
-(void)HchangeOutdata:(UIButton *)send{

//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    
//    if(![_aView3.databacklabel.text isEqualToString:@"离店日期"]){
//    ctl.sss=_Hdatestrback;
//    ctl.isa=YES;
//    ctl.type=2;
//        }
    
//    [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
//        NSString *str1 =paramas[@"month"];
//        NSString *str2=paramas[@"day"];
//        if([paramas[@"month"] intValue]<10){
//            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
//        }
//        if([paramas[@"day"] intValue]<10){
//            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
//        }
//        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        _aView3.dataOutlabel.text = date;
//        _aView3.weekOutlabel.text=[weekday weekdaywith:paramas];
//        _HdatestrOut= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//        if(![_aView3.databacklabel.text isEqualToString:@"离店日期"]){
//
//        NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
//        
//        NSDate * d2=  [LGLCalendarDate dateFromString:_Hdatestrback];
//        
//        NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        
//        _aView3.datacha.text=[NSString stringWithFormat:@"%ld晚",h];
//        }
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];

    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrIn=@"in";
    cdc.type=@"hotel";
    cdc.block=^(NSMutableDictionary*dict){
        
        NSString * date = [dict[@"in"] substringWithRange:NSMakeRange(5, 5)] ;
        NSString * string =[date stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
        _aView3.dataOutlabel.text = [NSString stringWithFormat:@"%@日",string];
        _HdatestrOut=dict[@"in"];
        _aView3.weekOutlabel.text=[weekday weekdaywith1:dict[@"in"]];

        NSString * date1 = [dict[@"out"] substringWithRange:NSMakeRange(5, 5)] ;
        NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
        _aView3.databacklabel.text = [NSString stringWithFormat:@"%@日",str];
        _Hdatestrback=dict[@"out"];

        _aView3.weekbacklabel.hidden=NO;
        _aView3.weekbacklabel.text=[weekday weekdaywith1:dict[@"out"]];
        _aView3.datacha.text=[NSString stringWithFormat:@"%d晚",[dict[@"num"] intValue]];
    };
    [self presentViewController:cdc animated:NO completion:nil];
}
//离开日期
-(void)HchangeBackdata:(UIButton*)send{
//    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
//    ctl.sss=_HdatestrOut;
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
//        NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
//        _aView3.databacklabel.text = date;
//        _aView3.weekbacklabel.hidden=NO;
//        _aView3.weekbacklabel.text=[weekday weekdaywith:paramas];
//        _Hdatestrback= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
//        
//        NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
//        
//        NSDate * d2=  [LGLCalendarDate dateFromString:_Hdatestrback];
//        
//        NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        
//         _aView3.datacha.text=[NSString stringWithFormat:@"%ld晚",h];
//    }];
//    //[self.navigationController  pushViewController:ctl animated:YES];
//    [self presentViewController:ctl animated:YES completion:nil];
    
//    changeDateVc * cdc =[changeDateVc new];
//    cdc.outOrIn=@"out";
//    cdc.indate=_HdatestrOut;
//    cdc.type=@"hotel";
//    cdc.block=^(NSMutableDictionary*dict){
//        NSString * date1 = [dict[@"out"] substringWithRange:NSMakeRange(5, 5)] ;
//        NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
//        _aView3.databacklabel.text = [NSString stringWithFormat:@"%@日",str];
//        _aView3.weekbacklabel.hidden=NO;
//        _aView3.weekbacklabel.text=[weekday weekdaywith1:dict[@"out"]];
//        _Hdatestrback=dict[@"out"];
//                NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
//                NSDate * d2=  [LGLCalendarDate dateFromString:_Hdatestrback];
//                NSInteger h=[weekday getDaysFrom:d1 To:d2];
//        _aView3.datacha.text=[NSString stringWithFormat:@"%ld晚",h];
//    };
//    [self presentViewController:cdc animated:NO completion:nil];
//    
    
    changeDateVc * cdc =[changeDateVc new];
    cdc.outOrback=@"back";
    //    cdc.outdate=_datestrOut;
    cdc.outdate=@"";
    
    cdc.type=@"flight";
    
    cdc.block=^(NSMutableDictionary*dict){
        
        NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
        NSDate * d2=  [LGLCalendarDate dateFromString:dict[@"back"]];
        NSInteger h=[weekday getDaysFrom:d1 To:d2];
        if (h<0) {
            [UIAlertView showAlertWithTitle1:@"您要选择的离店日期不能早于入住日期，请重新选择！" duration:2];
        }else{
                    NSString * date1 = [dict[@"back"]substringWithRange:NSMakeRange(5, 5)] ;
                    NSString * str =[date1 stringByReplacingOccurrencesOfString:@"-" withString:@"月"];
                    _aView3.databacklabel.text = [NSString stringWithFormat:@"%@日",str];
                    _aView3.weekbacklabel.hidden=NO;
                    _aView3.weekbacklabel.text=[weekday weekdaywith1:dict[@"back"]];
                    _Hdatestrback=dict[@"back"];
                            NSDate * d1=  [LGLCalendarDate dateFromString:_HdatestrOut];
                            NSDate * d2=  [LGLCalendarDate dateFromString:_Hdatestrback];
                            NSInteger h=[weekday getDaysFrom:d1 To:d2];
                    _aView3.datacha.text=[NSString stringWithFormat:@"%ld晚",h];

        }
    };
    [self presentViewController:cdc animated:NO completion:nil];
    
 
}
//选取人员
-(void)showGF3:(UITapGestureRecognizer*)tap3{
    ChangeMenViewController * men = [ChangeMenViewController new];
    men.type=3;
    
    men.menarry=_aView3.Mendataarr;

    men.block=^(NSMutableArray *array){
        menarr=array;
        _aView3.Mendataarr=menarr;
        [_aView3.menconView reloadData];
    };
    [self presentViewController:men animated:NO completion:nil];
}
//选取城市
-(void)hotelcity:(UIButton *)send{
    HotelcityVC * hvc =[HotelcityVC new];
    hvc.block=^(NSString *hotelcitystr){
      [_aView3.outCitybut setTitle:hotelcitystr forState:UIControlStateNormal];
    };
     [self presentViewController:hvc animated:NO completion:nil];
}
//查询酒店
-(void)HlookupBut:(UIButton*)send{
    
if(![_aView3.databacklabel.text isEqualToString:@"离店日期"]){
    HotelVC * hvc =[HotelVC new];
    NSString * strout =@"";
           if([[[NSUserDefaults standardUserDefaults] objectForKey:@"HpubAndpri"] isEqualToString: @"1"]&&[[[NSUserDefaults standardUserDefaults]objectForKey:@"HYw"]isEqualToString:@"1"]){
        hvc.menarray=_aView3.Mendataarr;
    }
    for (HotelModel * model  in hotelarr) {
        if([_aView3.outCitybut.titleLabel.text isEqualToString:model.cityName]){
            strout=model.cityId;
        }
    }
    NSMutableDictionary * dict  =[NSMutableDictionary new];
    [dict setValue:strout forKey:@"outcitycode"];
    [dict setValue:_Hdatestrback forKey:@"dataBack"];
    [dict setValue:_HdatestrOut forKey:@"dataOut"];
    [dict setValue:_aView3.weekOutlabel.text forKey:@"week"];
    [dict setValue:_aView3.weekbacklabel.text forKey:@"week1"];
    [dict setValue:_aView3.outCitybut.titleLabel.text forKey:@"outcityname"];
    
    if ((![_aView3.seatlabel.text isEqualToString:@""])&&(![_aView3.seatlabel.text isEqualToString:@"酒店名/行政区/商圈"])) {
        [dict setValue:_aView3.seatlabel.text forKey:@"seatname"];
        [dict setValue: _hotelseatdic forKey:@"seatDict"];
        [dict setValue:@"YES" forKey:@"type"];
    }
    
    hvc.requtstdict=dict;
    hvc.outcity=_aView3.outCitybut.titleLabel.text;
    hvc.hidesBottomBarWhenPushed = YES;
    [self.navigationController  pushViewController:hvc animated:YES];
    
}else{
    [UIAlertView showAlertWithTitle:@"离店日期不能为空，请选择。"];
 }
}
-(void)hotelseatbut:(UIButton*)but{
    if ([_aView3.outCitybut.titleLabel.text isEqualToString:@""]) {
        [UIAlertView showAlertWithTitle1:@"请选择城市" duration:1.2];
    }else{
    HotelChangeVC * hcvc =[HotelChangeVC new];
    hcvc.hidesBottomBarWhenPushed=YES;
    NSString * cityid = @"";
    for (HotelModel * model  in hotelarr) {
        if([_aView3.outCitybut.titleLabel.text isEqualToString:model.cityName]){
            cityid=model.cityId;
         }
    }
     hcvc.cityId=cityid;
      
        hcvc.block=^(NSMutableDictionary * celldic){
           
            _hotelseatdic=celldic;
            
            if ([[celldic allKeys] containsObject:@"poiName"]) {
                _aView3.seatlabel.text=celldic[@"poiName"];
            }else{
                _aView3.seatlabel.text=celldic[@"name"];;
            }
        };
    [self.navigationController  pushViewController:hcvc animated:YES];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    self.tabBarController.tabBar.hidden=NO;
    _connetview.frame=CGRectMake(0,deviceScreenHeight, deviceScreenWidth, deviceScreenHeight);
    _flightbut.hidden=NO;
    _hotlebut.hidden=NO;
    _trainbut.hidden=NO;
}
//实现接收通知方法
- (void)changehostory:(NSNotification*)hotel{
    
    NSDictionary *dict = hotel.userInfo;
    
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"hlookupBut"]];
    BOOL all = false;
    if (arr.count == 5) {
        [arr removeObjectAtIndex:0];
    }
    
    for (NSMutableDictionary * dic in arr) {
        if ([dict[@"hotelName"] isEqualToString:dic[@"hotelName"]]) {
            all=YES;
            break;
        }
    }
    if (all==NO) {
        [arr addObject:dict];
    }
    
[[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"hlookupBut"];
    
    NSArray * arr1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"hlookupBut"];
        _aView3.lastarr=[NSMutableArray arrayWithArray:arr1];
        [_aView3.collectionView2 reloadData];
//        NSLog(@"%@",_aView3.lastarr);
}
//实现接收通知方法
- (void)changeLabelText:(NSNotification*)nf{
    
    NSDictionary *dict = nf.userInfo;
        NSInteger  isOn = [dict[@"num"] integerValue];
    _scrollView.contentOffset=CGPointMake(self.view.frame.size.width*(isOn-1), 0);
    _vi.frame=CGRectMake((deviceScreenWidth/3)*(isOn-1), 126 , deviceScreenWidth/3, 2);
    self.tabBarController.tabBar.hidden=NO;
}
-(void)dealloc{
    //删除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"num" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"hostory" object:nil];
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
    
}
@end
