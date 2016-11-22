//
//  HabitDevelopSectionHeaderView.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "HabitDevelopSectionHeaderView.h"
#import "Masonry.h"

@interface HabitDevelopSectionHeaderView()
@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIButton * addButton;
@end

@implementation HabitDevelopSectionHeaderView
- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    [self.titleLabel setText:_title];
}

- (void)setHasAdd:(BOOL)hasAdd {
    _hasAdd =               hasAdd;
    if (_hasAdd) {
        [self.addButton setHidden:NO];
    } else {
        [self.addButton setHidden:YES];
    }
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        _titleLabel.textColor = [UIColor colorWithRed:0 green:0.722 blue:0.714 alpha:1];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(25);
            make.left.equalTo(self.contentView.mas_left).with.offset(25);
        }];
    }
    return _titleLabel;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _addButton.tintColor = [UIColor colorWithRed:0 green:0.722 blue:0.714 alpha:1];
        [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [self.contentView addSubview:_addButton];
        [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel.mas_centerY);
            make.right.equalTo(self.contentView).with.offset(-13);
            make.width.mas_equalTo(@25);
            make.height.mas_equalTo(@25);
        }];
    }
    return _addButton;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc]init];
        [self addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return _contentView;
}

- (void)addButtonTarget:(id)target action:(SEL)sel forControlEvents:(UIControlEvents)event {
    [self.addButton addTarget:target action:sel forControlEvents:event];
}
@end
