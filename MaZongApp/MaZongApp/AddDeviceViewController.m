//
//  AddDeviceViewController.m
//  MaZongApp
//
//  Created by 赵雪莹 on 2016/11/13.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "AddDeviceViewController.h"
#import "User.h"
#import "YLToast.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPRequestOperationManager.h"

@interface AddDeviceViewController ()

@end

@implementation AddDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"添加设备";
    self.deviceIdTxtField.text = @"111";
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
    
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:self.deviceIdTxtField.text,@"MACHINE_ID",self.deviceNameTxtField.text,@"MACHINE_TITLE",[NSString stringWithFormat:@"%zd",g_user.userNo],@"USER_NO", nil];
    
    [manager POST:URL_ADD_DEVICE parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"POST请求完成,%@",responseObject);
        NSDictionary* dic = (NSDictionary*)responseObject;
        NSString* detail = [dic objectForKey:@"message"];
        NSInteger statusCode = ((NSNumber*)[dic objectForKey:@"statusCode"]).integerValue;
        [YLToast showWithText:detail];
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
