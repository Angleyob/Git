//
//  AccountVerifyResponse.h
//  Tour
//
//  Created by Euet on 16/12/1.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "ResponseBase.h"

@interface AccountVerifyResponse : ResponseBase

@property(nonatomic,copy)NSString * LoginUserId;
@property(nonatomic,copy)NSString * MemberId;
@property(nonatomic,copy)NSString * Reason;
@property(nonatomic,copy)NSString * UserName;
@property(nonatomic,copy)NSDictionary * UserInf;


@end
