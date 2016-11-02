//
//  User.m
//  MaZongApp
//
//  Created by fanyunlong on 2016/11/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "User.h"

@implementation User
- (void) encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.pass forKey:@"pass"];
}
-(id)initWithCoder:(NSCoder *)encoder
{
    self.pass = [encoder decodeObjectForKey:@"pass"];
    self.name = [encoder decodeObjectForKey:@"name"];
    return self;
}
@end
