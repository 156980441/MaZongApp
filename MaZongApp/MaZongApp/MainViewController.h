//
//  MainViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainView;

@interface MainViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet MainView *mainView;

@property (nonatomic, strong) NSMutableArray *deviceDataSource;

@end
