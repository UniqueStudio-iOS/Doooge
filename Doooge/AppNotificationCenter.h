//
//  AppNotificationCenter.h
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DailyRoutine;
@class CustomHabit;

@interface AppNotificationCenter : NSObject
+ (instancetype)sharedNotificationCenter;

- (void)requestNotificationAuthorization;

- (void)registerDefaultDailyRoutines;
- (void)registerDailyRoutine:(DailyRoutine *)dailyRoutine;
- (void)registerCustomHabit:(CustomHabit *)customHabit;
- (void)removeCustomHabit:(CustomHabit *)customHabit;

- (void)registerCustomHabitCategory:(NSString *)name;
@end
