//
//  InsuranceProductQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface InsuranceProductQueryRequest : RequestBase

@property(nonatomic,copy)NSString * Name;
@property(nonatomic,copy)NSString * ProductNo;
@property(nonatomic,assign)int Type;

 @end
