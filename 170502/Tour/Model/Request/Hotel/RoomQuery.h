//
//  RoomQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface RoomQuery : RequestBase
@property (nonatomic,copy) NSString * CheckInDate;
@property (nonatomic,copy) NSString * CheckOutDate;
@property (nonatomic,copy) NSString * ConfirmRightNow;
@property (nonatomic,copy) NSString * EmpRank;
@property (nonatomic,copy) NSString * HotelId;
@property (nonatomic,copy) NSString * PayType;
@property (nonatomic,copy) NSString * RatePlanFrom;
@property (nonatomic,copy) NSString * RatePlanId;
@property (nonatomic,copy) NSString * RoomId;
@property (nonatomic,copy) NSString * TripType;
@end
