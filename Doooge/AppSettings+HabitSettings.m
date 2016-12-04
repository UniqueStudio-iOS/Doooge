//
//  AppSettings+HabitSettings.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/30.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "AppSettings+HabitSettings.h"

#import "DailyRoutine.h"
#import "CustomHabit.h"

#import "AppTime.h"

@implementation AppSettings(HabitSettings)
#pragma mark - Register Methods
- (void)registerDailyRoutines {
    NSDate * initialDate = [NSDate dateWithTimeIntervalSince1970:0];
    [self.userDefaults registerDefaults:@{
                                          @"早饭":@{
                                                    @"hour":@7,
                                                    @"minute":@30,
                                                    @"persist":@0,
                                                    @"last":initialDate
                                                  },
                                          @"午饭":@{
                                                    @"hour":@12,
                                                    @"minute":@0,
                                                    @"persist":@0,
                                                    @"last":initialDate
                                                  },
                                          @"晚饭":@{
                                                    @"hour":@19,
                                                    @"minute":@30,
                                                    @"persist":@0,
                                                    @"last":initialDate
                                                  },
                                          @"运动":@{
                                                    @"hour":@12,
                                                    @"minute":@0,
                                                    @"persist":@0,
                                                    @"last":initialDate
                                                  },
                                          @"睡觉":@{
                                                    @"hour":@23,
                                                    @"minute":@0,
                                                    @"persist":@0,
                                                    @"last":initialDate
                                                  }
                                          }];
}
#pragma mark - Daily Routines
- (void)updateDailyRoutine:(NSString *)ID withHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSMutableDictionary * content = [[self.userDefaults objectForKey:ID]mutableCopy];
    content[@"hour"] = [NSNumber numberWithInteger:hour];
    content[@"minute"] = [NSNumber numberWithInteger:minute];
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:content] forKey:ID];
    NSLog(@"Daily Routine Updated!");
}

- (NSDictionary *)dailyRoutineWithName:(NSString *)name {
    return [self.userDefaults objectForKey:name];
}
#pragma mark - Custom Habits
- (void)registerCustomHabits {
    [self.userDefaults registerDefaults:@{@"habits": [NSDictionary dictionary]}];
}

- (void)registerOrUpdateCustomHabit:(CustomHabit *)customHabit {
    NSMutableDictionary * container = [[self.userDefaults objectForKey:@"habits"]mutableCopy];
    
    NSDictionary * content = @{
                               @"hour":[NSNumber numberWithInteger:customHabit.hour],
                               @"minute":[NSNumber numberWithInteger:customHabit.minute],
                               @"week":[NSNumber numberWithInteger:customHabit.week],
                               @"persist":[NSNumber numberWithInteger:customHabit.persistDays],
                               @"remind":[NSNumber numberWithBool:customHabit.hasRemind],
                               @"last":customHabit.lastClocked
                               };
    [container setObject:content forKey:customHabit.ID];
    
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:container] forKey:@"habits"];
    NSLog(@"Custom Habit Updated!");
}

- (void)deleteCustomHabitWithName:(NSString *)name {
    NSMutableDictionary * container = [[self.userDefaults objectForKey:@"habits"]mutableCopy];
    
    [container removeObjectForKey:name];
    
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:container] forKey:@"habits"];
}

- (void)updateCustomHabitWithName:(NSString *)name lastClocked:(NSDate *)date andPersistDays:(NSInteger)persistDays{
    NSMutableDictionary * container = [[self.userDefaults objectForKey:@"habits"]mutableCopy];
    
    NSMutableDictionary * content = [[container objectForKey:name]mutableCopy];
    content[@"last"] = date;
    content[@"persist"] = [NSNumber numberWithInteger:persistDays];
    if (persistDays > 0 && persistDays % 21 == 0) {
        self.growthPoints += 100;
        self.goldCoins += 50;
    }
    [container setObject:content forKey:name];
    
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:container] forKey:@"habits"];
}

- (NSDictionary *)customHabitWithName:(NSString *)name {
    return [[self.userDefaults objectForKey:@"habits"]objectForKey:name];
}
#pragma mark - Growth Points And Gold Coins
- (void)reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:(NSInteger)unfinished mutableDictionary:(NSMutableDictionary *)mutableDictionary andKey:(NSString *)key withDate:(NSDate *)date{
    self.growthPoints -= 5 * unfinished;
    mutableDictionary[@"last"] = date;
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:mutableDictionary] forKey:key];
}

- (void)calculateGrowthPointsWithDailyRoutines {
    NSMutableDictionary * breakfast = [[self.userDefaults objectForKey:@"早饭"]mutableCopy];
    if ([breakfast[@"last"]timeIntervalSince1970] != 0) {
        NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:breakfast[@"last"] andDate2:[AppTime sharedTime].date] - 1;
        if (unfinished > 0) {
            [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:unfinished mutableDictionary:breakfast andKey:@"早饭" withDate:[[AppTime sharedTime]yesterday]];
        } else if (unfinished == 0) {
            NSDate * targetDate = [[AppTime sharedTime]timeFromHour:[breakfast[@"hour"]integerValue]+1 andMinute:[breakfast[@"minute"]integerValue]];
            if (![[AppTime sharedTime]isDate1:[AppTime sharedTime].date withinDate2:targetDate]) {
                [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:1 mutableDictionary:breakfast andKey:@"早饭" withDate:[[AppTime sharedTime]date]];
            }
        }
    } else {
        [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:0 mutableDictionary:breakfast andKey:@"早饭" withDate:[[AppTime sharedTime]date]];
    }
    NSMutableDictionary * lunch = [[self.userDefaults objectForKey:@"午饭"]mutableCopy];
    if ([lunch[@"last"]timeIntervalSince1970] != 0) {
        NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:lunch[@"last"] andDate2:[AppTime sharedTime].date] - 1;
        if (unfinished > 0) {
            [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:unfinished mutableDictionary:lunch andKey:@"午饭" withDate:[[AppTime sharedTime]yesterday]];
        } else if (unfinished == 0) {
            NSDate * targetDate = [[AppTime sharedTime]timeFromHour:[lunch[@"hour"]integerValue]+1 andMinute:[lunch[@"minute"]integerValue]];
            if (![[AppTime sharedTime]isDate1:[AppTime sharedTime].date withinDate2:targetDate]) {
                [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:1 mutableDictionary:lunch andKey:@"午饭" withDate:[[AppTime sharedTime]date]];
            }
        }
    } else {
        [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:0 mutableDictionary:lunch andKey:@"午饭" withDate:[[AppTime sharedTime]date]];
    }
    NSMutableDictionary * dinner = [[self.userDefaults objectForKey:@"晚饭"]mutableCopy];
    if ([dinner[@"last"]timeIntervalSince1970] != 0) {
        NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:dinner[@"last"] andDate2:[AppTime sharedTime].date] - 1;
        if (unfinished > 0) {
            [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:unfinished mutableDictionary:dinner andKey:@"晚饭" withDate:[[AppTime sharedTime]yesterday]];
        } else if (unfinished == 0) {
            NSDate * targetDate = [[AppTime sharedTime]timeFromHour:[dinner[@"hour"]integerValue]+1 andMinute:[dinner[@"minute"]integerValue]];
            if (![[AppTime sharedTime]isDate1:[AppTime sharedTime].date withinDate2:targetDate]) {
                [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:1 mutableDictionary:dinner andKey:@"晚饭" withDate:[[AppTime sharedTime]date]];
            }
        }
    } else {
        [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:0 mutableDictionary:dinner andKey:@"晚饭" withDate:[[AppTime sharedTime]date]];
    }
    NSMutableDictionary * sports = [[self.userDefaults objectForKey:@"运动"]mutableCopy];
    if ([sports[@"last"]timeIntervalSince1970] != 0) {
        NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:sports[@"last"] andDate2:[AppTime sharedTime].date] - 1;
        if (unfinished > 0) {
            [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:unfinished mutableDictionary:sports andKey:@"运动" withDate:[[AppTime sharedTime]yesterday]];
        } else if (unfinished == 0) {
            NSDate * targetDate = [[AppTime sharedTime]timeFromHour:[sports[@"hour"]integerValue]+1 andMinute:[sports[@"minute"]integerValue]];
            if (![[AppTime sharedTime]isDate1:[AppTime sharedTime].date withinDate2:targetDate]) {
                [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:1 mutableDictionary:sports andKey:@"运动" withDate:[[AppTime sharedTime]date]];
            }
        }
    } else {
        [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:0 mutableDictionary:sports andKey:@"运动" withDate:[[AppTime sharedTime]date]];
    }
    NSMutableDictionary * sleep = [[self.userDefaults objectForKey:@"睡觉"]mutableCopy];
    if ([sleep[@"last"]timeIntervalSince1970] != 0) {
        NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:sleep[@"last"] andDate2:[AppTime sharedTime].date] - 1;
        if (unfinished > 0) {
            [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:unfinished mutableDictionary:sleep andKey:@"睡觉" withDate:[[AppTime sharedTime]yesterday]];
        } else if (unfinished == 0) {
            NSDate * targetDate = [[AppTime sharedTime]timeFromHour:[sleep[@"hour"]integerValue]+1 andMinute:[sleep[@"minute"]integerValue]];
            if (![[AppTime sharedTime]isDate1:[AppTime sharedTime].date withinDate2:targetDate]) {
                [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:1 mutableDictionary:sleep andKey:@"睡觉" withDate:[[AppTime sharedTime]date]];
            }
        }
    } else {
        [self reduceDailyRoutinePastDaysGrowthPointsWithUnfinishedDays:0 mutableDictionary:sleep andKey:@"睡觉" withDate:[[AppTime sharedTime]date]];
    }
}

- (void)calculateGrowthPointsWithCustomHabits {
    NSDictionary * customHabits = [self.userDefaults objectForKey:@"habits"];
    NSMutableDictionary * mutableCustomHabits = [customHabits mutableCopy];
    for (NSString * customHabitName in customHabits) {
        NSDictionary * customHabit = customHabits[customHabitName];
        if ([customHabit[@"last"]timeIntervalSince1970] != 0) {
            NSInteger unfinished = [[AppTime sharedTime]intervalDaysBetweenDate1:customHabit[@"last"] andDate2:[AppTime sharedTime].date] - 1;
            if (unfinished > 0) {
                self.growthPoints -= 5 * unfinished;
                NSMutableDictionary * mutableCustomHabit = [customHabit mutableCopy];
                mutableCustomHabit[@"last"] = [[AppTime sharedTime]yesterday];
                [mutableCustomHabits setObject:mutableCustomHabit forKey:customHabitName];
            }
        }
    }
    [self.userDefaults setObject:[NSDictionary dictionaryWithDictionary:mutableCustomHabits] forKey:@"habits"];
}
@end
