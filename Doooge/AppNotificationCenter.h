//
//  AppNotificationCenter.h
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppNotificationCenter : NSObject
+ (instancetype)sharedNotificationCenter;

- (void)requestNotificationAuthorization;
@end
