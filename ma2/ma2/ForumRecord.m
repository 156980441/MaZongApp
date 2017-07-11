//
//  ForumRecord.m
//  ma2
//
//  Created by 赵雪莹 on 2017/7/12.
//  Copyright © 2017年 fanyunlong. All rights reserved.
//

#import "ForumRecord.h"

@implementation ForumRecord
- (instancetype)initWithDic:(NSDictionary *)dic{
    if (self = [super init]) {
        //KVC赋值
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

+ (instancetype)initWithDic:(NSDictionary *)dic{
    return [[self alloc] initWithDic:dic];
}

+(NSMutableArray *)moments{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Moments.plist" ofType:nil];
    NSArray *dicArr = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dic in dicArr) {
        ForumRecord *moment = [ForumRecord initWithDic:dic];
        [arr addObject:moment];
    }
    return arr;
}


@end
