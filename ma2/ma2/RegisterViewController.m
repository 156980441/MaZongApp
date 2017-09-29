//
//  RegisterViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "RegisterViewController.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = NO;
    
    self.nameTxtField = [[UITextField alloc] init];
    self.passTxtFiled = [[UITextField alloc] init];
    self.confirmPassTxtFiled = [[UITextField alloc] init];
    self.deviceIDTxtField = [[UITextField alloc] init];
    self.mailTxtField = [[UITextField alloc] init];
    self.validTxtField = [[UITextField alloc] init];
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.confirmBtn.layer.cornerRadius = 5;
    self.confirmBtn.tintColor = [UIColor whiteColor];
    [self.confirmBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    
    self.nameTxtField.borderStyle = self.passTxtFiled.borderStyle = self.deviceIDTxtField.borderStyle = self.confirmPassTxtFiled.borderStyle = self.validTxtField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.nameTxtField.placeholder = @"请输入用户名";
    self.passTxtFiled.placeholder = @"请输入密码";
    self.confirmPassTxtFiled.placeholder = @"请再次输入密码";
    self.deviceIDTxtField.placeholder = @"请输入设备 ID";
    self.validTxtField.placeholder = @"请输入验证码";
    self.mailTxtField.placeholder = @"请输入您的邮箱";
    
    [self.view addSubview:self.nameTxtField];
    [self.view addSubview:self.passTxtFiled];
    [self.view addSubview:self.confirmPassTxtFiled];
    [self.view addSubview:self.deviceIDTxtField];
    [self.view addSubview:self.validTxtField];
    [self.view addSubview:self.mailTxtField];
    [self.view addSubview:self.confirmBtn];
    
    self.nameTxtField.translatesAutoresizingMaskIntoConstraints =
    self.passTxtFiled.translatesAutoresizingMaskIntoConstraints =
    self.confirmPassTxtFiled.translatesAutoresizingMaskIntoConstraints =
    self.deviceIDTxtField.translatesAutoresizingMaskIntoConstraints =
    self.deviceIDTxtField.translatesAutoresizingMaskIntoConstraints =
    self.validTxtField.translatesAutoresizingMaskIntoConstraints =
    self.mailTxtField.translatesAutoresizingMaskIntoConstraints =
    self.confirmBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *name_top = [NSLayoutConstraint constraintWithItem:self.nameTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:statusHeight + navHeight + 30];
    NSLayoutConstraint *name_left = [NSLayoutConstraint constraintWithItem:self.nameTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *name_right = [NSLayoutConstraint constraintWithItem:self.nameTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *name_hight = [NSLayoutConstraint constraintWithItem:self.nameTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *pass_top = [NSLayoutConstraint constraintWithItem:self.passTxtFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *pass_left = [NSLayoutConstraint constraintWithItem:self.passTxtFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_right = [NSLayoutConstraint constraintWithItem:self.passTxtFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_hight = [NSLayoutConstraint constraintWithItem:self.passTxtFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *firm_top = [NSLayoutConstraint constraintWithItem:self.confirmPassTxtFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passTxtFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *firm_left = [NSLayoutConstraint constraintWithItem:self.confirmPassTxtFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *firm_right = [NSLayoutConstraint constraintWithItem:self.confirmPassTxtFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *firm_hight = [NSLayoutConstraint constraintWithItem:self.confirmPassTxtFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *id_top = [NSLayoutConstraint constraintWithItem:self.deviceIDTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.confirmPassTxtFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *id_left = [NSLayoutConstraint constraintWithItem:self.deviceIDTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *id_right = [NSLayoutConstraint constraintWithItem:self.deviceIDTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *id_hight = [NSLayoutConstraint constraintWithItem:self.deviceIDTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *mail_top = [NSLayoutConstraint constraintWithItem:self.mailTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.deviceIDTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *mail_left = [NSLayoutConstraint constraintWithItem:self.mailTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *mail_right = [NSLayoutConstraint constraintWithItem:self.mailTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *mail_hight = [NSLayoutConstraint constraintWithItem:self.mailTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *vali_top = [NSLayoutConstraint constraintWithItem:self.validTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mailTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *vali_left = [NSLayoutConstraint constraintWithItem:self.validTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *vali_right = [NSLayoutConstraint constraintWithItem:self.validTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *vali_hight = [NSLayoutConstraint constraintWithItem:self.validTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bt_top = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.validTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *bt_left = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_right = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.nameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_hight = [NSLayoutConstraint constraintWithItem:self.confirmBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.nameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSArray *array = [NSArray arrayWithObjects:
                      name_top, name_left, name_right, name_hight,
                      pass_top,pass_left,pass_right,pass_hight,
                      firm_top,firm_left,firm_right,firm_hight,
                      id_top,id_left,id_right,id_hight,
                      vali_top,vali_left,vali_right,vali_hight,
                      mail_top,mail_left,mail_right,mail_hight,
                      bt_top,bt_left,bt_right,bt_hight,
                      nil];
    [self.view addConstraints:array];
    
    
    [self.confirmBtn addTarget:self action:@selector(confirmBtnPress:) forControlEvents:UIControlEventTouchDown];
    
#ifdef LOC_TEST
    self.nameTxtField.text = @"fanyl";
    self.passTxtFiled.text = @"123";
    self.confirmPassTxtFiled.text = @"123";
    self.deviceIDTxtField.text = @"FYL201688888888";
    self.validTxtField.text = @"aaa";
    self.mailTxtField.text = @"156980441@qq.com";
#else
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)confirmBtnPress:(id)sender {
#ifdef LOC_TEST
    [self.navigationController popViewControllerAnimated:YES];
#else
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:self.nameTxtField.text,@"USER_NAME",self.passTxtFiled.text,@"PASSWORD", nil];
    
    [manager POST:URL_USER_REGISTER parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"POST请求完成,%@",responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
#endif
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
