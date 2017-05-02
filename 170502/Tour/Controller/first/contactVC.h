//
//  contactVC.h
//  Tour
//
//  Created by Euet on 17/1/3.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^contactBlcok)(NSMutableArray * contactarr);
@interface contactVC : UIViewController
@property(nonatomic,strong)contactBlcok block;

@property(nonatomic,copy)NSString * metype;

-(void)sendMessage:(contactBlcok)block;
@end
