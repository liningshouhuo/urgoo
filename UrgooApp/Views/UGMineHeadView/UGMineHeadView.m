//
//  UGMineHeadView.m
//  UrgooApp
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMineHeadView.h"


@interface UGMineHeadView ()

@property(strong,nonatomic)UIButton *settingBtn;//设置







@property(assign,nonatomic)CGRect originalHeaderImageViewFrame;

@end


@implementation UGMineHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
//375 *450


#pragma mark - initUI
-(void)initUI
{
    //背景图片
    _backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    UIColor * bgColor=[UIColor colorWithRed:37.0/255 green:175.0/255 blue:153.0/255 alpha:1];
    //_backImageView.image = [UIImage imageNamed:@"me_header_bg"];
   _backImageView.backgroundColor = bgColor;
    //_backImageView.backgroundColor = [UIColor blueColor];
//    _backImageView.backgroundColor = [UIColor colorWithRed:37.0 green:175.0 blue:153.0 alpha:1.0];
    
    _backImageView.userInteractionEnabled = YES;
    _backImageView.clipsToBounds = YES;
    [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_backImageView];
    
    //头像
    _avatorImageView =[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-30, _backImageView.height-140, 70, 70)];
    _avatorImageView.userInteractionEnabled = YES;
    _avatorImageView.layer.masksToBounds = YES;
    _avatorImageView.image =[UIImage imageNamed:@"photo-g"];//头像
    _avatorImageView.layer.cornerRadius = 35;
    [_avatorImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    [_backImageView addSubview:_avatorImageView];
    
    //家长名字
    _parentNameLabel =[[UILabel alloc]initWithFrame:CGRectMake(_avatorImageView.x-10, _avatorImageView.y+_avatorImageView.height+2, _avatorImageView.width+20, 15)];
    _parentNameLabel.userInteractionEnabled = YES;
    _parentNameLabel.text = @"Kevin Garnett";
    _parentNameLabel.textAlignment = NSTextAlignmentCenter;
    _parentNameLabel.font = [UIFont systemFontOfSize:12];
    _parentNameLabel.textColor = [UIColor whiteColor];
    [_backImageView addSubview:_parentNameLabel];
    
    //名字
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_parentNameLabel.x-10, _parentNameLabel.y+_parentNameLabel.height+2, _parentNameLabel.width+20, 20)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = @"Tom";
    _nameLabel.font = [UIFont systemFontOfSize:12];
    _nameLabel.textColor = [UIColor whiteColor];
    //[_backImageView addSubview:_nameLabel];
    
//200+2*kScreenWidth/3
    
    //设置
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _settingBtn.frame = CGRectMake(kScreenWidth-50 ,10 ,50 ,50);
    [_settingBtn setImage:[[UIImage imageNamed:@"my_setting_n"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
   // [_backImageView addSubview:_settingBtn];
    
    //设置按钮太小了--所以再添加一个view在上面好了
    UIView *settingView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth-90, 0, 90, 80)];
    settingView.backgroundColor = [UIColor clearColor];
    [settingView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(settingAction)]];
    [_backImageView addSubview:settingView];
    
    
    
    //背景颜色
    _bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, _backImageView.height-30, kScreenWidth, 30)];
    _bgView.image = [UIImage imageNamed:@"me_header_bg_black"];
    [_backImageView addSubview:_bgView];
    
    
    
    
   
    CGFloat kWidth = kScreenWidth/2;
    //从业经验1~3年
    _experienceLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kWidth, 30)];
    _experienceLabel.textAlignment = NSTextAlignmentCenter;
    _experienceLabel.text = @"就读年级:10";
    _experienceLabel.font = [UIFont systemFontOfSize:12];
    _experienceLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_experienceLabel];
    
    //坐标
    _localLabel =[[UILabel alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, 30)];
    _localLabel.textAlignment = NSTextAlignmentCenter;
    _localLabel.text = @"留学目标国:USA";
    _localLabel.font = [UIFont systemFontOfSize:12];
    _localLabel.textColor = [UIColor whiteColor];
    [_bgView addSubview:_localLabel];
    
    
    //分割线
    UILabel *line1 =[[UILabel alloc]initWithFrame:CGRectMake(kWidth-0.5, 7, 1, 15)];
    line1.backgroundColor = RGB(112, 151, 147);
    [_bgView addSubview:line1];
    
    
    
    
    self.backgroundColor =[UIColor whiteColor];
//    NSArray *titlesArr = @[@"我的顾问",@"订单",@"账户"];
//    NSArray *imgsArr=@[@"Page 1@3x",@"order@3x",@"account@3x"];
//    CGFloat kwidth = kScreenWidth/4;
//    CGFloat margin = kScreenWidth/8;
//    CGFloat kHeight = kScreenWidth/4;
//    for (NSInteger i= 0; i<imgsArr.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame=  CGRectMake(i%3 *(kwidth + margin), _backImageView.height+i/3 *kHeight, kwidth, 56);
//        [button setImage:[UIImage imageNamed:imgsArr[i]] forState:UIControlStateNormal];
//        //[button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        [button setBackgroundColor: [UIColor whiteColor]];
//        button.imageView.contentMode=UIViewContentModeScaleAspectFit;
//        button.tag = 100+i;
//        
//        [self addSubview:button];
//        
//        
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i%3 *(kwidth + margin),  button.y+button.height, kwidth, 30)];
//        titleLabel.text = titlesArr[i];
//        titleLabel.backgroundColor = [UIColor whiteColor];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        titleLabel.font = [UIFont systemFontOfSize:11];
//        titleLabel.userInteractionEnabled = YES;
//        [self addSubview:titleLabel];
//        
//    }
    
    self.originalHeaderImageViewFrame = self.bounds;

}


-(void)updateHeaderImageViewFrameWithOffsetY:(CGFloat)offsetY
{
    //向上滚动的时候，图片不变窄
    if (offsetY>0) {
        return;
    }
    
    //防止height小于0
    if (self.originalHeaderImageViewFrame.size.height-offsetY<0) {
        return;
    }
    
   
    CGFloat x = self.originalHeaderImageViewFrame.origin.x;
    CGFloat y = self.originalHeaderImageViewFrame.origin.y + offsetY;
    CGFloat width  = self.originalHeaderImageViewFrame.size.width;
    CGFloat height = self.originalHeaderImageViewFrame.size.height - offsetY;
    
    
    self.backImageView.frame = CGRectMake(x, y, width, height);
    self.bgView.frame = CGRectMake(0, _backImageView.height-30, kScreenWidth, 30);
    _avatorImageView.frame =CGRectMake(kScreenWidth/2-30, _backImageView.height-140, 70, 70);
    _parentNameLabel.frame=CGRectMake(_avatorImageView.x-10, _avatorImageView.y+_avatorImageView.height+2, _avatorImageView.width+20, 15);
    _nameLabel.frame = CGRectMake(_parentNameLabel.x-10, _parentNameLabel.y+_parentNameLabel.height+2, _parentNameLabel.width+20, 20);
    
    
}

-(void)tapAction
{
    _headBlock();
}
-(void)settingAction
{
    _settingBlock();
}
@end
