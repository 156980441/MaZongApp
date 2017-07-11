//
//  RootViewController.m
//  Ma
//
//  Created by 我叫不紧张 on 2017/7/11.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat navBar = self.navigationController.navigationBar.frame.size.height;
    CGFloat statusBar = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat tabBar = self.tabBarController.tabBar.bounds.size.height;
    
    self.view.frame = CGRectMake(0, navBar+statusBar, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - tabBar);
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
