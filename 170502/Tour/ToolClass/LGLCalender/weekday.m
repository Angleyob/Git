//
//  weekday.m
//  LGLCalender-Demo
//
//  Created by Euet on 16/12/19.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import "weekday.h"

@implementation weekday
#pragma mark -传入参数-字典-为月，日，年的变为字符串的方法
+(NSString*)weekdaywith:(NSMutableDictionary *)dic{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    NSInteger d =[dic[@"day"] integerValue];
     NSInteger m =[dic[@"month"] integerValue];
     NSInteger y =[dic[@"year"] integerValue];
    [_comps setDay:d];
    [_comps setMonth:m];
    [_comps setYear:y];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *
    weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
        NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString * weekStr = weekArray[_weekday-1];
    
    return weekStr;
}
#pragma mark -传入参数NSInteger为月，日，年的变为字符串的方法
+(NSString*)weekdaywithday:(NSInteger)day month:(NSInteger)month year:(NSInteger)year{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
   
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *
    weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:_date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString * weekStr = weekArray[_weekday-1];
    return weekStr;
};

#pragma mark -计算两个NSdate相差几天的方法
+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate
{
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [gregorian setFirstWeekday:2];
    //去掉时分秒信息
    NSDate *fromDate;
    NSDate *toDate;
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:serverDate];
    [gregorian rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:endDate];
    NSDateComponents *dayComponents = [gregorian components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return dayComponents.day;
}

+(NSString*)weekdaywith1:(NSString *)string{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:string];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *
    weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    NSInteger _weekday = [weekdayComponents weekday];
    NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
    NSString * weekStr = weekArray[_weekday-1];
    return weekStr;
}

@end
