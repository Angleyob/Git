//
//  JTCell.h
//  Tour
//
//  Created by Euet on 17/2/4.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "flightJTmodel.h"

@interface JTCell : UITableViewCell

@property (strong, nonatomic)  UILabel *jtcity;
@property (strong, nonatomic)  UIView *view1;
@property (strong, nonatomic)  UIView *view2;
@property (strong, nonatomic)  UIView *view3;
@property (strong, nonatomic)  UILabel *stoptime;
@property (strong, nonatomic)  UILabel *outtime;
@property (strong, nonatomic)  UILabel *freetime;

- (void)setCellWithModel:(flightJTmodel *)app;

@end
