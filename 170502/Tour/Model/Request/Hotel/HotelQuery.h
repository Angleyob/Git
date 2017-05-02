//
//  HotelQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface HotelQuery : RequestBase
@property (nonatomic,copy) NSString * CityId;
@property (nonatomic,assign) int  Count;
@property (nonatomic,copy) NSString * Cllx;
@property (nonatomic,copy) NSString * Brand;
@property (nonatomic,assign) int  Start;
@property (nonatomic,copy) NSString * EmployeesRank;
@property (nonatomic,copy) NSString * Facility;
@property (nonatomic,copy) NSString * Latitude;
@property (nonatomic,copy) NSString * LocationId;
@property (nonatomic,copy) NSString * HotelName;
@property (nonatomic,copy) NSString * LocationName;
@property (nonatomic,copy) NSString * Longitude;
@property (nonatomic,copy) NSString * MaxPrice;
@property (nonatomic,copy) NSString * MinPrice;
@property (nonatomic,copy) NSString * OrderBy;
@property (nonatomic,copy) NSString * OrderFrom;
@property (nonatomic,copy) NSString * Range;
@property (nonatomic,copy) NSString * Star;
@property (nonatomic,copy) NSString * Type;

@end
