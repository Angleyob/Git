//
//  Account.m
//  Tour
//
//  Created by Euet on 16/12/1.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "Account.h"
@implementation Account
#pragma mark -账号密码验证
+(void)AccountVerify:(AccountVerifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_AccountVerify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
        }];
    };
#pragma mark -添加旅客
+(void)BookEmpModify:(BookEmpModifyRequest*)model success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_BookEmpModify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -旅客查询
+(void)BookEmpQuery:(BookEmpQueryRequest *)model success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//  NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_BookEmpQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -差旅卡号查询
+(void)CardNoQuery:(CardNoQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_CardNoQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -添加联系人
+(void)ContactModify:(ContactModifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
//    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_ContactModify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -联系人查询
+(void)ContactQuery:(ContactQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    //NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_ContactQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -用户信息获取
+(void)EmpQuery:(EmpQueryRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_EmpQuery];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -忘记密码-获取密码
+(void)Password:(PasswordRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_Password];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -修改登录密码
+(void)PasswordModify:(PasswordModifyRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_PasswordModify];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -重置密码
+(void)ResetPassword:(ResetPasswordRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_ResetPassword];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
#pragma mark -获取验证码
+(void)VerifyCode:(VerifyCodeRequest*)model  success:(HttpSuccess)success failure:(HttpFailure)failure{
    //将模型中所有属性及其值转成字典
    NSMutableDictionary * dict =model.mj_keyValues;
    NSLog(@"%@",dict);
    NSString * urlString =[APIClass WithApiHead:API_Test_Url ApiBody:API_VerifyCode];
    [NetWorking postWithUrlString:urlString parameters:dict success:^(id  _Nonnull respondData) {
        success(respondData);
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
