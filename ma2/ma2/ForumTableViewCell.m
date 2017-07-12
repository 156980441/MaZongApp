//
//  ForumTableViewCell.m
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ForumTableViewCell.h"
#import "ForumBodyView.h"
#import "ForumToolBarView.h"
#import "ForumViewModel.h"
#import "stdafx_MaZongApp.h"

@interface ForumTableViewCell()

//主体
@property (nonatomic,weak) ForumBodyView *bodyView;

//工具条
@property (nonatomic,weak) ForumToolBarView *toolBarView;

@end

@implementation ForumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)momentsTableViewCellWithTableView:(UITableView *)tableView{
    static NSString *reuseID = @"cell";
    ForumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[ForumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        UIImageView *im = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bgg"]];
        //        self.backgroundView = im;
        
        // 阴影
        self.layer.shadowOffset = CGSizeMake(0, 1);  //阴影偏移量
        self.layer.shadowRadius = 1.5;
        self.layer.shadowColor = [UIColor grayColor].CGColor;
        self.layer.shadowOpacity = 1; //阴影透明度
        // 圆角
        self.layer.cornerRadius = 7.0;
        self.layer.masksToBounds = NO;
        
        // 添加子控件
        [self setChildView];
    }
    return self;
}

//添加子控件
- (void)setChildView{
    //Code圈主体
    ForumBodyView *bodyView = [[ForumBodyView alloc] init];
    [self addSubview:bodyView];
    self.bodyView = bodyView;
    
    //工具条
    ForumToolBarView *toolBar = [[ForumToolBarView alloc] init];
    [self addSubview:toolBar];
    self.toolBarView = toolBar;
}

- (void)setMomentFrames:(ForumViewModel *)momentFrames{
    _momentFrames = momentFrames;
    
    //设置子控件的frame
    self.bodyView.frame = momentFrames.momentsBodyFrame;
    self.bodyView.momentFrames = momentFrames;
    self.toolBarView.frame = momentFrames.momentsToolBarFrame;
    self.toolBarView.momentFrames = momentFrames;
}
//设置cell的frame
-(void)setFrame:(CGRect)frame{
    frame.origin.x += circleCellMargin;
    frame.size.width -= circleCellMargin * 2;
    [super setFrame:frame];
}
@end
