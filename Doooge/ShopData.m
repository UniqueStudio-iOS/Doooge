//
//  ShopData.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/27.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ShopData.h"

#import "AppSettings+ShopSettings.h"

#import "ItemCell.h"
#import "ItemCell2.h"

@interface ShopData()
@property (nonatomic, readwrite, strong) NSArray * foodData;
@property (nonatomic, readwrite, strong) NSArray * toyData;
@property (nonatomic, readwrite, strong) NSArray * decorateData;
@end

@implementation ShopData
+ (NSArray *)foodData {
    return @[
             @{
                 @"name":@"dogfood",
                 @"image":@"dogfood",
                 @"price":@1
                 },
             @{
                 @"name":@"drumstick",
                 @"image":@"drumstick",
                 @"price":@1
                 },
             @{
                 @"name":@"bone",
                 @"image":@"bone",
                 @"price":@1
                 },
             @{
                 @"name":@"cake",
                 @"image":@"cake",
                 @"price":@1
                 }
             ];
}

+ (NSArray *)toyData {
    return @[
             @{
                 @"name":@"ball",
                 @"image":@"ball",
                 @"price":@1
                 },
             @{
                 @"name":@"hat",
                 @"image":@"hat",
                 @"price":@1
                 },
             @{
                 @"name":@"frisbee",
                 @"image":@"frisbee",
                 @"price":@1
                 },
             @{
                 @"name":@"rattle",
                 @"image":@"rattle",
                 @"price":@1
                 }
             ];
}

+ (NSArray *)decorateData {
    return @[
             @{
                 @"name":@"pinkmat",
                 @"position":@"left",
                 @"image":@"pinkmat",
                 @"price":@1
                 },
             @{
                 @"name":@"wingsmat",
                 @"position":@"left",
                 @"image":@"wingsmat",
                 @"price":@1
                 },
             @{
                 @"name":@"magichat",
                 @"position":@"left",
                 @"image":@"magichat",
                 @"price":@1
                 }
             ];
}

- (instancetype)init {
    if (self = [super init]) {
        _foodData = [ShopData foodData];
        _toyData = [ShopData toyData];
        _decorateData = [ShopData decorateData];
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView.tag == 1) {
        return self.foodData.count;
    } else if (collectionView.tag == 2) {
        return self.toyData.count;
    } else {
        return self.decorateData.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag != 3) {
        ItemCell * itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell" forIndexPath:indexPath];
        itemCell.userInteractionEnabled = YES;
        if (collectionView.tag == 1) {
            itemCell.name = self.foodData[indexPath.row][@"name"];
            itemCell.image = [UIImage imageNamed:self.foodData[indexPath.row][@"image"]];
            itemCell.price = [self.foodData[indexPath.row][@"price"]integerValue];
            itemCell.style = ItemCellFoodStyle;
        } else {
            itemCell.name = self.toyData[indexPath.row][@"name"];
            itemCell.image = [UIImage imageNamed:self.toyData[indexPath.row][@"image"]];
            itemCell.price = [self.toyData[indexPath.row][@"price"]integerValue];
            itemCell.style = ItemCellToyStyle;
            itemCell.hasPurchased = [[AppSettings sharedSettings]toyStatusWithName:itemCell.name];
        }
        ItemCell * __weak weakItemCell = itemCell;
        itemCell.purchaseHandler = ^(ItemCellStyle style, NSString * name, NSInteger price) {
            switch (style) {
                case ItemCellFoodStyle:
                    if ([[AppSettings sharedSettings]canAffordItemWithPrice:price]) {
                        [[AppSettings sharedSettings]increaseFoodWithName:name andPrice:price];
                        NSLog(@"%ld", [[AppSettings sharedSettings]foodWithName:name]);
                    }
                    break;
                case ItemCellToyStyle:
                    if ([[AppSettings sharedSettings]canAffordItemWithPrice:price]) {
                        [[AppSettings sharedSettings]gainToyWithName:name andPrice:price];
                        weakItemCell.hasPurchased = YES;
                    }
                    break;
            }
            self.refreshGoinCoinsHandler();
        };
        return itemCell;
    } else {
        ItemCell2 * itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ItemCell2" forIndexPath:indexPath];
        itemCell.userInteractionEnabled = YES;
        
        itemCell.name = self.decorateData[indexPath.row][@"name"];
        itemCell.position = self.decorateData[indexPath.row][@"position"];
        itemCell.image = [UIImage imageNamed:self.decorateData[indexPath.row][@"image"]];
        itemCell.price = [self.decorateData[indexPath.row][@"price"]integerValue];
        
        itemCell.hasPurchased = [[AppSettings sharedSettings]decoratePurchaseStatusWithName:itemCell.name];
        itemCell.hasUsed = [[AppSettings sharedSettings]decorateUseStatusWithName:itemCell.name];
        
        ItemCell2 * __weak weakItemCell = itemCell;
        ShopData * __weak weakSelf = self;
        itemCell.buyHandler = ^(NSString * name, NSInteger price) {
            if ([[AppSettings sharedSettings]canAffordItemWithPrice:price]) {
                [[AppSettings sharedSettings]gainDecorateWithName:name andPrice:price];
                if ([[AppSettings sharedSettings]decoratePurchaseStatusWithName:name]) {
                    NSLog(@"Purchase succeed!");
                } else {
                    NSLog(@"Purchase failed!");
                }
                
                weakItemCell.hasPurchased = YES;
                self.refreshGoinCoinsHandler();
            }
        };
        itemCell.useHandler = ^(NSString * name, NSString * position) {
            for (NSDictionary * decorateItem in weakSelf.decorateData) {
                if ([decorateItem[@"position"] isEqualToString:position]) {
                    if ([decorateItem[@"name"] isEqualToString:name]) {
                        [[AppSettings sharedSettings]useDecorateWithName:decorateItem[@"name"]];
                    } else {
                        [[AppSettings sharedSettings]unuseDecorateWithName:decorateItem[@"name"]];
                    }
                }
            }
            [collectionView reloadData];
        };
        return itemCell;
    }

}
@end
