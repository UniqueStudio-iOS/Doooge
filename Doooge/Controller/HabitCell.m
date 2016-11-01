//
//  HabitCell.m
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import "HabitCell.h"
@interface HabitCell()
@property (nonatomic, strong) IBOutlet UILabel * nameLabel;
@property (nonatomic, strong) IBOutlet UILabel * persistLabel;
@property (nonatomic, strong) IBOutlet UILabel * timeLabel;
@end
@implementation HabitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name {
    _name = name;
    [self.nameLabel setText:_name];
}

- (void)setPersist:(NSInteger)persist {
    _persist = persist;
    [self.persistLabel setText:[NSString stringWithFormat:@"已坚持%ld天", (long)_persist]];
}

- (void)setTime:(NSDateComponents *)time {
    NSArray * weekArray = @[@"周日 ", @"周一 ",@"周二 ", @"周三 ",@"周四 ",@"周五 ",@"周六 "];
    _time = time;
    NSString * timeString = [NSString string];
    if (_time.weekday != NSIntegerMax) {
        timeString = [timeString stringByAppendingString:weekArray[_time.weekday-1]];
    }
    if (_time.hour != NSIntegerMax && _time.minute != NSIntegerMax) {
        timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_time.hour]];
        timeString = [timeString stringByAppendingString:@":"];
        if (_time.minute < 10) {
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"0%ld", (long)_time.minute]];
        } else {
            timeString = [timeString stringByAppendingString:[NSString stringWithFormat:@"%ld", (long)_time.minute]];
        }
    }
    [self.timeLabel setText:timeString];
}

@end
