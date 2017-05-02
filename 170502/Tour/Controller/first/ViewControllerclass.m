//
//  ViewControllerclass.m
//  Tour
//
//  Created by Euet on 17/3/7.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "ViewControllerclass.h"

@interface ViewControllerclass ()
{
    NSInteger _originY;
}
@end

@implementation ViewControllerclass

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed =YES;
}
- (void)hideTabbar {
        if (_originY + 49 == fabs(self.tabBarController.tabBar.frame.origin.y)) {
            return ;
        }
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
        if (_originY == fabs(self.tabBarController.tabBar.frame.origin.y)) {
            return ;
        }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
