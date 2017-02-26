//
//  UGBasicInfomationHeadView.h
//  UrgooApp
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void(^ChangeHeadImageViewBlock)();

@interface UGBasicInfomationHeadView : UIView
//height 75 +10 +17 = 102
@property(strong,nonatomic)UIImageView *iconIv;
@property(strong,nonatomic) UILabel *photoLabel;



@property(copy,nonatomic)ChangeHeadImageViewBlock changeblock;

@end
