//
//  MainViewController.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "DeviceDetailViewController.h"
#import "DeviceModel.h"

static NSString* deviceCell_identifier = @"deviceCell_identifier";

@interface MainViewController ()
@property (nonatomic, strong) DeviceModel *selectedDevice;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设备列表";
    self.deviceDataSource = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        DeviceModel* deviceModel = [[DeviceModel alloc] init];
        deviceModel.name = [NSString stringWithFormat:@"设备 %d",i];
        deviceModel.temperature = @"21.6";
        deviceModel.tds = @"200";
        deviceModel.ph = @"3.3";
        deviceModel.isOff = YES;
        [self.deviceDataSource addObject:deviceModel];
    }
    
    [self.deviceTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:deviceCell_identifier];
    
    //定时轮播
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
    
    self.adsImages = [NSMutableArray array];
    for (int i = 1; i < 4; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_00%d.JPG",i]];
        [self.adsImages addObject:image];
    }
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.staticAdsScrollView.frame);
    for (int i = 0; i < self.adsImages.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(width * i, 0, width, height))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [self.adsImages objectAtIndex:i];
        [self.staticAdsScrollView addSubview:imageView];
    }
    self.staticAdsScrollView.contentSize = CGSizeMake(width * self.adsImages.count, height);//设置内容大小
    self.staticAdsScrollView.contentOffset = CGPointMake(width, 0);//设置内容偏移量
    self.staticAdsScrollView.pagingEnabled = YES;//打开整屏滑动
    self.staticAdsScrollView.showsHorizontalScrollIndicator = NO;
    
    self.adsImages = [NSMutableArray array];
    for (int i = 4; i < 7; i ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"IMG_00%d.JPG",i]];
        [self.adsImages addObject:image];
    }
    for (int i = 0; i < self.adsImages.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(width * i, 0, width, height))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [self.adsImages objectAtIndex:i];
        [self.dynamicAdsScrollView addSubview:imageView];
    }
    self.dynamicAdsScrollView.contentSize = CGSizeMake(width * self.adsImages.count, height);//设置内容大小
    self.dynamicAdsScrollView.contentOffset = CGPointMake(width, 0);//设置内容偏移量
    self.dynamicAdsScrollView.pagingEnabled = YES;//打开整屏滑动
    self.dynamicAdsScrollView.showsHorizontalScrollIndicator = NO;
    
}

#pragma mark ----定时器自动轮播方法----
- (void)autoPlay {
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    
    //更改scrollView   countOffSet
    //如果偏移量 >= contentSize.width 要先把偏移量置为（0， 0） 再加上一个width
    CGFloat x_staticAds = self.staticAdsScrollView.contentOffset.x;//获取偏移量
    CGFloat x_dynamicAds = self.dynamicAdsScrollView.contentOffset.x;//获取偏移量
    if (x_staticAds + width >= self.staticAdsScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.staticAdsScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.staticAdsScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.staticAdsScrollView setContentOffset:(CGPointMake(x_staticAds + width, 0)) animated:YES];
    }
    if (x_dynamicAds + width >= self.dynamicAdsScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(x_dynamicAds + width, 0)) animated:YES];
    }
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
    DeviceDetailViewController* deviceDetail = (DeviceDetailViewController*)[segue destinationViewController];
    deviceDetail.device = self.selectedDevice;
}

#pragma - mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedDevice = [self.deviceDataSource objectAtIndex:indexPath.row];
    DeviceDetailViewController* deviceDetail = [[DeviceDetailViewController alloc] init];
    deviceDetail.device = self.selectedDevice;
    [self.navigationController pushViewController:deviceDetail animated:YES];
}
#pragma - mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.deviceDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:deviceCell_identifier];
    DeviceModel* device = [self.deviceDataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = device.name;
    return cell;
}
@end
