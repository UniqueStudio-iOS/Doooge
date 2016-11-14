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

- (void)updateDailyRoutine:(DailyRoutine *)dailyRoutine;
- (void)updateCustomHabit:(CustomHabit *)customHabit;
- (void)createDefaultDailyRoutines;

@end
