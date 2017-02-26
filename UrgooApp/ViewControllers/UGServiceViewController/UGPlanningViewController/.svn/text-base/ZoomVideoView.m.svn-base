//
//  ZoomVideoView.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/12.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "ZoomVideoView.h"

@implementation ZoomVideoView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //[self initUI];
    }
    return self;
}

-(void)initUIData:(ZoomVideoModel *)model
{
    _backImageView = [[UIImageView alloc] init];
    _backImageView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    _backImageView.image = [UIImage imageNamed:@"zoomVideobg"];
    _backImageView.userInteractionEnabled = YES;
    [self addSubview:_backImageView];
    
    UIImageView *imageBackView = [[UIImageView alloc] init];
    imageBackView.frame = CGRectMake(0, 0, 107, 107);
    imageBackView.center = CGPointMake(kScreenWidth/2, kScreenHeight/5);
    imageBackView.backgroundColor = [UIColor whiteColor];
    imageBackView.layer.cornerRadius = 107/2;
    imageBackView.clipsToBounds = YES;
    [_backImageView addSubview:imageBackView];
    
    _heardImageV = [[UIImageView alloc] init];
    _heardImageV.frame = CGRectMake(2, 2, 103, 103);
    //_heardImageV.image = [UIImage imageNamed:@"头像"];
    [_heardImageV sd_setImageWithURL:[NSURL URLWithString:model.pic] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    _heardImageV.clipsToBounds = YES;
    _heardImageV.layer.cornerRadius = 103/2;
    [imageBackView addSubview:_heardImageV];
    
    _name = [[UILabel alloc] init];
    _name.frame = CGRectMake(0, imageBackView.bottom+17, kScreenWidth, 22);
    if (!model.nickname) {
       _name.text = @"---";
    }else{
        _name.text = model.nickname;
    }
    _name.textAlignment = NSTextAlignmentCenter;
    _name.font = [UIFont systemFontOfSize:20];
    _name.textColor = [UIColor colorWithHexString:@"ffffff"];
    [_backImageView addSubview:_name];
    
    UILabel *note  = [[UILabel alloc] init];
    note.frame = CGRectMake(0, _name.bottom+10, kScreenWidth, 17);
    note.text = @"邀请你视频聊天";
    note.textAlignment = NSTextAlignmentCenter;
    note.font = [UIFont systemFontOfSize:15];
    note.textColor = [UIColor colorWithHexString:@"ffffff"];
    [_backImageView addSubview:note];
    

    CGFloat sizeR = 84*kScreenWidth/375;
    _rejectButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rejectButn.frame = CGRectMake(55*kScreenWidth/375, kScreenHeight/6*5-sizeR, sizeR, sizeR);
    _rejectButn.backgroundColor = [UIColor colorWithHexString:@"ff4e45"];
    _rejectButn.titleLabel.font = [UIFont systemFontOfSize:15];
    _rejectButn.layer.cornerRadius = sizeR/2;
    _rejectButn.clipsToBounds = YES;
    [_rejectButn setTitle:@"拒绝" forState:UIControlStateNormal];
    [_rejectButn addTarget:self action:@selector(clickReject) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_rejectButn];
  
    _acceptButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _acceptButn.frame = CGRectMake(kScreenWidth - 55*kScreenWidth/375-sizeR, kScreenHeight/6*5-sizeR, sizeR, sizeR);
    _acceptButn.backgroundColor = [UIColor colorWithHexString:@"0fb967"];
    _acceptButn.titleLabel.font = [UIFont systemFontOfSize:15];
    _acceptButn.layer.cornerRadius = sizeR/2;
    _acceptButn.clipsToBounds = YES;
    [_acceptButn setTitle:@"接受" forState:UIControlStateNormal];
    [_acceptButn addTarget:self action:@selector(clickAccept) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_acceptButn];
    
}

-(void)clickReject
{
    if (_rejectBlock) {
        _rejectBlock();
    }
}

-(void)clickAccept
{
    if (_acceptBlock) {
        _acceptBlock();
    }
}


@end
