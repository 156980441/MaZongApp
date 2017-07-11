//
//  ForumRecord.h
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ForumRecord : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *comment_count;
@property (nonatomic, copy) NSString *like_count;
@property (nonatomic, strong) NSArray *photos;

- (instancetype)initWithDic:(NSDictionary *)dic;
+ (instancetype)initWithDic:(NSDictionary *)dic;

+ (NSMutableArray *)moments;
@end
