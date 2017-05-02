//
//  Basic.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BreachReasonQueryRequest.h"
#import "CityQueryRequest.h"
#import "CostCenterQueryRequest.h"
#import "DistrictQueryRequest.h"
#import "EmpRankQueryRequest.h"
#import "InsureGivingQueryRequest.h"
#import "InsureQueryRequest.h"
#import "MemberRegRequest.h"
#import "PayRequest.h"
#import "PayTypeQueryRequest.h" 
#import "PointQueryRequest.h"
#import "ProjectQueryRequest.h"
#import "TravelStaQueryRequest.h"
#import "VouchRequest.h"
#import "YwApproveSetQueryRequest.h"
#import "NationQuery.h"

//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Basic : NSObject
#pragma mark -违背原因
+(void)BreachReasonQueryRequest:(BreachReasonQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -城市查询
+(void)CityQueryRequest:(CityQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -成本中心
+(void)CostCenterQueryRequest:(CostCenterQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -商圈 行政区查询
+(void)DistrictQueryRequest:(DistrictQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -获取员工职级
+(void)EmpRankQueryRequest:(EmpRankQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -获取赠送保险
+(void)InsureGivingQueryRequest:(InsureGivingQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -保险查询
+(void)InsureQueryRequest:(InsureQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -企业注册
+(void)MemberRegRequest:(MemberRegRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -支付操作
+(void)PayRequest:(PayRequest*)verify  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -获取支付方式
+(void)PayTypeQueryRequest:(PayTypeQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -关键词获取城市热点
+(void)PointQueryRequest:(PointQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -项目信息
+(void)ProjectQueryRequest:(ProjectQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -差旅标准
+(void)TravelStaQueryRequest:(TravelStaQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -担保信息
+(void)VouchRequest:(VouchRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -获取火车票，酒店，飞机票 审批规则后台设置情况
+(void)YwApproveSetQueryRequest:(YwApproveSetQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;

#pragma mark -国籍信息
+(void)NationQueryRequest:(NationQuery*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
