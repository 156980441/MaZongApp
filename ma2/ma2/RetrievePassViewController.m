//
//  RetrievePassViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/9/28.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "RetrievePassViewController.h"

@interface RetrievePassViewController ()

@end

@implementation RetrievePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.mailTextFiled = [[UITextField alloc] init];
    self.mailTextFiled.borderStyle = UITextBorderStyleRoundedRect;

    self.modfiyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.modfiyBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.modfiyBtn.layer.cornerRadius = 5;
    self.modfiyBtn.tintColor = [UIColor whiteColor];
    [self.modfiyBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.modfiyBtn setBackgroundColor:[UIColor colorWithRed:83/255.0 green:149/255.0 blue:232/255.0 alpha:1]];
    
    
    [self.view addSubview:self.mailTextFiled];
    [self.view addSubview:self.modfiyBtn];
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat navHeight = self.navigationController.navigationBar.frame.size.height;
    
    NSLayoutConstraint *name_top = [NSLayoutConstraint constraintWithItem:self.mailTextFiled attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:statusHeight + navHeight + 30];
    NSLayoutConstraint *name_left = [NSLayoutConstraint constraintWithItem:self.mailTextFiled attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:60.0];
    NSLayoutConstraint *name_right = [NSLayoutConstraint constraintWithItem:self.mailTextFiled attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-60];
    NSLayoutConstraint *name_hight = [NSLayoutConstraint constraintWithItem:self.mailTextFiled attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:30];
    
    NSLayoutConstraint *bt_top = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.mailTextFiled attribute:NSLayoutAttributeBottom multiplier:1.0 constant:40];
    NSLayoutConstraint *bt_left = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.mailTextFiled attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_right = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.mailTextFiled attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    NSLayoutConstraint *bt_hight = [NSLayoutConstraint constraintWithItem:self.modfiyBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.mailTextFiled attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0];
    
    NSArray *array = [NSArray arrayWithObjects:
                      name_top, name_left, name_right, name_hight,
                      bt_top,bt_left,bt_right,bt_hight,
                      nil];
    [self.view addConstraints:array];
    
    
    [self.modfiyBtn addTarget:self action:@selector(confirmBtnPress:) forControlEvents:UIControlEventTouchDown];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
