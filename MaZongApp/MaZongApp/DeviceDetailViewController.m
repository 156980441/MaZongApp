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

static NSString* deviceDetailCell_identifier = @"deviceCell_identifier";

@interface DeviceDetailViewController ()
@property (nonatomic, strong) MainView *innerMainView;
@end

@implementation DeviceDetailViewController

//这里使用 storyboard  
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    
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
    [NSThread detachNewThreadSelector:@selector(layoutScrollViews:) toTarget:self withObject:self];
}

-(void)layoutScrollViews:(id)userInfo
{
    [NSThread sleepForTimeInterval:1];
    [self.innerMainView setStaticAdsImages:self.s_images withDynamicAdsImages:self.d_images];
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
        [cell.contentView addSubview:s];
    }
    return cell;
}

@end
