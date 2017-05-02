//
//  TrainVC.h
//  Tour
//
//  Created by Euet on 17/1/11.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainVC : UIViewController
@property(nonatomic,copy)NSMutableDictionary * requtstdict;
@property(nonatomic,copy)NSString * outcity;
@property(nonatomic,copy)NSString * backcity;

@property(nonatomic,strong)UIButton * databut;
@property(nonatomic,strong)UILabel * databutlabel;

@property(nonatomic,strong)UILabel * outTimelabel;
@property(nonatomic,strong)UILabel * arriveTimelabel;
@property(nonatomic,strong)UILabel * outcitylabel;
@property(nonatomic,strong)UILabel * arriveAirlabel;
@property(nonatomic,strong)UILabel * pricelabel;
@property(nonatomic,strong)UILabel * discountlabel;
@property(nonatomic,strong)UILabel * airConpanylabel;
@property(nonatomic,strong)UILabel * airStylelabel;
@property(nonatomic,strong)UILabel * stopAirlabel;
@property(nonatomic,strong)UILabel * gxlabel;
@property(nonatomic,strong)UILabel * zhzlabel;

@property(nonatomic,copy)NSString * gxlabeltext;


@property(nonatomic,strong)UIImageView * priceimageview;
@property(nonatomic,strong)UIImageView * logoimageview;

@property(nonatomic,copy)NSMutableArray * menarray;

@property(nonatomic,copy)NSMutableArray * arr;

@property(nonatomic,copy)NSMutableArray * arr1;

@property(nonatomic,assign)BOOL to;

@property(nonatomic,copy)NSString * name06;
@property(nonatomic,copy)NSString * password06;
//城市数组
@property(nonatomic,copy)NSMutableArray * cityarr;


//审批所需字典
@property(nonatomic,copy)NSMutableDictionary * TdataDict;
//审批判断
@property(nonatomic,assign)BOOL Approval;

@end
