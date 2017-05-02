//
//  ForderTPmessVC.h
//  Tour
//
//  Created by Euet on 17/2/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForderTPmessVC : UIViewController

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


@end
