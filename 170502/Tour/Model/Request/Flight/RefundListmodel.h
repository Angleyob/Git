//
//  RefundListmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入FlightOrderReturn模型的RefundList数组属性中
@interface RefundListmodel : NSObject
@property(nonatomic,copy)NSString*PassengerId;
@property(nonatomic,copy)NSString*FlightId;
@property(nonatomic,copy)NSString*Refuntype;

@end
