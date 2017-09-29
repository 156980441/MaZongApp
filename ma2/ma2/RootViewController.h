//
//  RootViewController.h
//  ma2
//
//  Created by fanyunlong on 2017/7/11.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic,copy) NSMutableArray* dataSource;
@end
