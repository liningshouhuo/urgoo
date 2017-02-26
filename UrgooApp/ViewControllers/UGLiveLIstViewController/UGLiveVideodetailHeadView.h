//
//  UGLiveVideodetailHeadView.h
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveVideoModel.h"

typedef void(^VideoBlock)(LiveVideoModel *model,NSString *timeIsUp,NSString *timeState);
typedef void(^PersonDataBlock)(NSString *counselorId);

@interface UGLiveVideodetailHeadView : UIView
{
    int aTimer;
    int hourT;
    int minuteT;
    int secondT;
    int days;
}

@property (nonatomic,strong) UIView      *backGroundView;
@property (nonatomic,strong) UIImageView *personImageV;
@property (nonatomic,strong) UIButton    *videoButn;
@property (nonatomic,strong) UIButton    *personDataButn;
@property (nonatomic,strong) UILabel     *numeber;
@property (nonatomic,strong) UILabel     *title;
@property (nonatomic,strong) UILabel     *subTitle;
@property (nonatomic,strong) UILabel     *timeNote;
@property (nonatomic,strong) UILabel     *timeLong;
@property (strong,nonatomic) NSTimer     *timer;//预约计时
@property (copy,nonatomic)   NSString    *timeIsUp;
@property (copy,nonatomic)   NSString    *timeState;//1.直播 2.结束

@property (nonatomic,strong) VideoBlock       videoBlock;
@property (nonatomic,strong) PersonDataBlock  personDataBlock;
@property (nonatomic,strong) LiveVideoModel   *liveVideoModel;

-(void)initUI:(LiveVideoModel *)model;

@end
