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
#import "ItemCell2.h"

@interface ShopViewController ()<UICollectionViewDelegate>{

}
@property (nonatomic, strong) IBOutlet UILabel * goldCoinLabel;
@property (nonatomic, strong) IBOutlet UICollectionView * foodView;
@property (nonatomic, strong) IBOutlet UICollectionView * toyView;
@property (nonatomic, strong) IBOutlet UICollectionView * decorateView;

@property (nonatomic, strong) UIBarButtonItem * backButton;

@property (nonatomic, strong) ShopData * shopData;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self loadBarButton];
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
    self.toyView.dataSource = self.shopData;
    [self.toyView registerClass:[ItemCell class] forCellWithReuseIdentifier:@"ItemCell"];
    self.decorateView.delegate = self;
    self.decorateView.dataSource = self.shopData;
    [self.decorateView registerClass:[ItemCell2 class] forCellWithReuseIdentifier:@"ItemCell2"];
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

- (void)loadBarButton {
    self.navigationItem.leftBarButtonItem = self.backButton;
}

- (UIBarButtonItem *)backButton {
    if (!_backButton) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17.0];
        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -3, 0, 0);
        [button sizeToFit];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        _backButton = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    return _backButton;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
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
