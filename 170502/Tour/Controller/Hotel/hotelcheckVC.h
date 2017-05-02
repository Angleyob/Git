//
//  hotelcheckVC.h
//  Tour
//
//  Created by Euet on 17/1/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelcheckVC : UIViewController


@property(nonatomic,copy) NSMutableArray * dataArray;
@property(nonatomic,copy) NSMutableArray * dataArray1;

@property(nonatomic,copy) NSMutableArray *menarr;
@property(nonatomic,copy) NSString *bookTicketList;

@property(nonatomic,copy)NSString* ContactMobile;
@property(nonatomic,copy)NSString* ContactName;
//项目，违规，成本
@property(nonatomic,copy)NSString* ViolationReason;
@property(nonatomic,copy)NSString* ViolationItem;
@property(nonatomic,copy)NSString* ViolationReasonCode;
@property(nonatomic,copy)NSString* CostCenter;
@property(nonatomic,copy)NSString* ProjectId;

@property(nonatomic,copy)NSString * project;
@property(nonatomic,copy)NSString * cencer;
@property(nonatomic,copy)NSString * Voitm;
@property(nonatomic,copy)NSString * Voreson;
//价格详情
@property(nonatomic,copy) NSString * free;
@property(nonatomic,copy)NSString * tprice;
@property(nonatomic,copy)NSString * pricela;
//订单数据
@property(nonatomic,copy)NSString * hotelname;
@property(nonatomic,copy)NSString * hotelid;
@property(nonatomic,copy)NSString * roomname;
@property(nonatomic,copy)NSString * roommess;
@property(nonatomic,copy)NSString * inhoteldate;
@property(nonatomic,copy)NSString * outhoteldate;
@property(nonatomic,copy)NSString * roomprice;
@property(nonatomic,copy)NSString * roomid;
@property(nonatomic,copy)NSString * RatePlanId;




@property(nonatomic,copy)NSString * payType;

@end
