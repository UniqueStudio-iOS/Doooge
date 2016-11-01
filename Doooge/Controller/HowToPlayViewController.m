//
//  HowToPlayViewController.m
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import "HowToPlayViewController.h"

@interface HowToPlayViewController ()
@property (nonatomic, strong) UIImageView * dragDownImageView;
@end

@implementation HowToPlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureDragDownImage {
//    self.navigationController.navigationItem.titleView
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
