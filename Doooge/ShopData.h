//
//  ShopData.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/27.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RefreshGoldCoinsHandler)();

@interface ShopData : NSObject<UICollectionViewDataSource>
@property (nonatomic, readonly, copy) NSArray * foodData;
@property (nonatomic, readonly, copy) NSArray * toyData;
@property (nonatomic, readonly, copy) NSArray * decorateData;

@property (nonatomic, copy) RefreshGoldCoinsHandler refreshGoinCoinsHandler;

- (instancetype)init;
@end
