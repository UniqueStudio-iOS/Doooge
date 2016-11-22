//
//  EditNameViewController.m
//  Doooge
//
//  Created by BlackDragon on 2016/10/29.
//  Copyright © 2016年 BlackDragon. All rights reserved.
//

#import "EditNameViewController.h"

@interface EditNameViewController ()<UITextFieldDelegate>
@property (nonatomic, strong) UIBarButtonItem * completeButton;
@property (nonatomic, strong) UIBarButtonItem * backButton;
@property (nonatomic, strong) UITextField * editText;
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
    self.editText.delegate = self;
    [self gestureConfiguration];
}

- (void)loadBarButton {
    self.navigationItem.rightBarButtonItem = self.completeButton;
    self.navigationItem.leftBarButtonItem = self.backButton;
}
#pragma mark Lazy Load
- (UIBarButtonItem *)completeButton {
    if (!_completeButton) {
        _completeButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(completeEdit)];
        _completeButton.tintColor = mainColor;
    }
    return _completeButton;
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
#pragma mark Interact
- (void)completeEdit {
    self.nameEditedHandler(self.editText.text);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)gestureConfiguration {
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];
}

- (void)dismissKeyboard{
    [self.editText resignFirstResponder];
}
#pragma mark TextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}
@end
