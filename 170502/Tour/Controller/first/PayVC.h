//
//  PayVC.h
//  Tour
//
//  Created by Euet on 16/12/24.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerclass.h"

@interface PayVC : UIViewController

@property(nonatomic,copy)NSMutableArray * dataArray;
//飞机
@property(nonatomic,copy)NSMutableArray * FdataArray1;
@property(nonatomic,copy)NSMutableArray * menArray;
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


@property(nonatomic,copy)NSString * orderstring;

@property(nonatomic,copy)NSString * BusinessType;


@property(nonatomic,copy)NSString * price;
@property(nonatomic,copy)NSString * Hprice;
@property(nonatomic,copy)NSString * Tprice;
//火车支付数据
@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSString * freeprice;
@property(nonatomic,copy)NSString * mestprice;
@property(nonatomic,copy)NSString * mesfreeprice;

@property(nonatomic,copy)NSMutableArray * StopOverarr;
//酒店支付cell数据
@property(nonatomic,copy)NSString * hotelname;
@property(nonatomic,copy)NSString * hotelid;
@property(nonatomic,copy)NSString * roomname;
@property(nonatomic,copy)NSString * roommess;
@property(nonatomic,copy)NSString * inhoteldate;
@property(nonatomic,copy)NSString * outhoteldate;
@property(nonatomic,copy)NSString * roomprice;
@property(nonatomic,copy)NSString * roomid;
@property(nonatomic,copy)NSString * RatePlanId;

@property(nonatomic,copy)NSString * meshprice;
@property(nonatomic,copy)NSString * meshfreeprice;

@end
