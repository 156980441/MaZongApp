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
    
    self.nameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(37, 90, 300, 30)];
    self.passTxtFiled = [[UITextField alloc] initWithFrame:CGRectMake(37, 150, 300, 30)];
    self.confirmPassTxtFiled = [[UITextField alloc] initWithFrame:CGRectMake(37, 210, 300, 30)];
    self.deviceIDTxtField = [[UITextField alloc] initWithFrame:CGRectMake(37, 270, 300, 30)];
    self.validTxtField = [[UITextField alloc] initWithFrame:CGRectMake(37, 330, 300, 30)];
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.confirmBtn.frame = CGRectMake(37, 400, 300, 30);
    
    self.confirmBtn.backgroundColor = [UIColor blueColor];
    self.confirmBtn.tintColor = [UIColor whiteColor];
    [self.confirmBtn setTitle:@"注册" forState:UIControlStateNormal];
    self.nameTxtField.borderStyle = self.passTxtFiled.borderStyle = self.deviceIDTxtField.borderStyle = self.confirmPassTxtFiled.borderStyle = self.validTxtField.borderStyle = UITextBorderStyleLine;
    
    self.nameTxtField.placeholder = @"请输入用户名";
    self.passTxtFiled.placeholder = @"请输入密码";
    self.confirmPassTxtFiled.placeholder = @"请再次输入密码";
    self.deviceIDTxtField.placeholder = @"请输入设备 ID";
    self.validTxtField.placeholder = @"请输入验证码";
    
    [self.view addSubview:self.nameTxtField];
    [self.view addSubview:self.passTxtFiled];
    [self.view addSubview:self.confirmPassTxtFiled];
    [self.view addSubview:self.deviceIDTxtField];
    [self.view addSubview:self.validTxtField];
    [self.view addSubview:self.confirmBtn];
    
    [self.confirmBtn addTarget:self action:@selector(confirmBtnPress:) forControlEvents:UIControlEventTouchDown];
    
#ifdef LOC_TEST
    self.nameTxtField.text = @"fanyl";
    self.passTxtFiled.text = @"123";
    self.confirmPassTxtFiled.text = @"123";
    self.deviceIDTxtField.text = @"FYL201688888888";
    self.validTxtField.text = @"aaa";
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
