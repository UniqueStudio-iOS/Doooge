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




@interface AppNotificationCenter()
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

- (UNMutableNotificationContent *)contentWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle {
    UNMutableNotificationContent * targetContent = [[UNMutableNotificationContent alloc]init];
    targetContent.title = title;
    targetContent.subtitle = subtitle;
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

@end
