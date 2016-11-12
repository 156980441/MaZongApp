//
//  MainViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "DeviceDetailViewController.h"
#import "AddDeviceViewController.h"
#import "DeviceModel.h"
#import "User.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPSessionManager.h"

static NSString* deviceCell_identifier = @"deviceCell_identifier";

@interface MainViewController ()
@property (nonatomic, strong) DeviceModel *selectedDevice;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MainView* mainView = [MainView viewFromNIB];
    mainView.frame = self.mainView.frame;
    
    mainView.deviceTableView.delegate = self;
    mainView.deviceTableView.dataSource = self;
    
    [mainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    
    [self.mainView addSubview:mainView];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfTapInScrollView:)];
    [mainView.dynamicAdsScrollView addGestureRecognizer:tap];
    
    NSLog(@"mainView:%f,%f,%f,%f",self.mainView.frame.origin.x,self.mainView.frame.origin.y,self.mainView.frame.size.width,self.mainView.frame.size.height);
    NSLog(@"view:%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    
    self.title = @"设备列表";
    self.deviceDataSource = [NSMutableArray array];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    NSString* url = [NSString stringWithFormat:@"%@%zd",URL_DEVICE_LIST,self.user.userNo];
    NSString* url = [NSString stringWithFormat:@"%@5",URL_DEVICE_LIST];
    [session GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"%@",responseObject);
             NSArray* arr = (NSArray*)responseObject;
             for (NSDictionary* dic in arr) {
                 DeviceModel* dev = [[DeviceModel alloc] init];
                 dev.name = [dic objectForKey:@"TITLE"];
                 dev.deviceId = [dic objectForKey:@"ID"];
                 dev.ph = [dic objectForKey:@"PH"];
                 dev.temperature = [dic objectForKey:@"TEMPERATURE"];
                 dev.tds = [dic objectForKey:@"TDS"];
                 [self.deviceDataSource addObject:dev];
             }
             [mainView.deviceTableView reloadData];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
    
}

- (void)handleOfTapInScrollView:(UITapGestureRecognizer*)tap
{
    [self performSegueWithIdentifier:@"showAds" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.selectedDevice != nil) {
        UIViewController* vc = [segue destinationViewController];
        if ([vc isKindOfClass:[DeviceDetailViewController class]]) {
            DeviceDetailViewController* deviceDetail = (DeviceDetailViewController*)vc;
            deviceDetail.device = self.selectedDevice;
        }
        if ([vc isKindOfClass:[AddDeviceViewController class]]) {
            
        }
    }
    
}

#pragma - mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.row 是从 0 开始的
    if (indexPath.row < self.deviceDataSource.count) {
        self.selectedDevice = [self.deviceDataSource objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"add_device" sender:nil];
    }
}
#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.deviceDataSource.count != 0) {
        return self.deviceDataSource.count + 1;//多的一个显示添加设备按钮
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:deviceCell_identifier];
    if (self.deviceDataSource.count > 0 && self.deviceDataSource.count != indexPath.row) {
        DeviceModel* device = [self.deviceDataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = device.name;
    }
    else {
        cell.textLabel.text = @"添加设备";
    }
    return cell;
}
@end
