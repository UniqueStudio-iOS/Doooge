//
//  DailyRoutineSectionHeaderView.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/16.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PackButtonPressedHandler)(BOOL isPacked);

@interface DailyRoutineSectionHeaderView : UIView
@property (nonatomic) BOOL isPacked;
@property (nonatomic, copy) PackButtonPressedHandler packButtonPressedHandler;
@end
