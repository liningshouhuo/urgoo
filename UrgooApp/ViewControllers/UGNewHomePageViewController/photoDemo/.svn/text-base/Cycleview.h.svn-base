//
//  Cycleview.h
//  图片轮播器
//
//  Created by Mac on 16/4/24.
//  Copyright © 2016年 闫龙. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickBannerBlock)(NSInteger bnnerindex);
@interface Cycleview : UIView

@property (copy,nonatomic) ClickBannerBlock bannerBlock;
@property (strong,nonatomic) NSArray * picUrlArray;
- (void)returnText:(ClickBannerBlock)block;
@end
