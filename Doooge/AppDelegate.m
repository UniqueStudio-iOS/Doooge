//
//  AppDelegate.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppDelegate.h"
#import "AppSettings.h"
#import "AppDatabase.h"
#import "AppNotificationCenter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
#warning remove later
    [AppSettings sharedSettings].primary = YES;
    [AppSettings sharedSettings];
    [self authorizationCheck];
    [self dataCheck];
    return YES;
}

- (void)authorizationCheck {
    if ([AppSettings sharedSettings].isAuthorized == NO) {
        [[AppNotificationCenter sharedNotificationCenter]requestNotificationAuthorization];
    }
}

- (void)dataCheck {
    if ([AppSettings sharedSettings].isPrimary == YES) {
        [[AppSettings sharedSettings]registerShopItems];
#warning add later
//        [[AppDatabase sharedDatabase]createDefaultDailyRoutines];
        [[AppNotificationCenter sharedNotificationCenter]registerDefaultDailyRoutines];
        [AppSettings sharedSettings].primary = NO;
    }
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
    application.applicationIconBadgeNumber = 0;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
