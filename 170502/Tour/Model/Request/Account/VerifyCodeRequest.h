//
//  VerifyCodeRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface VerifyCodeRequest : RequestBase

@property(nonatomic,copy)NSString * EmpNo;
@property(nonatomic,copy)NSString * Hykh;
@property(nonatomic,copy)NSString * Mobile;


@end
