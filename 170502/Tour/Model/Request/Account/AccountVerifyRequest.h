//
//  nnnn.h
//  Tour
//
//  Created by lb on 16/12/1.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"
#import "BreachReasonQueryRequest.h"
@interface AccountVerifyRequest : RequestBase

@property(nonatomic,copy)NSString * MemberCardNo;
@property(nonatomic,copy)NSString * Password;
@property(nonatomic,copy)NSString * UserName;
@property(nonatomic,copy)NSString * RegistrationID;

-(NSMutableDictionary *)createDictionayFromModelProperties;

@end
