//
//  HotelOrderQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface HotelOrderQuery : RequestBase
@property (nonatomic,copy) NSString * CityId;
@property (nonatomic,assign) int  Count;
@property (nonatomic,copy) NSString * Cllx;
@property (nonatomic,copy) NSString * ContactName;
@property (nonatomic,assign) int  Start;
@property (nonatomic,copy) NSString * CostCode;
@property (nonatomic,copy) NSString * DateType;
@property (nonatomic,copy) NSString * EndDate;
@property (nonatomic,copy) NSString * Guest;
@property (nonatomic,copy) NSString * HotelName;
@property (nonatomic,copy) NSString * StartDate;
@property (nonatomic,copy) NSString * OrderStatus;
@property (nonatomic,copy) NSString * ProjectId;
@property (nonatomic,copy) NSString * QueryRange;
@end
