//
//  DooogeNotificationCenter.m
//  Doooge
//
//  Created by 陈志浩 on 2016/10/30.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import "DooogeNotificationCenter.h"
#import "DooogeUserDefaults.h"
#import <UserNotifications/UserNotifications.h>

@interface DooogeNotificationCenter()
@property (nonatomic, strong) NSString * petName;
@property (nonatomic, strong) UNMutableNotificationContent * eatContent;
@property (nonatomic, strong) UNMutableNotificationContent * sportContent;
@property (nonatomic, strong) UNMutableNotificationContent * sleepContent;
@property (nonatomic, strong) UNCalendarNotificationTrigger * breakfastTriggler;
@property (nonatomic, strong) UNCalendarNotificationTrigger * lunchTriggler;
@property (nonatomic, strong) UNCalendarNotificationTrigger * dinnerTriggler;
@property (nonatomic, strong) UNCalendarNotificationTrigger * sportTriggler;
@property (nonatomic, strong) UNCalendarNotificationTrigger * sleepTriggler;
@end

@implementation DooogeNotificationCenter

+ (instancetype)currentNotificationCenter {
    static DooogeNotificationCenter * instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[DooogeNotificationCenter alloc]init];
    });
    return instance;
}

- (void)requestAuthorization {
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            //...
        }
    }];
}

- (NSString *)petName {
    return [[DooogeUserDefaults dooogeUserDefaults]nameForPet];
}

- (UNMutableNotificationContent *)eatContent {
    _eatContent = [[UNMutableNotificationContent alloc]init];
    _eatContent.title = @"咕咕咕～";
    _eatContent.body = [NSString stringWithFormat:@"%@真的饿啦！我们该吃饭啦~在通知中心里给我喂食吧！", [self petName]];
    _eatContent.badge = @1;
    return _eatContent;
}

- (UNMutableNotificationContent *)sportContent {
    _sportContent = [[UNMutableNotificationContent alloc]init];
    _sportContent.title = @"走走走，运动去！";
    _sportContent.body = @"555最近又胖了，我们一起去运动好不好？在通知中心带我玩吧！";
    _sportContent.badge = @1;
    return _sportContent;
}

- (UNMutableNotificationContent *)sleepContent {
    _sleepContent = [[UNMutableNotificationContent alloc]init];
    _sleepContent.title = @"天黑请闭眼";
    _sleepContent.body = [NSString stringWithFormat:@"%@困了，熬夜很伤身体噢，快来通知中心哄我睡吧！", [self petName]];
    _sleepContent.badge = @1;
    return _sleepContent;
}

- (UNCalendarNotificationTrigger *)breakfastTriggler {
    _breakfastTriggler = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[NSKeyedUnarchiver unarchiveObjectWithData:[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"breakfast"][@"time"]] repeats:YES];
    return _breakfastTriggler;
}

- (UNCalendarNotificationTrigger *)lunchTriggler {
    _lunchTriggler = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[NSKeyedUnarchiver unarchiveObjectWithData:[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"lunch"][@"time"]] repeats:YES];
    return _lunchTriggler;
}

- (UNCalendarNotificationTrigger *)dinnerTriggler {
    _dinnerTriggler = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[NSKeyedUnarchiver unarchiveObjectWithData:[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"dinner"][@"time"]] repeats:YES];
    return _dinnerTriggler;
}

- (UNCalendarNotificationTrigger *)sportTriggler {
    _sportTriggler = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[NSKeyedUnarchiver unarchiveObjectWithData:[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sport"][@"time"]] repeats:YES];
    return _sportTriggler;
}

- (UNCalendarNotificationTrigger *)sleepTriggler {
    _sleepTriggler = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:[NSKeyedUnarchiver unarchiveObjectWithData:[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sleep"][@"time"]] repeats:YES];
    return _sleepTriggler;
}

- (void)requestAllHealthyRoutines {
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    
    NSString * breakfastRequestIdentifier = @"breakfast";
    UNNotificationRequest * breakfastRequest = [UNNotificationRequest requestWithIdentifier:breakfastRequestIdentifier
                                                                          content:self.eatContent
                                                                          trigger:self.breakfastTriggler];
    [center addNotificationRequest:breakfastRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];

    NSString * lunchRequestIdentifier = @"lunch";
    UNNotificationRequest * lunchRequest = [UNNotificationRequest requestWithIdentifier:lunchRequestIdentifier
                                                                           content:self.eatContent
                                                                           trigger:self.lunchTriggler];
    [center addNotificationRequest:lunchRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    NSString * dinnerRequestIdentifier = @"dinner";
    UNNotificationRequest * dinnerRequest = [UNNotificationRequest requestWithIdentifier:dinnerRequestIdentifier
                                                                           content:self.eatContent
                                                                           trigger:self.dinnerTriggler];
    [center addNotificationRequest:dinnerRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    NSString * sportRequestIdentifier = @"sport";
    UNNotificationRequest * sportRequest = [UNNotificationRequest requestWithIdentifier:sportRequestIdentifier
                                                                           content:self.sportContent
                                                                           trigger:self.sportTriggler];
    [center addNotificationRequest:sportRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    NSString * sleepRequestIdentifier = @"sleep";
    UNNotificationRequest * sleepRequest = [UNNotificationRequest requestWithIdentifier:sleepRequestIdentifier
                                                                           content:self.sleepContent
                                                                           trigger:self.sleepTriggler];
    [center addNotificationRequest:sleepRequest withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
    
    
}
@end
