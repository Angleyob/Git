//
//  PassengerListmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入flightOrder模型的PassengerList数组属性中
@interface PassengerListmodel : NSObject
@property(nonatomic,copy)NSString*Name;
@property(nonatomic,copy)NSString*Pnrno;
@property(nonatomic,copy)NSString*PassenType;
@property(nonatomic,copy)NSString*Nationality;
@property(nonatomic,copy)NSString*MobileNum;
@property(nonatomic,copy)NSString*Insurance;
@property(nonatomic,copy)NSString*EmpId;
@property(nonatomic,copy)NSString*DocType;
@property(nonatomic,copy)NSString*DocNamevalid;
@property(nonatomic,copy)NSString*DocName;
@property(nonatomic,copy)NSString*Birthday;

@end
