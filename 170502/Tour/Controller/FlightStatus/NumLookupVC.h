//
//  NumLookupVC.h
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumLookupVC : UIViewController

@property(nonatomic,strong)UITextField * flightNO;
@property(nonatomic,strong)UITextField * FlyDate;

@property(nonatomic,copy)NSString*flightnum;
@property(nonatomic,copy)NSString*startFlyDate;
@property(nonatomic,copy)NSString*WeekLabel;
@property(nonatomic,copy)NSString*twomothdate;


@end
