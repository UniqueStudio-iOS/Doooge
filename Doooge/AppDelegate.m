//
//  AppDelegate.m
//  Doooge
//
//  Created by VicChan on 2016/10/29.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "AppDelegate.h"
#import "DooogeUserDefaults.h"
#import "DooogeNotificationCenter.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
    [[DooogeNotificationCenter currentNotificationCenter]requestAuthorization];
    [self initializeCheck];
    [[DooogeNotificationCenter currentNotificationCenter]requestAllHealthyRoutines];
    
    // Override point for customization after application launch.
    return YES;
}


- (void)initializeCheck {
    if (![[DooogeUserDefaults dooogeUserDefaults]growthPointForPet]) {
        [[DooogeUserDefaults dooogeUserDefaults]setGrowthPointForPet:1000];
    }
    if (![[DooogeUserDefaults dooogeUserDefaults]nameForPet]) {
        [[DooogeUserDefaults dooogeUserDefaults]setNameForPet:@"Doooge"];
    }
        if (![[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"breakfast"]) {
    NSDateComponents * breakfastTime = [[NSDateComponents alloc]init];
    breakfastTime.hour = 2;
    breakfastTime.minute = 31;
    NSDictionary * breakfastDict = [NSDictionary dictionaryWithObjectsAndKeys:@1, @"ID", @0, @"persist", [NSKeyedArchiver archivedDataWithRootObject:breakfastTime], @"time", nil];
    [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:breakfastDict forKey:@"breakfast"];
        }
    if (![[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"lunch"]) {
        NSDateComponents * lunchTime = [[NSDateComponents alloc]init];
        lunchTime.hour = 12;
        lunchTime.minute = 0;
        NSDictionary * lunchDict = [NSDictionary dictionaryWithObjectsAndKeys:@2, @"ID", @0, @"persist",  [NSKeyedArchiver archivedDataWithRootObject:lunchTime], @"time", nil];
        [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:lunchDict forKey:@"lunch"];
    }
    if (![[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"dinner"]) {
        NSDateComponents * dinnerTime = [[NSDateComponents alloc]init];
        dinnerTime.hour = 18;
        dinnerTime.minute = 0;
        NSDictionary * dinnerDict = [NSDictionary dictionaryWithObjectsAndKeys:@3, @"ID", @0, @"persist",  [NSKeyedArchiver archivedDataWithRootObject:dinnerTime], @"time", nil];
        [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dinnerDict forKey:@"dinner"];
    }
    if (![[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sport"]) {
        NSDateComponents * sportTime = [[NSDateComponents alloc]init];
        sportTime.hour = 6;
        sportTime.minute = 0;
        NSDictionary * sportDict = [NSDictionary dictionaryWithObjectsAndKeys:@4, @"ID", @0, @"persist",  [NSKeyedArchiver archivedDataWithRootObject:sportTime], @"time", nil];
        [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:sportDict forKey:@"sport"];
    }
    if (![[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sleep"]) {
        NSDateComponents * sleepTime = [[NSDateComponents alloc]init];
        sleepTime.hour = 23;
        sleepTime.minute = 0;
        NSDictionary * sleepDict = [NSDictionary dictionaryWithObjectsAndKeys:@5, @"ID", @0, @"persist",  [NSKeyedArchiver archivedDataWithRootObject:sleepTime], @"time", nil];
        [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:sleepDict forKey:@"sleep"];
    }
    [[DooogeUserDefaults dooogeUserDefaults]synchronize];
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
