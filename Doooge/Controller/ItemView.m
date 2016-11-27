//
//  ItemView.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/26.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ItemView.h"

@interface ItemView()
@property (nonatomic, strong) IBOutlet UIView * backgroundView;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UIView * containerView;
@property (nonatomic, strong) IBOutlet UILabel * priceLabel;
@property (nonatomic, strong) IBOutlet UIButton * purchaseButton;
@end

@implementation ItemView

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.imageView setImage:_image];
}

- (void)setPrice:(NSInteger)price {
    _price = price;
    [self.priceLabel setText:[NSString stringWithFormat:@"%ld", _price]];
}
@end
