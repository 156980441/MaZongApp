//
//  DeviceDetailViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "DeviceModel.h"

static NSString* deviceDetailCell_identifier = @"deviceCell_identifier";

@interface DeviceDetailViewController ()

@end

@implementation DeviceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设备详情";
    NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.device.temperature];
    NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.device.tds];
    NSString* ph = [NSString stringWithFormat:@"PH：%@",self.device.ph];
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.device.temperature];
    self.deviceDataSource = [NSMutableArray arrayWithObjects:temperature,tds,ph,isOff, nil];
    
    [self.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceDetailCell_identifier];
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
    DeviceModel* device = [self.deviceDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = device.name;
    return cell;
}

@end
