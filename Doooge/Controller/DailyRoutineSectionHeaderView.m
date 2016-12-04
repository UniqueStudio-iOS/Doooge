//
//  DailyRoutineSectionHeaderView.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/16.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "DailyRoutineSectionHeaderView.h"

@interface DailyRoutineSectionHeaderView()
@property (nonatomic, strong) IBOutlet UIButton * packButton;
@end

@implementation DailyRoutineSectionHeaderView
#pragma mark - Initialize
- (void)awakeFromNib {
    [super awakeFromNib];
    self.isPacked = NO;
}
#pragma mark - Actions
- (IBAction)didPressPackButton:(UIButton *)packButton {
    self.isPacked = !self.isPacked;
    [UIView animateWithDuration:0.50 delay:0.10 usingSpringWithDamping:1.00 initialSpringVelocity:1.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.packButton.transform = CGAffineTransformRotate(self.packButton.transform, M_PI);
        self.packButtonPressedHandler(self.isPacked);
    } completion:^(BOOL finished) {
        
    }];
}
@end
