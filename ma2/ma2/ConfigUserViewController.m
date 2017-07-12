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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.oldLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 90, 30)];
    self.currentLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 230, 90, 30)];
    self.confirmLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 310, 90, 30)];
    self.oldTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 150, 160, 30)];
    self.currentTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(160, 230, 160, 30)];
    self.confirmTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(160, 310, 160, 30)];
    self.oldTextField.borderStyle = self.currentTextFiled.borderStyle = self.confirmTextFiled.borderStyle = UITextBorderStyleLine;
    self.modfiyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.modfiyBtn.frame = CGRectMake(60, 380, 260, 30);
    [self.modfiyBtn setTitle:@"修改" forState:UIControlStateNormal];
    self.modfiyBtn.backgroundColor = [UIColor blueColor];
    
    [self.view addSubview:self.oldLbl];
    [self.view addSubview:self.currentLbl];
    [self.view addSubview:self.confirmLbl];
    [self.view addSubview:self.oldTextField];
    [self.view addSubview:self.currentTextFiled];
    [self.view addSubview:self.confirmTextFiled];
    [self.view addSubview:self.modfiyBtn];
    
    self.oldLbl.text = @"旧密码";
    self.currentLbl.text = @"新密码";
    self.confirmLbl.text = @"确认密码";
    
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
