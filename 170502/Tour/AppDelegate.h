//
//  AppDelegate.h
//  Tour
//
//  Created by Euet on 16/11/29.
//  Copyright © 2016年 lhy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;
-(void)tabebar;
-(void)customUINavigationController;

@end

