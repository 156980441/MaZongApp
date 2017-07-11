//
//  RootViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) UIScrollView* upScrollView;
@property (nonatomic, strong) UIScrollView* downScrollView;
@property (nonatomic, strong) UITableView* tableView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.upScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.downScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
