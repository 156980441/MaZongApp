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
#import "YLLocationManager.h"

#import "stdafx_MaZongApp.h"
#import "AFNetworkReachabilityManager.h"
#import "AFHTTPSessionManager.h"
#import "AFHTTPRequestOperationManager.h"

static NSArray* g_city_arr = nil;

@interface LoginViewViewController ()
@property (nonatomic, strong) YLLocationManager* location;
@end

@implementation LoginViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"登录";
    g_city_arr = @[@"北京市"];
    if (!g_user) {
        g_user = [[User alloc] init];
        g_user.cityId = -1;
    }
    
    // test
    
    self.nameTxt.text = @"fdfds";
    self.passTxt.text = @"123456";
    
    self.location = [[YLLocationManager alloc] initWithGpsUpdate:^(CLLocation *loc) {
        // 初始化编码器
        CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
        // 通过定位获取的经纬度坐标，反编码获取地理信息标记并打印改标记下得城市名
        [geoCoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
            if (g_user.cityId == -1) {
                CLPlacemark *placemark = [placemarks lastObject];
                NSString *cityName = placemark.locality;
                g_user.cityId = [g_city_arr indexOfObject:cityName];
            }
        }];
    }];
    
    [self.location startUpdatingLocation];
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
        NSDictionary* jsonData = (NSDictionary*)responseObject;
        NSDictionary* admin_dic = [jsonData objectForKey:@"admin"];
        g_user.name = [admin_dic objectForKey:@"username"];
        g_user.pass = [admin_dic objectForKey:@"password"];
        g_user.userNo = ((NSNumber*)[admin_dic objectForKey:@"userNo"]).integerValue;
        [self saveToArchiver:g_user];
        [self performSegueWithIdentifier:@"main" sender:self];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
