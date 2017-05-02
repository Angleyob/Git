//
//  framsizeclass.h
//  Tour
//
//  Created by Euet on 17/2/6.
//  Copyright © 2017年 lhy. All rights reserved.
//


//适配类方法
#import <Foundation/Foundation.h>

@interface framsizeclass : NSObject
+(CGSize)newCGSize:(CGSize)frame;
+ (UIEdgeInsets)newUIEdgeInsets:(UIEdgeInsets)frame;
+(CGRect)newSuitFrame:(CGRect)frame;

@end
