//
//  AppTime.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTime : NSObject
+ (instancetype)sharedTime;

- (NSDate *)date;
- (NSDate *)yesterday;

- (NSDate *)timeFromHour:(NSInteger)hour andMinute:(NSInteger)minute;
- (BOOL)isSameDayWithDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
- (BOOL)isSameWeekdayWithDate:(NSDate *)date andWeek:(NSInteger)week;
- (BOOL)isDate1:(NSDate *)date1 withinDate2:(NSDate *)date2;
- (NSInteger)intervalDaysBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
@end
