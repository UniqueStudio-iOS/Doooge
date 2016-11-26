//
//  NotificationData.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/21.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NotificationData : NSObject
+ (NSString *) dailyRoutineNotificationContentWithID:(NSString *)ID;
+ (NSString *) customHabitNotificationContentWithID:(NSString *)ID;
+ (NSString *) lowGrowthPointNotificationContent;
+ (NSString *) noneGrowthPointNotificationContent;
+ (NSArray *) defaultDailyRoutineConfiguration;
@end
