//
//  EditNameViewController.m
//  Doooge
//
//  Created by 陈志浩 on 2016/10/29.
//  Copyright © 2016年 placeholder. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()
@property (nonatomic, strong) UIBarButtonItem * completeButton;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) IBOutlet UITextField * editText;
@end

@implementation EditNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self basicConfiguration];
    [self loadBarButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)basicConfiguration {
    self.tableView.tableFooterView = [[UIView alloc]init];
}

- (void)loadBarButton {
    self.navigationItem.rightBarButtonItem = self.completeButton;
//    self.navigationItem.leftBarButtonItem = self.backButton;
}
#pragma mark Lazy Load
- (UIBarButtonItem *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeEdit)];
        _completeButton.tintColor = mainColor;
    }
    return _completeButton;
}

//- (UIBarButtonItem *)backButton {
//    if (!_backButton) {
//        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
//        [button setTitle:@"返回" forState:UIControlStateNormal];
//    }
//    return _backButton;
//}
#pragma mark Interact
- (void)completeEdit {
    self.editedBlock(self.editText.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
