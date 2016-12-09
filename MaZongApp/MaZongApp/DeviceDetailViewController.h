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
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) DeviceModel *device;
@property (nonatomic, strong) NSMutableArray* deviceDataSource;
@property (nonatomic, strong) NSMutableArray* s_images;
@property (nonatomic, strong) NSMutableArray* d_images;
@property (nonatomic, strong) NSString* url;
@end
