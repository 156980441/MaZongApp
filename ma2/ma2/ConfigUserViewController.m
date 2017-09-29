//
//  ConfigUserViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 2017/6/5.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "ConfigUserViewController.h"

@interface ConfigUserViewController ()

@end

@implementation ConfigUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改密码";
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.oldTextField = [[UITextField alloc] init];
    self.currentTextFiled = [[UITextField alloc] init];
    self.confirmTextFiled = [[UITextField alloc] init];
    self.modfiyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    self.oldTextField.borderStyle = self.currentTextFiled.borderStyle = self.confirmTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    [self.modfiyBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.modfiyBtn.layer.cornerRadius = 5;
    self.modfiyBtn.tintColor = [UIColor whiteColor];
    [self.modfiyBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    
    [self.view addSubview:self.oldTextField];
    [self.view addSubview:self.currentTextFiled];
    [self.view addSubview:self.confirmTextFiled];
    [self.view addSubview:self.modfiyBtn];
    
    self.oldTextField.translatesAutoresizingMaskIntoConstraints =
    self.currentTextFiled.translatesAutoresizingMaskIntoConstraints =
    self.confirmTextFiled.translatesAutoresizingMaskIntoConstraints =
    self.modfiyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *name_top = [NSLayoutConstraint constraintWithItem:self.oldTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:statusHeight + navHeight + 80];
    NSLayoutConstraint *name_left = [NSLayoutConstraint constraintWithItem:self.oldTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *name_right = [NSLayoutConstraint constraintWithItem:self.oldTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *name_hight = [NSLayoutConstraint constraintWithItem:self.oldTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *pass_top = [NSLayoutConstraint constraintWithItem:self.currentTextFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.oldTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *pass_left = [NSLayoutConstraint constraintWithItem:self.currentTextFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.oldTextField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_right = [NSLayoutConstraint constraintWithItem:self.currentTextFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.oldTextField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_hight = [NSLayoutConstraint constraintWithItem:self.currentTextFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.oldTextField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *firm_top = [NSLayoutConstraint constraintWithItem:self.confirmTextFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.currentTextFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *firm_left = [NSLayoutConstraint constraintWithItem:self.confirmTextFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.currentTextFiled attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *firm_right = [NSLayoutConstraint constraintWithItem:self.confirmTextFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.currentTextFiled attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *firm_hight = [NSLayoutConstraint constraintWithItem:self.confirmTextFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.currentTextFiled attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bt_top = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.confirmTextFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *bt_left = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.confirmTextFiled attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_right = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.confirmTextFiled attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_hight = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.confirmTextFiled attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSArray *array = [NSArray arrayWithObjects:
                      name_top, name_left, name_right, name_hight,
                      pass_top,pass_left,pass_right,pass_hight,
                      firm_top,firm_left,firm_right,firm_hight,
                      bt_top,bt_left,bt_right,bt_hight,
                      nil];
    [self.view addConstraints:array];
    
    self.oldTextField.placeholder = @"请输入原始密码";
    self.currentTextFiled.placeholder = @"请输入新密码";
    self.confirmTextFiled.placeholder = @"请确认新密码";
    
#ifdef LOC_TEST
    self.deviceIdTxtField.text = @"111";
    self.deviceNameTxtField.text = @"有二三四五六";
#else
#endif
    
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
