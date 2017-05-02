//
//  HotelOrder.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"
#import "Linkinfo.h"
#import "CheckInInfo.h"
@interface HotelOrder : RequestBase
@property(nonatomic,copy)NSString  * CheckInDate;
@property(nonatomic,copy)NSString  * CheckOutDate;
@property(nonatomic,copy)NSString  * CostCode;
@property(nonatomic,copy)NSString  * EarliestArrTime;
@property(nonatomic,copy)NSString  * HotelId;
@property(nonatomic,copy)NSString  * IfGuarantee;
@property(nonatomic,copy)NSString  * LatestArrTime;
@property(nonatomic,copy)NSString  * Matters;
@property(nonatomic,copy)NSString  * OrderFrom;
@property(nonatomic,copy)NSString  * ProjectId;
@property(nonatomic,copy)NSString  * TravelOrderNo;
@property(nonatomic,copy)NSString  * TripType;
@property(nonatomic,copy)NSString  * ViolationItem;
@property(nonatomic,copy)NSString  * ViolationReason;
@property(nonatomic,copy)NSString  * ViolationReasonCode;
@property(nonatomic,copy)NSString*ProjectRmk;

@property(nonatomic,strong) Linkinfo * Linkinfo;
@property(nonatomic,strong)  CheckInInfo * CheckInInfo;
@end
