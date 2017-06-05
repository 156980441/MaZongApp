//
//  User.m
//  MaZongApp
//
//  Created by fanyunlong on 2016/11/2.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "User.h"
#import <objc/runtime.h>

@implementation User

User* g_user = nil;

- (void) encodeWithCoder:(NSCoder *)encoder
{
    //获取某个类的所有成员变量
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    //归档
    for (int i = 0; i < count; i ++) {
        Ivar aIvar = ivarList[i];
        //获取成员变量的名称
        const char *iVarName = ivar_getName(aIvar);
        id value = [self valueForKey:[NSString stringWithUTF8String:iVarName]];
        if (!value) {
            
        }else {
            [encoder encodeObject:value forKey:[NSString stringWithUTF8String:iVarName]];
        }
    }
}
-(id)initWithCoder:(NSCoder *)encoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivarList = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i ++) {
            Ivar aIvar = ivarList[i];
            const char *name = ivar_getName(aIvar);
            id value = [encoder decodeObjectForKey:[NSString stringWithUTF8String:name]];
            if (!value) {
                
            }else {
                [self setValue:value forKey:[NSString stringWithUTF8String:name]];
            }
        }
        
    }
    return self;
}
@end



@implementation NSObject (YLObject)

- (void) initFromDictionary:(NSDictionary *)dic
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i ++) {
        objc_property_t aProperty = propertyList[i];
        //获取属性名
        const char *name = property_getName(aProperty);
        
        id value = dic[[NSString stringWithUTF8String:name]];
        if (!value) {
            
        }else {
            //使用kvc给属性赋值
            [self setValue:value forKey:[NSString stringWithUTF8String:name]];
        }
    }
}

@end
