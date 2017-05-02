//
//  TrainQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainQuery : RequestBase
@property (nonatomic,copy) NSString * ArrivalPeriod;
@property (nonatomic,copy) NSString * AscOrDesc;
@property (nonatomic,copy) NSString * CheciType;
@property (nonatomic,copy) NSString * Cllx;
@property (nonatomic,copy) NSString * DepartPeriod;
@property (nonatomic,copy) NSString * FromStation;
@property (nonatomic,copy) NSString * ifBeginStation;
@property (nonatomic,copy) NSString * ifFilter;
@property (nonatomic,copy) NSString * OrderBy;
@property (nonatomic,copy) NSString * SessionId;
@property (nonatomic,copy) NSString * ToStation;
@property (nonatomic,copy) NSString * TrainDate;
@property (nonatomic,copy) NSString * TravelPersonId;
@property (nonatomic,copy) NSString * ZwCode;

@end
