//
//  hotelOrderSucessVC.h
//  Tour
//
//  Created by Euet on 17/3/6.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelOrderSucessVC : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *orderaNo;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;
@property (strong, nonatomic) IBOutlet UIButton *odrMesbut;
@property (strong, nonatomic) IBOutlet UIButton *trainbut;
@property (strong, nonatomic) IBOutlet UIButton *flightbut;
@property (strong, nonatomic) IBOutlet UIButton *jxbut;

@property (copy, nonatomic)  NSString * price;
@property (copy, nonatomic)  NSString * orderno;
@property (copy, nonatomic)  NSString * statusStr;

@end
