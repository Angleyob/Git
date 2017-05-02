//
//  TrainReturnQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainReturnQuery : RequestBase
@property(nonatomic,copy) NSString * Cllx;
@property(nonatomic,assign) int Count;
@property(nonatomic,copy) NSString * EndDate;
@property(nonatomic,copy) NSString * OrderNo;
@property(nonatomic,copy) NSString * Passenger;
@property(nonatomic,copy) NSString * QueryRange;
@property(nonatomic,copy) NSString * RefundOrderNo;
@property(nonatomic,copy) NSString * RefundStatus;
@property(nonatomic,assign) int Start;
@property(nonatomic,copy) NSString * StartDate;
@end
