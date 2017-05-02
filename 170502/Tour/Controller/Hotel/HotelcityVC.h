//
//  HotelcityVC.h
//  Tour
//
//  Created by Euet on 17/1/16.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^hotelBlcok)(NSString *hotelcitystr);
@interface HotelcityVC : UIViewController
@property (strong, nonatomic) hotelBlcok block;
@property(nonatomic,strong)UICollectionView * menconView;

-(void)sendMessage:(hotelBlcok)block;

@end
