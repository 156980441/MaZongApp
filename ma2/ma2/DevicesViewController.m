//
//  DevicesViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/9/29.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "DevicesViewController.h"
#import "DeviceDetailViewController.h"
#import "DeviceModel.h"
#import "User.h"
#import "stdafx_MaZongApp.h"

#import "AFHTTPSessionManager.h"

#import "MBProgressHUD.h"
#import "YLToast.h"

static NSString* deviceCell_identifier = @"device_identifier";

@interface DevicesViewController () <UITableViewDataSource,UITableViewDelegate>

@end

@implementation DevicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (g_user) {
        [self loadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method
-(void)loadData
{
    NSMutableArray* arr_dataSource = [NSMutableArray array];
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString* url = [NSString stringWithFormat:@"%@/%zd",URL_DEVICE_LIST,g_user.userNo];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.label.text = NSLocalizedString(@"获取设备列表中...", @"HUD loading title");
    [session GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             NSArray* arr = (NSArray*)responseObject;
             for (NSDictionary* dic in arr) {
                 DeviceModel* dev = [[DeviceModel alloc] init];
                 dev.name = [dic objectForKey:@"TITLE"];
                 dev.deviceId = [dic objectForKey:@"ID"];
                 dev.ph = [dic objectForKey:@"PH"];
                 dev.temperature = [dic objectForKey:@"TEMPERATURE"];
                 dev.tds = [dic objectForKey:@"TDS"];
                 if ([[dic objectForKey:@"STATE"] isEqual:[NSNull null]]) {
                     dev.isOff = 1;
                 }
                 else
                 {
                     dev.isOff = ((NSString*)[dic objectForKey:@"STATE"]).integerValue;
                 }
                 [arr_dataSource addObject:dev];
             }
             
             self.dataSource = arr_dataSource;
             dispatch_async(dispatch_get_main_queue(), ^{
                 [hud hideAnimated:YES];
                 [self.tableView reloadData];
             });
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [hud hideAnimated:YES];
                 [YLToast showWithText:@"获取设备列表失败"];
             });
         }];
    
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
        cell = [tableView dequeueReusableCellWithIdentifier:deviceCell_identifier];
        DeviceModel* device = [self.dataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = device.name;
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
        DeviceDetailViewController* detail = [[DeviceDetailViewController alloc] init];
        detail.selectDevice = [self.dataSource objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:detail animated:YES];
    }
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"设备删除" message:@"您确定要删除该设备吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    DeviceModel* device = [self.dataSource objectAtIndex:indexPath.row];
    
    void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        NSString* url_ads = [NSString stringWithFormat:@"%@/%zd/%@",URL_DELETE_DEVICE,g_user.userNo, device.deviceId];
        [session GET:url_ads parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 [self.dataSource removeObjectAtIndex:indexPath.row];
                 // 刷新
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error);
             }];
        
    };
    void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:action];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
    [alert addAction:destructiveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
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
