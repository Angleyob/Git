//
//  StatusMessageVC.h
//  Tour
//
//  Created by Euet on 17/3/1.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttentionModel.h"

@interface StatusMessageVC : UIViewController

@property(nonatomic,copy)NSMutableDictionary * dict;

@property(nonatomic,strong)AttentionModel * attmodel;
@property(nonatomic,assign)int  num;


@end
