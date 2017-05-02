//
//  FlightScheduleListQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightScheduleListQuery : RequestBase
@property(nonatomic,copy)NSString*FlightDate;
@property(nonatomic,copy)NSString*FlightValue;

@end
