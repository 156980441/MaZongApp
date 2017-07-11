//
//  ForumToolBarView.m
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ForumToolBarView.h"
#import "stdafx_MaZongApp.h"
#import "UIColor+HexString.h"
#import "ForumViewModel.h"
#import "ForumRecord.h"

@interface ForumToolBarView ()

@property (nonatomic ,weak) UIButton *likeBtn;
@property (nonatomic ,weak) UIButton *commentBtn;

@end

@implementation ForumToolBarView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加子控件
        [self setChildView];
        self.layer.cornerRadius = 7.0;
        self.layer.masksToBounds = NO;
    }
    return self;
}

- (void)setChildView{
    self.backgroundColor = [UIColor colorWithHexString:@"#555555"];
    //点赞
    UIButton *likeBtn = [[UIButton alloc] init];
    [likeBtn setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
    //    [likeBtn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    [likeBtn setTitleColor:circleCellToolBarTintColor forState:UIControlStateNormal];
    likeBtn.titleLabel.font = circleCellToolBarTittleFont;
    [self addSubview:likeBtn];
    self.likeBtn = likeBtn;
    
    //评论
    UIButton *commentBtn = [[UIButton alloc] init];
    [commentBtn setImage:[UIImage imageNamed:@"comment"] forState:UIControlStateNormal];
    [commentBtn setTitleColor:circleCellToolBarTintColor forState:UIControlStateNormal];
    commentBtn.titleLabel.font = circleCellToolBarTittleFont;
    [self addSubview:commentBtn];
    self.commentBtn = commentBtn;
}
- (void)setMomentFrames:(ForumViewModel *)momentFrames{
    _momentFrames = momentFrames;
    self.likeBtn.frame = momentFrames.toolLikeFrame;
    [self.likeBtn setTitle:[NSString stringWithFormat:@" %@",momentFrames.moment.like_count] forState:UIControlStateNormal];
    
    self.commentBtn.frame = momentFrames.toolCommentFrame;
    [self.commentBtn setTitle:[NSString stringWithFormat:@" %@",momentFrames.moment.comment_count] forState:UIControlStateNormal];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
