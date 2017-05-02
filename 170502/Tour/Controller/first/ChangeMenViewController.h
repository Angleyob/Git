//
//  ChangeMenViewController.h
//  Tour
//
//  Created by Euet on 16/12/20.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^menBlcok)(NSMutableArray *array);
@interface ChangeMenViewController : UIViewController
@property(nonatomic,strong)menBlcok block;
-(void)sendMessage:(menBlcok)block;

@property(nonatomic,strong)UIImageView * imageview;

@property(nonatomic,copy) NSMutableArray * menarry;

@property(nonatomic,assign)int type;

@end
