//
//  Train.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PassStationQuery.h"
#import "TGQApproveQuery.h"
#import "TrainAccountQuery.h"
#import "TrainAccountVerify.h"
#import "TrainCancelChange.h"
#import "TrainChangeInfQuery.h"
#import "TrainChangeQuery.h"
#import "TrainOrder.h"
#import "TrainOrderCancel.h"
#import "TrainOrderChange.h"
#import "TrainOrderInfQuery.h"
#import "TrainOrderQuery.h"
#import "TrainOrderReturn.h"
#import "TrainQuery.h"
#import "TrainReturnInfQuery.h"
#import "TrainReturnQuery.h"
#import "TrainServiceFeeQuery.h"
#import "TrainStationQuery.h"
#import "TrainStationSearch.h"

//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Train : NSObject
+(void)PassStationQuery:(PassStationQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TGQApproveQuery:(TGQApproveQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainAccountQuery:(TrainAccountQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainAccountVerify:(TrainAccountVerify*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainCancelChange:(TrainCancelChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainChangeInfQuery:(TrainChangeInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainChangeQuery:(TrainChangeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrder:(TrainOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrderCancel:(TrainOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrderChange:(TrainOrderChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrderInfQuery:(TrainOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrderQuery:(TrainOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainOrderReturn:(TrainOrderReturn*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainQuery:(TrainQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainReturnInfQuery:(TrainReturnInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainReturnQuery:(TrainReturnQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainServiceFeeQuery:(TrainServiceFeeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainStationQuery:(TrainStationQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

+(void)TrainStationSearch:(TrainStationSearch*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
