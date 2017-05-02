//
//  Flight.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AirwayQuery.h"
#import "AttentionFlightScheduleListQuery.h"
#import "CabinOnSaleQuery.h"
#import "CabinQuery.h"
#import "CabinTypeQuery.h"
#import "CancelFlightSchedule.h"
#import "CustomFlightSchedule.h"
#import "FlightChangeQuery.h"
#import "FlightChangeInfQuery.h"
#import "FlightEndorseTicketCancel.h"
#import "FlightOrder.h"
#import "FlightOrderCancel.h"
#import "FlightOrderChange.h"
#import "FlightOrderInfQuery.h"
#import "FlightOrderQuery.h"
#import "FlightOrderReturn.h"
#import "FlightQuery.h"
#import "FlightReturnInfQuery.h"
#import "FlightReturnQuery.h"
#import "FlightReturnTicketCancel.h"
#import "FlightScheduleListQuery.h"
#import "RemarkString.h"
#import "StopOverQuery.h"
#import "WhiteListVerify.h"
//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Flight : NSObject
+(void)AirwayQuery:(AirwayQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)AttentionFlightScheduleListQuery:(AttentionFlightScheduleListQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)CabinOnSaleQuery:(CabinOnSaleQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)CabinQuery:(CabinQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)CabinTypeQuery:(CabinTypeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)CancelFlightScheduleyQuery:(CancelFlightSchedule*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)CustomFlightSchedule:(CustomFlightSchedule*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightChangeInfQuery:(FlightChangeInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightChangeQuery:(FlightChangeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightEndorseTicketCancel:(FlightEndorseTicketCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrder:(FlightOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrderCancel:(FlightOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrderChange:(FlightOrderChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrderInfQuery:(FlightOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrderQuery:(FlightOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightOrderReturn:(FlightOrderReturn*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightQuery:(FlightQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightReturnInfQuery:(FlightReturnInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightReturnQuery:(FlightReturnQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightReturnTicketCancel:(FlightReturnTicketCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)FlightScheduleListQuery:(FlightScheduleListQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)RemarkString:(RemarkString*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)StopOverQuery:(StopOverQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)WhiteListVerify:(WhiteListVerify*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
