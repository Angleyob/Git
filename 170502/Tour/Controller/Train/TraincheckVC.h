//
//  TraincheckVC.h
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TraincheckVC : UIViewController

@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString *freeprice;

@property(nonatomic,copy)NSMutableArray * StopOverarr;

@property(nonatomic,copy) NSMutableArray * dataArray;
@property(nonatomic,copy) NSMutableArray * dataArray1;

@property(nonatomic,copy) NSMutableArray *menarr;
@property(nonatomic,copy) NSString *bookTicketList;

@property(nonatomic,copy)NSString* ContactMobile;
@property(nonatomic,copy)NSString* ContactName;

@property(nonatomic,copy)NSString* ViolationReason;
@property(nonatomic,copy)NSString* ViolationItem;
@property(nonatomic,copy)NSString* ViolationReasonCode;
@property(nonatomic,copy)NSString* CostCenter;
@property(nonatomic,copy)NSString* ProjectId;
@property(nonatomic,copy)NSString* pricestr;

@property(nonatomic,copy)NSString * project;
@property(nonatomic,copy)NSString * cencer;
@property(nonatomic,copy)NSString * Voitm;
@property(nonatomic,copy)NSString * Voreson;

@end
