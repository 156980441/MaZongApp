//
//  MainView.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
@property (strong, nonatomic) IBOutlet UIScrollView *staticAdsScrollView;
@property (strong, nonatomic) IBOutlet UIScrollView *dynamicAdsScrollView;
@property (strong, nonatomic) IBOutlet UITableView *deviceTableView;
@end
