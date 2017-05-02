//
//  MyFooterView.h
//  Tour
//
//  Created by Euet on 17/3/28.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyFooterView;
@protocol MyFooterViewDelegate <NSObject>
-(void)bookbutClick:(MyFooterView *)foot;
@end
@interface MyFooterView : UICollectionReusableView
@property(strong,nonatomic)UILabel *titleLab;
@property(strong,nonatomic)UIButton *button;
@property (nonatomic ,weak) id<MyFooterViewDelegate>delegate;

@end
