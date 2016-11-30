//
//  AppDatabase.h
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DailyRoutine;
@class CustomHabit;

@interface AppDatabase : NSObject
+ (instancetype)sharedDatabase;

- (void)addDailyRoutine:(DailyRoutine *)dailyRoutine;
- (void)addCustomHabit:(CustomHabit *)customHabit;

- (void)createDefaultDailyRoutines;

- (DailyRoutine *)dailyRoutineWithName:(NSString *)name;
- (CustomHabit *)customHabitWithName:(NSString *)name;

- (NSArray *)allDailyRoutine;
- (NSArray *)allCustomHabit;
- (NSArray *)allCustomHabitName;

- (void)updateDailyRoutineWithName:(NSString *)name fromUserDefaults:(NSUserDefaults *)userDefaults;
- (void)updateHour:(NSInteger)hour andMinute:(NSInteger)minute withDailyRoutine:(DailyRoutine *)dailyRoutine;

- (void)updateCustomHabitWithName:(NSString *)name fromUserDefaults:(NSUserDefaults *)userDefaults;
- (void)updateLastClocked:(NSDate *)date withCustomHabit:(CustomHabit *)customHabit;
- (void)updateHour:(NSInteger)hour
            minute:(NSInteger)minute
         hasRemind:(BOOL)hasRemind
              week:(NSInteger)week
   withCostomHabit:(CustomHabit *)customHabit;
- (void)deleteCustomHabit:(CustomHabit *)customHabit;
@end
