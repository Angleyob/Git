//
//  paySucceedVC.h
//  Tour
//
//  Created by Euet on 16/12/27.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerclass.h"

@interface paySucceedVC : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *goOnBut;
@property (weak, nonatomic) IBOutlet UILabel *succedlabel;
@property (weak, nonatomic) IBOutlet UILabel *messagelabel;
@property (weak, nonatomic) IBOutlet UIView *orderView;
@property (weak, nonatomic) IBOutlet UILabel *ordermesLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNolabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPricelabel;
@property (weak, nonatomic) IBOutlet UIButton *oderMessageBut;
@property (weak, nonatomic) IBOutlet UIButton *hotelBut;
@property (weak, nonatomic) IBOutlet UIButton *retainBut;
@property (weak, nonatomic) IBOutlet UIButton *gbBut;

@property(nonatomic,assign)NSString * publicNo;

@property(nonatomic,assign)NSString * orderZT;
@property(nonatomic,assign)NSString * orderno;
@property(nonatomic,assign)NSString * orderprice;

@property(nonatomic,assign)NSString * type;


@end
