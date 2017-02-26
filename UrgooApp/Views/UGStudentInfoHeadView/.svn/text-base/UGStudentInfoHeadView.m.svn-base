//
//  UGStudentInfoHeadView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGStudentInfoHeadView.h"

@interface UGStudentInfoHeadView ()

@property(strong,nonatomic)UIButton *backBtn;//返回


@property(strong,nonatomic)UIImageView *backImageView; //背景图片
@property(strong,nonatomic)UIImageView *avatorImageView; //头像
@property(strong,nonatomic)UIImageView *verifiedImageView;//认证图片
@property(strong,nonatomic)UILabel *nameLabel;

@property(strong,nonatomic)UILabel *gradeLabel; //年级
@property(strong,nonatomic)UILabel *localLabel; //坐标



@end

@implementation UGStudentInfoHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
//375 *170


#pragma mark - initUI
-(void)initUI
{
    //背景图片
    _backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 170)];
    _backImageView.image = [UIImage imageNamed:@"me_header_bg"];
    _backImageView.userInteractionEnabled = YES;
    [self addSubview:_backImageView];
    
    
    
    //返回
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10 ,20 ,30 ,30);
    [_backBtn setImage:[[UIImage imageNamed:@"me_icon_Setting"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [_backImageView addSubview:_backBtn];
    
    
    
    //头像
    _avatorImageView =[[UIImageView alloc]initWithFrame:CGRectMake(20, 50, 70, 70)];
    _avatorImageView.userInteractionEnabled = YES;
    _avatorImageView.layer.masksToBounds = YES;
    _avatorImageView.image =[UIImage imageNamed:@"bg"];
    _avatorImageView.layer.cornerRadius = 35;
    [_backImageView addSubview:_avatorImageView];
    
    //已认证
    _verifiedImageView =[[UIImageView alloc]initWithFrame:CGRectMake(_avatorImageView.x+10, _avatorImageView.y+_avatorImageView.height-5, _avatorImageView.width-20, 15)];
    _verifiedImageView.userInteractionEnabled = YES;
    _verifiedImageView.image =[UIImage imageNamed:@"me_tag_Verified"];
    [_backImageView addSubview:_verifiedImageView];
    

    //name Cindy
    _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.avatorImageView.x+self.avatorImageView.width+10, self.avatorImageView.center.y, 150, 20)];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.text = @"Cindy";
    _nameLabel.font = [UIFont systemFontOfSize:14];
    _nameLabel.textColor = [UIColor whiteColor];
    [_backImageView addSubview:_nameLabel];
    
    
    
    
    //背景颜色
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _backImageView.height-30, kScreenWidth, 30)];
    bgView.image = [UIImage imageNamed:@"me_header_bg_black"];
    [_backImageView addSubview:bgView];
    
    
    
    
    //名字
    _gradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth/2, 30)];
    _gradeLabel.textAlignment = NSTextAlignmentCenter;
    _gradeLabel.text = @"Grade:10";
    _gradeLabel.font = [UIFont systemFontOfSize:12];
    _gradeLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:_gradeLabel];
    

    
    //坐标
    _localLabel =[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, 0, kScreenWidth/2, 30)];
    _localLabel.textAlignment = NSTextAlignmentCenter;
    _localLabel.text = @"Destination:USA";
    _localLabel.font = [UIFont systemFontOfSize:12];
    _localLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:_localLabel];
    
    //分割线
    UILabel *line1 =[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2-1, 7, 2, 15)];
    line1.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
    [bgView addSubview:line1];
 
}
-(void)backAction
{
    _backBlock();
}


@end
