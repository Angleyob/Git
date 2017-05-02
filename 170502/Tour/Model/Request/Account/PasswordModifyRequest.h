//
//  PasswordModifyRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PasswordModifyRequest : RequestBase

@property(nonatomic,copy)NSString * NewPassword;

@property(nonatomic,copy)NSString * OldPassword;

@end
