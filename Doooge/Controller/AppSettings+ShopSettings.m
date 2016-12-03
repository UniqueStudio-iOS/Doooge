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
    [self.userDefaults registerDefaults:@{@"food":foodItems}];
    
    NSMutableDictionary * toyItems = [NSMutableDictionary dictionary];
    for (NSDictionary * toyItem in data.toyData) {
        [toyItems setObject:@NO forKey:toyItem[@"name"]];
    }
    [self.userDefaults registerDefaults:@{@"toy":toyItems}];
    
    NSMutableDictionary * decorateItems = [NSMutableDictionary dictionary];
    for (NSDictionary * decorateItem in data.decorateData) {
        [decorateItems setObject:@{@"buy":@NO, @"use":@NO} forKey:decorateItem[@"name"]];
    }
    [self.userDefaults registerDefaults:@{@"decorate":decorateItems}];
}
#pragma mark Shop
- (BOOL)canAffordItemWithPrice:(NSInteger)price {
    return (self.goldCoins - price) >= 0;
}

#pragma mark Food
- (void)increaseFoodWithName:(NSString *)name andPrice:(NSInteger)price{
    self.goldCoins -= price;
    NSMutableDictionary * dictionary = [[self.userDefaults objectForKey:@"food"]mutableCopy];
    
    [dictionary setObject:[NSNumber numberWithInteger:[[dictionary objectForKey:name]integerValue] + 1] forKey:name];
    
    [self.userDefaults setObject:dictionary forKey:@"food"];
}

- (NSInteger)foodWithName:(NSString *)name {
    return [[[self.userDefaults objectForKey:@"food"]objectForKey:name]integerValue];
}
#pragma mark Toy
- (void)gainToyWithName:(NSString *) name andPrice:(NSInteger)price {
    self.goldCoins -= price;
    NSMutableDictionary * dictionary = [[self.userDefaults objectForKey:@"toy"]mutableCopy];
    
    [dictionary setObject:[NSNumber numberWithBool:YES] forKey:name];
    
    [self.userDefaults setObject:dictionary forKey:@"toy"];
}

- (BOOL)toyStatusWithName:(NSString *)name {
    return [[[self.userDefaults objectForKey:@"toy"]objectForKey:name]boolValue];
}
#pragma mark Decorate
- (void)gainDecorateWithName:(NSString *)name andPrice:(NSInteger)price {
    self.goldCoins -= price;
    NSMutableDictionary * decorateItems = [[self.userDefaults objectForKey:@"decorate"]mutableCopy];
    
    NSMutableDictionary * decorateItem = [[decorateItems objectForKey:name]mutableCopy];
    decorateItem[@"buy"] = @YES;
    
    [decorateItems setObject:decorateItem forKey:name];
    [self.userDefaults setObject:decorateItems forKey:@"decorate"];
}

- (void)useDecorateWithName:(NSString *)name {
    NSMutableDictionary * decorateItems = [[self.userDefaults objectForKey:@"decorate"]mutableCopy];
    
    NSMutableDictionary * targetItem = [[decorateItems objectForKey:name]mutableCopy];
    targetItem[@"use"] = @YES;
    
    [decorateItems setObject:targetItem forKey:name];
    [self.userDefaults setObject:decorateItems forKey:@"decorate"];
}

- (void)unuseDecorateWithName:(NSString *)name {
    NSMutableDictionary * decorateItems = [[self.userDefaults objectForKey:@"decorate"]mutableCopy];
    
    NSMutableDictionary * targetItem = [[decorateItems objectForKey:name]mutableCopy];
    targetItem[@"use"] = @NO;
    
    [decorateItems setObject:targetItem forKey:name];
    [self.userDefaults setObject:decorateItems forKey:@"decorate"];
}

- (BOOL)decoratePurchaseStatusWithName:(NSString *)name {
    return [[[[self.userDefaults objectForKey:@"decorate"]objectForKey:name]objectForKey:@"buy"]boolValue];
}

- (BOOL)decorateUseStatusWithName:(NSString *)name {
    return [[[[self.userDefaults objectForKey:@"decorate"]objectForKey:name]objectForKey:@"use"]boolValue];
}
@end
