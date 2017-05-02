//
//  FlightorderList.h
//  Tour
//
//  Created by Euet on 17/2/14.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlightorderList : UIViewController

//判断点击类型（待支付，退票，改签）
@property(nonatomic,assign) NSInteger num;

//返回点击类型
@property(nonatomic,assign) NSInteger back;

@end
