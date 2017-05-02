//
//  HotelChangeVC.h
//  Tour
//
//  Created by Euet on 17/3/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^cellBalock)(NSMutableDictionary * celldic);
@interface HotelChangeVC : UIViewController
@property(nonatomic,copy) NSString * cityId;
@property (nonatomic, copy) cellBalock block;
- (void)cellBalock:(cellBalock)block;

@end
