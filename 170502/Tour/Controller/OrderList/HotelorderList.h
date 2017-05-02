//
//  HotelorderList.h
//  Tour
//
//  Created by Euet on 17/2/14.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelorderList : UIViewController
//判断点击类型（待支付，待审批）
@property(nonatomic,assign) NSInteger num;
//返回类型
@property(nonatomic,assign) NSInteger back;
@end
