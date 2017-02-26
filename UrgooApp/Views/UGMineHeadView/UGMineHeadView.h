//
//  UGMineHeadView.h
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^HeadViewImageViewBlock)();
typedef void (^SettingBtnBlock)();
@interface UGMineHeadView : UIView


@property(strong,nonatomic)UIImageView *backImageView; //背景图片
@property(strong,nonatomic)UIImageView *avatorImageView; //头像
//@property(strong,nonatomic)UIImageView *verifiedImageView;

//@property(strong,nonatomic)UIImageView *verifiedImageView;
@property(strong,nonatomic)UILabel *parentNameLabel; //家长名字



@property(strong,nonatomic)UIImageView *bgView;//灰色背景

@property(strong,nonatomic)UILabel *nameLabel; //名字
@property(strong,nonatomic)UILabel *experienceLabel; //从业经验1~3年
@property(strong,nonatomic)UILabel *localLabel; //坐标



//375 *450

//200 + 2*kScreenWidth/3

@property(copy,nonatomic)HeadViewImageViewBlock headBlock;
@property(copy,nonatomic)SettingBtnBlock settingBlock;




-(void)updateHeaderImageViewFrameWithOffsetY:(CGFloat)offsetY;

@end
