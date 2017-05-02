//
//  Hotel.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Hotel.h"

@implementation Hotel
#pragma mark -获取酒店基础数据
+(void)HotelBaseDataList:(HotelBaseDataList*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelBaseDataList];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询酒店详情
+(void)HotelInfQuery:(HotelInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];

};
#pragma mark -提交订单
+(void)HotelOrder:(HotelOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelOrder];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -酒店订单取消
+(void)HotelOrderCancel:(HotelOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelOrderCancel];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取酒店订单详情
+(void)HotelOrderInfQuery:(HotelOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelOrderInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -酒店订单查询
+(void)HotelOrderQuery:(HotelOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelOrderQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询酒店
+(void)HotelQuery:(HotelQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_HotelQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询房型信息
+(void)RoomQuery:(RoomQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
  NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_RoomQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
@end
