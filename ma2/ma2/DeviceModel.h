//
//  DeviceModel.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *tds;
@property (nonatomic, strong) NSString *ph;
@property (nonatomic, assign) BOOL isOff;// 设备是否打开，默认关闭 1
@end
