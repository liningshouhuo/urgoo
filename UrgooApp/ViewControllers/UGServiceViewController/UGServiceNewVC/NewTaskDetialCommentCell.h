//
//  NewTaskDetialCommentCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"
#import "NewTaskCommentModel.h"

@interface NewTaskDetialCommentCell : UITableViewCell
{
    UILabel *loading;
    BOOL isLoading;
}

@property (nonatomic,strong) UIView      *backGroundView;
@property (nonatomic,strong) UIImageView *headImageV;
@property (nonatomic,strong) UILabel     *name;
@property (nonatomic,strong) UILabel     *time;
@property (nonatomic,strong) UILabel     *comment;
@property (nonatomic,strong) UIImageView *wordImageV;
@property (nonatomic,strong) UILabel     *wordTitle;

-(void)initUI:(NewTaskCommentModel *)model;

@end
