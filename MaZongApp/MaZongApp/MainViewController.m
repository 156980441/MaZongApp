//
//  MainViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "MainView.h"
#import "DeviceDetailViewController.h"
#import "AddDeviceViewController.h"
#import "DeviceModel.h"
#import "User.h"

#import "YLToast.h"
#import "YLLog.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPSessionManager.h"

static NSString* deviceCell_identifier = @"deviceCell_identifier";


void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL];
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}

@interface MainViewController ()
@property (nonatomic, strong) DeviceModel *selectedDevice;
@property (nonatomic, strong) NSMutableArray *staticImages;
@property (nonatomic, strong) NSMutableArray *dynaticImages;
@property (nonatomic, strong) MainView *innerMainView;
@property (nonatomic, strong) NSString* url;
@end

@implementation MainViewController

// storyboard 不调用 init 方法

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s开始",__func__);
    [super viewDidAppear:animated];
    
    self.title = @"设备列表";
    self.deviceDataSource = [NSMutableArray array];
    
    if (!self.staticImages) {
        self.staticImages = [NSMutableArray array];
    }
    if (!self.dynaticImages) {
        self.dynaticImages = [NSMutableArray array];
    }
    
    self.innerMainView = [MainView viewFromNIB];// 有没有一个方法只在初始化的时候调用一次。而不要在每次都调用。
    self.innerMainView.frame = CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), CGRectGetHeight(self.mainView.frame));
    self.innerMainView.deviceTableView.delegate = self;
    self.innerMainView.deviceTableView.dataSource = self;
    [self.innerMainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    [self.mainView addSubview:self.innerMainView];
    
    [self getDeviceList];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfTapInScrollView:)];
    [self.innerMainView.dynamicAdsScrollView addGestureRecognizer:tap];
    if (self.staticImages.count == 0 || self.dynaticImages.count == 0) {
        [YLLog readyGetTime];
        [self getAdsResource];
    }
    else {
        dispatch_async(dispatch_get_main_queue(), ^(){
            NSLog(@"布局开始");
            [self.innerMainView setStaticAdsImages:self.staticImages withDynamicAdsImages:self.dynaticImages];
            NSLog(@"布局结束");
        });
    }
    NSLog(@"%s结束",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)handleOfTapInScrollView:(UITapGestureRecognizer*)tap
{
    [self performSegueWithIdentifier:@"showAds" sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.selectedDevice != nil) {
        UIViewController* vc = [segue destinationViewController];
        if ([vc isKindOfClass:[DeviceDetailViewController class]]) {
            DeviceDetailViewController* deviceDetail = (DeviceDetailViewController*)vc;
            deviceDetail.device = self.selectedDevice;
            deviceDetail.s_images = self.staticImages;
            deviceDetail.d_images = self.dynaticImages;
            deviceDetail.url = self.url;
        }
        if ([vc isKindOfClass:[AddDeviceViewController class]]) {
            
        }
    }
    
}

-(void)getAdsResource
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSString* url_ads = [NSString stringWithFormat:@"%@/%zd",URL_CITY_ADS,g_user.cityId];
    [session GET:url_ads parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             
             NSArray* arr = (NSArray*)responseObject;
             
             dispatch_group_async(group, queue, ^{
                 
                 __block NSString* url;
                 __block NSURL* nsurl;
                 __block NSData* data;
                 __block UIImage* image;
                 
                 NSLog(@"广告加载开始");
                 
                 for (NSDictionary* dic in arr) {
                     
                     NSString* root_url = [dic objectForKey:@"ADV_URL"];
                     NSString* url_image1 = [dic objectForKey:@"PIC_URL1"];
                     NSString* url_image2 = [dic objectForKey:@"PIC_URL2"];
                     NSString* url_image3 = [dic objectForKey:@"PIC_URL3"];
                     
                     NSMutableArray* arr = nil;
                     if (![root_url isEqualToString:@""]) {
                         arr = self.dynaticImages;
                         self.url = root_url;
                     }
                     else {
                         arr = self.staticImages;
                     }
                     
                     if (![url_image1 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image1];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         image = [[UIImage alloc] initWithData:data];
                         [arr addObject:image];
                     }
                     if (![url_image2 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image2];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         image = [[UIImage alloc] initWithData:data];
                         [arr addObject:image];
                     }
                     if (![url_image3 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image3];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         image = [[UIImage alloc] initWithData:data];
                         [arr addObject:image];
                     }
                 }
                 
                 NSLog(@"广告加载结束");
                 
                 dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                     NSLog(@"所有广告加载完毕，耗时：%@ 秒",[YLLog costTime]);
                     [self.innerMainView setStaticAdsImages:self.staticImages withDynamicAdsImages:self.dynaticImages];
                 });
                 
             });
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
}
-(void)getDeviceList
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString* url = [NSString stringWithFormat:@"%@/%zd",URL_DEVICE_LIST,g_user.userNo];
    [session GET:url parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSArray* arr = (NSArray*)responseObject;
             for (NSDictionary* dic in arr) {
                 DeviceModel* dev = [[DeviceModel alloc] init];
                 dev.name = [dic objectForKey:@"TITLE"];
                 dev.deviceId = [dic objectForKey:@"ID"];
                 dev.ph = [dic objectForKey:@"PH"];
                 dev.temperature = [dic objectForKey:@"TEMPERATURE"];
                 dev.tds = [dic objectForKey:@"TDS"];
                 dev.isOff = ((NSString*)[dic objectForKey:@"ACTIVITY"]).integerValue;
                 [self.deviceDataSource addObject:dev];
             }
             [self.innerMainView.deviceTableView reloadData];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             [YLToast showWithText:@"获取设备列表失败"];
         }];
}

#pragma - mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPath.row 是从 0 开始的
    if (indexPath.row < self.deviceDataSource.count) {
        self.selectedDevice = [self.deviceDataSource objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"add_device" sender:nil];
    }
}
#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.deviceDataSource.count != 0) {
        return self.deviceDataSource.count + 1;//多的一个显示添加设备按钮
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:deviceCell_identifier];
    if (self.deviceDataSource.count > 0 && self.deviceDataSource.count != indexPath.row) {
        DeviceModel* device = [self.deviceDataSource objectAtIndex:indexPath.row];
        cell.textLabel.text = device.name;
    }
    else {
        cell.textLabel.text = @"添加设备";
    }
    return cell;
}
@end
