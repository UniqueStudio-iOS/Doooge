//
//  DailyRoutineModel.m
//  RealmDemo
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 ZhihaoChen. All rights reserved.
//

#import "DailyRoutineModel.h"

@interface DailyRoutineModel ()

@end

@implementation DailyRoutineModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        if (dict) {
            _ID = [[dict objectForKey:@"ID"]integerValue];
            _time = [NSKeyedUnarchiver unarchiveObjectWithData:[dict objectForKey:@"time"]];
            _persist = [[dict objectForKey:@"persist"]integerValue];
        }
    }
    return self;
}

+ (instancetype)dailyRoutineWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

- (NSDictionary *)convertToDictionary {
    NSDictionary * result = [
                             [NSDictionary alloc]initWithObjectsAndKeys:
                                [NSNumber numberWithInteger:self.ID], @"ID",
                                [NSKeyedArchiver archivedDataWithRootObject:self.time], @"time",
                                [NSNumber numberWithInteger:self.persist], @"persist",
                                nil
                            ];
    return result;
}

@end
