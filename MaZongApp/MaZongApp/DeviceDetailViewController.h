//
//  DeviceDetailViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"

@class DeviceModel;
@class MainView;

@interface DeviceDetailViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet MainView *mainView;
@property (nonatomic, strong) DeviceModel *device;
@property (nonatomic, strong) NSMutableArray* deviceDataSource;
@end
