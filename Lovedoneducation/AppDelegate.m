//
//  AppDelegate.m
//  Lovedoneducation
//
//  Created by 王俊钢 on 2017/10/18.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "startVC.h"
#import "MainNavigationController.h"
// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#import "myinfomessageVC.h"
#endif

#import <NIMSDK/NIMSDK.h>
#import <NIMAVChat/NIMAVChat.h>

#import "ZTVendorManager.h"

@interface AppDelegate ()<JPUSHRegisterDelegate, NIMLoginManagerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // AppDelegate 进行全局设置
    if (@available(iOS 11.0, *)){
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];

//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
//        //可以添加自定义categories
//        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
//                                                          UIUserNotificationTypeSound |
//                                                          UIUserNotificationTypeAlert)
//                                              categories:nil];
//    } else {
//        //categories 必须为nil
////        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
////                                                          UIRemoteNotificationTypeSound |
////                                                          UIRemoteNotificationTypeAlert)
////                                              categories:nil];
//    }
//
//    /*!
//     * @abstract 启动SDK
//     *
//     * @param launchingOption 启动参数.
//     * @param appKey 一个JPush 应用必须的,唯一的标识. 请参考 JPush 相关说明文档来获取这个标识.
//     * @param channel 发布渠道. 可选.
//     * @param isProduction 是否生产环境. 如果为开发状态,设置为 NO; 如果为生产状态,应改为 YES.
//     * @param advertisingIdentifier 广告标识符（IDFA） 如果不需要使用IDFA，传nil.
//     *
//     * @discussion 提供SDK启动必须的参数, 来启动 SDK.
//     * 此接口必须在 App 启动时调用, 否则 JPush SDK 将无法正常工作.
//     */
//
//    [JPUSHService setupWithOption:launchOptions appKey:JIGUANG
//                          channel:@"Test"
//                 apsForProduction:NO
//            advertisingIdentifier:nil];
    
    [ZTVendorManager registerVendorSDK];
    
    [self configJPushoptions:launchOptions];
    
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *token = [defat objectForKey:user_token];
    if ([strisNull isNullToString:token]) {
         [self configstart];
    }
    else
    {
        self.window.rootViewController = [MainTabBarController shareInstance];
    }
    
    // 登录云信 IM
    [self NIMLogin];
    
    return YES;
}

- (void)NIMLogin{
    NSString *appKey        = NIMKEY;
    NIMSDKOption *option    = [NIMSDKOption optionWithAppKey:appKey];
    option.apnsCername      = @"your APNs cer name";
    option.pkCername        = @"your pushkit cer name";
    [[NIMSDK sharedSDK] registerWithOption:option];
    [[NIMSDK sharedSDK].loginManager addDelegate:self];
    NIMAutoLoginData *loginData = [[NIMAutoLoginData alloc] init];
    NSString *account = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_imtoken];
    loginData.account = account;
    loginData.token = token;
    loginData.forcedMode = YES;
    [[[NIMSDK sharedSDK] loginManager] autoLogin:loginData];
}

- (void)onLogin:(NIMLoginStep)step{
    NSLog(@"%ld", step);
}

- (void)onAutoLoginFailed:(NSError *)error{
    NSLog(@"NIM auto login failed.");
}





#pragma mark 极光推送

- (void)configJPushoptions:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:JIGUANG
                          channel:nil
                 apsForProduction:NO
            advertisingIdentifier:nil];
    
    // 注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(networkDidReceiveMessage:)
                                                 name:kJPFNetworkDidReceiveMessageNotification
                                               object:nil];
    
    
}

// 接收到自定义消息事件
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"%@",userInfo);
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    } // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [JPUSHService handleRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();  // 系统要求执行这个方法
    NSLog(@"尼玛的推送消息呢===%@",userInfo);
    
    [self goToMssageViewControllerWith:userInfo];
    
}


- (void)goToMssageViewControllerWith:(NSDictionary*)msgDic{
    //将字段存入本地，因为要在你要跳转的页面用它来判断,这里我只介绍跳转一个页面，
//    SystemMessageTVC * VC = [[SystemMessageTVC alloc]init];
//    VC.typestr = @"1";
//    UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
//    [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];
//
    myinfomessageVC *VC = [[myinfomessageVC alloc] init];
    VC.InActionType = ENUM_ViewController_ActionTypeHome;
    UINavigationController * Nav = [[UINavigationController alloc]initWithRootViewController:VC];//这里加导航栏是因为我跳转的页面带导航栏，如果跳转的页面不带导航，那这句话请省去。
    [self.window.rootViewController presentViewController:Nav animated:YES completion:nil];

}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    
    NSLog(@"尼玛的推送消息呢===%@",userInfo);
    application.applicationIconBadgeNumber = 0;
    [self goToMssageViewControllerWith:userInfo];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"尼玛的推送消息呢===%@",userInfo);
    application.applicationIconBadgeNumber = 0;
    [self goToMssageViewControllerWith:userInfo];
}





//- (void)application:(UIApplication *)application
//didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
//
//    /// Required - 注册 DeviceToken
//    [JPUSHService registerDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//
//    // Required,For systems with less than or equal to iOS6
//    //处理收到的 APNs 消息
//    application.applicationIconBadgeNumber = 0;
//    [JPUSHService handleRemoteNotification:userInfo];
//    [self goToMssageViewControllerWith:userInfo];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//
//    // IOS 7 Support Required
//    [JPUSHService handleRemoteNotification:userInfo];
//    completionHandler(UIBackgroundFetchResultNewData);
//    [self goToMssageViewControllerWith:userInfo];
//}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [application cancelAllLocalNotifications];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)configstart
{
    startVC *vc = [[startVC alloc] init];
    MainNavigationController *nav = [[MainNavigationController alloc] init];
    nav.viewControllers = @[vc];
    self.window.rootViewController = nav;
}



@end
