//
//  CustomHabitSectionHeaderView.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/17.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "CustomHabitSectionHeaderView.h"

@interface CustomHabitSectionHeaderView()
@property (nonatomic, strong) IBOutlet UIButton * addButton;
@end
@implementation CustomHabitSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)didPressedAddButton:(UIButton *)addButton {
    self.addButtonPressedHandler();
}
@end
