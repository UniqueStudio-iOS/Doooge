//
//  AppDatabase.m
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppDatabase.h"

#import <Realm.h>

#import "AppSettings+HabitSettings.h"

#import "DailyRoutine.h"
#import "CustomHabit.h"


@interface AppDatabase()
@property RLMRealm * realm;
@end

@implementation AppDatabase
#pragma mark Singleton
+ (instancetype)sharedDatabase {
    static AppDatabase * database = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        database = [[AppDatabase alloc]init];
    });
    return database;
}

- (instancetype)init {
    if (self = [super init]) {
        _realm = [RLMRealm defaultRealm];
    }
    return self;
}
#pragma mark General

#pragma mark UpdateModel
- (void)addDailyRoutine:(DailyRoutine *)dailyRoutine {
    [self.realm beginWriteTransaction];
    [DailyRoutine createOrUpdateInRealm:self.realm withValue:dailyRoutine];
    
}

- (void)addCustomHabit:(CustomHabit *)customHabit {
    [self.realm beginWriteTransaction];
    [CustomHabit createOrUpdateInRealm:self.realm withValue:customHabit];
    [self.realm commitWriteTransaction];
}
#pragma mark CreateDefaultModel
- (void)createDefaultDailyRoutines {
    DailyRoutine * breakfast = [[DailyRoutine alloc]initWithValue:@[@"早饭", @0, @7, @30]];
    DailyRoutine * lunch = [[DailyRoutine alloc]initWithValue:@[@"午饭", @0, @12, @0]];
    DailyRoutine * dinner = [[DailyRoutine alloc]initWithValue:@[@"晚饭", @0, @19, @30]];
    DailyRoutine * sport = [[DailyRoutine alloc]initWithValue:@[@"运动", @0, @12, @0]];
    DailyRoutine * sleep = [[DailyRoutine alloc]initWithValue:@[@"睡觉", @0, @23, @0]];
    
    [self.realm beginWriteTransaction];
    [DailyRoutine createInRealm:self.realm withValue:breakfast];
    [DailyRoutine createInRealm:self.realm withValue:lunch];
    [DailyRoutine createInRealm:self.realm withValue:dinner];
    [DailyRoutine createInRealm:self.realm withValue:sport];
    [DailyRoutine createInRealm:self.realm withValue:sleep];
    [self.realm commitWriteTransaction];
}
#pragma mark AllModels
- (NSArray *)allDailyRoutine {
    RLMResults<DailyRoutine *> * dailyRoutines = [DailyRoutine allObjects];
    NSMutableArray * results = [NSMutableArray array];
    for (DailyRoutine * dailyRoutine in dailyRoutines) {
        [results addObject:dailyRoutine];
    }
    return [NSArray arrayWithArray:results];
}

- (NSArray *)allCustomHabit {
    RLMResults<CustomHabit *> * customHabits = [CustomHabit allObjects];
    NSMutableArray * results = [NSMutableArray array];
    for (CustomHabit * customHabit in customHabits) {
        [results addObject:customHabit];
    }
    return [NSArray arrayWithArray:results];
}

- (NSArray *)allCustomHabitName {
    NSArray * customHabits = [self allCustomHabit];
    NSMutableArray * results = [NSMutableArray array];
    for (CustomHabit * customHabit in customHabits) {
        [results addObject:customHabit.ID];
    }
    return [NSArray arrayWithArray:results];
}

- (CustomHabit *)customHabitWithName:(NSString *)name {
    NSString * condition = [NSString stringWithFormat:@"ID = '%@'", name];
    RLMResults<CustomHabit *> * results = [CustomHabit objectsWhere:condition];
    return [results firstObject];
}

- (DailyRoutine *)dailyRoutineWithName:(NSString *)name {
    NSString * condition = [NSString stringWithFormat:@"ID = '%@'", name];
    RLMResults<DailyRoutine *> * results = [DailyRoutine objectsWhere:condition];
    return [results firstObject];
}

- (void)updateDailyRoutineWithName:(NSString *)name fromUserDefaults:(NSUserDefaults *)userDefaults {
    DailyRoutine * dailyRoutine = [self dailyRoutineWithName:name];
    NSDictionary * dailyRoutineDictionary = [userDefaults objectForKey:name];
    [self.realm beginWriteTransaction];
    dailyRoutine.persistDays = [dailyRoutineDictionary[@"persist"]integerValue];
    [self.realm commitWriteTransaction];
    NSLog(@"Update Daily Routine From UserDefaults.");
}

- (void)updateCustomHabitWithName:(NSString *)name fromUserDefaults:(NSUserDefaults *)userDefaults {
    CustomHabit * customHabit = [self customHabitWithName:name];
    NSDictionary * customHabitDictionary = [[userDefaults objectForKey:@"habits"]objectForKey:name];
    [self.realm beginWriteTransaction];
    customHabit.persistDays = [customHabitDictionary[@"persist"]integerValue];
    customHabit.lastClocked = customHabitDictionary[@"last"];
    [self.realm commitWriteTransaction];
    NSLog(@"Update Custom Habit From UserDefaults.");
}

- (void)updateLastClocked:(NSDate *)date withCustomHabit:(CustomHabit *)customHabit {
    [self.realm beginWriteTransaction];
    customHabit.lastClocked = date;
    customHabit.persistDays++;
    [self.realm commitWriteTransaction];
}

- (void)updateHour:(NSInteger)hour minute:(NSInteger)minute hasRemind:(BOOL)hasRemind week:(NSInteger)week withCostomHabit:(CustomHabit *)customHabit {
    [self.realm beginWriteTransaction];
    customHabit.hour = hour;
    customHabit.minute = minute;
    customHabit.hasRemind = hasRemind;
    customHabit.week = week;
    [self.realm commitWriteTransaction];
}

- (void)updateHour:(NSInteger)hour andMinute:(NSInteger)minute withDailyRoutine:(DailyRoutine *)dailyRoutine {
    [self.realm beginWriteTransaction];
    dailyRoutine.hour = hour;
    dailyRoutine.minute = minute;
    [self.realm commitWriteTransaction];
}

- (void)deleteCustomHabit:(CustomHabit *)customHabit {
    [self.realm beginWriteTransaction];
    [self.realm deleteObject:customHabit];
    [self.realm commitWriteTransaction];
}
@end

