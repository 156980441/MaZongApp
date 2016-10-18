//
//  DeviceDetailViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceModel.h"
#import "MainView.h"

static NSString* deviceDetailCell_identifier = @"deviceCell_identifier";

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    MainView* mainView = [MainView viewFromNIB];
    mainView.frame = self.mainView.frame;
    self.mainView = mainView;
    NSLog(@"mainView:%f,%f,%f,%f",self.mainView.frame.origin.x,self.mainView.frame.origin.y,self.mainView.frame.size.width,self.mainView.frame.size.height);
    NSLog(@"view:%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    [self.view addSubview:self.mainView];
    
    self.mainView.deviceTableView.delegate = self;
    self.mainView.deviceTableView.dataSource = self;
    
    self.title = @"设备详情";
    NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.device.temperature];
    NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.device.tds];
    NSString* ph = [NSString stringWithFormat:@"PH：%@",self.device.ph];
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.device.temperature];
    self.deviceDataSource = [NSMutableArray arrayWithObjects:temperature,tds,ph,isOff, nil];
    
    [self.mainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceDetailCell_identifier];
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

#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:deviceDetailCell_identifier];
    cell.textLabel.text = [self.deviceDataSource objectAtIndex:indexPath.row];
    return cell;
}

@end
