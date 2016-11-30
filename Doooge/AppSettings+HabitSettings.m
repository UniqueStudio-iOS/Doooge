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

@implementation AppSettings(HabitSettings)
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

- (void)updateDailyRoutine:(NSString *)ID withHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSMutableDictionary * content = [[self.userDefaults objectForKey:ID]mutableCopy];
    content[@"hour"] = [NSNumber numberWithInteger:hour];
    content[@"minute"] = [NSNumber numberWithInteger:minute];
    [self.userDefaults setObject:content forKey:ID];
    NSLog(@"Daily Routine Updated!");
}

- (NSDictionary *)dailyRoutineWithName:(NSString *)name {
    return [self.userDefaults objectForKey:name];
}

- (void)registerOrUpdateCustomHabit:(CustomHabit *)customHabit {
    NSDictionary * content = @{
                               @"hour":[NSNumber numberWithInteger:customHabit.hour],
                               @"minute":[NSNumber numberWithInteger:customHabit.minute],
                               @"week":[NSNumber numberWithInteger:customHabit.week],
                               @"persist":[NSNumber numberWithInteger:customHabit.persistDays],
                               @"remind":[NSNumber numberWithBool:customHabit.hasRemind],
                               @"last":customHabit.lastClocked
                               };
    [self.userDefaults setObject:content forKey:customHabit.ID];
}

- (void)deleteCustomHabitWithName:(NSString *)name {
    [self.userDefaults removeObjectForKey:name];
}

- (void)updateCustomHabitWithName:(NSString *)name andLastClocked:(NSDate *)date {
    NSMutableDictionary * content = [[self.userDefaults objectForKey:name]mutableCopy];
    content[@"last"] = date;
    [self.userDefaults setObject:content forKey:name];
}

- (NSDictionary *)customHabitWithName:(NSString *)name {
    return [self.userDefaults objectForKey:name];
}
@end
