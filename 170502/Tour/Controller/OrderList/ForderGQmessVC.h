//
//  ForderGQmessVC.h
//  Tour
//
//  Created by Euet on 17/2/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForderGQmessVC : UIViewController
//是否已审批
@property(nonatomic,copy)NSString * statusStr;
//订单号
@property(nonatomic,copy)NSString * orderStr;
//订单类型
@property(nonatomic,copy)NSString * orderType;

@property(nonatomic,copy)NSMutableArray * FdataArray;

@property(nonatomic,copy)NSMutableArray * menarray;
@property(nonatomic,copy)NSMutableArray * menarray1;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;


//改签数据（单程)(往返的-去程航班）
@property(nonatomic,copy)NSString * startFlydate;
@property(nonatomic,copy)NSString * startFlyTime;
@property(nonatomic,copy)NSString * FlightNumber;
@property(nonatomic,copy)NSString * ShipSpace;
///改签数据（往返的-回程航班）
@property(nonatomic,copy)NSString * startFlydate1;
@property(nonatomic,copy)NSString * startFlyTime1;
@property(nonatomic,copy)NSString * FlightNumber1;
@property(nonatomic,copy)NSString * ShipSpace1;



@end
