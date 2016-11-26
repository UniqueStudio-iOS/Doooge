//
//  NotificationData.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/21.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "NotificationData.h"

#import "AppSettings.h"

@implementation NotificationData
+ (NSString *) dailyRoutineNotificationContentWithID:(NSString *)ID {
    if ([ID isEqualToString:@"早饭"])
        return [NSString stringWithFormat:@"吃个美味的早餐来开启美好的一天吧~%@也要吃早餐啦！", [AppSettings sharedSettings].petName];
    else if ([ID isEqualToString:@"午饭"])
        return [NSString stringWithFormat:@"咕咕咕~%@饿啦，我们一起去吃午饭吧", [AppSettings sharedSettings].petName];
    else if ([ID isEqualToString:@"晚饭"])
        return [NSString stringWithFormat:@"叮！晚饭时间到了~%@在家等你吃饭噢", [AppSettings sharedSettings].petName];
    else if ([ID isEqualToString:@"运动"])
        return @"555~最近又胖了！走走走，带我去运动";
    else
        return [NSString stringWithFormat:@"%@困了，熬夜很伤身体噢，快来哄我睡吧", [AppSettings sharedSettings].petName];
}

+ (NSString *) customHabitNotificationContentWithID:(NSString *)ID {
    NSInteger random = arc4random() % 3;
    if (random == 0)
        return [NSString stringWithFormat:@"滴！打卡时间到咯，记得“%@”", ID];
    else if (random == 1)
        return [NSString stringWithFormat:@"别忘了“%@”，快打卡吧", ID];
    else
        return [NSString stringWithFormat:@"嘿！“%@”时间到了耶！要打卡噢", ID];
}

+ (NSString *) lowGrowthPointNotificationContent {
    return [NSString stringWithFormat:@"%@最近不太健康，你要记得按时打卡噢~", [AppSettings sharedSettings].petName];
}

+ (NSString *) noneGrowthPointNotificationContent {
    return @"555…你不照顾我了吗？";
}

+ (NSArray *) defaultDailyRoutineConfiguration {
    return @[
             @{
                 @"ID":@"早饭",
                 @"hour":@7,
                 @"minute":@30},
             @{
                 @"ID":@"午饭",
                 @"hour":@12,
                 @"minute":@0},
             @{
                 @"ID":@"晚饭",
                 @"hour":@19,
                 @"minute":@30},
             @{
                 @"ID":@"运动",
                 @"hour":@12,
                 @"minute":@0},
             @{
                 @"ID":@"睡觉",
                 @"hour":@23,
                 @"minute":@0}
             ];
}
@end
