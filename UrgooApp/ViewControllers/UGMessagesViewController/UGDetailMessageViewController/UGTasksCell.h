//
//  UGTasksCell.h
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ugtaskcellStr = @"ugtaskcellStr";

@interface UGTasksCell : UITableViewCell

@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UILabel *nameLabel;//Cindy submit tasks summer school
@property(strong,nonatomic)UILabel *dateLabel; //时间：04-26 10:30
@property(strong,nonatomic)UIImageView *arrowImageView; //>箭头
@property(strong,nonatomic)UIImageView *redImageView;
@property(strong,nonatomic)UILabel *titleLabel;

+ (instancetype)tasksTableViewCellWithTableView:(UITableView *)tableView;

@end
