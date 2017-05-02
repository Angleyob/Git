//
//  changeDateVc.h
//  Tour
//
//  Created by Euet on 17/4/22.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DateBalock)(NSMutableDictionary * dictDate);

@interface changeDateVc : UIViewController
{
    NSMutableArray * dataArray;
    UIView * mainView;
}
//用来判断酒店,机票,火车
@property (nonatomic, copy) NSString * type;

//用来判断酒店的单选还是多选(点击入住时)
@property (nonatomic, copy) NSString * outOrIn;

//入住日期
@property (nonatomic, copy) NSString * indate;

//用来机票的单选还是多选(点击出发时)
@property (nonatomic, copy) NSString * outOrback;
//出发日期
@property (nonatomic, copy) NSString * outdate;



@property (nonatomic, copy) DateBalock block;

- (void)DateWithBlock:(DateBalock)block;
@end
