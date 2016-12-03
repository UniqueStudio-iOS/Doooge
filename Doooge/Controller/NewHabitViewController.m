//
//  NewHabitViewController.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "NewHabitViewController.h"

#import "DatePickerView.h"

#import "AppDatabase.h"
#import "AppTime.h"
#import "CustomHabit.h"

@interface NewHabitViewController ()<UITextFieldDelegate> {
    CustomHabitWeek weekStatus;
    NSInteger _hour;
    NSInteger _minute;
}
@property (nonatomic, strong) IBOutlet UITextField * nameText;
@property (nonatomic, strong) IBOutlet UILabel * timeLabel;
@property (nonatomic, strong) IBOutlet UIButton * sunButton;
@property (nonatomic, strong) IBOutlet UIButton * monButton;
@property (nonatomic, strong) IBOutlet UIButton * tueButton;
@property (nonatomic, strong) IBOutlet UIButton * wedButton;
@property (nonatomic, strong) IBOutlet UIButton * thurButton;
@property (nonatomic, strong) IBOutlet UIButton * friButton;
@property (nonatomic, strong) IBOutlet UIButton * satButton;
@property (nonatomic, strong) IBOutlet UISwitch * remindSwitch;

@property (nonatomic, strong) DatePickerView * timePicker;

@property (nonatomic, strong) UIBarButtonItem * completeButton;
@property (nonatomic, strong) UIBarButtonItem * backButton;

@property (nonatomic, strong) CustomHabit * customHabit;

@property (nonatomic) BOOL isExisted;

@end

@implementation NewHabitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self advancedUIConfiguration];
    [self loadBarButton];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)existedCustomHabit:(CustomHabit *)customHabit {
    self.isExisted = YES;
    self.customHabit = customHabit;
}

- (void)basicConfiguration {
    if (self.isExisted) {
        weekStatus = self.customHabit.week;
        _hour = self.customHabit.hour;
        _minute = self.customHabit.minute;
    } else {
        weekStatus = (Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday);
        _hour = 0;
        _minute = 0;
    }
    [self initDateWithHour:_hour andMinute:_minute];
    _nameText.delegate = self;
    [self gestureConfiguration];
}

- (void)advancedUIConfiguration {
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.nameText.tintColor = defaultBlackColor1;
    [self initializeButton:self.sunButton];
    [self initializeButton:self.monButton];
    [self initializeButton:self.tueButton];
    [self initializeButton:self.wedButton];
    [self initializeButton:self.thurButton];
    [self initializeButton:self.friButton];
    [self initializeButton:self.satButton];
    if (self.isExisted) {
        self.title = @"修改习惯";
        self.remindSwitch.on = self.customHabit.hasRemind;
        self.nameText.text = self.customHabit.ID;
        self.nameText.userInteractionEnabled = NO;
    } else {
        self.title = @"创建习惯";
    }
    [self updateTimeWithHour:_hour andMinute:_minute];
}

- (void)loadBarButton {
    self.navigationItem.rightBarButtonItem = self.completeButton;
    self.navigationItem.leftBarButtonItem = self.backButton;
}

- (void)initDateWithHour:(NSInteger)hour andMinute:(NSInteger)minute {
    NSDate * date = [[AppTime sharedTime]timeFromHour:hour andMinute:minute];
    [self.timePicker setDate:date];
}
#pragma mark Button
- (void)initializeButton:(UIButton *)button {
    [self addRoundedRectToButton:button];
    [self addTargetToButton:button];
    [self refreshButtonStatus:button];
}

- (void)addTargetToButton:(UIButton *)button {
    [button addTarget:self action:@selector(didSelectWeekButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRoundedRectToButton:(UIButton *)button {
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = kCustomHabitButtonCornerRadius;
}

- (void)buttonToSelect:(UIButton *)button {
    button.layer.borderWidth = kCustomHabitButtonBorderWidth;
    button.layer.borderColor = defaultClearColor.CGColor;
    button.backgroundColor = mainColor;
    [button setTitleColor:defaultWhiteColor1 forState:UIControlStateNormal];
}

- (void)buttonToDeselect:(UIButton *)button {
    button.layer.borderWidth = kCustomHabitButtonBorderWidth;
    button.layer.borderColor = defaultGrayColor1.CGColor;
    button.backgroundColor = defaultWhiteColor1;
    [button setTitleColor:defaultGrayColor1 forState:UIControlStateNormal];
}

- (void)refreshButtonStatus:(UIButton *)button {
    NSInteger flag = button.tag & weekStatus;
    if (flag) {
        [self buttonToSelect:button];
    } else {
        [self buttonToDeselect:button];
    }
}

- (void)didSelectWeekButton:(UIButton *)button {
    weekStatus = weekStatus ^ button.tag;
    [self refreshButtonStatus:button];
    [self visualizedWeekStatus];
}

- (void)visualizedWeekStatus {
    NSLog(@"WeekStatus:%lx", (long)weekStatus);
}
#pragma mark Lazy load
- (UIBarButtonItem *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeCreateOrUpdate)];
        _completeButton.tintColor = mainColor;
    }
    return _completeButton;
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
#pragma mark Interact

- (void)completeCreateOrUpdate {
    if (self.isExisted) {
        [[AppDatabase sharedDatabase]updateHour:_hour minute:_minute hasRemind:self.remindSwitch.isOn week:weekStatus withCostomHabit:self.customHabit];
    } else {
        self.customHabit = [[CustomHabit alloc]init];
        self.customHabit.ID = self.nameText.text;
        self.customHabit.persistDays = 0;
        self.customHabit.hour = _hour;
        self.customHabit.minute = _minute;
        self.customHabit.hasRemind = self.remindSwitch.isOn;
        self.customHabit.week = weekStatus;
        self.customHabit.lastClocked = [NSDate dateWithTimeIntervalSince1970:0];
        [[AppDatabase sharedDatabase]addCustomHabit:self.customHabit];
    }
    self.habitUpdateHandler(self.isExisted);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark TableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        [self.nameText resignFirstResponder];
        self.timePicker.viewHidden = NO;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == kNewHabitMaxCellNumber - 1) {
        cell.separatorInset = UIEdgeInsetsMake(0, CGRectGetWidth(cell.bounds)/2.0, 0, CGRectGetWidth(cell.bounds)/2.0);
    }
}
#pragma mark Lazy Load 
- (DatePickerView *)timePicker {
    if (!_timePicker) {
        _timePicker = [[[NSBundle mainBundle]loadNibNamed:@"DatePickerView" owner:nil options:nil]firstObject];
        [self.tableView addSubview:_timePicker];
        NewHabitViewController * __weak weakSelf = self;
        _timePicker.cancelHandler = ^(){
            weakSelf.timePicker.viewHidden = YES;
        };
        _timePicker.setTimeHandler = ^(NSInteger hour, NSInteger minute) {
            _hour = hour;
            _minute = minute;
            [weakSelf updateTimeWithHour:hour andMinute:minute];
            if (weakSelf.isExisted) {
                
            } else {
                
                
            }
            weakSelf.timePicker.viewHidden = YES;
        };
    }
    return _timePicker;
}

- (void)updateTimeWithHour:(NSInteger)hour andMinute:(NSInteger)minute{
    NSString * hourString;
    NSString * minuteString;
    if (hour < 10) {
        hourString = [NSString stringWithFormat:@" %ld", hour];
    } else {
        hourString = [NSString stringWithFormat:@"%ld", hour];
    }
    if (minute < 10) {
        minuteString = [NSString stringWithFormat:@"0%ld", minute];
    } else {
        minuteString = [NSString stringWithFormat:@"%ld", minute];
    }
    NSString * time = [NSString stringWithFormat:@"%@:%@", hourString, minuteString];
    [self.timeLabel setText:time];
}

- (void)gestureConfiguration {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
}

- (void)dismissKeyboard{
    [self.nameText resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
