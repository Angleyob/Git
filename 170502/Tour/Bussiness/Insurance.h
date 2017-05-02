//
//  Insurance.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InsuranceProductQueryRequest.h"
#import "InsuranceOrderCreateRequest.h"
#import "InsuranceOrderPayRequest.h"
//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);
@interface Insurance : NSObject

+(void)InsuranceProductQueryRequest:(InsuranceProductQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)InsuranceOrderCreateRequest:(InsuranceOrderCreateRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)InsuranceOrderPayRequest:(InsuranceOrderPayRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

@end
