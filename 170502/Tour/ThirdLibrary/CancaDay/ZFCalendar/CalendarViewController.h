//
//  CalendarViewController.h
//  Calendar
//
//  Created by 张凡 on 14-8-21.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <UIKit/UIKit.h>
#import "CalendarLogic.h"

//回掉代码块
typedef void (^CalendarBlock)(CalendarDayModel *model);

@interface CalendarViewController : UIViewController

@property(nonatomic ,strong) UICollectionView* collectionView;//网格视图

@property(nonatomic ,strong) NSMutableArray *calendarMonth;//每个月份的中的daymodel容器数组


//用来判断酒店,机票,火车
@property (nonatomic, copy) NSString * type;

//***
//用来判断酒店的单选还是多选(点击入住时)
@property (nonatomic, copy) NSString * outOrIn;

@property (nonatomic, copy) NSString * indate;


//用来机票的单选还是多选(点击出发时)
@property (nonatomic, copy) NSString * outOrback;
//出发日期
@property (nonatomic, copy) NSString * outdate;





@property(nonatomic ,strong) CalendarLogic *Logic;

@property (nonatomic, copy) CalendarBlock calendarblock;//回调

@property(nonatomic,strong) NSMutableArray * selectArray;


//计数，当数组中超过2个值时，就不让在添加 ，各人需要
@property(nonatomic,assign) NSInteger flag;


@end
