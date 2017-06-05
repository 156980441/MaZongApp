//
//  ConfigWifiViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 2017/6/5.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfigWifiViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *wifiTextField;
@property (weak, nonatomic) IBOutlet UITextField *passTextFiled;
- (IBAction)configWifiBtn:(id)sender;

@end
