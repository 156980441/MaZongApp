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
    
    self.wifiTextField.text = self.wifiName;
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

- (IBAction)configWifiBtn:(id)sender
{
    [YLToast showWithText:@"配置成功"];
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
