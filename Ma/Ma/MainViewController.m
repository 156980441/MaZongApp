//
//  MainViewController.m
//  Ma
//
//  Created by 我叫不紧张 on 2017/7/11.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "MainViewController.h"
#import "RootViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadViewControllers];
    
}

- (void)loadViewControllers
{
    RootViewController* devices = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    devices.title = @"Devices";
    devices.tabBarItem.title = @"device";
    RootViewController* forum = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:[NSBundle mainBundle]];
    forum.title = @"forum";
    forum.tabBarItem.title = @"forum";
    
    UINavigationController* nav1 = [[UINavigationController alloc] initWithRootViewController:devices];
    UINavigationController* nav2 = [[UINavigationController alloc] initWithRootViewController:forum];
    
    self.viewControllers = @[nav1,nav2];
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
