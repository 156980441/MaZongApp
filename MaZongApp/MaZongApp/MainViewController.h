//
//  MainViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView;
@class User;

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *mainView;

@property (nonatomic, strong) NSMutableArray *deviceDataSource;
@property (nonatomic, strong) User *user;

@end
