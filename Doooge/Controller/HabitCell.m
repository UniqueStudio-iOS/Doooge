//
//  HabitCell.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
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

- (void)setTimeWithHour:(NSInteger)hour andMinute:(NSInteger)minute {
    _hour = hour;
    _minute = minute;
    [self updateTimeLabel];
}

- (void)updateTimeLabel {
    NSString * hour;
    NSString * minute;
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
    NSString * time = [NSString stringWithFormat:@"%@:%@", hour, minute];
    [self.timeLabel setText:time];
}

@end
