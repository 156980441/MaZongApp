//
//  AdsViewController.h
//  MaZongApp
//
//  Created by 赵雪莹 on 16/10/19.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *adsWebView;
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;
- (IBAction)exitBtnPress:(id)sender;

@end
