//
//  YLLocationManager.m
//  YLSDKDemo
//
//  Created by fanyunlong on 2016/12/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "YLLocationManager.h"
/**
 分类只能扩充方法，不能扩展属性和成员变量（如果包含成员变量会直接报错）。
 如果分类中声明了一个属性，那么分类只会生成这个属性的set、get方法声明，不会有实现。
 */


/**
 类扩展：附加额外的属性，成员变量，方法声明，一般的私有属性写到类扩展。在 .m 中。
 */
@interface YLLocationManager () <CLLocationManagerDelegate>
{
    CLLocationManager *_locationManager;
}
@property(nonatomic,copy) void (^gpsBlock)(CLLocation* loc);
@end

@implementation YLLocationManager
-(instancetype)initWithGpsUpdate:(void (^)(CLLocation* loc))block
{
    self = [super init];
    if (self) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        [_locationManager requestWhenInUseAuthorization];
        self.gpsBlock = block;
    }
    return self;
}
-(instancetype)init
{
    return [self initWithGpsUpdate:nil];
}

- (void)startUpdatingLocation
{
    [_locationManager startUpdatingLocation];
}

- (void)stopUpdatingLocation
{
    [_locationManager stopUpdatingLocation];
}

- (void)requestLocation
{
    [_locationManager requestLocation];
}

#pragma mark - CLLocationManagerDelegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    if (self.gpsBlock) {
        self.gpsBlock([locations lastObject]);
    }
//    // 初始化编码器
//    CLGeocoder *geoCoder = [[CLGeocoder alloc] init];
//    // 通过定位获取的经纬度坐标，反编码获取地理信息标记并打印改标记下得城市名
//    [geoCoder reverseGeocodeLocation:[locations lastObject] completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark = [placemarks lastObject];
//        NSString *cityName = placemark.locality;
//        NSLog(@"城市 - %@", cityName);
//        
//        NSString *cityStr=[placemark.addressDictionary objectForKey:@"City"];
//        
//        NSLog(@"city %@",cityStr);
//        
//        NSString *Street=[placemark.addressDictionary objectForKey:@"Street"];
//        
//        NSLog(@"Street %@",Street);
//        
//        NSString *State=[placemark.addressDictionary objectForKey:@"State"];
//        
//        NSLog(@"State %@",State);
//        
//        NSString *ZIP=[placemark.addressDictionary objectForKey:@"ZIP"];
//        
//        NSLog(@"ZIP %@",ZIP);
//        
//        NSString *Country=[placemark.addressDictionary objectForKey:@"Country"];
//        
//        NSLog(@"Country %@",Country);
//        
//        NSString *CountryCode=[placemark.addressDictionary objectForKey:@"CountryCode"];
//        
//        NSLog(@"CountryCode %@",CountryCode);
//    }];
}
@end
