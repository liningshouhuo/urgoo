//
//  UGLiveVideoCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideoCell.h"

@implementation UGLiveVideoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return self;
}

-(void)initUI:(LiveVideoModel *)model
{
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 290);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.contentView addSubview:_backGroundView];
    
    _personImageV = [[UIImageView alloc] init];
    _personImageV.frame = CGRectMake(0, 0, kScreenWidth, 228);
    _personImageV.layer.masksToBounds = YES;
    _personImageV.contentMode = UIViewContentModeScaleAspectFill;
    [_personImageV sd_setImageWithURL:[NSURL URLWithString:model.masterPic] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
    _personImageV.backgroundColor = [UIColor grayColor];
    [_backGroundView addSubview:_personImageV];
    
    NSString *timeDetail = [NSString stringWithFormat:@"%@",model.balanceTime];
    _time = [[UILabel alloc] init];
    if ([model.status isEqualToString:@"1"]) {
        if ([model.balanceTime intValue] > 0) {
            _time.text = timeDetail;
            _time.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
            
            aTimer = [model.balanceTime intValue];
            [self add_timeCountdownStart];
        }else{
            timeDetail = @"进入直播 ";
            _time.text = timeDetail;
            _time.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
            CGSize titleSize = [StringHelper getSizeByString:timeDetail AndFontSize:11];
            _time.frame = CGRectMake(kScreenWidth-20-titleSize.width, 20, titleSize.width+5, 20);
        }
    }else if ([model.status isEqualToString:@"3"]){
        timeDetail = @" 查看回播  ";
        _time.text = timeDetail;
        _time.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        CGSize titleSize = [StringHelper getSizeByString:timeDetail AndFontSize:11];
        _time.frame = CGRectMake(kScreenWidth-20-titleSize.width, 20, titleSize.width+5, 20);
    }else{
        timeDetail = @"已结束  ";
        _time.text = timeDetail;
        _time.backgroundColor = RGBAlpha(0, 0, 0, 0.5);//alph 0.5
        CGSize titleSize = [StringHelper getSizeByString:timeDetail AndFontSize:11];
        _time.frame = CGRectMake(kScreenWidth-20-titleSize.width, 20, titleSize.width+5, 20);
    }
    
    _time.layer.cornerRadius = 10;
    _time.clipsToBounds = YES;
    _time.textAlignment = NSTextAlignmentCenter;
    _time.font = [UIFont systemFontOfSize:11];
    _time.textColor = [UIColor whiteColor];
    //CGSize titleSize = [StringHelper getSizeByString:timeDetail AndFontSize:11];
    //_time.frame = CGRectMake(kScreenWidth-20-titleSize.width, 20, titleSize.width+5, 20);
    [_personImageV addSubview:_time];
    
    NSString *numeberDetail = [NSString stringWithFormat:@"%@人已报名",model.paticipateCount];
    _numeber = [[UILabel alloc] init];
    _numeber.frame = CGRectMake(0, 20, 70, 10);
    _numeber.text = numeberDetail;
    _numeber.textAlignment = NSTextAlignmentCenter;
    _numeber.font = [UIFont systemFontOfSize:11];
    _numeber.textColor = [UIColor colorWithHexString:@"999999"];
    CGSize numeberSize = [StringHelper getSizeByString:numeberDetail AndFontSize:11];
    _numeber.frame = CGRectMake(kScreenWidth-30-numeberSize.width, _personImageV.bottom+5, numeberSize.width+5, 20);
    if ([model.status isEqualToString:@"1"]) {
        [_backGroundView addSubview:_numeber];
    }
    
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(40, _personImageV.bottom+5, kScreenWidth-_numeber.width-10-40, 30);
    _title.text = model.title;
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    _title.font = [UIFont systemFontOfSize:16];
    [_backGroundView addSubview:_title];
    
    _subTitle = [[UILabel alloc] init];
    _subTitle.frame = CGRectMake(40, _title.bottom, kScreenWidth-40, 15);
    _subTitle.text = model.des;
    _subTitle.textColor = [UIColor colorWithHexString:@"666666"];
    _subTitle.font = [UIFont systemFontOfSize:12];
    [_backGroundView addSubview:_subTitle];
    
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
    _time.text = str;
    _time.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
    CGSize titleSize = [StringHelper getSizeByString:str AndFontSize:11];
    _time.frame = CGRectMake(kScreenWidth-20-titleSize.width, 20, titleSize.width+5, 20);
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
