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
@property (nonatomic) NSInteger growthPoints;
@property (nonatomic) NSInteger goldCoins;
@property (nonatomic) NSInteger petLevel;

@property (nonatomic, strong) IBOutlet UIImageView * imageView;
@property (nonatomic, strong) IBOutlet UILabel * petNameLabel;

@property (nonatomic, strong) IBOutlet UILabel * growthPointsLabel;
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
    self.imageView.layer.cornerRadius = kIconSideLength;
    self.imageView.layer.masksToBounds = YES;
    //Buttons
    [self configureButton:self.howToPlayButton];
    [self configureButton:self.habitDevelopButton];
    [self configureButton:self.dressUpButton];
}

- (void)configureButton:(UIButton *)button {
    [self configureBackgroundWithButton:button];
    [self configureBorderWithButton:button];
}

- (void)configureBorderWithButton:(UIButton *)button {
    CGRect topRect = CGRectMake(0, -kMainButtonBorderWidth, kMainButtonBorderLength, kMainButtonBorderWidth);
    CGRect rightRect = CGRectMake(kMainButtonBorderLength, 0, kMainButtonBorderWidth, kMainButtonBorderHeight);
    CGRect bottomRect = CGRectMake(0, kMainButtonBorderHeight, kMainButtonBorderLength, kMainButtonBorderWidth);
    CGRect leftRect = CGRectMake(-kMainButtonBorderWidth, 0, kMainButtonBorderWidth, kMainButtonBorderHeight);
    CAShapeLayer * topLayer = [CAShapeLayer layer];
    CAShapeLayer * rightLayer = [CAShapeLayer layer];
    CAShapeLayer * bottomLayer = [CAShapeLayer layer];
    CAShapeLayer * leftLayer = [CAShapeLayer layer];
    [self configureLayer:topLayer inRect:topRect];
    [self configureLayer:rightLayer inRect:rightRect];
    [self configureLayer:bottomLayer inRect:bottomRect];
    [self configureLayer:leftLayer inRect:leftRect];
    [button.layer addSublayer:topLayer];
    [button.layer addSublayer:rightLayer];
    [button.layer addSublayer:bottomLayer];
    [button.layer addSublayer:leftLayer];
}

- (void)configureLayer:(CAShapeLayer *)layer inRect:(CGRect)rect{
    layer.lineWidth = 0;
    layer.strokeColor = defaultClearColor.CGColor;
    layer.fillColor = defaultGrayColor2.CGColor;
    
    CGMutablePathRef layerPath = CGPathCreateMutable();
    CGPathAddRect(layerPath, NULL, rect);
    layer.path = layerPath;
    
    CGPathRelease(layerPath);
}

- (void)configureBackgroundWithButton:(UIButton *)button {
    CAShapeLayer * backgroundLayer = [CAShapeLayer layer];
    CGMutablePathRef backgroundPath = CGPathCreateMutable();
    
    [backgroundLayer setFillColor:mainColor.CGColor];
    [backgroundLayer setStrokeColor:defaultClearColor.CGColor];
    backgroundLayer.lineWidth = 0;
    
    CGPathAddRect(backgroundPath, NULL, CGRectMake(kMainButtonBackgroundXOffset, kMainButtonBackgroundYOffset, kMainButtonBackgroundWidth, kMainButtonBackgroundHeight));
    backgroundLayer.path = backgroundPath;
    
    CGPathRelease(backgroundPath);
    
    [button.layer addSublayer:backgroundLayer];
}

#pragma mark Data
- (void)refreshData {
    self.growthPoints = [AppSettings sharedSettings].growthPoints;
    self.petName = [AppSettings sharedSettings].petName;
}

#pragma mark Methods of Setter
- (void)setPetName:(NSString *)petName {
    _petName = petName;
    [self.petNameLabel setText:_petName];
}

- (void)setGrowthPoint:(NSInteger)growthPoint {
    _growthPoints = growthPoint;
    [self.growthPointsLabel setText:[NSString stringWithFormat:@"%ld", (long)self.growthPoints]];
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
