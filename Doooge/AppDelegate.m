//
//  AppDelegate.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppDelegate.h"
#import "AppSettings.h"
#import "AppSettings+ShopSettings.h"
#import "AppSettings+HabitSettings.h"
#import "AppDatabase.h"
#import "AppNotificationCenter.h"

static NSString * const kBreakfastKey = @"早饭";
static NSString * const kLunchKey = @"午饭";
static NSString * const kDinnerKey = @"晚饭";
static NSString * const kSportKey = @"运动";
static NSString * const kSleepKey = @"睡觉";

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window.backgroundColor = [UIColor whiteColor];
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
        [[AppSettings sharedSettings]registerDailyRoutines];
        [[AppDatabase sharedDatabase]createDefaultDailyRoutines];
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
    NSUserDefaults * userDefaults = [AppSettings sharedSettings].userDefaults;
    [self updateDailyRoutinesWithUserDefaults:userDefaults];
    [self updateCustomHabitsWithUserDefaults:userDefaults];
}

- (void)updateDailyRoutinesWithUserDefaults:(NSUserDefaults *)userDefaults {
    [[AppDatabase sharedDatabase]updateDailyRoutineWithName:kBreakfastKey fromUserDefaults:userDefaults];
    [[AppDatabase sharedDatabase]updateDailyRoutineWithName:kLunchKey fromUserDefaults:userDefaults];
    [[AppDatabase sharedDatabase]updateDailyRoutineWithName:kDinnerKey fromUserDefaults:userDefaults];
    [[AppDatabase sharedDatabase]updateDailyRoutineWithName:kSportKey fromUserDefaults:userDefaults];
    [[AppDatabase sharedDatabase]updateDailyRoutineWithName:kSleepKey fromUserDefaults:userDefaults];
}

- (void)updateCustomHabitsWithUserDefaults:(NSUserDefaults *)userDefaults {
    NSArray * customHabitNames = [[AppDatabase sharedDatabase]allCustomHabitName];
    for (NSString * name in customHabitNames) {
        [[AppDatabase sharedDatabase]updateCustomHabitWithName:name fromUserDefaults:userDefaults];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
