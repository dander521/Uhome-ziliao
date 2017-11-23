//
//  AppDelegate.m
//  天利娱乐
//
//  Created by miaocai on 2017/6/1.
//  Copyright © 2017年 TLYL01. All rights reserved.
//

#import "AppDelegate.h"
#import "MCMainTabBarController.h"
#import "MCLoginViewController.h"
#import "MCChaseNumberViewController.h"
#import "UMMobClick/MobClick.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setUpKeyWindow];
    [self setUMengStatic];
    return YES;
}

- (void)setUpKeyWindow{
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window = window;

     NSString *str =  [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"];
    if (![str isEqualToString:@""] && str != nil) {
        window.rootViewController = [[MCMainTabBarController alloc] init];
    } else {
        window.rootViewController = [[MCLoginViewController alloc] init];
        
    }
    
    [window makeKeyAndVisible];
}
- (void)setUMengStatic{
    
    UMConfigInstance.appKey = @"59828129f43e483ff6000a84";
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    [MobClick setLogEnabled:NO];
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCloadDefaultCZList" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MCloadIssueNumber" object:nil userInfo:nil];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
