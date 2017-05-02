//
//  projectChangeVC.h
//  Tour
//
//  Created by Euet on 17/4/20.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectprijectBalock)(NSMutableDictionary * dict);
@interface projectChangeVC : UIViewController

@property(nonatomic,assign)NSString * projectNo;
@property(nonatomic,assign)NSString * projectName;
@property (nonatomic, copy) SelectprijectBalock block;
- (void)SelectprijectWithBlock:(SelectprijectBalock)block;

@end
