//
//  CancelFlightSchedule.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CancelFlightSchedule : RequestBase
@property(nonatomic,copy)NSString*FlightNo;
@property(nonatomic,copy)NSString*PhoneNumber;
@property(nonatomic,copy)NSString*TravelRange;

@end
