//
//  UITabBar+RedDot.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/9/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UITabBar+RedDot.h"

#define TabbarItemNums 4.0    //tabbar的数量
@implementation UITabBar (RedDot)

-(void)showTabBarRedDotOnItemIndex:(int)index
{
    [self removeTabBarRedDotOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 3.5;
    badgeView.backgroundColor = [UIColor redColor];
    CGRect tabFrame = self.frame;
    
    //确定小红点的位置
    float percentX = (index + 0.65) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.1 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 7, 7);
    [self addSubview:badgeView];
}

-(void)hideTabBarRedDotOnItemIndex:(int)index
{
    //移除小红点
    [self removeTabBarRedDotOnItemIndex:index];
}

- (void)removeTabBarRedDotOnItemIndex:(int)index{
    
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        
        if (subView.tag == 888+index) {
            
            [subView removeFromSuperview];
            
        }
    }
}

@end
