//
//  HotelOrderCancel.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface HotelOrderCancel : RequestBase
@property(nonatomic,copy)NSString  * CancelReason;
@property(nonatomic,copy)NSString  * OrderNo;
@property(nonatomic,copy)NSString  * OrderType;
@property(nonatomic,copy)NSString  * Version;
@end
