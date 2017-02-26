//
//  UGSystemCell.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString *ugsystemcellStr = @"ugsystemcellStr";

@interface UGSystemCell : UITableViewCell

@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UIImageView *arrowImageView; //箭头
@property(strong,nonatomic)UIImageView *redImageView; //红点
@property(strong,nonatomic)UILabel *nameLabel;//Urgoo2.0 online
@property(strong,nonatomic)UILabel *detailLable;
@property(strong,nonatomic)UILabel *dateLabel; //2016-03-03

+ (instancetype)systemTableViewCellWithTableView:(UITableView *)tableView;

@end
