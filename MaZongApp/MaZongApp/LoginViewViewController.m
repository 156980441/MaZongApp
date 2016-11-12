//
//  LoginViewViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "LoginViewViewController.h"
#import "User.h"
#import "MainViewController.h"

#import "YLToast.h"
#import "YLCommon.h"

#import "stdafx_MaZongApp.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

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
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:name,@"USER_NAME",pass,@"PASSWORD", nil];
    
    [manager POST:URL_USER_LOGIN parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"POST请求完成,%@",responseObject);
        NSDictionary* jsonData = (NSDictionary*)responseObject;
        NSDictionary* admin_dic = [jsonData objectForKey:@"admin"];
        self.user = [[User alloc] init];
        self.user.name = [admin_dic objectForKey:@"username"];
        self.user.pass = [admin_dic objectForKey:@"password"];
        self.user.userNo = ((NSNumber*)[admin_dic objectForKey:@"userNo"]).integerValue;
        [self saveToArchiver:self.user];
        [self performSegueWithIdentifier:@"login" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         [YLToast showWithText:@"网络连接失败，请检查网络配置"];
        
    }];
    
//    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    session.requestSerializer = [AFJSONRequestSerializer serializer];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"USER_NAME"] = name;
//    params[@"PASSWORD"] = pass;
//    [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URL_USER_LOGIN parameters:params error:nil];
//    
//    [session POST:URL_USER_LOGIN parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
//        if([responseObject isKindOfClass:[NSDictionary class]]) {
//            NSString* result = [(NSDictionary*)responseObject objectForKey:@"result"];
//            if ([result isEqualToString:@"success"]) {
//                self.user.name = name;
//                self.user.pass = pass;
//                [self saveToArchiver:self.user];
//                
//                [self performSegueWithIdentifier:@"login" sender:self];
//            }
//            else {
//                [YLToast showWithText:result];
//            }
//        }
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        [YLToast showWithText:@"网络连接失败，请检查网络配置"];
//    }];
}
- (BOOL)saveToArchiver:(User*)user {
    NSString* fileName = [YLCommon docPath:@"user.archiver"];
    NSMutableData* data = [NSMutableData data];
    NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:user forKey:@"login_user"];
    [archiver finishEncoding];
    return [data writeToFile:fileName atomically:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UIViewController* vc = [segue destinationViewController];
    if ([vc isKindOfClass:[MainViewController class]]) {
        MainViewController* mainVc = (MainViewController*)vc;
        mainVc.user = self.user;
    }
}


@end
