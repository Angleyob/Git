//
//  VouchRequest.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface VouchRequest : RequestBase
@property(nonatomic,copy)NSString*CheckInDate;
@property(nonatomic,copy)NSString*CheckOutDate;
@property(nonatomic,copy)NSString*EarliestArrTime;
@property(nonatomic,copy)NSString*HotelId;
@property(nonatomic,copy)NSString*LatestArrTime;
@property(nonatomic,copy)NSString*RatePlanFrom;
@property(nonatomic,copy)NSString*RatePlanId;
@property(nonatomic,copy)NSString*RoomId;
@property(nonatomic,copy)NSString*RoomNum;
@end
