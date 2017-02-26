//
//  MyPageControl.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "MyPageControl.h"


@implementation MyPageControl

-(id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    activeImage = [UIImage imageNamed:@"PageControl_triangle"];
    inactiveImage = [UIImage imageNamed:@"PageControl_image"] ;
    
    return self;
}


-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView * dot = [self.subviews objectAtIndex:i];
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-2, -2, 10, 10)];
        imageView.image = (i == self.currentPage) ? activeImage : inactiveImage;
        [dot addSubview:imageView];
    }
}

-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    //修改图标大小
    for (NSUInteger subviewIndex = 0; subviewIndex < [self.subviews count]; subviewIndex++) {
        
//        UIView* subview = [self.subviews objectAtIndex:subviewIndex];
       
//        CGSize size;
//        
//        size.height = 10;
//        
//        size.width = 10;
//        
//        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
//                                     
//                                     size.width,size.height)];
        
        
    }
    
    
    
    [self updateDots];
}


@end
