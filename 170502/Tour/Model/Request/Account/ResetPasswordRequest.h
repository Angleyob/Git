//
//  ResetPasswordRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ResetPasswordRequest : RequestBase
@property(nonatomic,copy)NSString * Code;
@property(nonatomic,copy)NSString * Hykh;
@property(nonatomic,copy)NSString * Mobile;
@property(nonatomic,copy)NSString * NewPassword;
@property(nonatomic,copy)NSString * UserName;
@property(nonatomic,copy)NSString * OldPassword;

@end
