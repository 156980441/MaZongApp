//
//  DeviceDetailViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "DeviceDetailViewController.h"
#import "AdsViewController.h"
#import "DeviceModel.h"
#import "MainView.h"

#import "YLToast.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPSessionManager.h"

static NSString* deviceDetailCell_identifier = @"deviceCell_identifier";

@interface DeviceDetailViewController ()
@property (nonatomic, strong) MainView *innerMainView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation DeviceDetailViewController

//这里使用 storyboard  
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(modify)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.innerMainView = [MainView viewFromNIB];
    self.innerMainView.frame = CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), CGRectGetHeight(self.mainView.frame));
    self.innerMainView.deviceTableView.delegate = self;
    self.innerMainView.deviceTableView.dataSource = self;
    [self.innerMainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceDetailCell_identifier];
    [self.mainView addSubview:self.innerMainView];
    
    
    
    // 添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleOfTapInScrollView:)];
    [self.innerMainView.dynamicAdsScrollView addGestureRecognizer:tap];
    
    self.title = self.device.name;
    NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.device.temperature];
    NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.device.tds];
    NSString* ph = [NSString stringWithFormat:@"PH：%@",self.device.ph];
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.device.isOff? @"开":@"关"];
    self.deviceDataSource = [NSMutableArray arrayWithObjects:temperature,tds,ph,isOff, nil];
    dispatch_async(dispatch_get_main_queue(), ^(){
        [self.innerMainView setStaticAdsImages:self.s_images withDynamicAdsImages:self.d_images];
    });
}

- (void)handleOfTapInScrollView:(UITapGestureRecognizer*)tap
{
    CGPoint point = [tap locationInView:self.innerMainView.dynamicAdsScrollView];
    CGFloat width = CGRectGetWidth(self.innerMainView.dynamicAdsScrollView.frame);
    NSRange range1 = NSMakeRange(0, width);
    NSRange range2 = NSMakeRange(width, width * 2);
    NSRange range3 = NSMakeRange(width * 2, width * 3);
    
    if (NSLocationInRange(point.x, range1)) {
        
    }
    if (NSLocationInRange(point.x, range2)) {
        
    }
    if (NSLocationInRange(point.x, range3)) {
        
    }
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
    
    if (self.url != nil) {
        UIViewController* vc = [segue destinationViewController];
        if ([vc isKindOfClass:[AdsViewController class]]) {
            AdsViewController* adsVc = (AdsViewController*)vc;
            adsVc.url = self.url;
        }
    }
    
}

#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:deviceDetailCell_identifier];
    cell.textLabel.text = [self.deviceDataSource objectAtIndex:indexPath.row];
    if (indexPath.row == 3) {
        UISwitch* s = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame), 5, 40, CGRectGetHeight(cell.contentView.frame) - 10)];
        [s setOn:self.device.isOff animated:YES];
        [s addTarget:self action:@selector(swithch:) forControlEvents:UIControlEventValueChanged];
        [cell.contentView addSubview:s];
    }
    return cell;
}
-(void)modify
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"编辑" message:nil preferredStyle:UIAlertControllerStyleAlert];
    //以下方法就可以实现在提示框中输入文本；
    
    //在AlertView中添加一个输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.placeholder = @"输入设备的新名称";
    }];
    
    //添加一个确定按钮 并获取AlertView中的第一个输入框 将其文本赋值给BUTTON的title
    [alertController addAction:[UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *nameTxtField = alertController.textFields.firstObject;
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
//        NSString* name_url = [NSString stringWithFormat:@"%@/%@/%@",URL_CHANGE_DEVICE_NAME,self.device.deviceId, @"修改名字"];
//        NSString* name_url = [NSString stringWithFormat:@"%@/%@/%@",URL_CHANGE_DEVICE_NAME,self.device.deviceId, @"6666"];
        NSString* name_url = [NSString stringWithFormat:@"%@/%@/%@",URL_CHANGE_DEVICE_NAME,self.device.deviceId, nameTxtField.text];
        [session GET:[name_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 [YLToast showWithText:@"修改成功"];
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 [YLToast showWithText:@"修改失败"];
             }];
        
    }]];
    
    //添加一个取消按钮
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //present出AlertView
    [self presentViewController:alertController animated:true completion:nil];
}

-(void)swithch:(id)mySwitch
{
    UISwitch* s = (UISwitch*)mySwitch;
    [self.deviceDataSource removeLastObject];
    self.device.isOff = s.on;
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.device.isOff? @"开":@"关"];
    [self.deviceDataSource addObject:isOff];
    [self.innerMainView.deviceTableView reloadData];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSString* url_ads = [NSString stringWithFormat:@"%@/%zd/%d",URL_CHANGE_DEVICE_STATE,self.device.deviceId, self.device.isOff];
    [session GET:url_ads parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"%@",responseObject);
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];

}
@end
