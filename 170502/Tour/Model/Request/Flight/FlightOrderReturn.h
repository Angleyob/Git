//
//  FlightOrderReturn.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightOrderReturn : RequestBase
@property(nonatomic,copy)NSString*OrderNo;
@property(nonatomic,copy)NSString*ReasonName;
@property(nonatomic,copy)NSString*RefundReason;
@property(nonatomic,copy)NSString*VipCancelReason;
@property(nonatomic,copy)NSString*VipCancelReasonId;
@property(nonatomic,copy)NSMutableArray*RefundList;
@end
