//
//  RootViewController.h
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewControllerType) {
    ViewControllerDeviceType,
    ViewControllerForumType,
    ViewControllerMineType,
    ViewControllerDetailType
};

@class DeviceModel;

@interface RootViewController : UIViewController

-(instancetype)initWithType:(ViewControllerType)type;

@property (nonatomic,copy) NSMutableArray* dataSource;

@property (nonatomic, strong) DeviceModel *selectDevice;
@end
