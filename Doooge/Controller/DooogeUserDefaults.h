//
//  DooogeUserDefaults.h
//  RealmDemo
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 ZhihaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DailyRoutineModel.h"

@interface DooogeUserDefaults : NSUserDefaults
+ (instancetype)dooogeUserDefaults;

- (void)setDailyRoutineDict:(NSDictionary *)dict forKey:(NSString *)key;
- (void)setDailyRoutine:(DailyRoutineModel *)model forKey:(NSString *)key;

- (NSDictionary *)dailyRoutineDictForKey:(NSString *)key;
- (DailyRoutineModel *)dailyRoutineForKey:(NSString *)key;

- (NSString *)nameForPet;
- (void)setNameForPet:(NSString *)name;

- (NSInteger)growthPointForPet;
- (void)setGrowthPointForPet:(NSInteger)growthPoint;

@end
