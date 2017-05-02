//
//  Activity.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IndianaActivityQueryRequest.h"
#import "IndianaContactSubmit.h"
#import "IndianaActivityWinnerQueryRequest.h"
#import "IndianaActivityRecordCreateRequest.h"

//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);


@interface Activity : NSObject
//获取活动
+(void)IndianaActivityQueryRequest:(IndianaActivityQueryRequest*)IndianaActivityQuery  success:(HttpSuccess)success failure:(HttpFailure)failure;
//提交资料
+(void)IndianaContactSubmit:(IndianaContactSubmit*)IndianaContactSubmit  success:(HttpSuccess)success failure:(HttpFailure)failure;
//获取中奖名单
+(void)IndianaActivityWinnerQueryRequest:(IndianaActivityWinnerQueryRequest*)IndianaActivityWinnerQuery  success:(HttpSuccess)success failure:(HttpFailure)failure;
//参与活动
+(void)IndianaActivityRecordCreateRequest:(IndianaActivityRecordCreateRequest*)IndianaActivityRecordCreate  success:(HttpSuccess)success failure:(HttpFailure)failure;


@end
