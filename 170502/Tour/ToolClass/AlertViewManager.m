

//
//  AlertViewManager.m
//  Alert
//
//  Created by 郭领 on 17/2/27.
//  Copyright (c) 2017年 郭领. All rights reserved.
//

#import "AlertViewManager.h"

@implementation AlertViewManager
//  有BUg,所跳转的页面必须是PUS跳转进入的
+ (void)alertWithTitle:(NSString *)title
               message:(NSString *)message
       textFieldNumber:(NSUInteger)textFieldNumber
          actionNumber:(NSUInteger)actionNumber
          actionTitles:(NSArray *)actionTitle
      textFieldHandler:(textFieldHandler)textFieldHandler
         actionHandler:(actionHandler)actionHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
   
    if (textFieldNumber > 0) {
        for (int i = 0; i < textFieldNumber; i++) {
            [alertC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textFieldHandler(textField, i);
            }];
        }
    }
    if (actionNumber > 0) {
        for (NSUInteger i = 0; i < actionNumber; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)  {
                actionHandler(action, i);
            }];
            [alertC addAction:action];
        }
    }
    
[[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}
+ (void)alertWithTitle1:(NSString *)title
               message:(NSString *)message
       textFieldNumber:(NSUInteger)textFieldNumber
          actionNumber:(NSUInteger)actionNumber
          actionTitles:(NSArray *)actionTitle
      textFieldHandler:(textFieldHandler)textFieldHandler
         actionHandler:(actionHandler1)actionHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (textFieldNumber > 0) {
        for (int i = 0; i < textFieldNumber; i++) {
            [alertC addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textFieldHandler(textField, i);
            }];
        }
    }
    if (actionNumber > 0) {
        for (NSUInteger i = 0; i < actionNumber; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)  {
                actionHandler(action,i,alertC.textFields.firstObject.text);
            }];
            [alertC addAction:action];
        }
    }
    
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}

+ (void)actionSheettWithTitle:(NSString *)title
                      message:(NSString *)message
                 actionNumber:(NSUInteger)actionNumber
                 actionTitles:(NSArray *)actionTitle
                actionHandler:(actionHandler)actionHandler {
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    if (actionNumber > 0) {
        for (NSUInteger i = 0; i < actionNumber; i++) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)  {
                actionHandler(action,i);
            }];
            [alertC addAction:action];
        }
    }
    [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:alertC animated:YES completion:nil];
}





@end
