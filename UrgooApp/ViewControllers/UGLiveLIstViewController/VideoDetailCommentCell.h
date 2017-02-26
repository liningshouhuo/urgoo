//
//  VideoDetailCommentCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Ext.h"
#import "LiveVideoCommentModel.h"

@interface VideoDetailCommentCell : UITableViewCell

@property (nonatomic,strong) UIView      *backGroundView;
@property (nonatomic,strong) UIImageView *headImageV;
@property (nonatomic,strong) UILabel     *name;
@property (nonatomic,strong) UILabel     *time;
@property (nonatomic,strong) UILabel     *comment;

-(void)initUI:(LiveVideoCommentModel *)model;

@end
