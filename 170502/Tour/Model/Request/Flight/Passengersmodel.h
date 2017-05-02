//
//  Passengersmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入WhiteListVerify模型的Passengers数组属性中
@interface Passengersmodel : NSObject
@property(nonatomic,copy)NSString*Passcard;
@property(nonatomic,copy)NSString*PassCardType;
@property(nonatomic,copy)NSString*Passname;

@end
