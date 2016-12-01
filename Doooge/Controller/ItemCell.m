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
    self.hasPurchased = NO;
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
}

- (void)setHasPurchased:(BOOL)hasPurchased {
    _hasPurchased = hasPurchased;
    if (self.style == ItemCellToyStyle) {
        if (_hasPurchased) {
            [self.purchaseButton setTitle:@"已购买" forState:UIControlStateNormal];
            [self.purchaseButton setBackgroundColor:defaultTransparentGrayColor1];
            self.purchaseButton.userInteractionEnabled = NO;
            [self.backView setBackgroundColor:defaultTransparentGrayColor1];
            [self.contentView insertSubview:self.imageView belowSubview:self.backView];
            [self.containerView setHidden:YES];
        } else {
            [self.purchaseButton setTitle:@"购买" forState:UIControlStateNormal];
            [self.purchaseButton setBackgroundColor:defaultOrangeColor];
            self.purchaseButton.userInteractionEnabled = YES;
            [self.backView setBackgroundColor:mainColor];
            [self.contentView insertSubview:self.imageView aboveSubview:self.backView];
            [self.contentView setHidden:NO];
        }
    }
}
@end
