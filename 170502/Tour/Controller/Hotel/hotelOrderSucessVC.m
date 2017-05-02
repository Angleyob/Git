//
//  hotelOrderSucessVC.m
//  Tour
//
//  Created by Euet on 17/3/6.
//  Copyright © 2017年 lhy. All rights reserved.
//

#import "hotelOrderSucessVC.h"
#import "HpayOrderMessageVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface hotelOrderSucessVC ()

@end

@implementation hotelOrderSucessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView * view= [[UIView alloc]initWithFrame:CGRectMake(0, 0, deviceScreenWidth, 64)];
    view.backgroundColor= [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    [self.view addSubview:view];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(deviceScreenWidth/2-40, 20, 80 , 30)];
    label.text=@"下单成功";
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    UIButton * backbut = [[UIButton alloc]initWithFrame:CGRectMake(10, 10, 44, 44)];
    UIImageView * imagviewback = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewback.image=[UIImage imageNamed:@"back-chevron"];
    [backbut addSubview:imagviewback];
    // [backbut setBackgroundImage:[UIImage imageNamed:@"back-chevron"] forState:UIControlStateNormal];
    [backbut addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    backbut.tag=666;
    [view addSubview:backbut];
    
    
    UIButton * sharembut = [[UIButton alloc]initWithFrame:CGRectMake(deviceScreenWidth-54, 10, 44, 44)];
    UIImageView * imagviewshare = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 14, 20)];
    imagviewshare.image=[UIImage imageNamed:@"share"];
    [sharembut addSubview:imagviewshare];
    [sharembut addTarget:self action:@selector(sharembut:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sharembut];


    _statusLabel.text=@"下单成功，等待支付";
    _orderaNo.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    _priceLabel.text=[NSString stringWithFormat:@"%@元",_price];
    _priceLabel.textColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
    _orderaNo.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    _orderaNo.text=_orderno;
    _orderaNo.textColor=[UIColor colorWithRed:156/255.0 green:156/255.0 blue:156/255.0 alpha:1];
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    
    _odrMesbut.backgroundColor=[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1];
     [_odrMesbut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_odrMesbut addTarget:self action:@selector(goclick:) forControlEvents:UIControlEventTouchUpInside];

    _odrMesbut.clipsToBounds=YES;
    //圆角
    _odrMesbut.layer.cornerRadius = 10.0;
    _odrMesbut.clipsToBounds=YES;
    _odrMesbut.tag = 601;

    _jxbut.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [_jxbut addTarget:self action:@selector(goclick:) forControlEvents:UIControlEventTouchUpInside];

    _jxbut.layer.cornerRadius = 10.0;
    [_jxbut setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
    _jxbut.tag = 602;

    [_jxbut.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
    [_jxbut.layer setBorderWidth:1];
    [_jxbut.layer setMasksToBounds:YES];
    
    _flightbut.clipsToBounds=YES;
    _flightbut.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _flightbut.tag = 603;
    _flightbut.layer.cornerRadius = 10.0;
    [_flightbut setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
    [_flightbut.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
    [_flightbut addTarget:self action:@selector(goclick:) forControlEvents:UIControlEventTouchUpInside];
    [_flightbut.layer setBorderWidth:1];
    [_flightbut.layer setMasksToBounds:YES];
    
    
    _trainbut.backgroundColor=[UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    _trainbut.tag = 604;
    _trainbut.clipsToBounds=YES;
    _trainbut.layer.cornerRadius = 10.0;
    [_trainbut setTitleColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1] forState:UIControlStateNormal];
    [_trainbut.layer setBorderColor:[UIColor colorWithRed:247/255.0 green:181/255.0 blue:42/255.0 alpha:1].CGColor];
    [_trainbut addTarget:self action:@selector(goclick:) forControlEvents:UIControlEventTouchUpInside];
    [_trainbut.layer setBorderWidth:1];
    [_trainbut.layer setMasksToBounds:YES];

}
-(void)goclick:(UIButton*)send{
    
    switch (send.tag) {
        case 601:{
            HpayOrderMessageVC * vc = [HpayOrderMessageVC new];
            vc.orderStr=_orderno;
            vc.tabBarController.tabBar.hidden=NO;
            [self.navigationController pushViewController:vc animated:NO];
            break;
        }
        case 602:{
                FirstViewController * vc = [FirstViewController new];
                vc.num=3;
                vc.tabBarController.tabBar.hidden=NO;
                [self.navigationController pushViewController:vc animated:NO];
                break;
        }
        case 603:{
              FirstViewController * vc = [FirstViewController new];
                vc.num=1;
                vc.tabBarController.tabBar.hidden=NO;
                [self.navigationController pushViewController:vc animated:NO];
            
            break;
        }
        case 604:{
            FirstViewController * vc = [FirstViewController new];
                vc.num=2;
                vc.tabBarController.tabBar.hidden=NO;
                [self.navigationController pushViewController:vc animated:NO];
            break;
        }
        default:
            break;
    }
}

-(void)back:(UIButton*)send{
   
    [AlertViewManager alertWithTitle:@"温馨提示"
                             message:@"你是否确定退出？"textFieldNumber:0 actionNumber:2 actionTitles:@[@"取消",@"确定"] textFieldHandler:nil actionHandler:^(UIAlertAction *action, NSUInteger index) {
                                 if (index==1) {
                                     [self.navigationController popToRootViewControllerAnimated:NO];
                                 }
                             }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    
    //    if ([_type isEqualToString:@"1"]) {
    //       str =[NSString stringWithFormat:@"机票订单。\n 航班:%@;\n 航线:%@;\n 时间:%@;\n 价格:￥%@; \n",_orderprice,_orderprice,_orderprice,_orderprice];
    //    }else if ([_type isEqualToString:@"2"]){
    //       str =[NSString stringWithFormat:@"酒店订单。\n 城市:%@;\n 地点:%@;\n 酒店名:%@;\n 价格:￥%@; \n",_orderprice,_orderprice,_orderprice,_orderprice];
    //    }else{
    //        str =[NSString stringWithFormat:@"火车订单。\n 车次:%@;\n 出发到达城市:%@;\n 时间:%@;\n 价格:￥%@; \n",_orderprice,_orderprice,_orderprice,_orderprice];
    //    }
            str =[NSString stringWithFormat:@"酒店订单。\n 订单状态:已支付; \n 订单号:%@; \n  订单总价:￥%@;",_orderno,_price];
       //1、创建分享参数
    NSArray* imageArray = @[image];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:str
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://wx.euet.com.cn/down/index.html"]
                                          title:@"一张新订单"
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

@end
