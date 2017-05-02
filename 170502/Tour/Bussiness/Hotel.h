//
//  Hotel.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HotelBaseDataList.h"
#import "HotelInfQuery.h"
#import "HotelOrder.h"
#import "HotelOrderCancel.h"
#import "HotelOrderInfQuery.h"
#import "HotelOrderQuery.h"
#import "HotelQuery.h"
#import "RoomQuery.h"

//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Hotel : NSObject
+(void)HotelBaseDataList:(HotelBaseDataList*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelInfQuery:(HotelInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelOrder:(HotelOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelOrderCancel:(HotelOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelOrderInfQuery:(HotelOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelOrderQuery:(HotelOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)HotelQuery:(HotelQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)RoomQuery:(RoomQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
