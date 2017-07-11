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

static NSString* rootCell_identifier = @"rootCell_identifier";

@interface RootViewController () <UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UIScrollView* upScrollView;
@property (nonatomic, strong) UIScrollView* downScrollView;
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
    
    self.upScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.downScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootCell_identifier];
    
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
    self.upScrollView.backgroundColor = [UIColor blueColor];
    self.downScrollView.frame = CGRectMake(0, height - barHeight - scrollViewHeight, width, scrollViewHeight);
    self.downScrollView.backgroundColor = [UIColor grayColor];
    self.tableView.frame = CGRectMake(0, statusHeight + navHeight + CGRectGetHeight(self.upScrollView.frame), width, height - scrollViewHeight * 2 - statusHeight - navHeight - barHeight);
    
    [self layoutScrollView:self.upScrollView images:self.staticAds];
    [self layoutScrollView:self.downScrollView images:self.dynamicAds];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)moments{
    if (!_moments) {
        _moments = [NSMutableArray array];
        _moments = [ForumRecord moments];
    }
    return _moments;
}
- (NSMutableArray *)momentFrames{
    if (!_momentFrames) {
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
#pragma mark ----定时器自动轮播方法----
- (void)autoPlay {
    
    CGFloat width = CGRectGetWidth(self.upScrollView.frame);
    
    //更改scrollView   countOffSet
    //如果偏移量 >= contentSize.width 要先把偏移量置为（0， 0） 再加上一个width
    CGFloat x_staticAds = self.upScrollView.contentOffset.x;//获取偏移量
    CGFloat x_dynamicAds = self.downScrollView.contentOffset.x;//获取偏移量
    if (x_staticAds + width >= self.upScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.upScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.upScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.upScrollView setContentOffset:(CGPointMake(x_staticAds + width, 0)) animated:YES];
    }
    if (x_dynamicAds + width >= self.downScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.downScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.downScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.downScrollView setContentOffset:(CGPointMake(x_dynamicAds + width, 0)) animated:YES];
    }
}

-(void)layoutScrollView:(UIScrollView*)scrollView images:(NSArray*)images
{
    CGFloat width = CGRectGetWidth(scrollView.frame);
    CGFloat height = CGRectGetHeight(scrollView.frame);
    for (int i = 0; i < images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(width * i, 0, width, height))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [images objectAtIndex:i];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(width * images.count, height);//设置内容大小
    scrollView.contentOffset = CGPointMake(0, 0);//设置内容偏移量
    scrollView.pagingEnabled = YES;//打开整屏滑动
    scrollView.showsHorizontalScrollIndicator = NO;
}

-(void)swithch:(id)mySwitch
{
    UISwitch* s = (UISwitch*)mySwitch;
    self.selectDevice.isOff = s.on;
    NSString* temperature = [NSString stringWithFormat:@"温度：%@",self.selectDevice.temperature];
    NSString* tds = [NSString stringWithFormat:@"TDS：%@",self.selectDevice.tds];
    NSString* ph = [NSString stringWithFormat:@"PH：%@",self.selectDevice.ph];
    NSString* isOff = [NSString stringWithFormat:@"远程开关：%@",self.selectDevice.isOff? @"开":@"关"];
    self.dataSource = [NSArray arrayWithObjects:temperature,tds,ph,isOff, nil];
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
    if (self.type == ViewControllerForumType) {
        return self.momentFrames.count;
    }
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:rootCell_identifier];
    if (self.dataSource.count > 0) {
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
            ForumTableViewCell *cell = [ForumTableViewCell momentsTableViewCellWithTableView:tableView];
            cell.momentFrames = self.momentFrames[indexPath.section];
        }
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == ViewControllerForumType) {
        //取数据
        ForumViewModel *momentFrame = self.momentFrames[indexPath.section];
        return momentFrame.cellHeight;
    }
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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
            detail.dataSource = [NSArray arrayWithObjects:temperature,tds,ph,isOff, nil];
            [self.navigationController pushViewController:detail animated:YES];
        }
    }
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
