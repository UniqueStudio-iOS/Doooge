//
//  AppSettings+ShopSettings.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/30.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "AppSettings+ShopSettings.h"

#import "ShopData.h"

@implementation AppSettings(ShopSettings)
#pragma mark Register Methods
- (void)registerShopItems {
    ShopData * data = [[ShopData alloc]init];
    
    NSMutableDictionary * foodItems = [NSMutableDictionary dictionary];
    for (NSDictionary * foodItem in data.foodData) {
        [foodItems setObject:@0 forKey:foodItem[@"name"]];
    }
    [self.userDefaults registerDefaults:foodItems];
    
    NSMutableDictionary * toyItems = [NSMutableDictionary dictionary];
    for (NSDictionary * toyItem in data.toyData) {
        [toyItems setObject:@NO forKey:toyItem[@"name"]];
    }
    [self.userDefaults registerDefaults:toyItems];
}
#pragma mark Shop
- (BOOL)canAffordItemWithPrice:(NSInteger)price {
    return (self.goldCoins - price) >= 0;
}
- (void)increaseFoodWithName:(NSString *)name andPrice:(NSInteger)price{
    self.goldCoins -= price;
    [self.userDefaults setInteger:[self.userDefaults integerForKey:name]+1 forKey:name];
}

- (NSInteger)foodWithName:(NSString *)name {
    return [self.userDefaults integerForKey:name];
}

- (void)gainToyWithName:(NSString *) name andPrice:(NSInteger)price {
    self.goldCoins -= price;
    [self.userDefaults setBool:YES forKey:name];
}

- (BOOL)toyStatusWithName:(NSString *)name {
    return [self.userDefaults boolForKey:name];
}
@end
