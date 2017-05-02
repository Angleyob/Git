//
//  TrainAccountQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainAccountQuery : RequestBase
@property (nonatomic,copy)NSMutableArray * PasssengerList;
//这些属性以字典的形式放到属性数组
@property (nonatomic,copy) NSString * No;
@property (nonatomic,copy) NSString * PassengerName;
@property (nonatomic,copy) NSString * PassportId;
@property (nonatomic,copy) NSString * PassportType;

@end
