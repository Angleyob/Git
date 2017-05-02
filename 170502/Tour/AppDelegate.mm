//
//  AppDelegate.m
//  Tour
//
//  Created by Euet on 16/11/29.
//  Copyright © 2016年 lhy. All rights reserved.

#import "AppDelegate.h"

#import <AdSupport/AdSupport.h>
#import "JPUSHService.h"

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>


#import "WXApiObject.h"
#import "WechatAuthSDK.h"
#import "WXApi.h"       //微信分享和微信支付

#import "Harpy.h"


#import "UPPaymentControl.h"

#import "RSA.h"
#import <CommonCrypto/CommonDigest.h>


BMKMapManager* _mapManager;


@interface AppDelegate ()<WXApiDelegate,WechatAuthAPIDelegate,JPUSHRegisterDelegate,BMKMapViewDelegate,BMKGeneralDelegate,HarpyDelegate>
@end
NSString* const appid = @"wx489dbe6b5d1efcd5";

@implementation AppDelegate
-(void)tabebar{
    //UITabBarController 标签栏控制器
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    //设置标签栏控制器的tabbar不透明
    tabBar.tabBar.translucent = NO;
    FirstViewController* first = [FirstViewController new];
    //first.title=@"首页";
    first.tabBarController.tabBar.hidden=NO;
    UINavigationController *nav1 = [[UINavigationController alloc] initWithRootViewController:first];
    /** 设置标签栏控制器的按钮颜色*/
    nav1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage imageNamed:@"homeoff"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"home-checked"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    /* 设置导航栏的背景颜色*/
    nav1.navigationBar.barTintColor = [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    //
    OrderViewController * sec = [OrderViewController new];
    UINavigationController *nav2 = [[UINavigationController alloc] initWithRootViewController:sec];
    nav2.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"订单" image:[[UIImage imageNamed:@"order"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"orderlist_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav2.navigationBar.barTintColor = [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    
    NeedViewController * three= [NeedViewController new];
    three.title=@"助手";
    UINavigationController *nav3 = [[UINavigationController alloc] initWithRootViewController:three];
    nav3.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"助手" image:[[UIImage imageNamed:@"assistant1"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"assistant"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav3.navigationBar.barTintColor = [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    
    
    MainViewController * four= [MainViewController new];
    four.title=@"我";
    UINavigationController *nav4 = [[UINavigationController alloc] initWithRootViewController:four];
    nav4.tabBarItem=[[UITabBarItem alloc]initWithTitle:@"我" image:[[UIImage imageNamed:@"me"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"me_on"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    nav4.navigationBar.barTintColor = [UIColor colorWithRed:7/255.0 green:68/255.0 blue:130/255.0 alpha:1];
    tabBar.viewControllers = @[nav1,nav2,nav3,nav4];
    _window.rootViewController = tabBar;
}
//定制导航栏视图控制器
-(void)customUINavigationController
{
//    OrderVC*viewController  = [[OrderVC alloc] init];
//    FlightMessageVC *viewController  = [[FlightMessageVC alloc] init];
    LoginViewController *viewController  = [[LoginViewController alloc] init];
    //创建一个导航栏视图控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
    //设置导航条样式
    nav.navigationBar.barStyle = UIBarStyleDefault;
    /*
     UIBarStyleDefault          = 0,
     UIBarStyleBlack
     */
    //设置导航条不透明  translucent
    nav.navigationBar.translucent = NO;
    //镂空颜色tintColor
    nav.navigationBar.tintColor = [UIColor redColor];
    //本身镂空颜色 barTintColor可以理解为设置背景颜色
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    //状态栏高20  导航条高44
    //如果图片高度比导航条高 会占用状态栏
    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"1"] forBarMetrics:UIBarMetricsDefault];
    //设置隐藏导航条
       nav.navigationBarHidden = YES;
    //把导航栏视图控制器设置为window的根视图
    _window.rootViewController = nav;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //第三方键盘
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;//这个是点击空白区域键盘收缩的开关
    manager.enableAutoToolbar = YES;//这个是它自带键盘工具条开关
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    [self customUINavigationController];
    
    [_window makeKeyAndVisible];
    //微信支付
    [WXApi registerApp:appid];
   
    
    
    
    //极光推送
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
  
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    // Required
    // init Push
    // notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
    // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。advertisingIdentifier:nil
 
    
    [JPUSHService setupWithOption:launchOptions appKey:@"a392a1c585e98e3ac7128920"
                          channel:@"App Store"
                 apsForProduction:YES];

    
    
    
//     要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"VTzd17Is2b1EA2l7eSkUEDl2UC1R0zj0" generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //第三方分享
    [self share];
    //版本更新
    [self checkVersion];
    
    
    return YES;
}
//百度地图
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    //    /下面的这个是微信调用的方法！没错！微信就是这么一小句话就调用起来了！
    return [WXApi handleOpenURL:url delegate:self];
    
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        if([code isEqualToString:@"success"]) {
            
            //如果想对结果数据验签，可使用下面这段代码，但建议不验签，直接去商户后台查询交易结果
            if(data != nil){
                //数据从NSDictionary转换为NSString
                NSData *signData = [NSJSONSerialization dataWithJSONObject:data
                                                                   options:0
                                                                     error:nil];
                NSString *sign = [[NSString alloc] initWithData:signData encoding:NSUTF8StringEncoding];
                
                //此处的verify建议送去商户后台做验签，如要放在手机端验，则代码必须支持更新证书
                if([self verify:sign]) {
                    //验签成功
                }
                else {
                    //验签失败
                }
            }
            
            //结果code为成功时，去商户后台查询一下确保交易是成功的再展示成功
        }
        else if([code isEqualToString:@"fail"]) {
            //交易失败
        }
        else if([code isEqualToString:@"cancel"]) {
            //交易取消
        }
    }];
    
    
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    
//    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidLoginNotification object:nil];

}
//- (void)networkDidReceiveMessage:(NSNotification *)notification {
//    
////    [JPUSHService setTags:nil aliasInbackground:[OpenUDID value]];
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
////        [JPUSHService setTags:nil alias:[OpenUDID value] fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias)
////         
////        {
////        }];
//        
//    });
//}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];

}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Tour"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}
#pragma mark - Core Data Saving support
- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

- (NSString *) readPublicKey:(NSString *) keyName
{
    if (keyName == nil || [keyName isEqualToString:@""]) return nil;
    
    NSMutableArray *filenameChunks = [[keyName componentsSeparatedByString:@"."] mutableCopy];
    NSString *extension = filenameChunks[[filenameChunks count] - 1];
    [filenameChunks removeLastObject]; // remove the extension
    NSString *filename = [filenameChunks componentsJoinedByString:@"."]; // reconstruct the filename with no extension
    
    NSString *keyPath = [[NSBundle mainBundle] pathForResource:filename ofType:extension];
    
    NSString *keyStr = [NSString stringWithContentsOfFile:keyPath encoding:NSUTF8StringEncoding error:nil];
    
    return keyStr;
}

-(BOOL) verify:(NSString *) resultStr {
    
    //此处的verify，商户需送去商户后台做验签
    return NO;
}
- (NSString*)sha1:(NSString *)string
{
    unsigned char digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_CTX context;
    NSString *description;
    
    CC_SHA1_Init(&context);
    
    memset(digest, 0, sizeof(digest));
    
    description = @"";
    
    
    if (string == nil)
    {
        return nil;
    }
    
    // Convert the given 'NSString *' to 'const char *'.
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    
    // Check if the conversion has succeeded.
    if (str == NULL)
    {
        return nil;
    }
    
    // Get the length of the C-string.
    int len = (int)strlen(str);
    
    if (len == 0)
    {
        return nil;
    }
    
    
    if (str == NULL)
    {
        return nil;
    }
    
    CC_SHA1_Update(&context, str, len);
    
    CC_SHA1_Final(digest, &context);
    
    description = [NSString stringWithFormat:
                   @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[ 0], digest[ 1], digest[ 2], digest[ 3],
                   digest[ 4], digest[ 5], digest[ 6], digest[ 7],
                   digest[ 8], digest[ 9], digest[10], digest[11],
                   digest[12], digest[13], digest[14], digest[15],
                   digest[16], digest[17], digest[18], digest[19]];
    
    return description;
}
#pragma mark  *********** 分享 ***********
-(void)share{
    
    [ShareSDK registerApp:@"1d38f88e7919c"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 break;
             case SSDKPlatformTypeRenren:
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
                 
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:appid                                       appSecret:@"28d673d6ba1927549f182a4f11d24e54"];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1106044735"
                                      appKey:@"QMqhR7EnmMCZPlrL"
                                    authType:SSDKAuthTypeBoth];
                 break;
                 //             case SSDKPlatformTypeRenren:
                 //                 [appInfo        SSDKSetupRenRenByAppId:@"226427"
                 //                                                 appKey:@"fc5b8aed373c4c27a05b712acba0f8c3"
                 //                                              secretKey:@"f29df781abdd4f49beca5a2194676ca4"
                 //                                               authType:SSDKAuthTypeBoth];
                 //                 break;
                 //             case SSDKPlatformTypeGooglePlus:
                 //                 [appInfo SSDKSetupGooglePlusByClientID:@"232554794995.apps.googleusercontent.com"
                 //                                           clientSecret:@"PEdFgtrMw97aCvf0joQj7EMk"
                 //                                            redirectUri:@"http://localhost"];
                 //                 break;
             default:
                 break;
         }
     }];

}
#pragma mark  *********** 检查版本更新 ***********
- (void)checkVersion{
    [[Harpy sharedInstance] setPresentingViewController:self.window.rootViewController];
    [[Harpy sharedInstance] setDelegate:self];
//    [[Harpy sharedInstance] setAlertControllerTintColor:KMainColorBlue];
    [[Harpy sharedInstance] setAppName:@"易游差旅"];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeOption];
    [[Harpy sharedInstance] setForceLanguageLocalization:HarpyLanguageChineseSimplified];//设置语言
    [[Harpy sharedInstance] checkVersion];
}

#pragma mark - HarpyDelegate
- (void)harpyDidShowUpdateDialog
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidLaunchAppStore
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidSkipVersion
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyUserDidCancel
{
    NSLog(@"%s", __FUNCTION__);
}

- (void)harpyDidDetectNewVersionWithoutAlert:(NSString *)message
{
    NSLog(@"%@", message);
}

@end
