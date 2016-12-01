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

- (NSDate *)timeFromHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSDateComponents * components = [[NSDateComponents alloc]init];
    components.hour = hour;
    components.minute = minute;
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

- (BOOL)isMoreThanOneDayWithDate1:(NSDate *)date1 andDate2:(NSDate *)date2 {
    NSCalendarUnit units = NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear;
    NSDateComponents * components1 = [self.calender components:units fromDate:date1];
    NSDateComponents * components2 = [self.calender components:units fromDate:date2];
    if ((labs(components1.day - components2.day) > 1) && (components1.month == components2.month) && (components1.year == components2.year)) {
        return YES;
    } else {
        return NO;
    }
}
@end
