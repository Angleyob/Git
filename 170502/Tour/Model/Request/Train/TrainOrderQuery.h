//
//  TrainOrderQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainOrderQuery : RequestBase
@property (nonatomic,copy) NSString * BookUserId;
@property (nonatomic,copy) NSString * Cllx;
@property (nonatomic,copy) NSString * ContactName;
@property (nonatomic,assign) int Count;
@property (nonatomic,copy) NSString * DateType;
@property (nonatomic,copy) NSString * EndDate;
@property (nonatomic,copy) NSString * FromStation;
@property (nonatomic,copy) NSString * OrderNo;
@property (nonatomic,copy) NSString * OrderNumber;
@property (nonatomic,copy) NSString * OrderStatus;
@property (nonatomic,copy) NSString * Passenger;
@property (nonatomic,copy) NSString * Phone;
@property (nonatomic,copy) NSString * QueryRange;
@property (nonatomic,assign) int Start;
@property (nonatomic,copy) NSString * StartDate;
@property (nonatomic,copy) NSString * ToStation;
@property (nonatomic,copy) NSString * TrainNum;

@end