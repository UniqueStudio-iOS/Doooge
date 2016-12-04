//
//  AppTime.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "AppTime.h"

@interface AppTime()
@property (nonatomic, strong) NSDate * date;
@property (nonatomic, strong) NSCalendar * calender;
@end

@implementation AppTime
+ (instancetype)sharedTime {
    static AppTime * time = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        time = [[AppTime alloc]init];
    });
    return time;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (NSDate *)date {
    _date = [NSDate date];
    return _date;
}

- (NSCalendar *)calender {
    _calender = [NSCalendar currentCalendar];
    return _calender;
}

- (NSDate *)yesterday {
    return [NSDate dateWithTimeInterval:-24*60*60 sinceDate:self.date];
}

- (NSDate *)timeFromHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.hour = hour;
    components.minute = minute;
    components.second = 0;
    NSCalendarUnit units = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents * defaultComponents = [self.calender components:units fromDate:self.date];
    components.year = defaultComponents.year;
    components.month = defaultComponents.month;
    components.day = defaultComponents.day;
    return [self.calender dateFromComponents:components];
}

- (BOOL)isSameDayWithDate1:(NSDate *)date1 andDate2:(NSDate *)date2 {
    NSCalendarUnit units = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents * components1 = [self.calender components:units fromDate:date1];
    NSDateComponents * components2 = [self.calender components:units fromDate:date2];
    if ((components1.day == components2.day) && (components1.month == components2.month) && (components1.year == components2.year)) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)isSameWeekdayWithDate:(NSDate *)date andWeek:(NSInteger)week {
    NSCalendarUnit units = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents * components = [self.calender components:units fromDate:date];
    if (components.weekday - 1) {
        return (1 << 6) & week;
    } else {
        return (1 << (components.weekday - 2) & week);
    }
}

- (NSInteger)intervalDaysBetweenDate1:(NSDate *)date1 andDate2:(NSDate *)date2 {
    NSDate * fromDate, * toDate;
    [self.calender rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:date1];
    [self.calender rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:date2];
    return (NSInteger)[toDate timeIntervalSinceDate:fromDate]/(24*3600);
}

- (BOOL)isDate1:(NSDate *)date1 withinDate2:(NSDate *)date2 {
    return ([date1 timeIntervalSinceDate:date2] <= 0);
}
@end
