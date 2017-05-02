//
//  ForderlistMessVC.h
//  Tour
//
//  Created by Euet on 17/2/15.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ForderlistMessVC : UIViewController



//是否已审批
@property(nonatomic,copy)NSString * statusStr;

//订单号
@property(nonatomic,copy)NSString * orderStr;
//订单类型
@property(nonatomic,copy)NSString * orderType;


@property(nonatomic,copy)NSMutableArray * FdataArray;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;


@property(nonatomic,copy)NSMutableArray * SPmen;

@end
