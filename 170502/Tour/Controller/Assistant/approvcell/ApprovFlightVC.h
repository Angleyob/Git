//
//  ApprovFlightVC.h
//  Tour
//
//  Created by Euet on 17/2/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovFlightVC : UIViewController
//是否已审批
@property(nonatomic,copy)NSString * DandYStr;

//订单号
@property(nonatomic,copy)NSString * orderStr;
//订单类型
@property(nonatomic,copy)NSString * orderType;

//机票，火车票，酒店详情
@property(nonatomic,copy)NSMutableArray * FdataArray;
//@property(nonatomic,copy)NSMutableArray * FmendataArray;

@property(nonatomic,copy)NSMutableArray * HdataArray;
//@property(nonatomic,copy)NSMutableArray * HmendataArray;

@property(nonatomic,copy)NSMutableArray * TdataArray;
@property(nonatomic,copy)NSMutableArray * TmendataArray;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;


@property(nonatomic,copy)NSMutableArray * SPmen;

@end
