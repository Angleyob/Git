
//提示框(只做提示操作)
#import <UIKit/UIKit.h>
@interface UIAlertView(show)
+ (void)showAlertWithTitle:(NSString *)title;
+ (void)showAlertWithTitle1:(NSString *)title duration:(NSTimeInterval)time;
+(void)timerFireMethod:(NSTimer*)theTimer;//弹出框

@end
