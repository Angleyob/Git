//
//  Train.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Train.h"

@implementation Train
#pragma mark -获取途径站点
+(void)PassStationQuery:(PassStationQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_PassStationQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];

};
#pragma mark -获取火车票退改签规则
+(void)TGQApproveQuery:(TGQApproveQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TGQApproveQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取12306账户
+(void)TrainAccountQuery:(TrainAccountQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainAccountQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -验证12306账户
+(void)TrainAccountVerify:(TrainAccountVerify*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainAccountVerify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -取消火车票改签申请
+(void)TrainCancelChange:(TrainCancelChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainCancelChange];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取火车票改签详情
+(void)TrainChangeInfQuery:(TrainChangeInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainChangeInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票改签单查询
+(void)TrainChangeQuery:(TrainChangeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainChangeQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -提交订单申请分配座位
+(void)TrainOrder:(TrainOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrder];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票订单取消
+(void)TrainOrderCancel:(TrainOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrderCancel];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票改签申请
+(void)TrainOrderChange:(TrainOrderChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrderChange];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取火车票订单详情
+(void)TrainOrderInfQuery:(TrainOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrderInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票订单查询
+(void)TrainOrderQuery:(TrainOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrderQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票退票申请
+(void)TrainOrderReturn:(TrainOrderReturn*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainOrderReturn];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询火车车次
+(void)TrainQuery:(TrainQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取火车票退票详情
+(void)TrainReturnInfQuery:(TrainReturnInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainReturnInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -火车票退票单查询
+(void)TrainReturnQuery:(TrainReturnQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainReturnQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取火车票服务费及保险信息
+(void)TrainServiceFeeQuery:(TrainServiceFeeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainServiceFeeQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询火车站站点
+(void)TrainStationQuery:(TrainStationQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainStationQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询火车站点（模糊查询）
+(void)TrainStationSearch:(TrainStationSearch*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_TrainStationSearch];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
@end
