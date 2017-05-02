//
//  HotelVC.h
//  Tour
//
//  Created by Euet on 17/1/17.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelVC : UIViewController
@property(nonatomic,copy)NSMutableDictionary*requtstdict;
@property(nonatomic,copy)NSString*outcity;
@property(nonatomic,copy)NSMutableArray*menarray;

//审批所需字典
@property(nonatomic,copy)NSMutableDictionary * HdataDict;
//审批判断
@property(nonatomic,assign)BOOL Approval;
//用于高级，经济连锁酒店以及设施服务的筛选
@property(nonatomic,assign)BOOL GJJSE;


@end
