//
//  HabitCell2.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/20.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "HabitCell2.h"

@interface HabitCell2()
@property (nonatomic, strong) IBOutlet UILabel * nameLabel;
@property (nonatomic, strong) IBOutlet UILabel * persistLabel;
@property (nonatomic, strong) IBOutlet UILabel * timeLabel;
@property (nonatomic, strong) IBOutlet UIButton * clockButton;
@end

@implementation HabitCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.hasClocked = NO;
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
    NSString * plainText = [NSString stringWithFormat:@"已坚持%ld天", (long)_persist];
    NSMutableAttributedString * attributedText = [[NSMutableAttributedString alloc]initWithString:plainText];
    [attributedText addAttribute:NSForegroundColorAttributeName value:mainColor range:NSMakeRange(3, plainText.length - 4)];
    [self.persistLabel setAttributedText:attributedText];
}

- (void)setHour:(NSInteger)hour {
    _hour = hour;
    [self updateTimeLabel];
}

- (void)setMinute:(NSInteger)minute {
    _minute = minute;
    [self updateTimeLabel];
}

- (void)setWeek:(NSInteger)week {
    _week = week;
    [self updateTimeLabel];
}

- (void)setTimeWithHour:(NSInteger)hour Minute:(NSInteger)minute andWeek:(NSInteger)week {
    _hour = hour;
    _minute = minute;
    _week = week;
    [self updateTimeLabel];
}

- (void)updateTimeLabel {
    NSString * hour;
    NSString * minute;
    NSString * week = [NSString string];
    if (_hour < 10) {
        hour = [NSString stringWithFormat:@" %ld", _hour];
    } else {
        hour = [NSString stringWithFormat:@"%ld", _hour];
    }
    if (_minute < 10) {
        minute = [NSString stringWithFormat:@"0%ld", _minute];
    } else {
        minute = [NSString stringWithFormat:@"%ld", _minute];
    }
    if (_week & Monday) week = [week stringByAppendingString:@"周一 "];
    if (_week & Tuesday) week = [week stringByAppendingString:@"周二 "];
    if (_week & Wednesday) week = [week stringByAppendingString:@"周三 "];
    if (_week & Thursday) week = [week stringByAppendingString:@"周四 "];
    if (_week & Friday) week = [week stringByAppendingString:@"周五 "];
    if (_week & Saturday) week = [week stringByAppendingString:@"周六 "];
    if (_week & Sunday) week = [week stringByAppendingString:@"周日 "];
    NSString * time = [NSString stringWithFormat:@"%@%@:%@", week, hour, minute];
    [self.timeLabel setText:time];
}

- (void)setHasClocked:(BOOL)hasClocked {
    _hasClocked = hasClocked;
    if (_hasClocked) {
        [self.clockButton setImage:[UIImage imageNamed:@"clocked"]forState:UIControlStateNormal];
        [self.clockButton removeTarget:self action:@selector(clock) forControlEvents:UIControlEventTouchUpInside];
    } else {
        [self.clockButton setImage:[UIImage imageNamed:@"clock"]forState:UIControlStateNormal];
        [self.clockButton addTarget:self action:@selector(clock) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)clock {
    self.clockHandler(self.name);
}
@end
