//
//  DeviceDetailViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"

@class DeviceModel;

@interface DeviceDetailViewController : MainViewController
@property (nonatomic, strong) DeviceModel *device;
@end
