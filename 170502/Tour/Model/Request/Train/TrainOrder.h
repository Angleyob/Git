//
//  TrainOrder.h
//  Tour
//
//  Created by Euet on 16/12/5.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import "RequestBase.h"

@interface TrainOrder : RequestBase
@property (nonatomic,copy) NSString * ArrivalsDate;
@property (nonatomic,copy) NSString * ArrivalsTime;
@property (nonatomic,copy) NSString * ContactName;
@property (nonatomic,copy) NSString * CostCode;
@property (nonatomic,copy) NSString * Email;
@property (nonatomic,copy) NSString * ApprovalId;


@property (nonatomic,copy) NSString * FromStationCode;
@property (nonatomic,copy) NSString * FromStationName;
@property (nonatomic,copy) NSString * Matter;
@property (nonatomic,copy) NSString * Mobile;
@property (nonatomic,copy) NSString * ProjectId;

@property (nonatomic,copy) NSString * ToStationCode;
@property (nonatomic,copy) NSString * ToStationName;
@property (nonatomic,copy) NSString * TrainDate;
@property (nonatomic,copy) NSString * TrainNum;
@property (nonatomic,copy) NSMutableArray * TrainPassengerList;

@property (nonatomic,copy) NSString * TrainTime;
@property (nonatomic,copy) NSString * TripType;
@property (nonatomic,copy) NSString * ViolationReason;
@property (nonatomic,copy) NSMutableDictionary * Violations;
//放入字典属性



@property(nonatomic,copy)NSString*ProjectRmk;


                                             
@end
