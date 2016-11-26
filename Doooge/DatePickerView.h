//
//  DatePickerView.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/19.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CancelHandler)();
typedef void(^SetTimeHandler)(NSInteger hour, NSInteger minute);
@interface DatePickerView : UIView
@property (nonatomic, copy) CancelHandler cancelHandler;
@property (nonatomic, copy) SetTimeHandler setTimeHandler;

@property (nonatomic, getter=isViewHidden) BOOL viewHidden;

@property (nonatomic, readonly) NSDate * date;
- (void)setDate:(NSDate *)date;
@end
