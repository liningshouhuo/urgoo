//
//  UGLiveVideodetailHeadView.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideodetailHeadView.h"

@implementation UGLiveVideodetailHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //[self initUI];
    }
    return self;
}

-(void)initUI:(LiveVideoModel *)model
{
    _liveVideoModel = model;
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 375);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [self addSubview:_backGroundView];
    
    _personImageV = [[UIImageView alloc] init];
    _personImageV.frame =CGRectMake(0, 0, _backGroundView.width, 250);
    _personImageV.layer.masksToBounds = YES;
    _personImageV.contentMode = UIViewContentModeScaleAspectFill;
    [_personImageV sd_setImageWithURL:[NSURL URLWithString:model.masterPic] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
    _personImageV.userInteractionEnabled = YES;
    [_backGroundView addSubview:_personImageV];
    
    
    _videoButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _videoButn.frame = CGRectMake(_backGroundView.width-71-15, _personImageV.bottom-36, 71, 21);
    _videoButn.layer.cornerRadius = 10;
    _videoButn.clipsToBounds = YES;
    _videoButn.enabled = NO;
    _videoButn.titleLabel.font = [UIFont systemFontOfSize:12];
    
    NSString *statuTitle;
    if ([model.status isEqualToString:@"2"]) {
        _videoBlock(_liveVideoModel,nil,@"2");
        statuTitle = @" 已结束 ";
        [_videoButn setTitle:statuTitle forState:UIControlStateNormal];
        _videoButn.backgroundColor = RGBAlpha(0, 0, 0, 0.5);
    }else if ([model.status isEqualToString:@"3"]){
        _videoBlock(_liveVideoModel,nil,@"2");
        statuTitle = @" 查看回播 ";
        _videoButn.enabled = YES;
        [_videoButn setTitle:statuTitle forState:UIControlStateNormal];
        _videoButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    }else if ([model.status isEqualToString:@"1"]){
        
        if ([model.balanceTime intValue] > 0) {
            aTimer = [model.balanceTime intValue];
            //aTimer = 10;
            [self add_timeCountdownStart];
        }else{
            
            _videoButn.enabled = YES;
            _videoBlock(_liveVideoModel,nil,@"1");
            statuTitle = @"进入直播";
            [_videoButn setTitle:statuTitle forState:UIControlStateNormal];
            _videoButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];;
            
        }
    }
    [_videoButn addTarget:self action:@selector(clickVideo) forControlEvents:UIControlEventTouchUpInside];
    [_personImageV addSubview:_videoButn];
    
    
    NSString *numeberDetail = [NSString stringWithFormat:@"%@人已报名",model.paticipateCount];
    _numeber = [[UILabel alloc] init];
    _numeber.frame = CGRectMake(0, 20, 70, 10);
    _numeber.text = numeberDetail;
    _numeber.textAlignment = NSTextAlignmentCenter;
    _numeber.font = [UIFont systemFontOfSize:11];
    _numeber.textColor = [UIColor colorWithHexString:@"999999"];
    CGSize numeberSize = [StringHelper getSizeByString:numeberDetail AndFontSize:11];
    _numeber.frame = CGRectMake(kScreenWidth-40-numeberSize.width, _personImageV.bottom+10, numeberSize.width+5, 20);
    if ([model.status isEqualToString:@"1"]) {
        [_backGroundView addSubview:_numeber];
    }
    
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(40, _personImageV.bottom+10, kScreenWidth-_numeber.width-40, 30);
    _title.text = model.title;
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    _title.font = [UIFont systemFontOfSize:16];
    [_backGroundView addSubview:_title];
    
    _subTitle = [[UILabel alloc] init];
    _subTitle.frame = CGRectMake(40, _title.bottom-5, kScreenWidth-50, 35);
    _subTitle.numberOfLines = 2;
    _subTitle.text = model.des;
    _subTitle.textColor = [UIColor colorWithHexString:@"666666"];
    _subTitle.font = [UIFont systemFontOfSize:12];
    [_backGroundView addSubview:_subTitle];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(20, _subTitle.bottom, kScreenWidth-40, 0.6);
    line.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [_backGroundView addSubview:line];
    
    NSString *timeNote = model.liveStartTime;
    _timeNote = [[UILabel alloc] init];
    _timeNote.frame = CGRectMake(40, line.bottom+10, kScreenWidth-45, 15);
    _timeNote.text = [NSString stringWithFormat:@"直播时间: %@",timeNote];
    _timeNote.font = [UIFont systemFontOfSize:11];
    _timeNote.textColor = [UIColor colorWithHexString:@"999999"];
    [_backGroundView addSubview:_timeNote];
    
    NSString *timeLong;
    if (model.liveTimeLong) {
        timeLong = [self KaddTimeLong:[model.liveTimeLong intValue]];
    }
    _timeLong = [[UILabel alloc] init];
    _timeLong.frame = CGRectMake(40, _timeNote.bottom+10, kScreenWidth-45, 15);
    _timeLong.text = [NSString stringWithFormat:@"直播时长: %@",timeLong];
    _timeLong.font = [UIFont systemFontOfSize:11];
    _timeLong.textColor = [UIColor colorWithHexString:@"999999"];
    [_backGroundView addSubview:_timeLong];
    
    
    _personDataButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _personDataButn.frame = CGRectMake(_backGroundView.width-80-25, _timeLong.y, 80, 15);
    _personDataButn.titleLabel.font = [UIFont systemFontOfSize:11];
    [_personDataButn setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
    [_personDataButn setImage:[UIImage imageNamed:@"click_arror_more"] forState:UIControlStateNormal];
    [_personDataButn setTitle:@"查看嘉宾详情" forState:UIControlStateNormal];
    [_personDataButn setImageEdgeInsets:UIEdgeInsetsMake(5, 70, 5, 0)];
    [_personDataButn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [_personDataButn addTarget:self action:@selector(clickPersonData) forControlEvents:UIControlEventTouchUpInside];
    
    if (![_liveVideoModel.targetId isEqualToString:@"0"]) {
        
        [_backGroundView addSubview:_personDataButn];
        
    }
    
    
}

-(void)add_timeCountdownStart
{
    _timer =[NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(add_timeCountdown) userInfo:nil repeats:YES];
    [_timer fire];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

-(void)add_timeCountdown
{
    hourT = (int)(aTimer/3600);
    minuteT = (int)(aTimer - hourT*3600)/60;
    secondT = aTimer - hourT*3600 - minuteT*60;
    
    days = (int)aTimer/3600/24;
    
    NSString *str;
    if (aTimer <= 0){
        
        DLog(@"倒计时结束,预约时间到了---");
        _timeIsUp = @"Time is up";
        _videoBlock(_liveVideoModel,nil,@"1");
        _videoButn.enabled = YES;
        str = [NSString stringWithFormat:@"进入直播"];
        [self changeTitle:str];
        [_timer invalidate];//结束计时
        
    }else{
        
        if (days > 0) {
            str = [NSString stringWithFormat:@"%d天后开始",days];
        }else if( days == 0){
            if (hourT > 0) {
                str = [NSString stringWithFormat:@"%d小时后开始",hourT];
            }else if( hourT == 0){
                if (minuteT > 0) {
                    str = [NSString stringWithFormat:@"%d分钟后开始",minuteT];
                }else if( minuteT == 0){
                    str = [NSString stringWithFormat:@"%d秒后开始",secondT];
                }
            }
        }
        
        [self changeTitle:str];
    }
    
    aTimer --;
}

-(void)changeTitle:(NSString *)str
{
    [_videoButn setTitle:str forState:UIControlStateNormal];
    _videoButn.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    CGSize videoTitleSize = [StringHelper getSizeByString:str AndFontSize:12];
    _videoButn.frame = CGRectMake(_backGroundView.width-15-videoTitleSize.width, _personImageV.bottom-36, videoTitleSize.width+5, 21);
}


-(void)clickVideo
{
    if (_videoBlock) {
        _videoBlock(_liveVideoModel,@"isUp",nil);//@"1"
    }
}
-(void)clickPersonData
{
    if (_personDataBlock) {
        _personDataBlock(_liveVideoModel.targetId);
    }
}

-(NSString *)KaddTimeLong:(int)timeZ
{
    NSString *str;
    int hour;
    int minute;
    int second;
    int day;
    hour = (int)(timeZ/3600);
    minute = (int)(timeZ - hour*3600)/60;
    second = timeZ - hour*3600 - minute*60;
    
    day = (int)timeZ/3600/24;
    
    if (day > 0) {
        str = [NSString stringWithFormat:@"%d天",day];
    }else{
        if (hour > 0) {
            str = [NSString stringWithFormat:@"%d小时",hour];
        }else{
            if (minute > 0) {
                str = [NSString stringWithFormat:@"%d分钟",minute];
            }else{
                str = [NSString stringWithFormat:@"%d秒",second];
            }
        }
    }
    return str;
}

@end
