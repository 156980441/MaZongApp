//
//  YLLog.m
//  YLSDK
//
//  Created by fanyunlong on 2016/11/8.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "YLLog.h"
#import "YLCommon.h"

#include <time.h>
#include <sys/stat.h>
#import <mach/mach_time.h>

static BOOL openLog = NO;
static uint64_t startTime = 0;
static uint64_t endTime = 0;

#define FILE_MAX_SIZE (1024*1024*100)
#define FILE_PATH_LENGTH 255

static char g_filename[FILE_PATH_LENGTH]= {0};

long get_file_size(char* filename)
{
    long length = 0;
    FILE *fp = NULL;
    fp = fopen(filename, "rb");
    if (fp != NULL)
    {
        fseek(fp, 0, SEEK_END);
        length = ftell(fp);
    }
    if (fp != NULL)
    {
        fclose(fp);
        fp = NULL;
    }
    return length;
}

void get_local_time(char* buffer)
{
    time_t rawtime;
    struct tm* timeinfo;
    time(&rawtime);
    timeinfo = localtime(&rawtime);
    sprintf(buffer, "%04d-%02d-%02d %02d:%02d:%02d ",
            (timeinfo->tm_year+1900), timeinfo->tm_mon + 1, timeinfo->tm_mday,
            timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
}

/*
 写入日志文件
 @param filename [in]: 日志文件名
 @param max_size [in]: 日志文件大小限制
 @param buffer [in]: 日志内容
 @param buf_size [in]: 日志内容大小
 @return 空
 */
void write_log_file(char* filename,long max_size, char* buffer, unsigned buf_size)
{
    if (filename != NULL && buffer != NULL)
    {
        // 文件超过最大限制, 删除
        long length = get_file_size(filename);
        if (length > max_size)
        {
            remove(filename); // 删除文件
        }
        // 写日志
        {
            FILE *fp;
            fp = fopen(filename, "at+");
            if (fp != NULL)
            {
                char now[32];
                memset(now, 0, sizeof(now));
                get_local_time(now);
                fwrite(now, strlen(now)+1, 1, fp);
                fwrite(buffer, buf_size, 1, fp);
                char huanhang = '\n';
                fwrite(&huanhang, 1, 1, fp);
                fclose(fp);
                fp = NULL;
            }
        }
    }
}

@implementation YLLog
+(void)openLog
{
    openLog = YES;
}
+(void)closeLog
{
    openLog = NO;
}
+(void)writeLog:(NSString*)log
{
    if (openLog) {
        
        NSLog(@"YLSDK LOG %@",log);
        
        if (!g_filename[0]) {
            time_t timep;
            time(&timep);
            struct tm* p;
            p = localtime(&timep);
            char s[100];
            strftime(s, sizeof(s), "%Y%m%d%H%M%S", p);
            
            const char* ret = [getDocumentDirectory() UTF8String];
            
            sprintf(g_filename, "%s/Logs", ret);
            mkdir(g_filename,0777);
            sprintf(g_filename, "%s/Logs/sdk_log_%s.txt", ret, s);
            
        }
        write_log_file(g_filename, FILE_MAX_SIZE, (char*)[log cStringUsingEncoding:NSUTF8StringEncoding], (unsigned)[log lengthOfBytesUsingEncoding:NSUTF8StringEncoding] + 1);
    }
}

+(void)readyGetTime
{
    startTime = mach_absolute_time ();    //开始时间;
}

+(NSString*)costTime
{
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) return @"time error";
    endTime = mach_absolute_time ();     //结束时间
    uint64_t elapsed = endTime - startTime;
    uint64_t nanos = elapsed * info.numer / info.denom;
    return [NSString stringWithFormat:@"%f",(float)nanos / NSEC_PER_SEC];
}

@end
