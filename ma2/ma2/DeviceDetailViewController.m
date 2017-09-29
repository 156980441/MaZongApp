//
//  DeviceDetailViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/9/29.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceModel.h"

#import "stdafx_MaZongApp.h"

#import "AFHTTPSessionManager.h"

#import "MBProgressHUD.h"
#import "YLToast.h"

static NSString* deviceDetailCell_identifier = @"device_detail_identifier";

@interface DeviceDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.selectDevice.name;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceDetailCell_identifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.dataSource = [self deviceDetailDataSource];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (NSMutableArray*) deviceDetailDataSource
{
    NSString* str1;
    NSString* str2;
    NSString* str3;
    NSString* str4 = [NSString stringWithFormat:@"远程开关：%@",self.selectDevice.isOff ? @"关":@"开"];
    if ([self.selectDevice.temperature isEqual:[NSNull null]]) {
        str1 = @"温度：未采集";
    }
    else
    {
        str1 = [NSString stringWithFormat:@"温度：%@",self.selectDevice.temperature];
    }
    if ([self.selectDevice.tds isEqual:[NSNull null]]) {
        str2 = @"TDS：未采集";
    }
    else
    {
        str2 = [NSString stringWithFormat:@"TDS：%@",self.selectDevice.tds];
    }
    if ([self.selectDevice.ph isEqual:[NSNull null]]) {
        str3 = @"PH：未采集";
    }
    else
    {
        str3 = [NSString stringWithFormat:@"PH：%@",self.selectDevice.ph];
    }
    return [NSMutableArray arrayWithObjects:str1,str2,str3,str4, nil];
}

-(void)switchPress:(id)mySwitch
{
    UISwitch* s = (UISwitch*)mySwitch;
    NSLog(@"------ %d",s.on);
    
#ifdef LOC_TEST
#else
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString* url_ads = [NSString stringWithFormat:@"%@/%@/%d",URL_CHANGE_DEVICE_STATE,self.selectDevice.deviceId, !self.selectDevice.isOff];
    [session GET:url_ads parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSDictionary* jsonDic = (NSDictionary*)responseObject;
             NSInteger code = ((NSString*)[jsonDic objectForKey:@"code"]).integerValue;
             if (code == 200) {
                 self.selectDevice.isOff = !self.selectDevice.isOff;
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [s setOn:!self.selectDevice.isOff animated:YES];
                     self.dataSource = [self deviceDetailDataSource];
                     [self.tableView reloadData];
                 });
             }
             else
             {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [s setOn:!self.selectDevice.isOff animated:YES];
                     [YLToast showWithText:@"请求失败"];
                 });
                 
             }
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [YLToast showWithText:@"网络请求失败"];
         }];
#endif
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
        cell = [tableView dequeueReusableCellWithIdentifier:deviceDetailCell_identifier];
        cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
        if (indexPath.row == 3) {
            UISwitch* s = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.accessoryView = s;
            [s setOn:!self.selectDevice.isOff animated:NO];
            [s addTarget:self action:@selector(switchPress:) forControlEvents:UIControlEventValueChanged];
            
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

@end
