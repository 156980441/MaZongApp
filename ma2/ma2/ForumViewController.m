//
//  ForumViewController.m
//  ma2
//
//  Created by fanyunlong on 2017/9/29.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ForumViewController.h"
#import "ForumRecord.h"
#import "ForumViewModel.h"
#import "ForumTableViewCell.h"
#import "stdafx_MaZongApp.h"

#import "AFHTTPSessionManager.h"

#import "MBProgressHUD.h"
#import "YLToast.h"

@interface ForumViewController ()
@property (nonatomic,strong) NSMutableArray *moments;      //数据模型
@property (nonatomic,strong) NSMutableArray *momentFrames; //ViewModel(包含cell子控件的Frame)
@end

@implementation ForumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataSource = self.momentFrames;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)moments{
    if (!_moments) {
        _moments = [ForumRecord moments];
    }
    return _moments;
}
- (NSMutableArray *)momentFrames{
    if (!_momentFrames) {
        _momentFrames = [NSMutableArray array];
        //数据模型 => ViewModel(包含cell子控件的Frame)
        for (ForumRecord *moment in self.moments) {
            ForumViewModel *momentFrame = [[ForumViewModel alloc] init];
            momentFrame.moment = moment;
            [self.momentFrames addObject:momentFrame];
        }
    }
    return _momentFrames;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    if (self.dataSource.count > 0) {
        
        {
            cell = [ForumTableViewCell momentsTableViewCellWithTableView:tableView];
            ForumTableViewCell* forumCell = (ForumTableViewCell*)cell;
            forumCell.momentFrames = self.momentFrames[indexPath.row];
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s",__func__);
    
        //取数据
        ForumViewModel *momentFrame = self.momentFrames[indexPath.row];
        return momentFrame.cellHeight;
   
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s",__func__);
    // indexPath.row 是从 0 开始的
    if (self.dataSource.count > 0) {
        
    }
}

@end
