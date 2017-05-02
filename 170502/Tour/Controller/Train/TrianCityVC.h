//
//  TrianCityVC.h
//  Tour
//
//  Created by Euet on 17/1/10.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TrianCityBlcok)(NSString *citystr,NSArray*arr);

@interface TrianCityVC : UIViewController


@property(nonatomic,copy)NSString * outcity;

@property(nonatomic,copy)NSString * backcity;

@property(nonatomic,strong)UICollectionView * menconView;

@property (strong, nonatomic) TrianCityBlcok block;

-(void)TrianCitysendMessage:(TrianCityBlcok)block;
@end
