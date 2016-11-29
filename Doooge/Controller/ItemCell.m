//
//  ItemCell.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/28.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ItemCell.h"


@interface ItemCell()
@property (nonatomic, strong) IBOutlet UIView * backView;
@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UIView * containerView;
@property (nonatomic, strong) IBOutlet UILabel * priceLabel;
@property (nonatomic, strong) IBOutlet UIButton * purchaseButton;
@end

@implementation ItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"ItemCell" owner:nil options:nil]firstObject];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self.purchaseButton removeTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.purchaseButton addTarget:self action:@selector(purchase) forControlEvents:UIControlEventTouchUpInside];
}

- (void)purchase {
    self.purchaseHandler(self.style, self.name, self.price);
}

- (void)setName:(NSString *)name {
    _name = name;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    [self.imageView setImage:_image];
}

- (void)setPrice:(NSInteger)price {
    _price = price;
    [self.priceLabel setText:[NSString stringWithFormat:@"%ld", _price]];
}

- (void)setStyle:(ItemCellStyle)style {
    _style = style;
    switch (_style) {
        case ItemCellFoodStyle:
            break;
        default:
            break;
    }
}
@end
