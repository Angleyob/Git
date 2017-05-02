//
//  LookupSiteVC.m
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "LookupSiteVC.h"
#import "LGLCalenderViewController.h"
#import "LGLCalendarDate.h"
#import "flightcityViewController.h"
@interface LookupSiteVC ()<UITextFieldDelegate,UIApplicationDelegate>
{
    UILabel * datelabel;
    UILabel * weeklabel1;
    
    UILabel * fromcitylabel;
    UILabel * tocitylabel;
    
    UIButton * outcitybut;
    UIButton * incitybbut;
    
    NSMutableArray* flightarr;
}

@end
@implementation LookupSiteVC

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

    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    UIView * view  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 9, 375, 132)]];
    view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:view];
    
    UIButton  * changebut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(331, 30, 30, 30)]];
    [changebut setBackgroundImage:[UIImage imageNamed:@"recommend_check"] forState:UIControlStateNormal];
    [changebut addTarget:self action:@selector(changebutclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:changebut];
    
    UILabel * fromlabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 11, 64, 18)]];
    fromlabel.text=@"出发地:";
    fromlabel.font=[UIFont systemFontOfSize:14];
    fromlabel.textAlignment=NSTextAlignmentLeft;
    fromlabel.textColor=[UIColor blackColor];
    [view addSubview:fromlabel];
    
    outcitybut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 0, 150, 42)]];
    [outcitybut addTarget:self action:@selector(citybutclick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:outcitybut];
 
    fromcitylabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(2, 10, 104, 18)]];
    fromcitylabel.text=@"请选择城市";
    fromcitylabel.font=[UIFont systemFontOfSize:14];
    fromcitylabel.textAlignment=NSTextAlignmentLeft;
    fromcitylabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [outcitybut addSubview:fromcitylabel];
    
    
    UIView * viewline  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 44, 295, 1)]];
    viewline.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view addSubview:viewline];

    
    UILabel * tolabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 55, 64, 18)]];
    tolabel.text=@"到达地:";
    tolabel.font=[UIFont systemFontOfSize:14];
    tolabel.textAlignment=NSTextAlignmentLeft;
    tolabel.textColor=[UIColor blackColor];
    [view addSubview:tolabel];
    
    incitybbut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 45, 150, 42)]];
    [incitybbut addTarget:self action:@selector(citybutclick1:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:incitybbut];
    
    tocitylabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(2, 10, 104, 18)]];
    tocitylabel.text=@"请选择城市";
    tocitylabel.font=[UIFont systemFontOfSize:14];
    tocitylabel.textAlignment=NSTextAlignmentLeft;
    tocitylabel.textColor=[UIColor colorWithRed:200/255.0 green:200/255.0 blue:204/255.0 alpha:1];
    [incitybbut addSubview:tocitylabel];
    
    UIView * viewline2  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 87, 355, 1)]];
    viewline2.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [view addSubview:viewline2];
    
    UILabel * label1  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 99, 84, 18)]];
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
    
    UIView * view0  = [[UIView alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(120, 88, 240, 43)]];
    datelabel  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(0, 10, 125, 18)]];
    datelabel.text=_startFlyDate;
    datelabel.font=[UIFont systemFontOfSize:13];
    datelabel.textAlignment=NSTextAlignmentLeft;
    datelabel.textColor=[UIColor blackColor];
    [view0 addSubview:datelabel];
    
    weeklabel1  = [[UILabel alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(135, 10, 64, 18)]];
    weeklabel1.text=_WeekLabel;
    weeklabel1.font=[UIFont systemFontOfSize:13];
    weeklabel1.textAlignment=NSTextAlignmentLeft;
    weeklabel1.textColor=[UIColor blackColor];
    [view0 addSubview:weeklabel1];
    UITapGestureRecognizer *tagTar = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showGFtagTar:)];
    [view0 addGestureRecognizer:tagTar];
    
    [view addSubview:view0];
    
    UIButton  * okbut  = [[UIButton alloc]initWithFrame:[framsizeclass newSuitFrame:CGRectMake(20, 171, 335, 44)]];
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
        _WeekLabel=[weekday weekdaywith:paramas];
        _startFlyDate= [NSString stringWithFormat:@"%@-%@-%@",paramas[@"year"],str1 ,str2];
        weeklabel1.text=_WeekLabel;
        datelabel.text=_startFlyDate;
    }];
    [self presentViewController:ctl animated:YES completion:nil];
    
    
    
    
}
-(void)okbutclick:(UIButton*)send{
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD show];
    StatusListVC * lvc = [StatusListVC new];
    lvc.startFlyDate=_startFlyDate;
    lvc.numORdate=YES;
    FlightScheduleListQuery * slq = [FlightScheduleListQuery new];
    slq.MemberId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"memberId"];
    slq.LoginUserId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInf"][@"loginUserId"];
    slq.FlightDate=_startFlyDate;
    
    NSString * strout =@"";
    NSString * strback =@"";
    for (FlightModel * model  in flightarr) {
        if([fromcitylabel.text isEqualToString:model.CityName]){
            strout=model.AirportCode;
        }
        if([tocitylabel.text isEqualToString:model.CityName]){
            strback=model.AirportCode;
        }
    }
    slq.FlightValue=[NSString stringWithFormat:@"%@%@",strout,strback];
    [Flight FlightScheduleListQuery:slq success:^(id data) {
        [SVProgressHUD dismiss];
                NSLog(@"%@",data);
        if ([data[@"status"] isEqualToString:@"T"]) {
            lvc.Alldata=data;
            lvc.flightnum=data[@"data"][0][@"flightNo"];
            lvc.startcity=data[@"data"][0][@"departCityName"];
            lvc.stopcity=data[@"data"][0][@"arriveCityName"];
            [self presentViewController:lvc animated:NO completion:nil];
        }else{
            [UIAlertView showAlertWithTitle:data[@"message"]];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"请检查您的网络"] duration:1.0];
    }];
    
}
-(void)changebutclick:(UIButton*)send{
    NSString * str = [[NSString alloc]init];
    NSString * s = [[NSString alloc]init];
    str = fromcitylabel.text;
    s = tocitylabel.text;
    fromcitylabel.text=s;
    tocitylabel.text=str;
}
-(void)citybutclick:(UIButton*)send{
    flightcityViewController * city = [flightcityViewController new ];
    city.block=^(NSString *citystr){
        fromcitylabel.text =citystr;
        fromcitylabel.textColor=[UIColor blackColor];
    };
    city.outcity=tocitylabel.text;
    // [self.navigationController  pushViewController:city animated:YES];
    [self presentViewController:city animated:YES completion:nil];
}
-(void)citybutclick1:(UIButton*)send{
flightcityViewController * city = [flightcityViewController new ];
    city.block=^(NSString *citystr){
        tocitylabel.text=citystr;
        tocitylabel.textColor=[UIColor blackColor];
    };
    city.backcity=fromcitylabel.text;
    // [self.navigationController  pushViewController:city animated:YES];
    [self presentViewController:city animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
