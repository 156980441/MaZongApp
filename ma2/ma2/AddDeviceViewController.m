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
    
    self.deviceNameTxtField = [[UITextField alloc] init];
    self.deviceIdTxtField = [[UITextField alloc] init];
    self.deviceNameTxtField.borderStyle = self.deviceIdTxtField.borderStyle = UITextBorderStyleRoundedRect;
    self.addBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.addBtn setTitle:@"添加" forState:UIControlStateNormal];
    [self.addBtn addTarget:self action:@selector(addDeviceBtnPress:) forControlEvents:UIControlEventTouchDown];
    self.addBtn.layer.cornerRadius = 5;
    self.addBtn.tintColor = [UIColor whiteColor];
    [self.addBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    
    [self.view addSubview:self.deviceIdTxtField];
    [self.view addSubview:self.deviceNameTxtField];
    [self.view addSubview:self.addBtn];
    
    self.deviceNameTxtField.translatesAutoresizingMaskIntoConstraints =
    self.deviceIdTxtField.translatesAutoresizingMaskIntoConstraints =
    self.addBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *name_top = [NSLayoutConstraint constraintWithItem:self.deviceNameTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:statusHeight + navHeight + 80];
    NSLayoutConstraint *name_left = [NSLayoutConstraint constraintWithItem:self.deviceNameTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *name_right = [NSLayoutConstraint constraintWithItem:self.deviceNameTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *name_hight = [NSLayoutConstraint constraintWithItem:self.deviceNameTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *id_top = [NSLayoutConstraint constraintWithItem:self.deviceIdTxtField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.deviceNameTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *id_left = [NSLayoutConstraint constraintWithItem:self.deviceIdTxtField attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.deviceNameTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *id_right = [NSLayoutConstraint constraintWithItem:self.deviceIdTxtField attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.deviceNameTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *id_hight = [NSLayoutConstraint constraintWithItem:self.deviceIdTxtField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.deviceNameTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSLayoutConstraint *bt_top = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.deviceIdTxtField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *bt_left = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.deviceIdTxtField attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_right = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.deviceIdTxtField attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_hight = [NSLayoutConstraint constraintWithItem:self.addBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.deviceIdTxtField attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSArray *array = [NSArray arrayWithObjects:
                      name_top, name_left, name_right, name_hight,
                      id_top,id_left,id_right,id_hight,
                      bt_top,bt_left,bt_right,bt_hight,
                      nil];
    [self.view addConstraints:array];
    
    self.deviceNameTxtField.placeholder = @"请输入设备名称";
    self.deviceIdTxtField.placeholder = @"请输入设备 ID";

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
- (void)addDeviceBtnPress:(id)sender {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:self.deviceIdTxtField.text,@"MACHINE_ID",self.deviceNameTxtField.text,@"MACHINE_TITLE",[NSString stringWithFormat:@"%zd",g_user.userNo],@"USER_NO", nil];
    
    [manager POST:URL_ADD_DEVICE parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
        NSDictionary* dic = (NSDictionary*)responseObject;
        NSString* detail = [dic objectForKey:@"message"];
        NSInteger statusCode = ((NSNumber*)[dic objectForKey:@"statusCode"]).integerValue;
        
        if (statusCode == 300) {
            
        } else if (statusCode == 200) {
            
        }
        
        [YLToast showWithText:detail];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [YLToast showWithText:@"网络请求失败"];
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
