//
//  YLLocationManager.h
//  YLSDKDemo
//
//  Created by fanyunlong on 2016/12/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface YLLocationManager : NSObject

-(instancetype)initWithGpsUpdate:(void (^)(CLLocation* loc))block;

- (void)startUpdatingLocation;

- (void)stopUpdatingLocation;

- (void)requestLocation;
@end
