//
//  ShopViewController.m
//  Doooge
//
//  Created by 陈志浩 on 2016/11/26.
//  Copyright © 2016年 VicChan. All rights reserved.
//

#import "ShopViewController.h"

@interface ShopViewController ()
@property (nonatomic, strong) IBOutlet UILabel * goldCoinLabel;
@property (nonatomic, strong) IBOutlet UICollectionView * foodView;
@property (nonatomic, strong) IBOutlet UICollectionView * toyView;
@property (nonatomic, strong) IBOutlet UICollectionView * decorateView;
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
