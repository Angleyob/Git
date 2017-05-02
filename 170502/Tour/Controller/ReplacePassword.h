//
//  ReplacePassword.h
//  Tour
//
//  Created by Euet on 16/12/13.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReplacePassword : UIView
@property (nonatomic,copy) void (^loginHandler)(NSString *newpassWord0,NSString *newpassWord);
@property(nonatomic,strong)UITextField * newpassWord0;
@property(nonatomic,strong)UITextField * newpassWord;
@property(nonatomic,strong)UIButton * backbut;
@property(nonatomic,strong)UIView * coverView;
@property(nonatomic,strong)UIButton * loginbut;

-(void)viewInit;  //添加一个方法，用于初始化控件
-(void)changebackgraoud;
-(void)changebackgraoud1;
@end
