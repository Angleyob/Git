//
//  PsgInfoList.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PsgInfoList : NSObject
//此模型放入CheckInRoomList的属性数组中
@property(nonatomic,copy)NSString  * Email;
@property(nonatomic,copy)NSString  * Fax;
@property(nonatomic,copy)NSString  * Mobile;
@property(nonatomic,copy)NSString  * Name;
@property(nonatomic,copy)NSString  * NameSec;
@property(nonatomic,copy)NSString  * PassengerType;
@property(nonatomic,copy)NSString  * Sex;
@property(nonatomic,copy)NSString  * Telephone;
@end
