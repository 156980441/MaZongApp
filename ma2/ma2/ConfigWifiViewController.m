//
//  ConfigWifiViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 2017/6/5.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "ConfigWifiViewController.h"

#import "YLToast.h"

#import <SystemConfiguration/CaptiveNetwork.h>

@interface ConfigWifiViewController ()
@property (nonatomic, copy) NSString* wifiName;
@end

@implementation ConfigWifiViewController

-(NSString*)wifiName
{
    if (!_wifiName) {
        id info = nil;
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        for (NSString *ifnam in ifs) {
            info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
            NSString *str = info[@"SSID"];
            NSString *str2 = info[@"BSSID"];
            NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
            _wifiName = [str copy];
        }
    }
    return _wifiName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.wifiTextField = [[UITextField alloc] init];
    self.passTextFiled = [[UITextField alloc] init];
    self.cofigBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.noteTextView = [[UITextView alloc] init];
    
    [self.view addSubview:self.passTextFiled];
    [self.view addSubview:self.wifiTextField];
    [self.view addSubview:self.cofigBtn];
    [self.view addSubview:self.noteTextView];

    self.wifiTextField.translatesAutoresizingMaskIntoConstraints =
    self.passTextFiled.translatesAutoresizingMaskIntoConstraints =
    self.noteTextView.translatesAutoresizingMaskIntoConstraints =
    self.cofigBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *name_top = [NSLayoutConstraint constraintWithItem:self.wifiTextField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:statusHeight + navHeight + 80];
    NSLayoutConstraint *name_left = [NSLayoutConstraint constraintWithItem:self.wifiTextField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *name_right = [NSLayoutConstraint constraintWithItem:self.wifiTextField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *name_hight = [NSLayoutConstraint constraintWithItem:self.wifiTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *pass_top = [NSLayoutConstraint constraintWithItem:self.passTextFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.wifiTextField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *pass_left = [NSLayoutConstraint constraintWithItem:self.passTextFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.wifiTextField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_right = [NSLayoutConstraint constraintWithItem:self.passTextFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.wifiTextField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *pass_hight = [NSLayoutConstraint constraintWithItem:self.passTextFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.wifiTextField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bt_top = [NSLayoutConstraint constraintWithItem:self.cofigBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passTextFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *bt_left = [NSLayoutConstraint constraintWithItem:self.cofigBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.passTextFiled attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_right = [NSLayoutConstraint constraintWithItem:self.cofigBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.passTextFiled attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_hight = [NSLayoutConstraint constraintWithItem:self.cofigBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.passTextFiled attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *text_height = [NSLayoutConstraint constraintWithItem:self.noteTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:60];
    NSLayoutConstraint *text_left = [NSLayoutConstraint constraintWithItem:self.noteTextView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.passTextFiled attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *text_right = [NSLayoutConstraint constraintWithItem:self.noteTextView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.passTextFiled attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *text_bottom = [NSLayoutConstraint constraintWithItem:self.noteTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-80];
    
    NSArray *array = [NSArray arrayWithObjects:
                      name_top, name_left, name_right, name_hight,
                      pass_top,pass_left,pass_right,pass_hight,
                      bt_top,bt_left,bt_right,bt_hight,
                      text_left,text_right,text_bottom,text_height,
                      nil];
    [self.view addConstraints:array];
    
    self.wifiTextField.placeholder = @"请输入 Wi-Fi 名称";
    self.passTextFiled.placeholder = @"请输入 Wi-Fi 密码";
    
    self.wifiTextField.borderStyle = self.passTextFiled.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.cofigBtn setTitle:@"配置" forState:UIControlStateNormal];
    self.cofigBtn.layer.cornerRadius = 5;
    self.cofigBtn.tintColor = [UIColor whiteColor];
    [self.cofigBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    self.wifiTextField.text = self.wifiName;
    self.noteTextView.text = @"注意：为确保成功配置，请确保设备和您的移动设备处于同一个 Wi-Fi网络下";
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 隐藏键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.wifiTextField resignFirstResponder];
    [self.passTextFiled resignFirstResponder];
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
