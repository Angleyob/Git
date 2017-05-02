//
//  InsuraceListmodel.h
//  Tour
//
//  Created by lb on 16/12/4.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <Foundation/Foundation.h>
//该模型放入InsuranceOrderCreateRequest模型的数组InsureOrderList属性中
@interface InsuraceListmodel : NSObject
@property(nonatomic,copy)NSString * Birthday;
@property(nonatomic,copy)NSString * CertNo;
@property(nonatomic,copy)NSString * CertType;
@property(nonatomic,copy)NSString * FlightNo;
@property(nonatomic,copy)NSString * FlightTime;
@property(nonatomic,copy)NSString * LinkAddress;
@property(nonatomic,copy)NSString * LinkMan;
@property(nonatomic,copy)NSString * Name;
@property(nonatomic,copy)NSString * Phone;
@property(nonatomic,copy)NSString * Sex;
@property(nonatomic,copy)NSString * UseDate;
@end
