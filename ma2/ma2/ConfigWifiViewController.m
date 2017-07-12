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
    
    self.wifiLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 90, 30)];
    self.passLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 230, 90, 30)];
    self.wifiTextField = [[UITextField alloc] initWithFrame:CGRectMake(160, 150, 160, 30)];
    self.passTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(160, 230, 160, 30)];
    self.wifiTextField.borderStyle = self.passTextFiled.borderStyle = UITextBorderStyleBezel;
    self.cofigBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cofigBtn.frame = CGRectMake(60, 320, 260, 30);
    [self.cofigBtn setTitle:@"配置" forState:UIControlStateNormal];
    self.cofigBtn.backgroundColor = [UIColor blueColor];
    self.noteTextView = [[UITextView alloc] initWithFrame:CGRectMake(60, 550, 260, 70)];
    
    [self.view addSubview:self.wifiLbl];
    [self.view addSubview:self.passLbl];
    [self.view addSubview:self.passTextFiled];
    [self.view addSubview:self.wifiTextField];
    [self.view addSubview:self.cofigBtn];
    [self.view addSubview:self.noteTextView];
    
    self.wifiLbl.text = @"Wi-Fi 名称";
    self.passLbl.text = @"Wi-Fi 密码";
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
