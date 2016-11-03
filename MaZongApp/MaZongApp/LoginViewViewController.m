//
//  LoginViewViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "LoginViewViewController.h"
#import "User.h"

#import "YLToast.h"
#import "YLCommon.h"

#import "stdafx_MaZongApp.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"

@interface LoginViewViewController ()

@end

@implementation LoginViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    
    // test
    
    self.nameTxt.text = @"admin5";
    self.passTxt.text = @"123456";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginBtnPress:(id)sender {
    if ([self.passTxt.text isEqualToString:@""]|| [self.nameTxt.text isEqualToString:@""]) {
        [YLToast showWithText:@"账号或者密码为空"];
    }
    else {
        [self checkuser:self.nameTxt.text withPass:self.passTxt.text];
    }
}
-(void)checkuser:(NSString*)name withPass:(NSString*)pass
{
    NSString* jsonData = [NSString stringWithFormat:@"\"USER_NAME\":\"%@\",\"PASSWORD\":\"%@\"",name,pass];
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:jsonData,@"jsonData",nil];
    [[AFHTTPSessionManager manager] POST:URL_USER_LOGIN parameters:dic success:^(NSURLSessionDataTask *task, id responseObject) {
        if([responseObject isKindOfClass:[NSDictionary class]]) {
            NSString* result = [(NSDictionary*)responseObject objectForKey:@"result"];
            if ([result isEqualToString:@"success"]) {
                self.user.name = name;
                self.user.pass = pass;
                [self saveToArchiver:self.user];
                
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            else {
                [YLToast showWithText:result];
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
    }];
}
- (BOOL)saveToArchiver:(User*)user {
    NSString* fileName = [YLCommon docPath:@"user.archiver"];
    NSMutableData* data = [NSMutableData data];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:user forKey:@"login_user"];
    [archiver finishEncoding];
    return [data writeToFile:fileName atomically:YES];
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
