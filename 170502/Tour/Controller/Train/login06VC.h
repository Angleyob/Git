//
//  login06VC.h
//  Tour
//
//  Created by Euet on 17/1/12.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^block06)(NSString *name06,NSString *password06);

@interface login06VC : UIViewController
@property(nonatomic,strong)block06 block;
-(void)sendMessage:(block06)block;

@property(nonatomic,strong)UITextField * UserName;
@property(nonatomic,strong)UITextField * PassWord;

//火车票
@property(nonatomic,copy)NSDictionary * trainDatadict;
@property(nonatomic,copy)NSDictionary * seatDatadict;
@property(nonatomic,copy)NSString * erro;
@property(nonatomic,copy)NSString * erromes;
@property(nonatomic,copy)NSMutableArray * StopOverarr;
@property(nonatomic,copy)NSMutableArray * seatarr;
@property(nonatomic,copy)NSString * gxlabeltext;

@property(nonatomic,copy)NSString   * style;
@property(nonatomic,copy)NSMutableDictionary * requtstdict;


@end
