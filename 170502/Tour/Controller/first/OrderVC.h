//
//  OrderVC.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.

#import <UIKit/UIKit.h>
@interface OrderVC : UIViewController
@property(nonatomic,copy)NSMutableArray * dataArray;
@property(nonatomic,copy)NSMutableArray * cabinArray;
@property(nonatomic,copy)NSMutableArray * errArray;
@property(nonatomic,copy)NSMutableArray * menarray;
@property(nonatomic,copy)NSString * InsuranceCode;
//保险类型
@property(nonatomic,copy)NSString *insuranceType;


@property(nonatomic,copy)NSString * erromes;
@property(nonatomic,assign)NSString * publicNo;
@property(nonatomic,copy)NSString * erroID;
@property(nonatomic,copy)NSString * erroMessage;

@end
