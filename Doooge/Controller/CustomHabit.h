//
//  CustomHabit.h
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <Realm/Realm.h>

@interface CustomHabit : RLMObject
@property NSString * ID;
@property NSInteger persistDays;
@property NSInteger hour;
@property NSInteger minute;
@property NSInteger week;
@property BOOL hasRemind;
@property NSDate * lastClocked;
@end
