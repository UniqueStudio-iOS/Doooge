//
//  MainViewController.m
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import "MainViewController.h"
#import "EditNameViewController.h"

#import "DooogeUserDefaults.h"
#import "DooogeNotificationCenter.h"

@interface MainViewController ()
@property (nonatomic, strong) NSString * name;
@property (nonatomic) NSInteger growthPoint;

@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UILabel * nameLabel;

@property (nonatomic, strong) IBOutlet UILabel * growthPointLabel;
@property (nonatomic, strong) IBOutlet UIButton * editNameButton;
@property (nonatomic, strong) IBOutlet UIButton * howToPlayButton;
@property (nonatomic, strong) IBOutlet UIButton * habitDevelopButton;
@property (nonatomic, strong) IBOutlet UIButton * dressUpButton;

@end

@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self advancedUIConfiguration];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIConfiguration
- (void)advancedUIConfiguration {
    //ImageView
    self.imageView.layer.cornerRadius = kIconSideLength/2;
    self.imageView.layer.masksToBounds = YES;
    //Buttons
    self.howToPlayButton.layer.borderWidth = 2.5;
    self.howToPlayButton.layer.borderColor = [UIColor colorWithWhite:0.278 alpha:1].CGColor;
    [self.howToPlayButton.layer addSublayer:[self backgroundLayer]];
    self.habitDevelopButton.layer.borderWidth = 2.5;
    self.habitDevelopButton.layer.borderColor = [UIColor colorWithWhite:0.278 alpha:1].CGColor;
    [self.habitDevelopButton.layer addSublayer:[self backgroundLayer]];
    self.dressUpButton.layer.borderWidth = 2.5;
    self.dressUpButton.layer.borderColor = [UIColor colorWithWhite:0.278 alpha:1].CGColor;
    [self.dressUpButton.layer addSublayer:[self backgroundLayer]];
}

- (void)configureStyleWithButton:(UIButton *)button {
    [button.layer addSublayer:[self backgroundLayer]];
}

- (CAShapeLayer *)backgroundLayer {
    CAShapeLayer * backgroundLayer = [CAShapeLayer layer];
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    [backgroundLayer setFillColor:[UIColor colorWithRed:0 green:0.722 blue:0.714 alpha:1].CGColor];
    [backgroundLayer setStrokeColor:[UIColor clearColor].CGColor];
    backgroundLayer.lineWidth = 0;
    CGPathAddRect(backgroundPath, NULL, CGRectMake(8, 7, 229, 32.5));
    backgroundLayer.path = backgroundPath;
    CGPathRelease(backgroundPath);
    return backgroundLayer;
}

- (void)refreshData {
    self.name = [[DooogeUserDefaults dooogeUserDefaults]nameForPet];
    [self.nameLabel setText:self.name];
    self.growthPoint = [[DooogeUserDefaults dooogeUserDefaults]growthPointForPet];
    [self.growthPointLabel setText:[NSString stringWithFormat:@"%ld", (long)self.growthPoint]];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromMainToEdit"]) {
        EditNameViewController * destViewController = (EditNameViewController *)segue.destinationViewController;
        destViewController.editedBlock = ^(NSString * name) {
            self.name = name;
            self.nameLabel.text = name;
            [[DooogeUserDefaults dooogeUserDefaults]setNameForPet:name];
            [[DooogeNotificationCenter currentNotificationCenter]requestAllHealthyRoutines];
        };
    }
}


@end
