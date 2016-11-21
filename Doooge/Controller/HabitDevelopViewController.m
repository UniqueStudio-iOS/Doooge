//
//  HabitDevelopViewController.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "HabitDevelopViewController.h"
#import "HabitCell.h"
#import "HabitCell2.h"

#import "AppDatabase.h"
#import "AppTime.h"
//#import "DooogeNotificationCenter.h"

#import "DailyRoutine.h"
#import "CustomHabit.h"

#import "DailyRoutineSectionHeaderView.h"
#import "CustomHabitSectionHeaderView.h"

#import "NewHabitViewController.h"

#import "DatePickerView.h"

@interface HabitDevelopViewController () <UITableViewDelegate, UITableViewDataSource> {
    NSInteger currentDailyRoutineRow;
    NSInteger currentCustomHabitRow;
    NSArray * dailyRoutines;
    NSArray * customHabits;
    
    NSInteger dailyRoutineCellRows;
}
@property (nonatomic, strong) IBOutlet UITableView * tableView;

@property (nonatomic, strong) UIBarButtonItem * backButton;

@property (nonatomic, strong) DailyRoutineSectionHeaderView * dailyRoutineSectionHeaderView;
@property (nonatomic, strong) CustomHabitSectionHeaderView * customHabitSectionHeaderView;

@property (nonatomic, strong) DatePickerView * timePicker;

@end

@implementation HabitDevelopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateData];
    [self basicConfiguration];
    [self loadBarButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateData];
    self.navigationController.navigationBarHidden = NO;
}

- (void)basicConfiguration {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc]init];
    dailyRoutineCellRows = dailyRoutines.count;
    [self timePicker];
}

- (void)updateData {
    dailyRoutines = [[AppDatabase sharedDatabase]allDailyRoutine];
    customHabits = [[AppDatabase sharedDatabase]allCustomHabit];
    [self.tableView reloadData];
}

- (void)loadBarButton {
    self.navigationItem.leftBarButtonItem = self.backButton;
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
        return dailyRoutineCellRows;
    else
        return customHabits.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return kDailyRoutineCellHeight;
    else
        return kCustomHabitCellHeight;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return kDailyRoutineSectionHeaderViewHeight;
    } else {
        return kCustomHabitSectionHeaderViewHeight;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.dailyRoutineSectionHeaderView;
    } else {
        return self.customHabitSectionHeaderView;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HabitCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HabitCell"];
        
        DailyRoutine * dailyRoutine = dailyRoutines[indexPath.row];
        cell.name = dailyRoutine.ID;
        cell.persist = dailyRoutine.persistDays;
        [cell setTimeWithHour:dailyRoutine.hour andMinute:dailyRoutine.minute];
        
        return cell;
    } else {
        HabitCell2 * cell = [tableView dequeueReusableCellWithIdentifier:@"HabitCell2"];
        
        CustomHabit * customHabit = customHabits[indexPath.row];
        cell.name = customHabit.ID;
        cell.persist = customHabit.persistDays;
        [cell setTimeWithHour:customHabit.hour Minute:customHabit.minute andWeek:customHabit.week];
        BOOL isSameDay = [[AppTime sharedTime]isSameDayWithDate1:[AppTime sharedTime].date andDate2:customHabit.lastClocked];
        cell.hasClocked = isSameDay;
        HabitDevelopViewController __weak * weakSelf = self;
        cell.clockHandler = ^(NSString * name) {
            CustomHabit * targetCustomHabit = [[AppDatabase sharedDatabase]customHabitWithName:name];
            [[AppDatabase sharedDatabase]updateLastClocked:[AppTime sharedTime].date withCustomHabit:targetCustomHabit];
            [weakSelf updateData];
        };
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self prepareDateWithRow:indexPath.row];
        self.timePicker.viewHidden = NO;
        currentDailyRoutineRow = indexPath.row;
    } else {
        currentCustomHabitRow = indexPath.row;
        [self performSegueWithIdentifier:@"modifyCustomHabit" sender:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1)
        return YES;
    else
        return NO;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [[AppDatabase sharedDatabase]deleteCustomHabit:customHabits[indexPath.row]];
        [self updateData];
    }
}

- (void)prepareDateWithRow:(NSInteger)row {
    DailyRoutine * dailyRoutine = dailyRoutines[row];
    NSDate * date = [[AppTime sharedTime]timeFromHour:dailyRoutine.hour andMinute:dailyRoutine.minute];
    [self.timePicker setDate:date];
}
//- (void)timeChange:(UIDatePicker *)sender {
//    if (currentDailyRoutineRow >= 0) {
//        NSInteger hour, minute;
//        NSDate * date = sender.date;
//        NSCalendar * calendar = sender.calendar;
//        [calendar getHour:&hour minute:&minute second:NULL nanosecond:NULL fromDate:date];
//        NSDateComponents * components = [[NSDateComponents alloc]init];
//        components.hour = hour;
//        components.minute = minute;
////        NSMutableDictionary * dict;
//        if (currentDailyRoutineRow == 0) {
////             dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"breakfast"]mutableCopy];
////            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
////            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"breakfast"];
////        } else if (currentDailyRoutineRow == 1) {
////            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"lunch"]mutableCopy];
////            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
////            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"lunch"];
////        } else if (currentDailyRoutineRow == 2) {
////            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"dinner"]mutableCopy];
////            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
////            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"dinner"];
////        } else if (currentDailyRoutineRow == 3) {
////            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sport"]mutableCopy];
////            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
////            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"sport"];
////        } else if (currentDailyRoutineRow == 4) {
////            dict = [[[DooogeUserDefaults dooogeUserDefaults]dailyRoutineDictForKey:@"sleep"]mutableCopy];
////            [dict setObject: [NSKeyedArchiver archivedDataWithRootObject:components] forKey:@"time"];
////            [[DooogeUserDefaults dooogeUserDefaults]setDailyRoutineDict:dict forKey:@"sleep"];
//        }
////        [self.tableView reloadData];
////        [[DooogeNotificationCenter currentNotificationCenter]requestAllHealthyRoutines];
//    }
//}

- (DailyRoutineSectionHeaderView *)dailyRoutineSectionHeaderView {
    if (!_dailyRoutineSectionHeaderView) {
        _dailyRoutineSectionHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"DailyRoutineSectionHeaderView" owner:nil options:nil]firstObject];
        _dailyRoutineSectionHeaderView.frame = CGRectMake(0, 0, kWindowWidth, kDailyRoutineSectionHeaderViewHeight);
        
        HabitDevelopViewController * __weak weakSelf = self;
        _dailyRoutineSectionHeaderView.packButtonPressedHandler = ^(BOOL isPacked) {
            if (isPacked) {
                dailyRoutineCellRows = 0;
                [weakSelf.tableView reloadData];
            } else {
                dailyRoutineCellRows = dailyRoutines.count;
                [weakSelf.tableView reloadData];
            }
        };
    }
    return _dailyRoutineSectionHeaderView;
}

- (CustomHabitSectionHeaderView *)customHabitSectionHeaderView {
    if (!_customHabitSectionHeaderView) {
        _customHabitSectionHeaderView = [[[NSBundle mainBundle] loadNibNamed:@"CustomHabitSectionHeaderView" owner:nil options:nil]firstObject];
        _customHabitSectionHeaderView.frame = CGRectMake(0, 0, kWindowWidth, kCustomHabitSectionHeaderViewHeight);
        
        HabitDevelopViewController * __weak weakSelf = self;
        _customHabitSectionHeaderView.addButtonPressedHandler = ^(){
            [weakSelf performSegueWithIdentifier:@"addCustomHabit" sender:nil];
        };
    }
    return _customHabitSectionHeaderView;
}

- (DatePickerView *)timePicker {
    if (!_timePicker) {
        _timePicker = [[[NSBundle mainBundle]loadNibNamed:@"DatePickerView" owner:nil options:nil]firstObject];
        [self.view addSubview:_timePicker];
        HabitDevelopViewController * __weak weakSelf = self;
        _timePicker.cancelHandler = ^(){
            [weakSelf deselectCellForCurrentIndexPath];
        };
        _timePicker.setTimeHandler = ^(NSInteger hour, NSInteger minute) {
            [weakSelf updateTimeWithHour:hour andMinute:minute];
            [weakSelf deselectCellForCurrentIndexPath];
        };
    }
    return _timePicker;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        [button sizeToFit];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _backButton;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateTimeWithHour:(NSInteger)hour andMinute:(NSInteger)minute {
    [[AppDatabase sharedDatabase]updateHour:hour andMinute:minute withDailyRoutine:dailyRoutines[currentDailyRoutineRow]];
    [self updateData];
}

- (void)deselectCellForCurrentIndexPath {
    NSIndexPath * targetIndex = [NSIndexPath indexPathForRow:currentDailyRoutineRow inSection:0];
    [self.tableView deselectRowAtIndexPath:targetIndex animated:YES];
}
#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier]isEqualToString:@"modifyCustomHabit"]) {
        NewHabitViewController * targetVC = segue.destinationViewController;
        [targetVC existedCustomHabit:customHabits[currentCustomHabitRow]];
        targetVC.habitUpdateHandler = ^(BOOL isExisted) {
            [self updateData];
        };
    } else if ([[segue identifier]isEqualToString:@"addCustomHabit"]) {
        NewHabitViewController * targetVC = segue.destinationViewController;
        targetVC.habitUpdateHandler = ^(BOOL isExisted) {
            [self updateData];
        };
    }
}

@end
