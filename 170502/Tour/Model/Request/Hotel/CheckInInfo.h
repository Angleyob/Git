//
//  CheckInInfo.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckInInfo : NSObject
@property(nonatomic,copy)NSString  * FaceId;
@property(nonatomic,copy)NSString  * RatePlanId;
@property(nonatomic,copy)NSString  * RoomId;
@property(nonatomic,copy)NSString  * RoomNum;
@property(nonatomic,copy)NSMutableArray  * CheckInRoomList;

@end
