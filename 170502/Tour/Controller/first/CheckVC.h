//
//  CheckVC.h
//  Tour
//
//  Created by Euet on 16/12/23.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckVC : UIViewController
@property(nonatomic,copy) NSMutableArray * dataArray;
@property(nonatomic,copy) NSMutableArray * dataArray1;

@property(nonatomic,copy) NSMutableArray *menarr;
@property(nonatomic,copy) NSMutableArray *bookTicketList;

@property(nonatomic,copy)NSString* ContactMobile;
@property(nonatomic,copy)NSString* ContactName;

@property(nonatomic,copy)NSString* ViolationReason;
@property(nonatomic,copy)NSString* ViolationItem;
@property(nonatomic,copy)NSString* ViolationReasonCode;
@property(nonatomic,copy)NSString* CostCenter;
@property(nonatomic,copy)NSString* ProjectId;


@property(nonatomic,copy)NSString * project;
@property(nonatomic,copy)NSString * cencer;
@property(nonatomic,copy)NSString * Voitm;
@property(nonatomic,copy)NSString * Voreson;

@property(nonatomic,assign)int a;
@property(nonatomic,assign)int b;
@property(nonatomic,assign)int c;
@property(nonatomic,assign)int d;

//保险类型1：强制，2：赠送 3：默认（可选）
//int a;
//保险份数
//int b;
////保险单份价格
//int c;
////保险总价 d=c*b*人数
//int d;

@property(nonatomic,assign)NSString * publicNo;

@end
