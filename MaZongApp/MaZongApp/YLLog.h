//
//  YLLog.h
//  YLSDK
//
//  Created by fanyunlong on 2016/11/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLLog : NSObject
+(void)openLog;
+(void)closeLog;
+(void)writeLog:(NSString*)log;
+(void)readyGetTime;
+(NSString*)costTime;
@end
