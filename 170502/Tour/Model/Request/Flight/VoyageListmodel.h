//
//  VoyageListmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入cabinonsaleQuery模型的数组属性中
@interface VoyageListmodel : NSObject
@property(nonatomic,copy)NSString*Cabin;
@property(nonatomic,copy)NSString*DepDate;
@property(nonatomic,copy)NSString*FlightNo;
@property(nonatomic,copy)NSString*PolicyId;
@property(nonatomic,copy)NSString*Voyage;

                  
@end
