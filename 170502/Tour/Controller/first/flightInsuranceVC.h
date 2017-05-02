//
//  flightInsuranceVC.h
//  Tour
//
//  Created by Euet on 17/4/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SelectInsureBalock)(NSMutableDictionary * dict);

@interface flightInsuranceVC : UIViewController
//保险类型
@property(nonatomic,copy)NSString *insuranceType;
@property(nonatomic,copy)NSString * InsuranceCode;

@property(nonatomic,copy)NSString * Num;

@property (nonatomic, copy) SelectInsureBalock block;
- (void)SelectInsureWithBlock:(SelectInsureBalock)block;
@end
