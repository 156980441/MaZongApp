//
//  MineViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/9/29.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "MineViewController.h"
#import "AddDeviceViewController.h"
#import "ConfigWifiViewController.h"
#import "ConfigUserViewController.h"
#import "LoginViewViewController.h"
#import "User.h"
#import "stdafx_MaZongApp.h"

#import "AFHTTPSessionManager.h"

#import "MBProgressHUD.h"
#import "YLToast.h"

static NSString* mineCell_identifier = @"mineCell_identifier";

@interface MineViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:mineCell_identifier];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSMutableArray* dataSource4Mine = [NSMutableArray array];
    [dataSource4Mine addObject:@"添加设备"];
    [dataSource4Mine addObject:@"Wifi 配置"];
    [dataSource4Mine addObject:@"修改密码"];
    [dataSource4Mine addObject:@"注销"];
    [dataSource4Mine addObject:@"关于"];
    self.dataSource = dataSource4Mine;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (self.dataSource.count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:mineCell_identifier];
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.row 是从 0 开始的
    if (self.dataSource.count > 0) {
        
        UIViewController* vc = nil;
        if (0 == indexPath.row) {
            vc = [[AddDeviceViewController alloc] init];
        }
        if (1 == indexPath.row) {
            vc = [[ConfigWifiViewController alloc] init];
        }
        if (2 == indexPath.row) {
            vc = [[ConfigUserViewController alloc] init];
        }
        if (3 == indexPath.row) {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"用户注销" message:@"您确定要注销用户吗？" preferredStyle:UIAlertControllerStyleAlert];
            
            void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
                LoginViewViewController* login = [[LoginViewViewController alloc] init];
                g_user.logout = 1;
                [login saveToArchiver:g_user];
                [self presentViewController:login animated:YES completion:nil];
            };
            void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
                [self dismissViewControllerAnimated:YES completion:nil];
            };
            
            UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:action];
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
            [alert addAction:destructiveAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        if (4 == indexPath.row) {
            NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
            NSString *currentVersion = infoDic[@"CFBundleShortVersionString"];//currentVersion为当前工程项目版本号
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"版本 %@",currentVersion] preferredStyle:UIAlertControllerStyleAlert];
            
            void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
                [self dismissViewControllerAnimated:YES completion:nil];
            };
            UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:cancel];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
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
