//
//  NewHabitViewController.h
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomHabit;

typedef void(^HabitUpdatedHandler)(BOOL isExisted);

@interface NewHabitViewController : UITableViewController

@property (nonatomic, copy) HabitUpdatedHandler habitUpdateHandler;

- (void)existedCustomHabit:(CustomHabit *)customHabit;
@end
