//
//  OrderApprovalRecordsQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface OrderApprovalRecordsQueryRequest : RequestBase

@property(nonatomic,assign) int  Count;
@property(nonatomic,assign) int  Start;
@property(nonatomic,copy) NSString * OrderNo;
@property(nonatomic,copy) NSString * OrderType;

@end
