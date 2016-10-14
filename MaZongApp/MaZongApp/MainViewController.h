//
//  MainViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIScrollView *staticAdsScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *dynamicAdsScrollView;
@property (strong, nonatomic) IBOutlet UITableView *deviceTableView;
@property (nonatomic, strong) NSMutableArray *deviceDataSource;
@property (nonatomic, strong) NSMutableArray *adsImages;
@end
