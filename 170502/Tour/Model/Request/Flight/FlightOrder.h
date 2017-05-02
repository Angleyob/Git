//
//  FlightOrder.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightOrder : RequestBase
@property(nonatomic,copy)NSMutableArray*LegList;
@property(nonatomic,copy)NSMutableArray*PassengerList;

@property(nonatomic,copy)NSString*ViolationReasonCode;
@property(nonatomic,copy)NSString*ViolationReason;
@property(nonatomic,copy)NSString*ViolationItem;
@property(nonatomic,copy)NSString*Violation;
@property(nonatomic,copy)NSString*TravelStaType;
@property(nonatomic,copy)NSString*TravelSta;
@property(nonatomic,copy)NSString*SecViolationReason;
@property(nonatomic,copy)NSString*SecViolationReasonCode;
@property(nonatomic,copy)NSString*SecViolationItem;
@property(nonatomic,copy)NSString*SecViolation;
@property(nonatomic,copy)NSString*ProjectId;
@property(nonatomic,copy)NSString*LegType;
@property(nonatomic,copy)NSString*InsuranceCode;
@property(nonatomic,copy)NSString*DeliveryType;
@property(nonatomic,copy)NSString*CostCenter;
@property(nonatomic,copy)NSString*ContactName;
@property(nonatomic,copy)NSString*ContactMobile;
@property(nonatomic,copy)NSString*ContactEmail;
@property(nonatomic,copy)NSString*ProjectRmk;


@end
