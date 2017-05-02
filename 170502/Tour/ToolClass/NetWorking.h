//
//  NetWorking.h
//  Taranada
//
//  Created by wen on 2016/11/15.
//  Copyright © 2016年 wen. All rights reserved.
//

#import <Foundation/Foundation.h>


//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);


@interface NetWorking : NSObject

//Get请求
+(void)getWithUrlString:(NSString *)urlString success:(HttpSuccess)success failure:(HttpFailure)failure;


//Post请求
+(void)postWithUrlString:(NSString *)urlString parameters:(NSDictionary *)parameters success:(HttpSuccess)success failure:(HttpFailure)failure;



@end
