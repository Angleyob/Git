//
//  framsizeclass.m
//  Tour
//
//  Created by Euet on 17/2/6.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "framsizeclass.h"
#define SCREEN_RATE (375/[UIScreen mainScreen].bounds.size.width)
#define SCREEN_RATE1 (667/[UIScreen mainScreen].bounds.size.height)

@implementation framsizeclass
+ (CGSize)newCGSize:(CGSize)frame
{
    CGSize newFrame;
    newFrame.width=frame.width/SCREEN_RATE;
    newFrame.height=frame.height/SCREEN_RATE1;
    return newFrame;
}
+ (UIEdgeInsets)newUIEdgeInsets:(UIEdgeInsets)frame
{
    UIEdgeInsets newFrame;
    newFrame.top=frame.top/SCREEN_RATE;
    newFrame.left=frame.left/SCREEN_RATE;
    newFrame.bottom=frame.bottom/SCREEN_RATE;
    newFrame.right=frame.right/SCREEN_RATE;
    return newFrame;
}
+(CGRect)newSuitFrame:(CGRect)frame
{
    CGRect newFrame;
    newFrame.size.height = frame.size.height/SCREEN_RATE1;
    newFrame.size.width = frame.size.width/SCREEN_RATE;
    newFrame.origin.x = frame.origin.x/SCREEN_RATE;
    newFrame.origin.y = frame.origin.y/SCREEN_RATE1;
    return newFrame;
}

@end
