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
#import "ConfigTableViewController.h"

#import "YLToast.h"
#import "YLLog.h"
#import "YLCommon.h"
#import "EGORefreshTableHeaderView.h"

#import "stdafx_MaZongApp.h"
#import "AFHTTPSessionManager.h"
#import "MBProgressHUD.h"

static NSString* deviceCell_identifier = @"deviceCell_identifier";
static NSString* ads_loc_path = nil;


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

@interface MainViewController () <EGORefreshTableHeaderDelegate>
@property (nonatomic, strong) DeviceModel *selectedDevice;
@property (nonatomic, strong) NSMutableArray *staticImages;
@property (nonatomic, strong) NSMutableArray *dynaticImages;
@property (nonatomic, strong) MainView *innerMainView;
@property (nonatomic, strong) NSString* url;

@property (nonatomic,strong) EGORefreshTableHeaderView* refreshHeaderView;
@property (nonatomic) BOOL reloading;
@end

@implementation MainViewController

// storyboard 不调用 init 方法

-(void)viewDidAppear:(BOOL)animated {
    NSLog(@"%s开始",__func__);
    [super viewDidAppear:animated];
    
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStylePlain target:self action:@selector(config)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithTitle:@"注销" style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.title = @"设备列表";
    
    if (self.deviceDataSource == nil) {
        self.deviceDataSource = [NSMutableArray array];
    }
    
    if (!self.staticImages) {
        self.staticImages = [NSMutableArray array];
    }
    if (!self.dynaticImages) {
        self.dynaticImages = [NSMutableArray array];
    }
    
    NSFileManager* mgr = [NSFileManager defaultManager];
    
    if (!ads_loc_path) {
        ads_loc_path = [NSString stringWithFormat:@"%@/ADS",getDocumentDirectory()];
    }
    
    NSString* dynPath = [NSString stringWithFormat:@"%@/dyn",ads_loc_path];
    NSString* staticPath = [NSString stringWithFormat:@"%@/static",ads_loc_path];
    
    if (![mgr fileExistsAtPath:dynPath]) {
        [mgr createDirectoryAtPath:dynPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    if (![mgr fileExistsAtPath:staticPath]) {
        [mgr createDirectoryAtPath:staticPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    for (int i = 1; i < 4; i++) {
        NSString* imagePath = [NSString stringWithFormat:@"%@/static/pic%d.jpeg",ads_loc_path,i];
        if ([mgr fileExistsAtPath:imagePath]) {
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            [self.staticImages addObject:image];
        }
        
    }
    for (int i = 1; i < 4; i++) {
        NSString* imagePath = [NSString stringWithFormat:@"%@/dyn/pic%d.jpeg",ads_loc_path,i];
        if ([mgr fileExistsAtPath:imagePath]) {
            UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
            [self.dynaticImages addObject:image];
        }
    }
    
    self.innerMainView = [MainView viewFromNIB];// 有没有一个方法只在初始化的时候调用一次。而不要在每次都调用。
    self.innerMainView.frame = CGRectMake(0, 0, CGRectGetWidth(self.mainView.frame), CGRectGetHeight(self.mainView.frame));
    self.innerMainView.deviceTableView.delegate = self;
    self.innerMainView.deviceTableView.dataSource = self;
    [self.innerMainView.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    [self.mainView addSubview:self.innerMainView];
    
    CGRect tableViewFrame = self.innerMainView.deviceTableView.frame;
    self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - tableViewFrame.size.height, tableViewFrame.size.width, tableViewFrame.size.height)];
    self.refreshHeaderView.delegate = self;
    [self.innerMainView.deviceTableView addSubview:self.refreshHeaderView];
    
    if (self.deviceDataSource.count == 0) {
        [self getDeviceList];
    }
    
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

-(void)config
{
    [self performSegueWithIdentifier:@"config" sender:nil];
}

-(void)logout
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"用户注销" message:@"您确定要注销用户吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
        [self.navigationController popViewControllerAnimated:YES];
    };
    void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:action];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
    [alert addAction:destructiveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if (self.selectedDevice != nil) {
        UIViewController* vc = [segue destinationViewController];
        UIViewController* last_vc = [segue sourceViewController];
        if ([vc isKindOfClass:[DeviceDetailViewController class]]) {
            DeviceDetailViewController* deviceDetail = (DeviceDetailViewController*)vc;
            deviceDetail.device = self.selectedDevice;
            deviceDetail.s_images = self.staticImages;
            deviceDetail.d_images = self.dynaticImages;
            deviceDetail.url = self.url;
        }
        if ([last_vc isKindOfClass:[AddDeviceViewController class]]) {
            NSLog(@"来自 Add UI");
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
                     
                     NSMutableArray* arr_temp = nil;
                     NSString* imagePath = nil;
                     if (![root_url isEqualToString:@""]) {
                         arr_temp = self.dynaticImages;
                         self.url = root_url;
                         imagePath = [NSString stringWithFormat:@"%@/dyn",ads_loc_path];
                     }
                     else {
                         arr_temp = self.staticImages;
                         imagePath = [NSString stringWithFormat:@"%@/static",ads_loc_path];
                     }
                     
                     if (![url_image1 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image1];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         if (data) {
                             image = [[UIImage alloc] initWithData:data];
                             [arr_temp addObject:image];
                             NSString *path = [imagePath stringByAppendingString:@"/pic1.jpeg"];
                             //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
                             [UIImageJPEGRepresentation(image,1) writeToFile:path atomically:YES];
                         }
                     }
                     if (![url_image2 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image2];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         if (data) {
                             image = [[UIImage alloc] initWithData:data];
                             [arr_temp addObject:image];
                             
                             NSString *path = [imagePath stringByAppendingString:@"/pic2.jpeg"];
                             //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
                             [UIImageJPEGRepresentation(image,1) writeToFile:path atomically:YES];
                         }
                     }
                     if (![url_image3 isKindOfClass:[NSNull class]]) {
                         url = [NSString stringWithFormat:@"%@%@",URL_ROOT,url_image3];
                         nsurl = [NSURL URLWithString:url];
                         data = [[NSData alloc] initWithContentsOfURL:nsurl];
                         if (data) {
                             image = [[UIImage alloc] initWithData:data];
                             [arr_temp addObject:image];
                             
                             NSString *path = [imagePath stringByAppendingString:@"/pic3.jpeg"];
                             //把图片直接保存到指定的路径（同时应该把图片的路径imagePath存起来，下次就可以直接用来取）
                             [UIImageJPEGRepresentation(image,1) writeToFile:path atomically:YES];
                         }
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
    [self.deviceDataSource removeAllObjects];
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    NSString* url = [NSString stringWithFormat:@"%@/%zd",URL_DEVICE_LIST,g_user.userNo];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    // Set the label text.
    hud.labelText = NSLocalizedString(@"获取设备列表中...", @"HUD loading title");
    
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
                 dev.isOff = ((NSString*)[dic objectForKey:@"STATE"]).integerValue;
                 [self.deviceDataSource addObject:dev];
             }
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 [hud hide:YES];
                 [self doneLoadingTableViewData];
                 [self.innerMainView.deviceTableView reloadData];
             });
             
             
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [hud hide:YES];
                 [YLToast showWithText:@"获取设备列表失败"];
             });
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
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"设备删除" message:@"您确定要删除该设备吗？" preferredStyle:UIAlertControllerStyleAlert];
    
    DeviceModel* device = [self.deviceDataSource objectAtIndex:indexPath.row];
    
    void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
        
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        
        NSString* url_ads = [NSString stringWithFormat:@"%@/%zd/%@",URL_DELETE_DEVICE,g_user.userNo, device.deviceId];
        [session GET:url_ads parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject) {
                 [self.deviceDataSource removeObjectAtIndex:indexPath.row];
                 // 刷新
                 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
             }
             failure:^(NSURLSessionDataTask *task, NSError *error) {
                 NSLog(@"%@",error);
             }];

    };
    void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    UIAlertAction* destructiveAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:action];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:cancel];
    [alert addAction:destructiveAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
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
    return cell;
}
- (void)reloadTableViewDataSource{
    
    //  should be calling your tableviews data source model to reload
    //  put here just for demo
    self.reloading = YES;
    
    [self getDeviceList];
    
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    self.reloading = NO;
    [self.refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.innerMainView.deviceTableView];
    
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    [self.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    
    [self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    
    return self.reloading; // should return if data source model is reloading
    
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}
@end
