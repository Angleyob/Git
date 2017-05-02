//
//  FlightOrderQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightOrderQuery : RequestBase
@property(nonatomic,copy)NSString*StartDate;
@property(nonatomic,copy)NSString*QueryRange;
@property(nonatomic,copy)NSString*ProjectId;
@property(nonatomic,copy)NSString*Pnr;
@property(nonatomic,copy)NSString*PassengerName;
@property(nonatomic,copy)NSString*OrderStatus;
@property(nonatomic,copy)NSString*OrderID;
@property(nonatomic,copy)NSString*InterFlag;
@property(nonatomic,copy)NSString*FlightNo;
@property(nonatomic,copy)NSString*EndDate;
@property(nonatomic,copy)NSString*DepartureCity;
@property(nonatomic,copy)NSString*DateType;
@property(nonatomic,copy)NSString*CostCenter;
@property(nonatomic,copy)NSString*Cllx;
@property(nonatomic,copy)NSString*BookerId;
@property(nonatomic,copy)NSString*ArrivalCity;
@property(nonatomic,assign) int Count;
@property(nonatomic,assign) int Start;
@end
