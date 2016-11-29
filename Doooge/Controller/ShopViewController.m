//
//  ShopViewController.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/26.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ShopViewController.h"

#import "AppSettings.h"
#import "ShopData.h"

#import "ItemCell.h"

@interface ShopViewController ()<UICollectionViewDelegate>{

}
@property (nonatomic, strong) IBOutlet UILabel * goldCoinLabel;
@property (nonatomic, strong) IBOutlet UICollectionView * foodView;
@property (nonatomic, strong) IBOutlet UICollectionView * toyView;
@property (nonatomic, strong) IBOutlet UICollectionView * decorateView;

@property (nonatomic, strong) ShopData * shopData;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [self updateGoldCoins:[AppSettings sharedSettings].goldCoins];
 
}

- (void)basicConfiguration {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.foodView.delegate = self;
    self.foodView.dataSource = self.shopData;
    [self.foodView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    self.toyView.delegate = self;
    self.foodView.dataSource = self.shopData;
    self.decorateView.delegate = self;
    self.decorateView.dataSource = self.shopData;
}

- (void)updateGoldCoins:(NSInteger)goldCoins {
    [self.goldCoinLabel setText:[NSString stringWithFormat:@"金币：%ld", goldCoins]];
}

- (ShopData *)shopData {
    if (!_shopData) {
        _shopData = [[ShopData alloc]init];
        ShopViewController * __weak weakSelf = self;
        _shopData.refreshGoinCoinsHandler = ^() {
            [weakSelf updateGoldCoins:[AppSettings sharedSettings].goldCoins];
        };
    }
    return _shopData;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
