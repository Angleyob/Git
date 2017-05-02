//
//  ApprovalRuleQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ApprovalRuleQueryRequest : RequestBase

@property(nonatomic,copy)NSString * BusinessType;
@property(nonatomic,assign)int  Count;
@property(nonatomic,copy)NSString * EmpId;
@property(nonatomic,copy)NSString * IsTravelStandard;
@property(nonatomic,copy)NSString * RuleId;
@property(nonatomic,assign)int Start;

@end
