//
//  LGLCalenderViewController.h
//  LGLProgress
//
//  Created by 李国良 on 2016/10/11.
//  Copyright © 2016年 李国良. All rights reserved.
//  https://github.com/liguoliangiOS/LGLCalender.git
#import <UIKit/UIKit.h>
typedef void(^SelectDateBalock)(NSMutableDictionary * paramas);
@interface LGLCalenderViewController : UIViewController
@property (nonatomic, copy)NSString* sss;
//日期类型，1，为机票，2，为酒店
@property (nonatomic, assign)int type;

@property (nonatomic, assign)BOOL isa;
@property (nonatomic, assign)   NSInteger year1;
@property (nonatomic, assign)    NSInteger month1;
 @property (nonatomic, assign)   NSInteger day1;

@property(nonatomic,copy)NSString*twomothdate;

@property (nonatomic, copy) SelectDateBalock block;
- (void)seleDateWithBlock:(SelectDateBalock)block;

@end
