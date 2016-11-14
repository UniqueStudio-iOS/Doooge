//
//  AppDatabase.m
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppDatabase.h"

#import <Realm.h>

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
#pragma mark UpdateModel
- (void)updateDailyRoutine:(DailyRoutine *)dailyRoutine {
    [self.realm beginWriteTransaction];
    [DailyRoutine createOrUpdateInRealm:self.realm withValue:dailyRoutine];
    [self.realm commitWriteTransaction];
}

- (void)updateCustomHabit:(CustomHabit *)customHabit {
    [self.realm beginWriteTransaction];
    [CustomHabit createOrUpdateInRealm:self.realm withValue:customHabit];
    [self.realm commitWriteTransaction];
}
#pragma mark CreateDefaultModel
- (void)createDefaultDailyRoutines {
    DailyRoutine * breakfast = [[DailyRoutine alloc]initWithValue:@[@"breakfast", @0, @7, @30]];
    DailyRoutine * lunch = [[DailyRoutine alloc]initWithValue:@[@"lunch", @0, @12, @0]];
    DailyRoutine * dinner = [[DailyRoutine alloc]initWithValue:@[@"dinner", @0, @19, @30]];
    DailyRoutine * sport = [[DailyRoutine alloc]initWithValue:@[@"sport", @0, @12, @0]];
    DailyRoutine * sleep = [[DailyRoutine alloc]initWithValue:@[@"sleep", @0, @23, @0]];
    
    [self.realm beginWriteTransaction];
    [DailyRoutine createInRealm:self.realm withValue:breakfast];
    [DailyRoutine createInRealm:self.realm withValue:lunch];
    [DailyRoutine createInRealm:self.realm withValue:dinner];
    [DailyRoutine createInRealm:self.realm withValue:sport];
    [DailyRoutine createInRealm:self.realm withValue:sleep];
    [self.realm commitWriteTransaction];
}
@end

