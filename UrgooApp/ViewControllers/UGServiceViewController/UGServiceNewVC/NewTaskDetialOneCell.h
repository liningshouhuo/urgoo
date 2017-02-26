//
//  NewTaskDetialOneCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"
#import "NewTaskInforModel.h"

@interface NewTaskDetialOneCell : UITableViewCell

@property (nonatomic, strong) UIView *backGroundV;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *content;

-(void)initUI:(NewTaskInforModel *)model;

@end
