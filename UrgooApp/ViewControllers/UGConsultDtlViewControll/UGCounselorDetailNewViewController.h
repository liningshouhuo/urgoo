//
//  UGCounselorDetailNewViewController.h
//  client
//
//  Created by IOS开发者 on 16/7/7.
//  Copyright © 2016年 IOS开发者. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDetailsModel.h"

@interface UGCounselorDetailNewViewController :BaseViewController

@property (strong, nonatomic) NSString *counselorId;
@property (strong, nonatomic) NSString *isJPush;

@property (strong, nonatomic) NSString *byTabBar;//由于导航条的原因，再改进
@property (strong, nonatomic) NSString *byGuanZhu;

-(void)shareWeiXin:(ShareDetailsModel *)model;

@end
