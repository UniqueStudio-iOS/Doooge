//
//  HabitDevelopViewController.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "HabitDevelopViewController.h"
#import "HabitCell.h"
#import "HabitDevelopSectionHeaderView.h"
#import "DooogeUserDefaults.h"
#import "DooogeNotificationCenter.h"
#import "Masonry.h"


@interface HabitDevelopViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger currentIndexRow;
}
@property (nonatomic, strong) IBOutlet UITableView * tableView;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (nonatomic, strong) UIView * grayView;
@end

@implementation HabitDevelopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self loadPickerView];
    currentIndexRow = -1;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)loadPickerView {
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
    }];
    [self.datePicker addTarget:self action:@selector(timeChange:) forControlEvents:UIControlEventValueChanged];
    [self.view insertSubview:self.grayView belowSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 5;
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 53.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HabitDevelopSectionHeaderView * sectionHeaderView =[[HabitDevelopSectionHeaderView alloc]init];
    sectionHeaderView.frame = CGRectMake(0, 0, tableView.bounds.size.width, 53.5);
    if (section == 0) {
        sectionHeaderView.title = @"健康作息打卡";
        sectionHeaderView.hasAdd = NO;
    } else {
        sectionHeaderView.title = @"其他习惯打卡";
        sectionHeaderView.hasAdd = YES;
    }
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HabitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HabitCell"];
    NSString * name = [NSString string];
    if (indexPath.section == 0) {
        NSDictionary * healthyHabit;
        if (indexPath.row == 0) {
            healthyHabit = [[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"breakfast"];
            name = @"早饭";
        } else if (indexPath.row == 1) {
            healthyHabit = [[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"lunch"];
            name = @"午饭";
        } else if (indexPath.row == 2) {
            healthyHabit = [[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"dinner"];
            name = @"晚饭";
        } else if (indexPath.row == 3) {
            healthyHabit = [[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sport"];
            name = @"运动";
        } else if (indexPath.row == 4) {
            healthyHabit = [[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sleep"];
            name = @"睡觉";
        }
        cell.name = name;
        cell.persist = [healthyHabit[@"persist"]integerValue];
        cell.time = [NSKeyedUnarchiver unarchiveObjectWithData:healthyHabit[@"time"]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self.datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).with.offset(-216);
        }];
        [UIView animateWithDuration:0.6 animations:^{
            [self.view layoutIfNeeded];
            self.grayView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        }];
        [self.view insertSubview:self.grayView belowSubview:self.datePicker];
        currentIndexRow = indexPath.row;
    }
}

- (void)dismissDatePicker {
    [self.datePicker mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom);
    }];
    [UIView animateWithDuration:0.6 animations:^{
        [self.view layoutIfNeeded];
        self.grayView.backgroundColor = [UIColor clearColor];
    }];
    [self.view insertSubview:self.grayView belowSubview:self.tableView];
    currentIndexRow = -1;
}

- (void)timeChange:(UIDatePicker *)sender {
    if (currentIndexRow >= 0) {
        NSInteger hour, minute;
        NSDate * date = sender.date;
        NSCalendar * calendar = sender.calendar;
        [calendar getHour:&hour minute:&minute second:NULL nanosecond:NULL fromDate:date];
        NSDateComponents * components = [[NSDateComponents alloc]init];
        components.hour = hour;
        components.minute = minute;
        NSMutableDictionary * dict;
        if (currentIndexRow == 0) {
             dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"breakfast"]mutableCopy];
            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"breakfast"];
        } else if (currentIndexRow == 1) {
            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"lunch"]mutableCopy];
            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"lunch"];
        } else if (currentIndexRow == 2) {
            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"dinner"]mutableCopy];
            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"dinner"];
        } else if (currentIndexRow == 3) {
            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sport"]mutableCopy];
            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"sport"];
        } else if (currentIndexRow == 4) {
            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sleep"]mutableCopy];
            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"sleep"];
        }
        [self.tableView reloadData];
        [[DooogeNotificationCenter currentNotificationCenter]requestAllHealthyRoutines];
    }
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]init];
        _datePicker.datePickerMode = UIDatePickerModeTime;
        [self.view addSubview:_datePicker];
    }
    return _datePicker;
}

- (UIView *)grayView {
    if (!_grayView) {
        _grayView = [[UIView alloc]init];
        _grayView.backgroundColor = [UIColor clearColor];
        _grayView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissDatePicker)];
        [_grayView addGestureRecognizer:tapRecognizer];
        [self.view addSubview:_grayView];
        [_grayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.width.equalTo(self.view.mas_width);
            make.bottom.equalTo(self.datePicker.mas_top);
            make.top.equalTo(self.tableView.mas_top);
        }];
        
    }
    return _grayView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
