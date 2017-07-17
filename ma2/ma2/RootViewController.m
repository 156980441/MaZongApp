//
//  RootViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "RootViewController.h"
#import "stdafx_MaZongApp.h"
#import "DeviceModel.h"
#import "ForumRecord.h"
#import "ForumViewModel.h"
#import "ForumTableViewCell.h"
#import "AddDeviceViewController.h"
#import "ConfigWifiViewController.h"
#import "ConfigUserViewController.h"
#import "LoginViewViewController.h"
#import "User.h"

#import "AFHTTPSessionManager.h"
#import "SDCycleScrollView.h"

static NSString* rootCell_identifier = @"rootCell_identifier";

@interface RootViewController () <UITableViewDataSource,UITableViewDelegate,SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView* upScrollView;
@property (nonatomic, strong) SDCycleScrollView* downScrollView;
@property (nonatomic, strong) UITableView* tableView;

@property (nonatomic, strong) NSMutableArray* staticAds;
@property (nonatomic, strong) NSMutableArray* dynamicAds;

@property (nonatomic,strong) NSMutableArray *moments;      //数据模型
@property (nonatomic,strong) NSMutableArray *momentFrames; //ViewModel(包含cell子控件的Frame)

@property ViewControllerType type;
@end

@implementation RootViewController

-(instancetype)initWithType:(ViewControllerType)type
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _type = type;
    _staticAds = [NSMutableArray array];
    _dynamicAds = [NSMutableArray array];
    
#ifdef LOC_TEST
    for (int i = 1; i <= 3; i++) {
        NSString* path = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"up%d",i] ofType:@"jpg"];
        UIImage* image = [UIImage imageWithContentsOfFile:path];
        [_staticAds addObject:image];
        [_dynamicAds addObject:image];
    }
#else
#endif
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 三方库 SDCycleScrollView bug，如果不先添加一个， self.upScrollView 不显示
//    SDCycleScrollView *cycleScrollView22 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:self.staticAds];
//    cycleScrollView22.delegate = self;
//    cycleScrollView22.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
//    [self.view addSubview:cycleScrollView22];
//    self.upScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:self.staticAds];
//    self.upScrollView.delegate = self;
    
    // 三方库 SDCycleScrollView 使用此方法初始化就没有问题，不愧是推荐的方法。
    self.upScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.upScrollView.localizationImageNamesGroup = self.staticAds;
    
    self.downScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero shouldInfiniteLoop:YES imageNamesGroup:self.dynamicAds];
    self.downScrollView.delegate = self;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if (self.type != ViewControllerForumType) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootCell_identifier];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self.momentFrames;
    }
    
    
    [self.view addSubview:self.upScrollView];
    [self.view addSubview:self.downScrollView];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.type == ViewControllerDeviceType && !g_user.password) {
        LoginViewViewController* loginVc = [[LoginViewViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat barHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    CGFloat scrollViewHeight = 70;
    
    self.upScrollView.frame = CGRectMake(0, statusHeight + navHeight, width, scrollViewHeight);
    self.downScrollView.frame = CGRectMake(0, height - barHeight - scrollViewHeight, width, scrollViewHeight);
    self.tableView.frame = CGRectMake(0, statusHeight + navHeight + CGRectGetHeight(self.upScrollView.frame), width, height - scrollViewHeight * 2 - statusHeight - navHeight - barHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)moments{
    if (!_moments) {
        NSLog(@"%s",__func__);
        _moments = [ForumRecord moments];
    }
    return _moments;
}
- (NSMutableArray *)momentFrames{
    if (!_momentFrames) {
        NSLog(@"%s",__func__);
        _momentFrames = [NSMutableArray array];
        //数据模型 => ViewModel(包含cell子控件的Frame)
        for (ForumRecord *moment in self.moments) {
            ForumViewModel *momentFrame = [[ForumViewModel alloc] init];
            momentFrame.moment = moment;
            [self.momentFrames addObject:momentFrame];
        }
    }
    return _momentFrames;
}

-(void)swithch:(id)mySwitch
{
    UISwitch* s = (UISwitch*)mySwitch;
    self.selectDevice.isOff = s.on;
    NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.selectDevice.temperature];
    NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.selectDevice.tds];
    NSString* ph = [NSString stringWithFormat:@"PH：%@",self.selectDevice.ph];
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.selectDevice.isOff? @"开":@"关"];
    self.dataSource = [NSMutableArray arrayWithObjects:temperature,tds,ph,isOff, nil];
    [self.tableView reloadData];
#ifdef LOC_TEST
#else
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSString* url_ads = [NSString stringWithFormat:@"%@/%@/%d",URL_CHANGE_DEVICE_STATE,self.device.deviceId, self.device.isOff];
    [session GET:url_ads parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {
             NSLog(@"%@",responseObject);
         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             NSLog(@"%@",error);
         }];
#endif
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%s",__func__);
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    UITableViewCell* cell = nil;
    if (self.dataSource.count > 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:rootCell_identifier];
        if (self.type == ViewControllerDeviceType) {
            DeviceModel* device = [self.dataSource objectAtIndex:indexPath.row];
            cell.textLabel.text = device.name;
        } else if (self.type == ViewControllerDetailType)
        {
            cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
            if (indexPath.row == 3) {
                UISwitch* s = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetWidth(cell.contentView.frame), 5, 40, CGRectGetHeight(cell.contentView.frame) - 10)];
                [s setOn:self.selectDevice.isOff animated:YES];
                [s addTarget:self action:@selector(swithch:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:s];
            }
        } else if (self.type == ViewControllerMineType)
        {
            cell.textLabel.text = [self.dataSource objectAtIndex:indexPath.row];
        } else if (self.type == ViewControllerForumType)
        {
            cell = [ForumTableViewCell momentsTableViewCellWithTableView:tableView];
            ForumTableViewCell* forumCell = (ForumTableViewCell*)cell;
            forumCell.momentFrames = self.momentFrames[indexPath.row];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    if (self.type == ViewControllerForumType) {
        //取数据
        ForumViewModel *momentFrame = self.momentFrames[indexPath.row];
        return momentFrame.cellHeight;
    }
    else
    {
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    // indexPath.row 是从 0 开始的
    if (self.dataSource.count > 0) {
        if (self.type == ViewControllerDeviceType) {
            RootViewController* detail = [[RootViewController alloc] initWithType:ViewControllerDetailType];
            detail.selectDevice = [self.dataSource objectAtIndex:indexPath.row];
            self.selectDevice = detail.selectDevice;
            detail.title = self.selectDevice.name;
            NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.selectDevice.temperature];
            NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.selectDevice.tds];
            NSString* ph = [NSString stringWithFormat:@"PH：%@",self.selectDevice.ph];
            NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.selectDevice.isOff? @"开":@"关"];
            detail.dataSource = [NSMutableArray arrayWithObjects:temperature,tds,ph,isOff, nil];
            [self.navigationController pushViewController:detail animated:YES];
        } else if (self.type == ViewControllerMineType) {
            UIViewController* vc = nil;
            if (0 == indexPath.row) {
                vc = [[AddDeviceViewController alloc] init];
            }
            if (1 == indexPath.row) {
                vc = [[ConfigWifiViewController alloc] init];
            }
            if (2 == indexPath.row) {
                vc = [[ConfigUserViewController alloc] init];
            }
            if (3 == indexPath.row) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"用户注销" message:@"您确定要注销用户吗？" preferredStyle:UIAlertControllerStyleAlert];
                
                void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
                    LoginViewViewController* login = [[LoginViewViewController alloc] init];
                    [self presentViewController:login animated:YES completion:nil];
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
            if (4 == indexPath.row) {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"版本 1.0" preferredStyle:UIAlertControllerStyleAlert];
                
                void (^cancel)(UIAlertAction* action) = ^(UIAlertAction* action){
                    [self dismissViewControllerAnimated:YES completion:nil];
                };
                UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:cancel];
                [alert addAction:cancelAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
/**
 *  修改Delete按钮文字为“删除”
 */
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == ViewControllerDeviceType)
        return @"删除";
    else
        return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type == ViewControllerDeviceType) {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"设备删除" message:@"您确定要删除该设备吗？" preferredStyle:UIAlertControllerStyleAlert];
        
        DeviceModel* device = [self.dataSource objectAtIndex:indexPath.row];
        
        void (^action)(UIAlertAction* action) = ^(UIAlertAction* action){
            
            AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
            
            NSString* url_ads = [NSString stringWithFormat:@"%@/%zd/%@",URL_DELETE_DEVICE,g_user.userNo, device.deviceId];
            [session GET:url_ads parameters:nil
                 success:^(NSURLSessionDataTask *task, id responseObject) {
                     [self.dataSource removeObjectAtIndex:indexPath.row];
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
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
