//
//  MainView.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainView : UIView
+ (instancetype) viewFromNIB;
@property (strong, nonatomic) IBOutlet UIScrollView *staticAdsScrollView;
@property (strong, nonatomic) IBOutlet UITableView *deviceTableView;
@property (strong, nonatomic) IBOutlet UIScrollView *dynamicAdsScrollView;
-(void)setStaticAdsImages:(NSArray*)staticImages withDynamicAdsImages:(NSArray*)dynamicImages;
-(void)setStaticAdsImages:(NSArray*)staticImages;
-(void)setDynamicAdsImages:(NSArray*)dynamicImages;
@end
