//
//  ItemCell.h
//  Doooge
//
//  Created by 陈志浩 on 2016/11/28.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PurchaseHandler)(ItemCellStyle style, NSString * name, NSInteger price);

@interface ItemCell : UICollectionViewCell
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic) NSInteger price;

@property (nonatomic) ItemCellStyle style;
@property (nonatomic) BOOL hasPurchased;

@property (nonatomic, copy) PurchaseHandler purchaseHandler;
@end
