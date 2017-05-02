//
//  OrderChangeListmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入FlightOrderChange模型的OrderChangeList数组属性中
@interface OrderChangeListmodel : NSObject
@property(nonatomic,copy)NSString*DepartTime;
@property(nonatomic,copy)NSString*FlightId;
@property(nonatomic,copy)NSString*FlightNumber;
@property(nonatomic,copy)NSString*PassengerId;
@property(nonatomic,copy)NSString*ShipSpace;

@end
