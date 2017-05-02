//
//  UIAlertView+show.m
//  MVCDemo
//
//  Created by Scarecrow on 16/4/17.
//  Copyright © 2016年 XB. All rights reserved.
//

#import "UIAlertView+show.h"
@implementation UIAlertView(show)
+ (void)showAlertWithTitle:(NSString *)title{
UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
   }
+ (void)showAlertWithTitle1:(NSString *)title duration:(NSTimeInterval)time
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:title delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
    
    [NSTimer scheduledTimerWithTimeInterval:time
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:alert
                                    repeats:YES];
    [alert show];
}
+(void)timerFireMethod:(NSTimer*)theTimer//弹出框
{
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert = NULL;
}
@end
