//
//  ApproveQueryRequest.h
//  Tour
//
//  Created by Euet on 16/12/2.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface ApproveQueryRequest : RequestBase
@property(nonatomic,copy) NSString * ApprovalStatus;
@property(nonatomic,copy) NSString * BookerId;
@property(nonatomic,copy) NSString * CostCenter;
@property(nonatomic,assign) int  Count;
@property(nonatomic,copy) NSString * DateType;
@property(nonatomic,copy) NSString * EndDate;
@property(nonatomic,copy) NSString * OrderId;
@property(nonatomic,copy) NSString * PassengerName;
@property(nonatomic,copy) NSString * ProductType;
@property(nonatomic,copy) NSString * ProjectId;
@property(nonatomic,assign) int  Start;
@property(nonatomic,copy) NSString * StartDate;
@end
