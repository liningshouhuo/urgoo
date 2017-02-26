//
//  UGAccountCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/4/26.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *ugaccountcellStr = @"ugaccountcellStr";

@interface UGAccountCell : UITableViewCell

@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UILabel *nameLabel;//
@property(strong,nonatomic)UILabel *dateLabel; //时间：04-26 10:30
@property(strong,nonatomic)UIImageView *arrowImageView; //>箭头
@property(strong,nonatomic)UIImageView *redImageView; //红点

+ (instancetype)accountTableViewCellWithTableView:(UITableView *)tableView;

@end
