//
//  Common.h
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * getDocumentDirectory(void);
FOUNDATION_EXPORT NSString * getLibraryDirectory(void);
FOUNDATION_EXPORT NSString * getBundleDirectory(void);

FOUNDATION_EXPORT NSString * date2Str(NSDate* date);
FOUNDATION_EXPORT NSDate * str2Date(NSString* str, NSString* format);

@interface YLCommon : NSObject

// yyyy-MM-dd
+(NSString*)date2String:(NSDate*)date;
+(NSDate*)string2Date:(NSString*)string;

+(NSString*)time2String:(NSDate*)date;
+(NSDate*)string2time:(NSString*)string;

+(NSArray *)getFirstAndLastDayOfThisWeek;

+(NSString*)docPath:(NSString*)filename;

+(UIImage *)initWithColor:(UIColor*)color rect:(CGRect)rect;
+(UIImage *)initwithRgba:(CGFloat*)rgba rect:(CGRect)rect;
@end
