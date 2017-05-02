//
//  forgetpassWord.h
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface forgetpassWord : UIView
@property (nonatomic,copy) void (^CZHandler)(NSString *workNumber,NSString *cardnNmber,NSString*phoneNumber,NSString*verifyNumber);
@property (nonatomic,copy) void (^loginHandler)(NSString *workNumber,NSString *cardnNmber,NSString*phoneNumber);
@property(nonatomic,strong)UITextField * workNumber;
@property(nonatomic,strong)UITextField * cardnNmber;
@property(nonatomic,strong)UITextField * phoneNumber;
@property(nonatomic,strong)UITextField * verifyNumber;
@property(nonatomic,strong)UIButton * verifybut;
@property(nonatomic,strong)UIButton * loginbut;
@property(nonatomic,strong)UIButton * backbut;
@property(nonatomic,strong)UIView * coverView;
@property(nonatomic,strong)UILabel * tslabel0;

-(void)viewInit;  //添加一个方法，用于初始化控件
-(void)changebackgraoud;
-(void)changebackgraoud1;
@end
