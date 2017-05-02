//
//  PassStationQuery.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface PassStationQuery : RequestBase
@property (nonatomic,copy) NSString * FromStationCode;
@property (nonatomic,copy) NSString * StartTime;
@property (nonatomic,copy) NSString * ToStationCode;
@property (nonatomic,copy) NSString * TrainCode;
@property (nonatomic,copy) NSString * TrainNo;
@end
