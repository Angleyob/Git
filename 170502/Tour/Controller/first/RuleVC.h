//
//  RuleVC.h
//  Tour
//
//  Created by Euet on 16/12/29.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RuleVC : UIViewController

@property(nonatomic,copy)NSMutableArray * menarray;

@property (weak, nonatomic) IBOutlet UILabel *erroLabel;
@property (weak, nonatomic) IBOutlet UIView *messageView;
@property (weak, nonatomic) IBOutlet UIButton *okbut;

//火车票

//余票数
@property(nonatomic,assign)NSInteger  Tcount;
@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSString * erro;
@property(nonatomic,copy)NSString * erromes;
@property(nonatomic,copy)NSMutableArray * StopOverarr;
@property(nonatomic,copy)NSMutableArray * seatarr;
@property(nonatomic,copy)NSString * gxlabeltext;
@property(nonatomic,copy)NSString * username_12306;
@property(nonatomic,copy)NSString * pssageWord_12306;

//酒店
@property(nonatomic,copy)NSString * herromes;
@property(nonatomic,copy)NSString * herroID;
@property(nonatomic,copy)NSString * herroMessage;
@property(nonatomic,copy)NSString * hgxlabeltext;
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

////

@property(nonatomic,copy)NSMutableDictionary * requtstdict;
@property(nonatomic,copy)NSMutableArray * dataArr;
@property(nonatomic,strong)NSMutableArray * cabinArray;
@property(nonatomic,copy)NSString   * style;
@end
