//
//  HabitCell.h
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HabitCell : UITableViewCell
@property (nonatomic, strong) NSString * name;
@property (nonatomic) NSInteger persist;
@property (nonatomic) NSInteger hour;
@property (nonatomic) NSInteger minute;
- (void)setTimeWithHour:(NSInteger)hour andMinute:(NSInteger)minute;
@end
