//
//  StatusListVC.h
//  Tour
//
//  Created by Euet on 17/3/2.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatusListVC : UIViewController

@property(nonatomic,copy)NSMutableDictionary * Alldata;

@property(nonatomic,copy)NSString*flightnum;
@property(nonatomic,copy)NSString*startFlyDate;
@property(nonatomic,copy)NSString*WeekLabel;
@property(nonatomic,copy)NSString*startcity;
@property(nonatomic,copy)NSString*stopcity;
@property(nonatomic,strong)UIButton * databut;


@property(nonatomic,assign)BOOL numORdate;

@end
