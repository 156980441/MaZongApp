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
@property(nonatomic,strong) NSString* username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) NSInteger userNo;
@property (nonatomic, assign) NSInteger cityId;
@end

@interface NSObject (YLObject)
- (void) initFromDictionary:(NSDictionary *)dic;
@end
