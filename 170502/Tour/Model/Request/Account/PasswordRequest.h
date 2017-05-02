//
//  PasswordRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PasswordRequest : RequestBase
@property(nonatomic,copy)NSString * Code;
@property(nonatomic,copy)NSString * Mobile;

@end
