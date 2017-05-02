//
//  Approval.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApprovalRuleQueryRequest.h"
#import "ApproveRequest.h"
#import "ApproveApplyRequest.h"
#import "ApproveQueryRequest.h"
#import "OrderApprovalRecordsQueryRequest.h"
//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);
//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Approval : NSObject
+(void)ApprovalRuleQuery:(ApprovalRuleQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)Approve:(ApproveRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)ApproveApply:(ApproveApplyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)ApproveQuery:(ApproveQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
+(void)OrderApprovalRecordsQuery:(OrderApprovalRecordsQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
