//
//  hotelorderVC.h
//  Tour
//
//  Created by Euet on 17/1/19.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelorderVC : UIViewController

@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;

@property(nonatomic,copy)NSMutableArray * dataArray;
@property(nonatomic,copy)NSMutableArray * cabinArray;
@property(nonatomic,copy)NSMutableArray * errArray;
@property(nonatomic,copy)NSString * InsuranceCode;
@property(nonatomic,copy)NSString * erromes;
@property(nonatomic,copy)NSString * erroID;
@property(nonatomic,copy)NSString * erroMessage;
@property(nonatomic,copy)NSString * gxlabeltext;

//酒店地址
@property(nonatomic,copy)NSString * address;



@property(nonatomic,copy)NSString * hotelname;
@property(nonatomic,copy)NSString * hotelid;
@property(nonatomic,copy)NSString * roomname;
@property(nonatomic,copy)NSString * roommess;
@property(nonatomic,copy)NSString * inhoteldate;
@property(nonatomic,copy)NSString * capacity;
@property(nonatomic,copy)NSString * outhoteldate;
@property(nonatomic,copy)NSString * roomprice;
@property(nonatomic,copy)NSString * roomid;
@property(nonatomic,copy)NSString * RatePlanId;
@property(nonatomic,copy)NSString * payType;
//用于标识现付是否担保
@property(nonatomic,copy)NSString * rucode;
@property(nonatomic,copy)NSMutableArray*menarray;



@end
