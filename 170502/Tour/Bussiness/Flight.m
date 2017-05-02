//
//  Flight.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Flight.h"

@implementation Flight
#pragma mark -航空公司
+(void)AirwayQuery:(AirwayQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
   
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_AirwayQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取航班动态列表
+(void)AttentionFlightScheduleListQuery:(AttentionFlightScheduleListQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_AttentionFlightScheduleListQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获得特价舱
+(void)CabinOnSaleQuery:(CabinOnSaleQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CabinOnSaleQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -舱位查询
+(void)CabinQuery:(CabinQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CabinQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -舱位类型
+(void)CabinTypeQuery:(CabinTypeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CabinTypeQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -取消关注航班动态
+(void)CancelFlightScheduleyQuery:(CancelFlightSchedule*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CancelFlightSchedule];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -关注航班动态
+(void)CustomFlightSchedule:(CustomFlightSchedule*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CustomFlightSchedule];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取机票改签单详情
+(void)FlightChangeInfQuery:(FlightChangeInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightChangeInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票改签单查询
+(void)FlightChangeQuery:(FlightChangeQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightChangeQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -取消改签申请
+(void)FlightEndorseTicketCancel:(FlightEndorseTicketCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightEndorseTicketCancel];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -提交订单
+(void)FlightOrder:(FlightOrder*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrder];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
    success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票订单取消
+(void)FlightOrderCancel:(FlightOrderCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrderCancel];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票改签申请
+(void)FlightOrderChange:(FlightOrderChange*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrderChange];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取机票订单详情
+(void)FlightOrderInfQuery:(FlightOrderInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrderInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票订单查询
+(void)FlightOrderQuery:(FlightOrderQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrderQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票退票申请
+(void)FlightOrderReturn:(FlightOrderReturn*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightOrderReturn];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -查询航班
+(void)FlightQuery:(FlightQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取机票退票详情
+(void)FlightReturnInfQuery:(FlightReturnInfQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightReturnInfQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -机票退票单查询
+(void)FlightReturnQuery:(FlightReturnQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightReturnQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -取消退票申请
+(void)FlightReturnTicketCancel:(FlightReturnTicketCancel*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightReturnTicketCancel];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取航班动态列表
+(void)FlightScheduleListQuery:(FlightScheduleListQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_FlightScheduleListQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取改签说明
+(void)RemarkString:(RemarkString*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_RemarkString];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -获取经停城市
+(void)StopOverQuery:(StopOverQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_StopOverQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
#pragma mark -白名单验证
+(void)WhiteListVerify:(WhiteListVerify*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_WhiteListVerify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
};
@end
