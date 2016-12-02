//
//  ItemCell2.h
//  Doooge
//
//  Created by 陈志浩 on 2016/12/2.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PurchaseHandler)(NSString * name, NSInteger price);
typedef void(^UseHandler)(NSString * name);

@interface ItemCell2 : UICollectionViewCell
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic) NSInteger price;

@property (nonatomic) BOOL hasPurchased;
@property (nonatomic) BOOL hasUsed;

@property (nonatomic, copy) PurchaseHandler purchaseHandler;
@property (nonatomic, copy) UseHandler useHandler;
@end
