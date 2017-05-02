//
//  NumLookupVC.m
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "NumLookupVC.h"
#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"
@interface NumLookupVC ()<UITextFieldDelegate,UIApplicationDelegate>
{
    UILabel * datelabel;
    UILabel * weeklabel1;
}

@end

@implementation NumLookupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 9, 375, 88)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UILabel * label  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 64, 18)]];
    label.text=@"航班号:";
    label.font=[UIFont systemFontOfSize:14];
    label.textAlignment=NSTextAlignmentLeft;
    label.textColor=[UIColor blackColor];
    [view addSubview:label];
    
    _flightNO =[[UITextField alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 11, 240, 18)]];
    _flightNO.placeholder=@"请输入航班号";
    _flightNO.textColor=[UIColor blackColor];
    _flightNO.font=[UIFont systemFontOfSize:14];
    _flightNO.tintColor =[UIColor blackColor];
    //设置删除文字按钮
    _flightNO.clearButtonMode = UITextFieldViewModeWhileEditing;
    _flightNO.tag =2;
    //keyboardType 键盘样式
    _flightNO.keyboardType = UIKeyboardTypeDefault;
    //设置return键样式
    _flightNO.returnKeyType = UIReturnKeyNext;
       //设置代理
    _flightNO.delegate = self;
    [view addSubview:_flightNO];
   
    
    UIView * viewline  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 44, 355, 1)]];
    viewline.backgroundColor=UIColorFromRGBA(0xc8c7cc, 1.0);
    [view addSubview:viewline];

    
    UILabel * label1  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 55, 84, 18)]];
    label1.text=@"起飞日期:";
    label1.font=[UIFont systemFontOfSize:14];
    label1.textAlignment=NSTextAlignmentLeft;
    label1.textColor=[UIColor blackColor];
    [view addSubview:label1];

    
    //获取当前时间并转换为字符串
    NSDate * date1 = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //两月后的一天
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = nil;
    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:date1];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:0];
    [adcomps setMonth:+2];
    [adcomps setDay:0];
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:date1 options:0];
    NSDateFormatter * dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy-MM-dd"];
   _twomothdate  = [dateFormatter1 stringFromDate:newdate];

    
    _startFlyDate = [dateFormatter stringFromDate:date1];
    _WeekLabel=@"今天";
    UIView * view0  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 45, 240, 43)]];
    datelabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 10, 125, 18)]];
    datelabel.text=_startFlyDate;
    datelabel.font=[UIFont systemFontOfSize:13];
    datelabel.textAlignment=NSTextAlignmentLeft;
    datelabel.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [view0 addSubview:datelabel];

    weeklabel1  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(135, 10, 64, 18)]];
    weeklabel1.text=_WeekLabel;
    weeklabel1.font=[UIFont systemFontOfSize:13];
    weeklabel1.textAlignment=NSTextAlignmentLeft;
    weeklabel1.textColor=UIColorFromRGBA(0x4a4a4a, 1.0);
    [view0 addSubview:weeklabel1];
    UITapGestureRecognizer *tagTar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtagTar:)];
    [view0 addGestureRecognizer:tagTar];
    [view addSubview:view0];

    
    UIButton  * okbut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 127, 335, 44)]];
    okbut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    okbut.clipsToBounds=YES;
    //圆角
    okbut.layer.cornerRadius = 10.0;
    [okbut setTitle:@"立即查询" forState:UIControlStateNormal];
    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okbut addTarget:self action:@selector(okbutclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:okbut];
}
-(void)showGFtagTar:(UITapGestureRecognizer *)tagTar{
   
    LGLCalenderViewController * ctl = [[LGLCalenderViewController alloc] init];
    ctl.twomothdate=_twomothdate;
       [ctl seleDateWithBlock:^(NSMutableDictionary *paramas) {
        NSString *str1 =paramas[@"month"];
        NSString *str2=paramas[@"day"];
        if([paramas[@"month"] intValue]<10){
            str1=[NSString stringWithFormat:@"0%@",paramas[@"month"]];
        }
        if([paramas[@"day"] intValue]<10){
            str2=[NSString stringWithFormat:@"0%@",paramas[@"day"]];
        }
// NSString * date = [NSString stringWithFormat:@"%@月%@日", str1, str2];
       _WeekLabel=[weekday weekdaywith:paramas];
       _startFlyDate= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
           weeklabel1.text=_WeekLabel;
           datelabel.text=_startFlyDate;
       }];
    //[self.navigationController  pushViewController:ctl animated:YES];
    [self presentViewController:ctl animated:YES completion:nil];
}
-(void)okbutclick:(UIButton*)send{
    if ([_flightNO.text isEqualToString:@""]) {
        [UIAlertView showAlertWithTitle:@"请输入的航班号"];
    }else{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    StatusListVC * lvc = [StatusListVC new];
    lvc.startFlyDate=datelabel.text;
    lvc.flightnum=_flightNO.text;
    lvc.numORdate=NO;
    FlightScheduleListQuery * slq = [FlightScheduleListQuery new];
    slq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    slq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    slq.FlightDate=datelabel.text;
    slq.FlightValue=_flightNO.text;
    [Flight FlightScheduleListQuery:slq success:^(id data) {
         [SVProgressHUD dismiss];
// NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            lvc.Alldata=data;
            lvc.startcity=data[@"data"][0][@"departCityName"];
            lvc.stopcity=data[@"data"][0][@"arriveCityName"];
            [self presentViewController:lvc animated:NO completion:nil];
        }else{
            [UIAlertView showAlertWithTitle:@"您输入的航班号有误，请重新输入"];
        }
    } failure:^(NSError *error) {
          [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
}
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
