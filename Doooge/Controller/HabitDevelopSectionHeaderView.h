//
//  HabitDevelopSectionHeaderView.h
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HabitDevelopSectionHeaderView : UIView
@property (nonatomic, strong) NSString * title;
@property (nonatomic) BOOL hasAdd;

- (void)addButtonTarget:(id)target action:(SEL)sel forControlEvents:(UIControlEvents)event;
@end
