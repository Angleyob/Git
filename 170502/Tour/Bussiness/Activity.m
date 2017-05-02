//
//  Activity.m
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Activity.h"

@implementation Activity
//获取活动
+(void)IndianaActivityQueryRequest:(IndianaActivityQueryRequest*)IndianaActivityQuery  success:(HttpSuccess)success failure:(HttpFailure)failure{

    NSMutableDictionary *dict=[NSMutableDictionary new];
    
    [dict setValue:IndianaActivityQuery.AppID forKey:@"AppID"];
    [dict setValue:IndianaActivityQuery.Ip forKey:@"Ip"];
    [dict setValue:IndianaActivityQuery.Channel forKey:@"Channel"];
    [dict setValue:IndianaActivityQuery.LoginUserId forKey:@"LoginUserId"];
    [dict setValue:IndianaActivityQuery.MemberId forKey:@"MemberId"];
  
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_IndianaActivityQuery];

    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];

};
//提交资料
+(void)IndianaContactSubmit:(IndianaContactSubmit*)IndianaContactSubmit  success:(HttpSuccess)success failure:(HttpFailure)failure{
    
};
//获取中奖名单
+(void)IndianaActivityWinnerQueryRequest:(IndianaActivityWinnerQueryRequest*)IndianaActivityWinnerQuery  success:(HttpSuccess)success failure:(HttpFailure)failure{
}
;
//参与活动
+(void)IndianaActivityRecordCreateRequest:(IndianaActivityRecordCreateRequest*)IndianaActivityRecordCreate  success:(HttpSuccess)success failure:(HttpFailure)failure{
};

@end
