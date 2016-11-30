//
//  AppSettings.h
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject
+ (instancetype)sharedSettings;

@property (nonatomic, strong, readonly) NSUserDefaults * userDefaults;

@property (nonatomic) NSInteger growthPoints;
@property (nonatomic) NSInteger goldCoins;
@property (nonatomic) NSInteger petLevel;
@property (nonatomic) NSString * petName;
@property (nonatomic, getter=isPrimary) BOOL primary;
@property (nonatomic, getter=isAuthorized) BOOL authorized;
@end
