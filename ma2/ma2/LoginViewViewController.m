//
//  LoginViewViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "LoginViewViewController.h"
#import "RegisterViewController.h"
#import "User.h"

#import "YLToast.h"
#import "YLCommon.h"
#import "YLLocationManager.h"

#import "stdafx_MaZongApp.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "MBProgressHUD.h"

static NSArray* g_city_arr = nil;

@interface LoginViewViewController ()
@property (nonatomic, strong) YLLocationManager* location;
@end

@implementation LoginViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
    self.nameTxt = [[UITextField alloc] init];
    self.passTxt = [[UITextField alloc] init];
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.fogretBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.registBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
    [self.fogretBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    self.loginBtn.tintColor = [UIColor whiteColor];
    self.registBtn.tintColor = self.fogretBtn.tintColor = [UIColor blueColor];
    
    self.nameTxt.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_user"]];
    self.passTxt.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_pass"]];
    self.nameTxt.leftViewMode = UITextFieldViewModeAlways;
    self.passTxt.leftViewMode = UITextFieldViewModeAlways;
    self.nameTxt.placeholder = @"请输入用户名";
    self.passTxt.placeholder = @"请输入密码";
    self.passTxt.borderStyle = self.nameTxt.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:self.logo];
    [self.view addSubview:self.nameTxt];
    [self.view addSubview:self.passTxt];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.fogretBtn];
    
    self.logo.translatesAutoresizingMaskIntoConstraints =
    self.nameTxt.translatesAutoresizingMaskIntoConstraints =
    self.passTxt.translatesAutoresizingMaskIntoConstraints =
    self.loginBtn.translatesAutoresizingMaskIntoConstraints =
    self.registBtn.translatesAutoresizingMaskIntoConstraints =
    self.fogretBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *top_logo = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:55];
    NSLayoutConstraint *x_logo = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0];
    NSLayoutConstraint *w_logo = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:147];
    NSLayoutConstraint *h_logo = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:144];
    
    NSLayoutConstraint *top_name = [NSLayoutConstraint constraintWithItem:self.nameTxt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.logo attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40.0];
    NSLayoutConstraint *left_name = [NSLayoutConstraint constraintWithItem:self.nameTxt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *right_name = [NSLayoutConstraint constraintWithItem:self.nameTxt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *h_name = [NSLayoutConstraint constraintWithItem:self.nameTxt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *top_pass = [NSLayoutConstraint constraintWithItem:self.passTxt attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameTxt attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20];
    NSLayoutConstraint *left_pass = [NSLayoutConstraint constraintWithItem:self.passTxt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *right_pass = [NSLayoutConstraint constraintWithItem:self.passTxt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *h_pass = [NSLayoutConstraint constraintWithItem:self.passTxt attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *login_top = [NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.passTxt attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *login_left = [NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *login_right = [NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *login_h = [NSLayoutConstraint constraintWithItem:self.loginBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30.0];
    
    NSLayoutConstraint *regist_h = [NSLayoutConstraint constraintWithItem:self.registBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    NSLayoutConstraint *regist_w = [NSLayoutConstraint constraintWithItem:self.registBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *regist_left = [NSLayoutConstraint constraintWithItem:self.registBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-70.0];
    NSLayoutConstraint *regist_top = [NSLayoutConstraint constraintWithItem:self.registBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:50.0];
    
    NSLayoutConstraint *forget_h = [NSLayoutConstraint constraintWithItem:self.fogretBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    NSLayoutConstraint *forget_w = [NSLayoutConstraint constraintWithItem:self.fogretBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100];
    NSLayoutConstraint *forget_left = [NSLayoutConstraint constraintWithItem:self.fogretBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:70.0];
    NSLayoutConstraint *forget_top = [NSLayoutConstraint constraintWithItem:self.fogretBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.loginBtn attribute:NSLayoutAttributeBottom multiplier:1.0 constant:50.0];
    
    
    //把约束添加到父视图上
    NSArray *array = [NSArray arrayWithObjects:
                      top_logo, x_logo, w_logo, h_logo,
                      top_name,left_name,right_name,h_name,
                      top_pass,left_pass,right_pass,h_pass,
                      login_top,login_left,login_right,login_h,
                      regist_top,regist_left,regist_h,regist_w,
                      forget_top,forget_left,forget_h,forget_w,
                      nil];
    [self.view addConstraints:array];
    
    [self.loginBtn addTarget:self action:@selector(loginBtnPress:) forControlEvents:UIControlEventTouchDown];
    [self.registBtn addTarget:self action:@selector(registBtnPress:) forControlEvents:UIControlEventTouchDown];
    [self.fogretBtn addTarget:self action:@selector(forgetBtnPress:) forControlEvents:UIControlEventTouchDown];
    
    g_city_arr = @[@"北京市"];
    if (!g_user) {
        g_user = [[User alloc] init];
        g_user.cityId = -1;
    }
    
    User* user = [self loadFromArchiver];
    
    if (user) {
        [self checkuser:user.username withPass:user.password];
    }
    
    // test
    
    self.nameTxt.text = @"admin";
    self.passTxt.text = @"123456";
    
    self.location = [[YLLocationManager alloc] initWithGpsUpdate:^(CLLocation *loc) {
        // 初始化编码器
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        // 通过定位获取的经纬度坐标，反编码获取地理信息标记并打印改标记下得城市名
        [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
            
            if (error) {
                [YLToast showWithText:@"定位失败"];
                NSLog(@"%s,%@",__FILE__,error.description);
            }
            else {
                if (g_user.cityId == -1) {
                    CLPlacemark *placemark = [placemarks lastObject];
                    NSString *cityName = placemark.locality;
                    g_user.cityId = [g_city_arr indexOfObject:cityName];
                    [self.location stopUpdatingLocation];
                }
            }
        }];
    }];
    
    [self.location startUpdatingLocation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES; // 隐藏 Navbar
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registBtnPress:(id)sender {
    NSLog(@"%s",__func__);
    RegisterViewController* registerVc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}
- (void)forgetBtnPress:(id)sender {
    NSLog(@"%s",__func__);
}
- (void)loginBtnPress:(id)sender {
    NSLog(@"%s",__func__);
#ifdef LOC_TEST
    g_user.password = @"123456";
    [self dismissViewControllerAnimated:YES completion:NO];
#else
    
    if ([self.passTxt.text isEqualToString:@""]|| [self.nameTxt.text isEqualToString:@""]) {
        [YLToast showWithText:@"账号或者密码为空"];
    }
    else {
        [self checkuser:self.nameTxt.text withPass:self.passTxt.text];
    }
#endif
}

-(void)checkuser:(NSString*)name withPass:(NSString*)pass
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:name,@"USER_NAME",pass,@"PASSWORD", nil];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.label.text = NSLocalizedString(@"登录中...", @"HUD loading title");
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    [manager POST:URL_USER_LOGIN parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* jsonData = (NSDictionary*)responseObject;
        NSString* statusCode = [jsonData objectForKey:@"statusCode"];
        if (statusCode.integerValue == 300)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [YLToast showWithText:@"该用户不存在"];
            });
        }
        else if (statusCode.integerValue == 200)
        {
            NSDictionary* admin_dic = [jsonData objectForKey:@"admin"];
            [g_user initFromDictionary:admin_dic];
            [self saveToArchiver:g_user];
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hideAnimated:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            });
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"login failure %@",error.localizedDescription);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hideAnimated:YES];
            [YLToast showWithText:@"登录失败"];
        });
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

- (User*)loadFromArchiver {
    NSString* fileName = [YLCommon docPath:@"user.archiver"];
    NSData* data = [NSData dataWithContentsOfFile:fileName];
    if ([data length] > 0) {
        NSKeyedUnarchiver* unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        User* user = [unArchiver decodeObjectForKey:@"login_user"];
        [unArchiver finishDecoding];
        return user;
    }
    else {
        return nil;
    }
}

// 隐藏键盘

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.nameTxt resignFirstResponder];
    [self.passTxt resignFirstResponder];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
