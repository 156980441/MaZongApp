//
//  AppDelegate.m
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "AppDelegate.h"
#import "stdafx_MaZongApp.h"
#import "RootViewController.h"
#import "DeviceModel.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    RootViewController* device = [[RootViewController alloc] initWithType:ViewControllerDeviceType];
    
    RootViewController* forum = [[RootViewController alloc] initWithType:ViewControllerForumType];
    RootViewController* mine = [[RootViewController alloc] initWithType:ViewControllerMineType];
    
    UINavigationController* nav0 = [[UINavigationController alloc] initWithRootViewController:device];
    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:forum];
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:mine];
    
    device.title = @"设备";
    forum.title = @"论坛";
    mine.title = @"我的";
    
    UITabBarController* tabBarVc = [[UITabBarController alloc] init];
    tabBarVc.viewControllers = @[nav0,nav1,nav2];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = tabBarVc;
    [self.window makeKeyAndVisible];
    
#ifdef LOC_TEST
    NSMutableArray* arr0 = [NSMutableArray array];
    
    for (int i = 0; i < 10; i++) {
        DeviceModel* dev = [[DeviceModel alloc] init];
        dev.name = [NSString stringWithFormat:@"Jim %d",i];
        dev.deviceId = [NSString stringWithFormat:@"100-200-0%d",i];;
        dev.ph = @"3";
        dev.temperature = @"23";
        dev.tds = @"10";
        dev.isOff = 1;
        [arr0 addObject:dev];
    }
    
    NSMutableArray* arr1 = [NSMutableArray array];
    NSMutableArray* arr2 = [NSMutableArray array];
    [arr2 addObject:@"添加设备"];
    [arr2 addObject:@"Wifi 配置"];
    [arr2 addObject:@"修改密码"];
    [arr2 addObject:@"注销"];
    [arr2 addObject:@"关于"];
    
    device.dataSource = arr0;
    mine.dataSource = arr2;
#else
    
#endif
    return YES;
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
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
