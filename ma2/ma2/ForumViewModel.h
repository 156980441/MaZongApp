//
//  ForumViewModel.h
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ForumRecord;

@interface ForumViewModel : NSObject

/**
 *  数据模型
 */
@property (nonatomic ,strong) ForumRecord *moment;

/**
 *  主体Frame
 */
@property (nonatomic ,assign) CGRect momentsBodyFrame;

//昵称Frame
@property (nonatomic ,assign) CGRect bodyNameFrame;
//头像Frame
@property (nonatomic ,assign) CGRect bodyIconFrame;
//时间Frame
@property (nonatomic ,assign) CGRect bodyTimeFrame;
//正文Frame
@property (nonatomic ,assign) CGRect bodyTextFrame;
//图片Frame
@property (nonatomic ,assign) CGRect bodyPhotoFrame;

/**
 *  工具条Frame
 */
@property (nonatomic, assign) CGRect momentsToolBarFrame;

//点赞Frame
@property (nonatomic ,assign) CGRect toolLikeFrame;
//评论Frame
@property (nonatomic ,assign) CGRect toolCommentFrame;

/**
 *  cell高度
 */
@property (nonatomic ,assign) CGFloat cellHeight;

@end
