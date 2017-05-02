//
//  InsuranceOrderCreateRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface InsuranceOrderCreateRequest : RequestBase
@property(nonatomic,strong)NSArray *InsureOrderList;
@property(nonatomic,copy)NSString * OpenID;
@property(nonatomic,copy)NSString * ProductNo;
@property(nonatomic,copy)NSString * UserID;
@end
