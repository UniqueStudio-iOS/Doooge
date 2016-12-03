//
//  AppSettings+ShopSettings.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/30.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppSettings.h"

@interface AppSettings(ShopSettings)
- (void)registerShopItems;

- (BOOL)canAffordItemWithPrice:(NSInteger)price;

- (void)increaseFoodWithName:(NSString *)name andPrice:(NSInteger)price;
- (NSInteger)foodWithName:(NSString *)name;

- (void)gainToyWithName:(NSString *)name andPrice:(NSInteger)price;
- (BOOL)toyStatusWithName:(NSString *)name;

- (void)gainDecorateWithName:(NSString *)name andPrice:(NSInteger)price;
- (void)useDecorateWithName:(NSString *)name;
- (void)unuseDecorateWithName:(NSString *)name;
- (BOOL)decoratePurchaseStatusWithName:(NSString *)name;
- (BOOL)decorateUseStatusWithName:(NSString *)name;
@end
