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

- (NSDate *)timeFromHour:(NSInteger)hour andMinute:(NSInteger)minute;
- (BOOL)isSameDayWithDate1:(NSDate *)date1 andDate2:(NSDate *)date2;
@end
