//
//  TrainorderVC.h
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainorderVC : UIViewController

@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSMutableDictionary * requtstdict;

@property(nonatomic,copy)NSMutableArray * StopOverarr;
@property(nonatomic,copy)NSMutableArray * seatarr;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSString * gxlabeltext;
@property(nonatomic,copy)NSMutableArray * dataArray;
@property(nonatomic,copy)NSMutableArray * cabinArray;
@property(nonatomic,copy)NSMutableArray * errArray;
@property(nonatomic,copy)NSString * InsuranceCode;
@property(nonatomic,copy)NSString * erromes;
@property(nonatomic,copy)NSString * erroID;
@property(nonatomic,copy)NSString * erroMessage;


@property(nonatomic,copy)NSString * username_12306;
@property(nonatomic,copy)NSString * pssageWord_12306;
//余票数
@property(nonatomic,assign)NSInteger  count;

@end
