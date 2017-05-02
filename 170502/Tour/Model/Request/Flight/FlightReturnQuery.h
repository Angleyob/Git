//
//  FlightReturnQuery.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightReturnQuery : RequestBase
@property(nonatomic,copy)NSString*TicketNo;
@property(nonatomic,copy)NSString*ReturnFlag;
@property(nonatomic,copy)NSString*QueryRange;
@property(nonatomic,copy)NSString*ProjectId;
@property(nonatomic,copy)NSString*Pnr;
@property(nonatomic,copy)NSString*PassengerName;
@property(nonatomic,copy)NSString*CostCode;
@property(nonatomic,copy)NSString*Cllx;
@property(nonatomic,copy)NSString*ApplyEndDate;
@property(nonatomic,copy)NSString*ApplyStartDate;
@property(nonatomic,copy)NSString*ApplicantName;
@property(nonatomic,assign) int Count;
@property(nonatomic,assign) int Start;


@end
