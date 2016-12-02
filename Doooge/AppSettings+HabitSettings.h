//
//  AppSettings+HabitSettings.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/30.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppSettings.h"

@class CustomHabit;

@interface AppSettings(HabitSettings)
- (void)registerDailyRoutines;

- (void)updateDailyRoutine:(NSString *)ID withHour:(NSInteger)hour andMinute:(NSInteger)minute;
- (NSDictionary *)dailyRoutineWithName:(NSString *)name;

- (void)registerOrUpdateCustomHabit:(CustomHabit *)customHabit;
- (void)deleteCustomHabitWithName:(NSString *)name;
- (void)updateCustomHabitWithName:(NSString *)name lastClocked:(NSDate *)date andPersistDays:(NSInteger)persistDays;
- (NSDictionary *)customHabitWithName:(NSString *)name;
@end
