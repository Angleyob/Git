//
//  flightcityViewController.h
//  Tour
//
//  Created by Euet on 16/12/15.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlcok)(NSString *citystr);
@interface flightcityViewController : UIViewController
@property(nonatomic,copy)NSString * outcity;
@property(nonatomic,copy)NSString * backcity;
@property(nonatomic,strong)UICollectionView * menconView;

@property (strong, nonatomic) myBlcok block;
-(void)sendMessage:(myBlcok)block;

@end
