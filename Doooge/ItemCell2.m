//
//  ItemCell2.m
//  Doooge
//
//  Created by 陈志浩 on 2016/12/2.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ItemCell2.h"

@interface ItemCell2()
@property (nonatomic, strong) IBOutlet UIView * backView;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UIView * containerView;
@property (nonatomic, strong) IBOutlet UILabel * priceLabel;
@property (nonatomic, strong) IBOutlet UIButton * purchaseButton;
@end

@implementation ItemCell2
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"ItemCell2" owner:nil options:nil]firstObject];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.hasPurchased = NO;
    self.hasUsed = NO;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.purchaseButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action {
    if (!self.hasPurchased) {
        self.buyHandler(self.name, self.price);
    } else {
        if (!self.hasUsed) {
            self.useHandler(self.name, self.position);
        }
    }
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (void)setPosition:(NSString *)position {
    _position = position;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.imageView setImage:_image];
}

- (void)setPrice:(NSInteger)price {
    _price = price;
    [self.priceLabel setText:[NSString stringWithFormat:@"%ld", _price]];
}

- (void)setHasPurchased:(BOOL)hasPurchased {
    _hasPurchased = hasPurchased;
    [self setStatus];
}

- (void)setHasUsed:(BOOL)hasUsed {
    _hasUsed = hasUsed;
    [self setStatus];
}

- (void)setStatus {
    if (!self.hasPurchased) {
        self.purchaseButton.userInteractionEnabled = YES;
        [self.purchaseButton setTitle:@"购买" forState:UIControlStateNormal];
        [self.purchaseButton setBackgroundColor:defaultOrangeColor];
    } else {
        if (!self.hasUsed) {
            self.purchaseButton.userInteractionEnabled = YES;
            [self.purchaseButton setTitle:@"点击使用" forState:UIControlStateNormal];
            [self.purchaseButton setBackgroundColor:mainColor];
        } else {
            self.purchaseButton.userInteractionEnabled = NO;
            [self.purchaseButton setTitle:@"已使用" forState:UIControlStateNormal];
            [self.purchaseButton setBackgroundColor:defaultTransparentGrayColor1];
        }
    }
}
@end
