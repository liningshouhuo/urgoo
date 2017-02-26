//
//  UGLiveVideoCell.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveVideoModel.h"

@interface UGLiveVideoCell : UITableViewCell
{
    int aTimer;
    int hourT;
    int minuteT;
    int secondT;
    int days;
}

@property (nonatomic,strong) UIView      *backGroundView;
@property (nonatomic,strong) UIImageView *personImageV;
@property (nonatomic,strong) UILabel     *time;
@property (nonatomic,strong) UILabel     *numeber;
@property (nonatomic,strong) UILabel     *title;
@property (nonatomic,strong) UILabel     *subTitle;
@property (strong,nonatomic) NSTimer     *timer;//预约计时

@property (nonatomic,strong) LiveVideoModel *liveVideoModel;

-(void)initUI:(LiveVideoModel *)model;

@end
