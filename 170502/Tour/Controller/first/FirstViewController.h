//
//  FirstViewController.h
//  Tour
//
//  Created by Euet on 16/12/14.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewControllerclass.h"

@interface FirstViewController : UIViewController
@property(nonatomic,copy) NSString * datestrOut;
@property(nonatomic,copy)NSString * datestrback;
@property(nonatomic,copy) NSString * TdatestrOut;
@property(nonatomic,copy)NSString * Tdatestrback;
@property(nonatomic,copy) NSString * HdatestrOut;
@property(nonatomic,copy)NSString * Hdatestrback;
@property(nonatomic,copy)NSArray*traincity;

@property(nonatomic,copy)NSMutableDictionary*hotelseatdic;

@property(nonatomic,assign)int num;

@end
