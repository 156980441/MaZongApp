//
//  MainView.m
//  MaZongApp
//
//  Created by fanyunlong on 16/10/14.
//  Copyright © 2016年 fanyl. All rights reserved.
//

#import "MainView.h"

@interface MainView ()
@property (nonatomic, strong) NSArray* staticImages;
@property (nonatomic, strong) NSArray* dynamicImages;
@end

@implementation MainView
+ (instancetype) viewFromNIB
{
    // 加载xib中的视图，其中xib文件名和本类类名必须一致
    // 这个xib文件的File's Owner必须为空
    // 这个xib文件必须只拥有一个视图，并且该视图的class为本类
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    return views[0];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    // 视图内容布局
    [super awakeFromNib]; 

}

#pragma mark ----定时器自动轮播方法----
- (void)autoPlay {
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    //更改scrollView   countOffSet
    //如果偏移量 >= contentSize.width 要先把偏移量置为（0， 0） 再加上一个width
    CGFloat x_staticAds = self.staticAdsScrollView.contentOffset.x;//获取偏移量
    CGFloat x_dynamicAds = self.dynamicAdsScrollView.contentOffset.x;//获取偏移量
    if (x_staticAds + width >= self.staticAdsScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.staticAdsScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.staticAdsScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.staticAdsScrollView setContentOffset:(CGPointMake(x_staticAds + width, 0)) animated:YES];
    }
    if (x_dynamicAds + width >= self.dynamicAdsScrollView.contentSize.width) {//判断增加后的偏移量是否超过范围
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(0, 0)) animated:NO];//先把偏移量置为（0，0）
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(width, 0)) animated:YES];//再偏移width宽度
    }else {
        [self.dynamicAdsScrollView setContentOffset:(CGPointMake(x_dynamicAds + width, 0)) animated:YES];
    }
}
-(void)setStaticAdsImages:(NSArray*)staticImages withDynamicAdsImages:(NSArray*)dynamicImages
{
    self.staticImages = [NSArray arrayWithArray:staticImages];
    self.dynamicImages = [NSArray arrayWithArray:dynamicImages];
    [self layoutScrollView:self.staticAdsScrollView images:self.staticImages];
    [self layoutScrollView:self.dynamicAdsScrollView images:self.dynamicImages];
    // 定时轮播
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoPlay) userInfo:nil repeats:YES];
}
-(void)layoutScrollView:(UIScrollView*)scrollView images:(NSArray*)images
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.staticAdsScrollView.frame);
    for (int i = 0; i < images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRectMake(width * i, 0, width, height))];
        imageView.contentMode = UIViewContentModeScaleToFill;
        imageView.image = [images objectAtIndex:i];
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(width * images.count, height);//设置内容大小
    scrollView.contentOffset = CGPointMake(width, 0);//设置内容偏移量
    scrollView.pagingEnabled = YES;//打开整屏滑动
    scrollView.showsHorizontalScrollIndicator = NO;
}

@end
