//
//  HpayOrderMessageVC.h
//  Tour
//
//  Created by Euet on 17/3/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HpayOrderMessageVC : UIViewController
//是否已审批
@property(nonatomic,copy)NSString * statusStr;

//订单号
@property(nonatomic,copy)NSString * orderStr;
//订单类型
@property(nonatomic,copy)NSString * orderType;


@property(nonatomic,copy)NSMutableArray * TdataArray;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;

@property(nonatomic,copy)NSMutableDictionary * Alldata;

@property(nonatomic,copy)NSMutableArray * SPmen;


@end
