//
//  UIViewController+tabbar.m
//  Tour
//
//  Created by Euet on 17/3/6.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "UIViewController+tabbar.h"

@interface UIViewController (tabbar)
@end


@implementation UIViewController (tabbar)
- (void)hideTabbar {
//    if (_originY + 49 == fabs(self.tabBarController.tabBar.frame.origin.y)) {
//        return ;
//    }
    for (UIView *v in [self.tabBarController.view subviews]) {
        if ([v isKindOfClass:[UITabBar class]]) {
            [UIView animateWithDuration:0.01 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
                
                CGRect frame = v.frame;
                frame.origin.y += 49.0f;
                v.frame = frame;
                NSLog(@"tabBar originY: %f", frame.origin.y);
            } completion:nil];
        } else {
            [UIView animateWithDuration:0.01 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
                
                CGRect frame = v.frame;
                frame.size.height += 49.0f;
                v.frame = frame;
                
            } completion:nil];
        }
    }
    return;
}

#pragma mark - 显示TabBar
-(void)showTabBar {
//    if (_originY == fabs(self.tabBarController.tabBar.frame.origin.y)) {
//        return ;
//    }
    for (UIView *v in [self.tabBarController.view subviews]) {
        if ([v isKindOfClass:[UITabBar class]]) {
            [UIView animateWithDuration:0.01 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
                
                CGRect frame = v.frame;
                frame.origin.y -= 49.0f;
                v.frame = frame;
            } completion:nil];
        } else {
            [UIView animateWithDuration:0.01 delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^(){
                CGRect frame = v.frame;  
                frame.size.height -= 49.0f;  
                v.frame = frame;  
            } completion:nil];  
        }  
    }  
    return;  
}
@end
