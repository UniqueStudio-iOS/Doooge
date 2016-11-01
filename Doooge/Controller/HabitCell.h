//
//  HabitCell.h
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HabitCell : UITableViewCell
@property (nonatomic, strong) NSString * name;
@property (nonatomic) NSInteger persist;
@property (nonatomic, strong) NSDateComponents * time;
@end
