//
//  leglistmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入flightOrder模型的leglist数组属性中
@interface leglistmodel : NSObject


@property(nonatomic,copy)NSString*Cabin;
@property(nonatomic,copy)NSString*FlightNo;
@property(nonatomic,copy)NSString*PolicyId;
@property(nonatomic,copy)NSString*SessionId;



@end
