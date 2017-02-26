//
//  UGLiveVideoDetailOneCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideoDetailOneCell.h"

@implementation UGLiveVideoDetailOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return  self;
}

-(void)initUI:(LiveVideoModel *)model
{
    _hightOne = 0;
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(10, 10, kScreenWidth-20, 280);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 11;
    [self.contentView addSubview:_backGroundView];
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(30, 20, _backGroundView.width-60, 16);
    _title.font = [UIFont systemFontOfSize:16];
    _title.text = @"本期嘉宾:";
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:_title];
    
    _advanceButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _advanceButn.frame = CGRectMake(_backGroundView.width-60-50, 20, 80, 16);
    //_advanceButn.layer.borderWidth = 0.6;
    _advanceButn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_advanceButn setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
    [_advanceButn setTitle:@"立即预约 >" forState:UIControlStateNormal];
    [_advanceButn addTarget:self action:@selector(clickAdvanceButton) forControlEvents:UIControlEventTouchUpInside];
    if (![model.targetId isEqualToString:@"0"]) {
        [_backGroundView addSubview:_advanceButn];
    }

    
    NSString *text = model.introduce;
    _detail = [[UILabel alloc] init];
    _detail.frame =CGRectMake(30, _title.bottom+5, _title.width, 10);
    _detail.textColor = [UIColor colorWithHexString:@"666666"];
    [_detail heightForLableText:text fontOfSize:13 frame:_detail.frame];
    [_backGroundView addSubview:_detail];
    
    _aspect = [[UILabel alloc] init];
    _aspect.frame = CGRectMake(30, _detail.bottom+15, _title.width, 16);
    _aspect.font = [UIFont systemFontOfSize:16];
    _aspect.text = @"精彩看点:";
    _aspect.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:_aspect];
    
    //NSArray *comingArr = @[@"Townsend Hrris High School,Flushing,New YorkTownsend Hrris High School,Flushing",@"Townsend Hrris High School,Flushing",@"Townsend Hrris High School"];
    NSArray *comingArr;
    if (model.liveNotice) {
         comingArr = @[model.liveNotice];
    }else{
        _hightOne = 100;
    }
   
    CGFloat heightt = 0;
    for (int i = 0; i < comingArr.count; i ++) {
        NSString *str = [NSString stringWithFormat:@"%@",comingArr[i]];
        UILabel *comeSoon = [[UILabel alloc] init];
        comeSoon.textColor = [UIColor colorWithHexString:@"666666"];
        comeSoon.frame = CGRectMake(30, _aspect.bottom+5+heightt, _aspect.width, 10);
        [comeSoon heightForLableText:str fontOfSize:13 frame:comeSoon.frame];
        heightt += comeSoon.height+10;
        [_backGroundView addSubview:comeSoon];
        
        _hightOne = comeSoon.bottom;
    }
    
    _backGroundView.frame = CGRectMake(10, 10, kScreenWidth-20, _hightOne + 20);
    CGRect frame = self.frame;
    frame.size.height = _hightOne + 30;
    self.frame = frame;
}


-(void)clickAdvanceButton
{
    if (_advanceBlock) {
        _advanceBlock();
    }
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
