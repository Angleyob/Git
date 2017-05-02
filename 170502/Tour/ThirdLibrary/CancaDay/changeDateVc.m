//
//  changeDateVc.m
//  Tour
//
//  Created by Euet on 17/4/22.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "changeDateVc.h"

#import "CalendarHomeViewController.h"
#import "CalendarDayModel.h"

@interface changeDateVc ()
{
    CalendarHomeViewController *chvc;
    NSInteger days;
}
@end

@implementation changeDateVc

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor=[UIColor whiteColor];

    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 120 , 30)];
    label.text=@"入住/离店日期";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backbut];
//    UIButton * okbut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-60, 25, 60, 20)];
//    okbut.titleLabel.font=[UIFont systemFontOfSize:15];
//    [okbut setTitle:@"完成" forState:UIControlStateNormal];
//    [okbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [okbut addTarget:self action:@selector(okbut:) forControlEvents:UIControlEventTouchUpInside];
//    [view addSubview:okbut];
    
    dataArray=[[NSMutableArray alloc] init];
    
    chvc = [[CalendarHomeViewController alloc]init];
    chvc.view.frame=CGRectMake(0,64, self.view.frame.size.width, self.view.frame.size.height);
    [self.view addSubview:chvc.view];
    
    
    [chvc setHotelToDay:2000 ToDateforString:nil];
   
        chvc.type=_type;

    if ([_type isEqualToString:@"hotel"]) {
        //酒店离店日期--单选标识
        NSString * outOrIn=_outOrIn;
        chvc.outOrIn=outOrIn;
        //酒店离店日期--单选时的入住日期
        chvc.indate=_indate;
     
        if ([_outOrIn isEqualToString:@"in"]) {
            label.text=@"入住/离店日期";
            [self mainViewClass:0];
        }else{
            label.text=@"离店日期";
        }
        
        chvc.calendarblock = ^(CalendarDayModel * model){
            if ([outOrIn isEqualToString:@"out"]) {
                NSLog(@"%@",[model toString]);
                [self changedate:model];
                [self okbutOne];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self changedate:model];
                [self mainViewClass:dataArray.count];
            }
        };
    }else if ([_type isEqualToString:@"flight"]){
        //机票返回日期--单选标识
        NSString * outOrback=_outOrback;
        chvc.outOrback=outOrback;
        //机票返回日期--单选时的入住日期
        chvc.outdate=_outdate;
        if ([_outOrback isEqualToString:@"out"]) {
            label.text=@"出发/返回日期";
            [self FmainViewClass:0];
        }else{
            label.text=@"选择日期";
        }
        chvc.calendarblock = ^(CalendarDayModel * model){
            if ([outOrback isEqualToString:@"back"]) {
                NSLog(@"%@",[model toString]);
                [self changedate:model];
                [self FokbutOne];
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self changedate:model];
                [self FmainViewClass:dataArray.count];
            }
        };
    }else{
        chvc.calendarblock = ^(CalendarDayModel * model){
                NSLog(@"%@",[model toString]);
                [self changedate:model];
                [self okbutOne];
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
}
-(void)changedate:(CalendarDayModel*)model{
    
    if(model.style==CellDayTypeClick)
    {
        [dataArray addObject:model.toString];
        
        NSSet *set = [NSSet setWithArray:dataArray];
        
        dataArray=[[set allObjects] mutableCopy];
        
        [dataArray sortUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
            return [obj1 compare:obj2];
        }];
    }
    else{
        if (![_outdate isEqualToString:@""]) {
            [dataArray addObject:model.toString];
        }else{
            [dataArray removeObject:model.toString];
        }
    }
}

    
-(void)mainViewClass:(NSInteger)num
{
    [mainView removeFromSuperview];
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50,self.view.frame.size.width,50)];
    mainView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mainView];
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:lable];
    
    if(num==0)
    {
        lable.text=@"请选择入住时间";
    }
    if(num==1)
    {
        lable.text=@"请选择离店时间";
    }
    if(num==2)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[dataArray objectAtIndex:1]];
        
        NSLog(@"%@",date1);
        NSLog(@"%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
         days = [comps day];
        lable.text=[NSString stringWithFormat:@"%@入住---%@离店 共%ld晚",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1],days];
    }
    if (dataArray.count!=0) {
        if (dataArray.count==2) {
            [self okbutTwo];
        }
    }
}

-(void)FmainViewClass:(NSInteger)num
{
    [mainView removeFromSuperview];
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-50,self.view.frame.size.width,50)];
    mainView.backgroundColor=[UIColor grayColor];
    [self.view addSubview:mainView];
    
    UILabel * lable =[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    lable.font=[UIFont systemFontOfSize:14.0f];
    lable.textColor=[UIColor whiteColor];
    lable.textAlignment=NSTextAlignmentCenter;
    [mainView addSubview:lable];
    
    if(num==0)
    {
        lable.text=@"请选择出发日期";
    }
    if(num==1)
    {
        lable.text=@"请选择返回日期";
    }
    if(num==2)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSDate* date1 = [formatter dateFromString:[dataArray objectAtIndex:0]];
        NSDate* date2 = [formatter dateFromString:[dataArray objectAtIndex:1]];
        
        NSLog(@"%@",date1);
        NSLog(@"%@",date2);
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:date1 toDate:date2  options:0];
        days = [comps day];
        lable.text=[NSString stringWithFormat:@"%@出发---%@返回 共%ld天",[dataArray objectAtIndex:0],[dataArray objectAtIndex:1],days+1];
    }
    
    if (dataArray.count!=0) {
        if (dataArray.count==2) {
            [self FokbutTwo];
        }
    }
}


-(void)okbutTwo{
    if (_block) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setValue:[dataArray objectAtIndex:0] forKey:@"in"];
        [dict setValue:[dataArray objectAtIndex:1] forKey:@"out"];
        NSNumber *number=[NSNumber numberWithUnsignedInteger:days];
        [dict setValue:number forKey:@"num"];
        _block(dict);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)okbutOne{
    if (_block) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setValue:[dataArray objectAtIndex:0] forKey:@"out"];
        _block(dict);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)FokbutTwo{
    if (_block) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setValue:[dataArray objectAtIndex:0] forKey:@"out"];
        [dict setValue:[dataArray objectAtIndex:1] forKey:@"back"];
        NSNumber *number=[NSNumber numberWithUnsignedInteger:days];
        [dict setValue:number forKey:@"num"];
        _block(dict);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)FokbutOne{
    if (_block) {
        NSMutableDictionary * dict = [NSMutableDictionary new];
        [dict setValue:[dataArray objectAtIndex:0] forKey:@"back"];
        _block(dict);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)DateWithBlock:(DateBalock)block{
  
    _block=block;
    
}
-(void)back:(UIButton*)send{
   
[self dismissViewControllerAnimated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
