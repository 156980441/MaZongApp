//
//  Common.m
//  DongGuanDaDi
//
//  Created by 我叫不紧张 on 16/8/7.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "YLCommon.h"

@implementation YLCommon
+(NSString*)date2String:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSDate*)string2Date:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date=[formatter dateFromString:string];
    return date;
}
+(NSString*)time2String:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
+(NSDate*)string2time:(NSString*)string
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[formatter dateFromString:string];
    return date;
}
+(NSArray *)getFirstAndLastDayOfThisWeek
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger weekday = [dateComponents weekday];
    //第几天(从sunday开始)
    NSInteger firstDiff,lastDiff;
    if (weekday == 1) {
        firstDiff = -6;
        lastDiff = 0;
    } else {
        firstDiff =  - weekday + 2;
        lastDiff = 8 - weekday;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [firstComponents setDay:day+firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    NSDateComponents *lastComponents = [calendar components:NSWeekdayCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    [lastComponents setDay:day+lastDiff];NSDate *lastDay = [calendar dateFromComponents:lastComponents];
    return [NSArray arrayWithObjects:firstDay,lastDay, nil];
}

+(NSString*)docPath:(NSString*)filename {
    NSArray* myPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* myDocPath = [myPaths objectAtIndex:0];
    NSString* filePath = [myDocPath stringByAppendingPathComponent:filename];
    return filePath;
}

+(UIImage *)initWithColor:(UIColor*)color rect:(CGRect)rect {
    CGRect imgRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    UIGraphicsBeginImageContextWithOptions(imgRect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, imgRect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+(UIImage *)initwithRgba:(CGFloat*)rgba rect:(CGRect)rect{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorRef = CGColorCreate(colorSpace,rgba);
    UIColor *color = [[UIColor alloc]initWithCGColor:colorRef];
    CGColorRelease(colorRef);
    CGColorSpaceRelease(colorSpace);
    
    return [self initWithColor:color rect:rect];
}
@end
