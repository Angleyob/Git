//
//  TJTCell.h
//  Tour
//
//  Created by Euet on 17/2/7.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tjtmodel.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)

@interface TJTCell : UITableViewCell
@property (strong, nonatomic)  UILabel *jtoutcity;
@property (strong, nonatomic)  UILabel *jtArrtivecity;
@property (strong, nonatomic)  UIView *view1;
@property (strong, nonatomic)  UIView *view2;
@property (strong, nonatomic)  UIView *view3;
@property (strong, nonatomic)  UIView *view4;
@property (strong, nonatomic)  UILabel *stoptime;
@property (strong, nonatomic)  UILabel *outtime;
@property (strong, nonatomic)  UILabel *freetime;
- (void)setCellWithModel:(Tjtmodel *)app;

@end
