//
//  ConfigTableViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 2017/6/5.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "ConfigTableViewController.h"

#import <SystemConfiguration/CaptiveNetwork.h>

static NSString* configTableViewCellIdentifier = @"ConfigTableViewCellIdentifier";

@interface ConfigTableViewController ()
@property (nonatomic, copy) NSArray* dataSource;
@property (nonatomic, copy) NSString* wifiName;
@end

@implementation ConfigTableViewController

// 懒加载
- (NSArray*)dataSource
{
    
    if (!_dataSource) {
        NSString* wifi = [NSString stringWithFormat:@"Wifi 配置:%@",self.wifiName];
        NSArray* arr = [NSArray arrayWithObjects:wifi,@"添加设备", nil];
        _dataSource = [arr copy];
    }
    return _dataSource;
}

-(NSString*)wifiName
{
    if (!_wifiName) {
        id info = nil;
        NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
        for (NSString *ifnam in ifs) {
            info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
            NSString *str = info[@"SSID"];
            NSString *str2 = info[@"BSSID"];
            NSString *str3 = [[ NSString alloc] initWithData:info[@"SSIDDATA"] encoding:NSUTF8StringEncoding];
            _wifiName = [str copy];
        }
    }
    return _wifiName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:configTableViewCellIdentifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"add_device" sender:nil];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:configTableViewCellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
