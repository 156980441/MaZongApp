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
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    MainView* mainView = [MainView viewFromNIB];
    mainView.frame = self.mainView.frame;
    
    mainView.deviceTableView.delegate = self;
    mainView.deviceTableView.dataSource = self;
    
    [mainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    
    NSMutableArray* adsImages = [NSMutableArray array];
    for (int i = 1; i < 4; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_00%d.JPG",i]];
        [adsImages addObject:image];
    }
    NSMutableArray* images = [NSMutableArray array];
    for (int i = 4; i < 7; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_00%d.JPG",i]];
        [images addObject:image];
    }
    [mainView setStaticAdsImages:adsImages withDynamicAdsImages:images];
    
    [self.mainView addSubview:mainView];
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfTapInScrollView:)];
    [mainView.dynamicAdsScrollView addGestureRecognizer:tap];
    
    NSLog(@"mainView:%f,%f,%f,%f",self.mainView.frame.origin.x,self.mainView.frame.origin.y,self.mainView.frame.size.width,self.mainView.frame.size.height);
    NSLog(@"view:%f,%f,%f,%f",self.view.frame.origin.x,self.view.frame.origin.y,self.view.frame.size.width,self.view.frame.size.height);
    
    self.title = @"设备列表";
    self.deviceDataSource = [NSMutableArray array];
    
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
//    NSString* url = [NSString stringWithFormat:@"%@%zd",URL_DEVICE_LIST,self.user.userNo];
    NSString* url = [NSString stringWithFormat:@"%@5",URL_DEVICE_LIST];
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
                 [self.deviceDataSource addObject:dev];
             }
             [mainView.deviceTableView reloadData];
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
    
    __block NSMutableArray* staticImages = [NSMutableArray array];
    NSString* url_stitic_ad = [NSString stringWithFormat:@"%@/1",URL_STITIC_ADS];
    [session GET:url_stitic_ad parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"%@",responseObject);
             NSArray* arr = (NSArray*)responseObject;
             for (NSDictionary* dic in arr) {
                 NSString* url_image1 = [dic objectForKey:@"PIC_URL1"];
                 NSString* url_image2 = [dic objectForKey:@"PIC_URL2"];
                 NSString* url_image3 = [dic objectForKey:@"PIC_URL3"];
                 if (![url_image1 isKindOfClass:[NSNull class]]) {
                     UIImageFromURL([NSURL URLWithString:url_image1],^( UIImage * image )
                     {
                         [staticImages addObject:image];
                     }, ^(void){
                         NSLog(@"%@",@"error!");
                     });
                 }
                 if (![url_image1 isKindOfClass:[NSNull class]]) {
                     UIImageFromURL([NSURL URLWithString:url_image2],^( UIImage * image )
                                    {
                                        [staticImages addObject:image];
                                    }, ^(void){
                                        NSLog(@"%@",@"error!");
                                    });
                 }
                 if (![url_image1 isKindOfClass:[NSNull class]]) {
                     UIImageFromURL([NSURL URLWithString:url_image3],^( UIImage * image )
                                    {
                                        [staticImages addObject:image];
                                    }, ^(void){
                                        NSLog(@"%@",@"error!");
                                    });
                 }
             }
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
    
    __block NSMutableArray* dynaticImages = [NSMutableArray array];
    NSString* url_dyl_ad = [NSString stringWithFormat:@"%@/0",URL_DY_ADS];
    [session GET:url_dyl_ad parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"%@",responseObject);
             NSLog(@"%@",responseObject);
             NSArray* arr = (NSArray*)responseObject;
             for (NSDictionary* dic in arr) {
                 NSString* root_url = [dic objectForKey:@"ADV_URL"];
                 NSString* url_image1 = [dic objectForKey:@"PIC_URL1"];
                 NSString* url_image2 = [dic objectForKey:@"PIC_URL2"];
                 NSString* url_image3 = [dic objectForKey:@"PIC_URL3"];
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     NSData * data1 = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",URL_ROOT,url_image1]]];
                     NSData * data2 = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",URL_ROOT,url_image2]]];
                     NSData * data3 = [[NSData alloc]initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@",URL_ROOT,url_image3]]];
                     UIImage *image1 = [[UIImage alloc]initWithData:data1];
                     UIImage *image2 = [[UIImage alloc]initWithData:data2];
                     UIImage *image3 = [[UIImage alloc]initWithData:data3];
                     [dynaticImages addObject:image1];
                     [dynaticImages addObject:image2];
                     [dynaticImages addObject:image3];
                     dispatch_async(dispatch_get_main_queue(), ^{
                         //在这里做UI操作(UI操作都要放在主线程中执行)
                     });
                 });
             }
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
    
    [mainView setStaticAdsImages:staticImages withDynamicAdsImages:dynaticImages];
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
        }
        if ([vc isKindOfClass:[AddDeviceViewController class]]) {
            
        }
    }
    
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
