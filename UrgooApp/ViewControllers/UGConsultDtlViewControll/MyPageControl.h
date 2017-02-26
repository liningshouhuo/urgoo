//
//  MyPageControl.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageControl : UIPageControl

{
    UIImage* activeImage;
    UIImage* inactiveImage;
}

- (id)initWithFrame:(CGRect)frame;


@end

/*

 MyPageControl *pageControl = [[MyPageControl alloc] initWithFrame:CGRectMake(0,0, 200, 30)];
 pageControl.backgroundColor = [UIColor clearColor];
 pageControl.numberOfPages = 5;
 pageControl.currentPage = 0;
 [self.view addSubview:pageControl];

*/