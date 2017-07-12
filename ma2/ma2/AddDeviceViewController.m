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
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.deviceNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 150, 90, 30)];
    self.deviceIdLbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 230, 90, 30)];
    self.deviceNameTxtField = [[UITextField alloc] initWithFrame:CGRectMake(160, 150, 160, 30)];
    self.deviceIdTxtField = [[UITextField alloc] initWithFrame:CGRectMake(160, 230, 160, 30)];
    self.deviceNameTxtField.borderStyle = self.deviceIdTxtField.borderStyle = UITextBorderStyleLine;
    self.addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.addBtn.frame = CGRectMake(60, 320, 260, 30);
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    self.addBtn.backgroundColor = [UIColor blueColor];
    [self.addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:self.deviceIdLbl];
    [self.view addSubview:self.deviceNameLbl];
    [self.view addSubview:self.deviceIdTxtField];
    [self.view addSubview:self.deviceNameTxtField];
    [self.view addSubview:self.addBtn];
    
    self.deviceNameLbl.text = @"设备名称";
    self.deviceIdLbl.text = @"设备 ID";

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

// 隐藏键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.deviceNameTxtField resignFirstResponder];
    [self.deviceIdTxtField resignFirstResponder];
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
