//
//  DloadingViewController.m
//  Tour
//
//  Created by Euet on 17/4/25.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "DloadingViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface DloadingViewController ()

@end

@implementation DloadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 100 , 30)];
    label.text=@"客户端下载";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    backbut.tag=666;
    [view addSubview:backbut];
    
    UIButton * sharembut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-54, 10, 44, 44)];
    UIImageView * imagviewshare = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewshare.image=[UIImage imageNamed:@"share"];
    [sharembut addSubview:imagviewshare];
    [sharembut addTarget:self action:@selector(sharembut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sharembut];

}
#pragma mark - 支付分享按钮
- (UIImage *)getSnapshotImage:(UIView*)view
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(view.frame),CGRectGetHeight(view.frame)), NO, 1);
    [view drawViewHierarchyInRect:CGRectMake(0,0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
               afterScreenUpdates:NO];
    UIImage*snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}
-(void)sharembut:(UIButton*)send{
    UIImage * image = [self getSnapshotImage:self.view];
    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    NSString * str ;
            str =@"易游差旅APP下载";
       //1、创建分享参数
    NSArray* imageArray = @[image];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数
//https://itunes.apple.com/cn/app/id1219129275?mt=8http://wx.euet.com.cn/down/index.html
//images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:str
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://wx.euet.com.cn/down/index.html"]
                                          title:@"易游差旅"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
}

-(void)back:(UIButton*)send{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
