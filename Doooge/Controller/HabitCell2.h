//
//  HabitCell2.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClockHandler)(NSString * name);

@interface HabitCell2 : UITableViewCell
@property (nonatomic, strong) NSString * name;
@property (nonatomic) NSInteger persist;
@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;
@property (nonatomic) NSInteger week;
@property (nonatomic) BOOL hasClocked;

@property (nonatomic, copy) ClockHandler clockHandler;

- (void)setTimeWithHour:(NSInteger)hour
                 Minute:(NSInteger)minute
                andWeek:(NSInteger)week;
@end
