//
//  AdsViewController.m
//  MaZongApp
//
//  Created by 赵雪莹 on 16/10/19.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "AdsViewController.h"

@interface AdsViewController ()

@end

@implementation AdsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //test
//    NSURL *url =[NSURL URLWithString:@"https://www.bing.com"];
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [self.adsWebView loadRequest:request];
    self.adsWebView.scalesPageToFit = YES;
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

- (IBAction)exitBtnPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
