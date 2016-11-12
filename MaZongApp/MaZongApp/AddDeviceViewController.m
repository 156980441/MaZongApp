//
//  AddDeviceViewController.m
//  MaZongApp
//
//  Created by 赵雪莹 on 2016/11/13.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "AddDeviceViewController.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPRequestOperationManager.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加设备";
    self.deviceIdTxtField.text = @"fanyl201788888888";
    self.deviceNameTxtField.text = @"有二三四五六";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addDeviceBtnPress:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:self.deviceIdTxtField.text,@"MACHINE_ID",self.deviceNameTxtField.text,@"MACHINE_TITLE",@"5",@"USER_NO", nil];
    
    [manager POST:URL_ADD_DEVICE parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"POST请求完成,%@",responseObject);
        
        [self.navigationController popViewControllerAnimated:YES];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
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
