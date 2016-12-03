//
//  User.h
//  MaZongApp
//
//  Created by fanyunlong on 2016/11/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;

extern User* g_user;

@interface User : NSObject
@property(nonatomic,strong) NSString* name;
@property (nonatomic, strong) NSString *pass;
@property (nonatomic, assign) NSInteger userNo;
@property (nonatomic, assign) NSInteger cityId;
@end
