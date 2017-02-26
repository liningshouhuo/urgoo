//
//  SeaveNewCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlanTasksModel.h"

@interface SeaveNewCell : UITableViewCell

@property (nonatomic, strong) UIView *backGroundV;
@property (nonatomic, strong) UIView *borderV;
@property (nonatomic, strong) UILabel *note;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *lastTime;

-(void)initUI:(PlanTasksModel *)model;

@end
