//
//  CustomFlightSchedule.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface CustomFlightSchedule : RequestBase
@property(nonatomic,copy)NSString*Ddbh;
@property(nonatomic,copy)NSString*FlightDate;
@property(nonatomic,copy)NSString*FlightNo;
@property(nonatomic,copy)NSString*LxrTel;
@property(nonatomic,copy)NSString*PassengerTel;
@property(nonatomic,copy)NSString*PickpersonTel;
@property(nonatomic,copy)NSString*TravelRange;
@property(nonatomic,copy)NSString*Xm;


@end
