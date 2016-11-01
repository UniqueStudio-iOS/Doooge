//
//  DooogeUserDefaults.m
//  RealmDemo
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 ZhihaoChen. All rights reserved.
//

#import "DooogeUserDefaults.h"

@implementation DooogeUserDefaults
static NSString * suiteName = @"group.com.vic.Doooge";
static DooogeUserDefaults * instance = nil;

+ (instancetype)dooogeUserDefaults {
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[DooogeUserDefaults alloc]initWithSuiteName:suiteName];
    });
    return instance;
}

- (void)setDailyRoutineDict:(NSDictionary *)dict forKey:(NSString *)key {
    [self setObject:dict forKey:key];
    [self synchronize];
}

- (void)setDailyRoutine:(DailyRoutineModel *)model forKey:(NSString *)key {
    [self setObject:[model convertToDictionary] forKey:key];
    [self synchronize];
}

- (NSDictionary *)dailyRoutineDictForKey:(NSString *)key {
    return [self dictionaryForKey:key];
}

- (DailyRoutineModel *)dailyRoutineForKey:(NSString *)key {
    return [DailyRoutineModel dailyRoutineWithDict:[self dictionaryForKey:key]];
}

- (NSString *)nameForPet {
    return [self stringForKey:@"petName"];
}

- (void)setNameForPet:(NSString *)name {
    [self setObject:name forKey:@"petName"];
    [self synchronize];
}

- (NSInteger)growthPointForPet {
    return [self integerForKey:@"growthPoint"];
}

- (void)setGrowthPointForPet:(NSInteger)growthPoint {
    [self setInteger:growthPoint forKey:@"growthPoint"];
    [self synchronize];
}

@end
