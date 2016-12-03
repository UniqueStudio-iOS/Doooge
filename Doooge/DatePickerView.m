//
//  DatePickerView.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/19.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "DatePickerView.h"

#import "Masonry.h"

@interface DatePickerView()
@property (nonatomic, strong) IBOutlet UIDatePicker * datePicker;
@property (nonatomic, strong) IBOutlet UIButton * cancelButton;
@property (nonatomic, strong) IBOutlet UIButton * setButton;
@property (nonatomic, strong) IBOutlet UIView * mainView;
@property (nonatomic, strong) IBOutlet UIView * backgroundView;

@property (nonatomic, readwrite) NSDate * date;

@property (nonatomic, strong)  UITapGestureRecognizer * tap;
@end

@implementation DatePickerView
@synthesize viewHidden = _viewHidden;
- (void)awakeFromNib {
    [super awakeFromNib];
    [self gestureConfiguration];
    [self insertSubview:self.mainView aboveSubview:self.backgroundView];
    [self setViewHidden:YES];
}
- (IBAction)didPressCancelButton {
//    [self setViewHidden:YES];
    self.cancelHandler();
}

- (IBAction)didPressSetTimeButton {
//    [self setViewHidden:YES];
    NSInteger hour, minute;
    [self.datePicker.calendar getHour:&hour minute:&minute second:NULL nanosecond:NULL fromDate:self.datePicker.date];
    self.setTimeHandler(hour, minute);
}

- (void)setViewHidden:(BOOL)viewHidden {
    _viewHidden = viewHidden;
    if (_viewHidden) {
        [self hiddenViews];
    } else {
        [self revealViews];
    }
}

- (void)setDate:(NSDate *)date {
    _date = date;
    self.datePicker.date = date;
}

- (BOOL)isViewHidden {
    return _viewHidden;
}

- (void)hiddenViews {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@246);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    [UIView animateWithDuration:0.45 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
        self.backgroundView.backgroundColor = defaultClearColor;
    } completion:^(BOOL finished) {
        [self.superview insertSubview:self atIndex:0];
    }];
}

- (void)revealViews {
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom).with.offset(-246);
        make.height.mas_equalTo(@246);
        make.left.equalTo(self.mas_left);
        make.width.equalTo(self.mas_width);
    }];
    [self.superview insertSubview:self atIndex:self.superview.subviews.count - 1];
    [UIView animateWithDuration:0.45 delay:0.05 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [self layoutIfNeeded];
        self.backgroundView.backgroundColor = defaultDatePickerBackgroundColor;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)gestureConfiguration {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenViews)];
    [self.backgroundView addGestureRecognizer:tap];
}
@end
