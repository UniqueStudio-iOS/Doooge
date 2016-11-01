//
//  DailyRoutineModel.h
//  RealmDemo
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 ZhihaoChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyRoutineModel : NSObject
@property (nonatomic) NSInteger ID;
@property (nonatomic, copy) NSDateComponents * time;
@property (nonatomic) NSInteger persist;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)dailyRoutineWithDict:(NSDictionary *)dict;

- (NSDictionary *)convertToDictionary;
@end
