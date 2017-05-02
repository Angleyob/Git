//
//  CostCenterQueryRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CostCenterQueryRequest : RequestBase
@property(nonatomic,copy)NSString*CostName;
@property(nonatomic,copy)NSString*CostNo;
@end
