//
//  RootViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "RootViewController.h"
#import "stdafx_MaZongApp.h"
#import "LoginViewViewController.h"
#import "User.h"

#import "AFHTTPSessionManager.h"
#import "SDCycleScrollView.h"
#import "MBProgressHUD.h"
#import "YLToast.h"

static NSString* rootCell_identifier = @"rootCell_identifier";

@interface RootViewController () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView* upScrollView;
@property (nonatomic, strong) SDCycleScrollView* downScrollView;
@property (nonatomic, strong) NSMutableArray* staticAds;
@property (nonatomic, strong) NSMutableArray* dynamicAds;
@end

@implementation RootViewController

-(instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    
    [self.view addSubview:self.upScrollView];
    [self.view addSubview:self.downScrollView];
    [self.view addSubview:self.tableView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!g_user.password) {
        LoginViewViewController* loginVc = [[LoginViewViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:loginVc];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
