//
//  ForumTableViewCell.h
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumViewModel;
/*
 主体 body
 配图 pic
 工具条 tool
 */

@interface ForumTableViewCell : UITableViewCell
+ (instancetype)momentsTableViewCellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) ForumViewModel *momentFrames;

@end
