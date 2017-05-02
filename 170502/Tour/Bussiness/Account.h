//
//  Account.h
//  Tour
//
//  Created by Euet on 16/12/1.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountVerifyRequest.h"
#import "BookEmpModifyRequest.h"
#import "BookEmpQueryRequest.h"
#import "CardNoQueryRequest.h"
#import "ContactModifyRequest.h"
#import "ContactQueryRequest.h"
#import "EmpQueryRequest.h"
#import "PasswordRequest.h"
#import "PasswordModifyRequest.h"
#import "ResetPasswordRequest.h"
#import "VerifyCodeRequest.h"

//宏定义成功block回调成功后得到的信息
typedef void (^HttpSuccess)(id data);

//宏定义失败block回调失败的信息
typedef void (^HttpFailure)(NSError * error);

@interface Account : NSObject

#pragma mark -账号密码验证
+(void)AccountVerify:(AccountVerifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -添加旅客
+(void)BookEmpModify:(BookEmpModifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -旅客查询
+(void)BookEmpQuery:(BookEmpQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -差旅卡号查询
+(void)CardNoQuery:(CardNoQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -添加联系人
+(void)ContactModify:(ContactModifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -联系人查询
+(void)ContactQuery:(ContactQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -用户信息获取
+(void)EmpQuery:(EmpQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -忘记密码-获取密码
+(void)Password:(PasswordRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -修改登录密码
+(void)PasswordModify:(PasswordModifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -重置密码
+(void)ResetPassword:(ResetPasswordRequest*)verify  success:(HttpSuccess)success failure:(HttpFailure)failure;
#pragma mark -获取验证码
+(void)VerifyCode:(VerifyCodeRequest*)verify  success:(HttpSuccess)success failure:(HttpFailure)failure;
@end
