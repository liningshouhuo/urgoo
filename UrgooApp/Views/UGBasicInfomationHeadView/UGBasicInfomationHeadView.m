//
//  UGBasicInfomationHeadView.m
//  UrgooApp
//
//  Created by admin on 16/3/3.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGBasicInfomationHeadView.h"


@interface UGBasicInfomationHeadView ()
@property(strong,nonatomic)UIView *backView;
@end


@implementation UGBasicInfomationHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

-(void)initUI
{
    self.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    
    _backView =[[UIView alloc]initWithFrame:CGRectMake(0, 8, kScreenWidth, 77)];
    _backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    line1.backgroundColor = [UIColor lightGrayColor];
    line1.alpha = 0.5;
    [_backView addSubview:line1];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 76.5, kScreenWidth, 0.5)];
    line2.backgroundColor = [UIColor lightGrayColor];
    line2.alpha = 0.5;
    [_backView addSubview:line2];
    

    
    

    //height 75 +10 +10 = 95
    _iconIv=[[UIImageView alloc]initWithFrame:CGRectMake(15, 11, 50, 50)];
    _iconIv.image = [UIImage imageNamed:@"photo-g"];
    _iconIv.layer.masksToBounds = YES;
    _iconIv.layer.cornerRadius = 25;
    _iconIv.userInteractionEnabled = YES;
    
    
    _photoLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconIv.x+_iconIv.width + 10, 11+10, 50, 30)];
    _photoLabel.text = @"头像";
    [_backView addSubview:_photoLabel];
    
    [_iconIv addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    [_backView addSubview:_iconIv];
}
-(void)tapAction
{
    _changeblock();
}
@end
