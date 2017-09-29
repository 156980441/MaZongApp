//
//  LoginViewViewController.h
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@interface LoginViewViewController : UIViewController
@property (strong, nonatomic) UIImageView* logo;
@property (strong, nonatomic) UITextField *nameTxt;
@property (strong, nonatomic) UITextField *passTxt;
@property (strong, nonatomic) UIButton *loginBtn;
@property (strong, nonatomic) UIButton *registBtn;
@property (strong, nonatomic) UIButton *fogretBtn;
- (BOOL)saveToArchiver:(User*)user;
@end
