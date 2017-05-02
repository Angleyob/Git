//
//  weekday.h
//  LGLCalender-Demo
//
//  Created by Euet on 16/12/19.
//  Copyright © 2016年 李国良. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface weekday : NSObject

+(NSString*)weekdaywith1:(NSString *)string;


+(NSString*)weekdaywith:(NSMutableDictionary *)dict;

+(NSString*)weekdaywithday:(NSInteger)day month:(NSInteger)month year:(NSInteger)year;

+(NSInteger)getDaysFrom:(NSDate *)serverDate To:(NSDate *)endDate;
@end
