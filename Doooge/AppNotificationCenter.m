//
//  AppNotificationCenter.m
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppNotificationCenter.h"

#import <UserNotifications/UserNotifications.h>

#import "AppSettings.h"
#import "AppSettings+HabitSettings.h"
#import "NotificationData.h"

#import "AppDatabase.h"
#import "DailyRoutine.h"
#import "CustomHabit.h"

#import "AppTime.h"

@interface AppNotificationCenter()<UNUserNotificationCenterDelegate>
@property (nonatomic, strong) UNUserNotificationCenter * userNotificationCenter;
@end

@implementation AppNotificationCenter
+ (instancetype)sharedNotificationCenter {
    static AppNotificationCenter * notificationCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        notificationCenter = [[AppNotificationCenter alloc]init];
    });
    return notificationCenter;
}

- (instancetype)init {
    if (self = [super init]) {
        _userNotificationCenter = [UNUserNotificationCenter currentNotificationCenter];
        _userNotificationCenter.delegate = self;
    }
    return self;
}

- (void)requestNotificationAuthorization {
    [self.userNotificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (error) {
            NSLog(@"RequestAuthorizationFailed:%@", [error localizedDescription]);
        } else {
            if (granted) {
                [[AppSettings sharedSettings]setAuthorized:YES];
            } else {
                [[AppSettings sharedSettings]setAuthorized:NO];
            }
        }
    }];
}

- (UNCalendarNotificationTrigger *)triggerWithHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSDateComponents * time = [[NSDateComponents alloc]init];
    time.hour = hour;
    time.minute = minute;
    UNCalendarNotificationTrigger * targetTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:time repeats:YES];
    return targetTrigger;
}

- (UNCalendarNotificationTrigger *)triggerWithWeekday:(NSInteger)weekday hour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSDateComponents * time = [[NSDateComponents alloc]init];
    time.hour = hour;
    time.minute = minute;
    time.weekday = weekday;
    UNCalendarNotificationTrigger * targetTrigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:time repeats:YES];
    return targetTrigger;
}

- (UNMutableNotificationContent *)contentWithTitle:(NSString *)title andBody:(NSString *)body {
    UNMutableNotificationContent * targetContent = [[UNMutableNotificationContent alloc]init];
    targetContent.title = title;
    targetContent.body = body;
    targetContent.badge = [NSNumber numberWithInt:kNotificationBadgeNumber];
    return targetContent;
}

- (void)requestWithIdentifier:(NSString *)identifier trigger:(UNNotificationTrigger *)trigger andContent:(UNMutableNotificationContent *)content {
    UNNotificationRequest * targetRequest = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    [self.userNotificationCenter addNotificationRequest:targetRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"NotifactionRequestFailed:%@", [error localizedDescription]);
        }
    }];
}

- (void)removeWithIdentifier:(NSString *)identifier {
    [self.userNotificationCenter removePendingNotificationRequestsWithIdentifiers:@[identifier]];
}

- (void)registerDefaultDailyRoutines {
    NSArray * models = [NotificationData defaultDailyRoutineConfiguration];
    for (NSDictionary * model in models) {
        NSString * ID = model[@"ID"];
        NSString * content = [NotificationData dailyRoutineNotificationContentWithID:ID];
        NSInteger hour = [model[@"hour"]integerValue];
        NSInteger minute = [model[@"minute"]integerValue];
        UNCalendarNotificationTrigger * targetTrigger = [self triggerWithHour:hour andMinute:minute];
        UNMutableNotificationContent * targetContent = [self contentWithTitle:@"Doooge" andBody:content];
        [self requestWithIdentifier:ID trigger:targetTrigger andContent:targetContent];
    }
}

- (void)registerDailyRoutine:(DailyRoutine *)dailyRoutine {
    NSString * content = [NotificationData dailyRoutineNotificationContentWithID:dailyRoutine.ID];
    UNCalendarNotificationTrigger * targetTrigger = [self triggerWithHour:dailyRoutine.hour andMinute:dailyRoutine.minute];
    UNMutableNotificationContent * targetContent = [self contentWithTitle:@"Doooge" andBody:content];
    [self requestWithIdentifier:dailyRoutine.ID trigger:targetTrigger andContent:targetContent];
}

- (NSString *)identifierWithID:(NSString *)ID andWeekday:(NSInteger)weekday {
    return [NSString stringWithFormat:@"%@-%ld", ID, weekday];
}

- (void)registerCustomHabit:(CustomHabit *)customHabit {
    if (customHabit.hasRemind == YES) {
        for (int unit = 1, weekday = 1 ; weekday <= 7 ; unit <<= 1, ++weekday) {
            if (customHabit.week & unit) {
                NSString * content = [NotificationData customHabitNotificationContentWithID:customHabit.ID];
                UNCalendarNotificationTrigger * targetTrigger = [self triggerWithWeekday:(weekday%7)+1 hour:customHabit.hour andMinute:customHabit.minute];
                UNMutableNotificationContent * targetContent = [self contentWithTitle:@"Doooge" andBody:content];
                targetContent.categoryIdentifier = customHabit.ID;
                NSString * ID = [self identifierWithID:customHabit.ID andWeekday:weekday];
                [self requestWithIdentifier:ID trigger:targetTrigger andContent:targetContent];
            } else {
                NSString * ID = [self identifierWithID:customHabit.ID andWeekday:weekday];
                [self removeWithIdentifier:ID];
            }
        }
    } else {
        [self removeCustomHabit:customHabit];
    }
}

- (void)removeCustomHabit:(CustomHabit *)customHabit {
    for (int unit = 1, weekday = 1 ; weekday <= 7 ; unit <<= 1, ++weekday) {
            NSString * ID = [self identifierWithID:customHabit.ID andWeekday:weekday];
            [self removeWithIdentifier:ID];
    }
    [self removeCustomHabitCategory:customHabit.ID];
}

- (void)registerCustomHabitCategory:(NSString *)name {
        [self.userNotificationCenter getNotificationCategoriesWithCompletionHandler:^(NSSet<UNNotificationCategory *> * _Nonnull categories) {
            UNNotificationAction * action = [UNNotificationAction actionWithIdentifier:@"clock" title:@"滴！打卡" options:UNNotificationActionOptionNone];
            UNNotificationCategory * category = [UNNotificationCategory categoryWithIdentifier:name actions:@[action] intentIdentifiers:@[] options:UNNotificationCategoryOptionNone];
            [self.userNotificationCenter setNotificationCategories:[categories setByAddingObject:category]];
        }];
}

- (void)removeCustomHabitCategory:(NSString *)name {
    [self.userNotificationCenter getNotificationCategoriesWithCompletionHandler:^(NSSet<UNNotificationCategory *> * _Nonnull categories) {
        UNNotificationCategory * targetCategory = NULL;
        NSMutableSet * mutableCategories = [NSMutableSet setWithSet:categories];
        for (UNNotificationCategory * category in mutableCategories) {
            if ([category.identifier isEqualToString:name]) {
                targetCategory = category;
            }
        }
        if (targetCategory) {
            [mutableCategories removeObject:targetCategory];
        }
        [self.userNotificationCenter setNotificationCategories:mutableCategories];
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    if ([response.actionIdentifier isEqualToString:@"clock"]) {
        NSString * categoryIdentifier = response.notification.request.content.categoryIdentifier;
        CustomHabit * customHabit = [[AppDatabase sharedDatabase]customHabitWithName:categoryIdentifier];
        if (![[AppTime sharedTime]isSameDayWithDate1:customHabit.lastClocked andDate2:[AppTime sharedTime].date]) {
            [[AppDatabase sharedDatabase]updateLastClocked:[AppTime sharedTime].date withCustomHabit:customHabit];
            [[AppSettings sharedSettings]updateCustomHabitWithName:customHabit.ID lastClocked:[AppTime sharedTime].date andPersistDays:customHabit.persistDays];
        }
    }
    completionHandler();
}
@end
