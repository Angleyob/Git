//
//  FlightMessageVC.h
//  Tour
//
//  Created by Euet on 16/12/22.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerclass.h"
typedef void(^GQBlcok)(NSMutableDictionary *datadict,NSString * flightnum,NSString * stratFlytime,NSString * fromdata);
@interface FlightMessageVC : UIViewController
@property (strong, nonatomic) GQBlcok block;
-(void)sendMessage:(GQBlcok)block;

@property(nonatomic,copy)NSMutableDictionary * requtstdict;
@property(nonatomic,copy)NSString * outcity;
@property(nonatomic,copy)NSString * backcity;

@property(nonatomic,strong)UIButton * databut;
@property(nonatomic,strong)UILabel * databutlabel;

@property(nonatomic,strong)UILabel * outTimelabel;
@property(nonatomic,strong)UILabel * arriveTimelabel;
@property(nonatomic,strong)UILabel * outAirlabel;
@property(nonatomic,strong)UILabel * arriveAirlabel;
@property(nonatomic,strong)UILabel * pricelabel;
@property(nonatomic,strong)UILabel * discountlabel;
@property(nonatomic,strong)UILabel * airConpanylabel;
@property(nonatomic,strong)UILabel * airStylelabel;
@property(nonatomic,strong)UILabel * stopAirlabel;
@property(nonatomic,strong)UILabel * gxlabel;
@property(nonatomic,strong)UILabel * zhzlabel;

@property(nonatomic,strong)UIImageView * priceimageview;
@property(nonatomic,strong)UIImageView * logoimageview;

@property(nonatomic,copy)NSString * publicNo;


@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableArray * arr;

@property(nonatomic,copy)NSMutableArray * arr1;


@property(nonatomic,assign)BOOL to;
//改签判断
@property(nonatomic,assign)BOOL gqYESorNO;
//改签数据
@property(nonatomic,copy)NSString * fromdate;
@property(nonatomic,copy)NSString * fromcity;
@property(nonatomic,copy)NSString * tocity;


//审批查询所需数据
@property(nonatomic,copy)NSMutableArray * FdataArray;
//审批判断
@property(nonatomic,assign) BOOL  Approval;

@end
