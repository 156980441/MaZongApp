//
//  YLToast.h
//  YLUI
//
//  Created by 我叫不紧张 on 16/8/6.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEFAULT_DISPLAY_DURATION 2.0f  

@interface YLToast : NSObject
{
    NSString *_text;
    UIButton *_contentView;
    CGFloat  _duration;
}
+ (void)showWithText:(NSString *) text;

+ (void)showWithText:(NSString *) text duration:(CGFloat)duration;

+ (void)showWithText:(NSString *) text topOffset:(CGFloat) topOffset;

+ (void)showWithText:(NSString *) text topOffset:(CGFloat) topOffset duration:(CGFloat) duration;

+ (void)showWithText:(NSString *) text bottomOffset:(CGFloat) bottomOffset;

+ (void)showWithText:(NSString *) text bottomOffset:(CGFloat) bottomOffset duration:(CGFloat) duration;

@end
