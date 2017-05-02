//
//  Insurance.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Insurance.h"
@implementation Insurance
+(void)InsuranceProductQueryRequest:(InsuranceProductQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    
        //将模型中所有属性及其值转成字典n
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_InsuranceProductQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
+(void)InsuranceOrderCreateRequest:(InsuranceOrderCreateRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
 //   NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_InsuranceOrderCreate];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
+(void)InsuranceOrderPayRequest:(InsuranceOrderPayRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_InsuranceOrderPay];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];

};
@end
