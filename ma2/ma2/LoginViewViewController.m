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
    
    self.title = @"登录";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.hidden = YES;
    
    self.logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo.jpg"]];
    self.logo.frame = CGRectMake(127, 55, 147, 144);
    self.nameTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 244, 300, 30)];
    self.passTxt = [[UITextField alloc] initWithFrame:CGRectMake(60, 298, 300, 30)];
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.loginBtn.frame = CGRectMake(60, 370, 300, 30);
    self.registBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.registBtn.frame = CGRectMake(100, 420, 100, 30);
    self.fogretBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.fogretBtn.frame = CGRectMake(230, 420, 100, 30);
    
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.registBtn setTitle:@"注册新用户" forState:UIControlStateNormal];
    [self.fogretBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    self.loginBtn.tintColor = [UIColor whiteColor];
    
    self.registBtn.tintColor = self.fogretBtn.tintColor = [UIColor blueColor];
    self.loginBtn.backgroundColor = [UIColor blueColor];
    self.passTxt.borderStyle = self.nameTxt.borderStyle = UITextBorderStyleLine;
    
    self.nameTxt.placeholder = @"请输入用户名";
    self.passTxt.placeholder = @"请输入密码";
    
    [self.view addSubview:self.logo];
    [self.view addSubview:self.nameTxt];
    [self.view addSubview:self.passTxt];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registBtn];
    [self.view addSubview:self.fogretBtn];
    
    self.logo.translatesAutoresizingMaskIntoConstraints = self.nameTxt.translatesAutoresizingMaskIntoConstraints = self.passTxt.translatesAutoresizingMaskIntoConstraints = self.loginBtn.translatesAutoresizingMaskIntoConstraints = self.registBtn.translatesAutoresizingMaskIntoConstraints = self.fogretBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *contraint1 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:55];
    NSLayoutConstraint *contraint2 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:127];
    //子view的下边缘离父view的下边缘40个像素
    NSLayoutConstraint *contraint3 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-40.0];
    //子view的右边缘离父view的右边缘40个像素
    NSLayoutConstraint *contraint4 = [NSLayoutConstraint constraintWithItem:self.logo attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-40.0];
    
    [self.loginBtn addTarget:self action:@selector(loginBtnPress:) forControlEvents:UIControlEventTouchDown];
    [self.registBtn addTarget:self action:@selector(registBtnPress:) forControlEvents:UIControlEventTouchDown];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)registBtnPress:(id)sender {
    RegisterViewController* registerVc = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVc animated:YES];
}
- (void)loginBtnPress:(id)sender {
    
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
    hud.labelText = NSLocalizedString(@"登录中...", @"HUD loading title");
    // You can also adjust other label properties if needed.
    // hud.label.font = [UIFont italicSystemFontOfSize:16.f];
    
    [manager POST:URL_USER_LOGIN parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary* jsonData = (NSDictionary*)responseObject;
        NSDictionary* admin_dic = [jsonData objectForKey:@"admin"];
        [g_user initFromDictionary:admin_dic];
        [self saveToArchiver:g_user];
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
            [self performSegueWithIdentifier:@"main" sender:self];
        });
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [hud hide:YES];
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
