//
//  FlightOrderChange.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface FlightOrderChange : RequestBase
@property(nonatomic,copy)NSString*OrderNo;
@property(nonatomic,copy)NSMutableArray*OrderChangeList;
@property(nonatomic,copy)NSString*ChangeReasonCode;
@property(nonatomic,copy)NSString*ChangeReason;
@end
