//
//  CheckInRoomList.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//此模型放入CheckInInfo的属性数组中
@interface CheckInRoomList : NSObject
@property(nonatomic,copy)NSString  * RoomNum;
@property(nonatomic,copy)NSMutableArray * PsgInfoList;
@end
