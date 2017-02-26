//
//  SeaveTaskHeardView.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewTaskInforModel.h"

@interface SeaveTaskHeardView : UIView

@property (nonatomic, strong) UIView *backGroundV;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

-(CGRect)initUI:(NewTaskInforModel *)model;

@end
