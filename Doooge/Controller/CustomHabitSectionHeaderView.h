//
//  CustomHabitSectionHeaderView.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/17.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddButtonPressedHandler)(void);

@interface CustomHabitSectionHeaderView : UIView
@property (nonatomic, copy) AddButtonPressedHandler addButtonPressedHandler;
@end
