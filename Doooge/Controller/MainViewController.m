//
//  MainViewController.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "MainViewController.h"
#import "EditNameViewController.h"

#import "AppSettings.h"
#import "AppNotificationCenter.h"

@interface MainViewController ()
@property (nonatomic, strong) NSString * petName;
@property (nonatomic) NSInteger growthPoint;

@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UILabel * petNameLabel;

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UI
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
#pragma mark Data
- (void)refreshData {
    self.petName = [AppSettings sharedSettings].petName;
    self.growthPoint = [AppSettings sharedSettings].growthPoints;
}

#pragma mark Methods of Setter
- (void)setPetName:(NSString *)petName {
    _petName = petName;
    [self.petNameLabel setText:_petName];
}

- (void)setGrowthPoint:(NSInteger)growthPoint {
    _growthPoint = growthPoint;
    [self.growthPointLabel setText:[NSString stringWithFormat:@"%ld", (long)self.growthPoint]];
}
#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"fromMainToEdit"]) {
        EditNameViewController * destViewController = (EditNameViewController *)segue.destinationViewController;
        destViewController.nameEditedHandler = ^(NSString * petName) {
            self.petName = petName;
            [AppSettings sharedSettings].petName = petName;
        };
    }
}


@end
