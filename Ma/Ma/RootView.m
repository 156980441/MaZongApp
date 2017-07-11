//
//  RootView.m
//  Ma
//
//  Created by 我叫不紧张 on 2017/7/11.
//  Copyright © 2017年 fanyl. All rights reserved.
//

#import "RootView.h"

@implementation RootView

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"RootView" owner:self options:nil] objectAtIndex:0];
        [self addSubview:view];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
