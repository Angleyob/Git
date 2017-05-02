//
//  orderPayVc.h
//  Tour
//
//  Created by Euet on 17/2/23.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderPayVc : UIViewController


@property(nonatomic,copy)NSMutableArray * dataArray;

@property(nonatomic,copy)NSString * orderstring;

@property(nonatomic,copy)NSString * BusinessType;


@property(nonatomic,copy)NSMutableArray * FdataArray;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableDictionary * Messagedict;





@property(nonatomic,assign)NSString * price;
@property(nonatomic,assign)NSString * Hprice;
@property(nonatomic,assign)NSString * Tprice;
//火车支付数据
@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSString * freeprice;
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

@end
