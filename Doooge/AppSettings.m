//
//  AppSettings.m
//  Doooge
//
//  Created by BlackDragon on 2016/11/13.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "AppSettings.h"

static NSString * const kGrowthPointsKey = @"growthPoints";
static NSString * const kGoldCoinsKey = @"goldCoins";
static NSString * const kPetLevelKey = @"petLevel";
static NSString * const kPetNameKey = @"petName";
static NSString * const kPrimaryKey = @"primary";
static NSString * const kAuthorizedKey = @"authorized";

static NSString * kSuiteName = @"group.com.vic.Doooge";

@interface AppSettings()
@property (nonatomic, strong, readwrite) NSUserDefaults * userDefaults;
@end

@implementation AppSettings
@synthesize growthPoints = _growthPoints;
@synthesize goldCoins = _goldCoins;
@synthesize petLevel = _petLevel;
@synthesize petName = _petName;
@synthesize primary = _primary;
@synthesize authorized = _authorized;

#pragma mark Singleton
+ (instancetype)sharedSettings {
    static AppSettings * settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settings = [[AppSettings alloc]init];
    });
    return settings;
}

- (instancetype)init {
    if (self = [super init]) {
        _userDefaults = [[NSUserDefaults alloc]initWithSuiteName:kSuiteName];
        
        [_userDefaults registerDefaults:@{
                                          kGrowthPointsKey:@50,
                                          kGoldCoinsKey:@20,
                                          kPetLevelKey:@1,
                                          kPetNameKey:@"Doooge",
                                          kPrimaryKey:@YES,
                                          kAuthorizedKey:@NO}];
        
        _growthPoints = [_userDefaults integerForKey:kGrowthPointsKey];
        _goldCoins = [_userDefaults integerForKey:kGoldCoinsKey];
        _petLevel = [_userDefaults integerForKey:kPetLevelKey];
        _petName = [_userDefaults stringForKey:kPetNameKey];
        _primary = [_userDefaults boolForKey:kPrimaryKey];
        _authorized = [_userDefaults boolForKey:kAuthorizedKey];
    }
    return self;
}
#pragma mark GrowthPoints
- (void)setGrowthPoints:(NSInteger)growthPoints {
    _growthPoints = growthPoints;
    [self.userDefaults setInteger:_growthPoints forKey:kGrowthPointsKey];
}

- (NSInteger)growthPoints {
    return _growthPoints;
}
#pragma mark GoldCoins
- (void)setGoldCoins:(NSInteger)goldCoins {
    _goldCoins = goldCoins;
    [self.userDefaults setInteger:_goldCoins forKey:kGoldCoinsKey];
}

- (NSInteger)goldCoins {
    return _goldCoins;
}
#pragma mark PetLevel
- (void)setPetLevel:(NSInteger)petLevel {
    _petLevel = petLevel;
    [self.userDefaults setInteger:_petLevel forKey:kPetLevelKey];
}

- (NSInteger)petLevel {
    return _petLevel;
}
#pragma mark PetName
- (void)setPetName:(NSString *)petName {
    _petName = petName;
    [self.userDefaults setObject:_petName forKey:kPetNameKey];
}

- (NSString *)petName {
    return _petName;
}
#pragma mark Primary
- (void)setPrimary:(BOOL)primary {
    _primary = primary;
    [self.userDefaults setBool:_primary forKey:kPrimaryKey];
}

- (BOOL)isPrimary {
    return _primary;
}
#pragma mark Authorized
- (void)setAuthorized:(BOOL)authorized {
    _authorized = authorized;
    [self.userDefaults setBool:_authorized forKey:kAuthorizedKey];
}

- (BOOL)isAuthorized {
    return _authorized;
}

@end
