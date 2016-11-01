//
//  DooogeNotificationCenter.h
//  Doooge
//
//  Created by 陈志浩 on 2016/10/30.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DooogeNotificationCenter : NSObject
+ (instancetype)currentNotificationCenter;

- (void)requestAuthorization;
- (void)requestAllHealthyRoutines;
@end
