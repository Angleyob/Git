//
//  ApprovalGQvc.h
//  Tour
//
//  Created by Euet on 17/2/13.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApprovalGQvc : UIViewController
//订单号
@property(nonatomic,copy)NSString * orderStr;
//订单类型
@property(nonatomic,copy)NSString * orderType;

//机票，火车票，详情
@property(nonatomic,copy)NSMutableArray * FdataArray;
//@property(nonatomic,copy)NSMutableArray * FmendataArray;

@property(nonatomic,copy)NSMutableArray * TdataArray;
@property(nonatomic,copy)NSMutableArray * TmendataArray;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;

@end
