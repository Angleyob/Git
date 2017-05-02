//
//  FlightQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightQuery : RequestBase
@property(nonatomic,copy)NSString*Airways;
@property(nonatomic,copy)NSString*ArrivalCity;
@property(nonatomic,copy)NSString*AscOrDesc;
@property(nonatomic,copy)NSString*BackKey;
@property(nonatomic,copy)NSString*BusinessType;
@property(nonatomic,copy)NSString*CabinType;
@property(nonatomic,copy)NSString*DepartCity;
@property(nonatomic,copy)NSString*DepartDate;
@property(nonatomic,copy)NSString*EmployeesRank;
@property(nonatomic,copy)NSString*GoKey;
@property(nonatomic,copy)NSString*OrderBy;
@property(nonatomic,copy)NSString*PassengerType;
@property(nonatomic,copy)NSString*SortType;
@property(nonatomic,copy)NSMutableArray*Passageres;

@end
