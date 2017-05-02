//
//  hotelMessageVC.h
//  Tour
//
//  Created by Euet on 17/1/18.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hotelMessageVC : UIViewController
@property(nonatomic,copy) NSString * hotelId;
@property(nonatomic,copy) NSString * hotelname;

@property(nonatomic,copy) NSMutableDictionary * datadict;

@property(nonatomic,copy)NSMutableDictionary*requtstdict;

@property(nonatomic,copy)NSMutableArray*menarray;

@end
