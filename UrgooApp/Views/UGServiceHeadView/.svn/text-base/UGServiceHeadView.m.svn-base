//
//  UGServiceHeadView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/24.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGServiceHeadView.h"


@interface UGServiceHeadView ()
@property(strong,nonatomic)UIImageView *backImageView;
@end

@implementation UGServiceHeadView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
#pragma mark - initUI
-(void)initUI{
    self.backgroundColor = [UIColor whiteColor];
   
    //_backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
    _backImageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight * 0.22)];
//    UIImage * image = [UIImage imageNamed:@"me_header_bg"];
//    _backImageView.image = image;
        _backImageView.image = [UIImage imageNamed:@"banner_change"];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.clipsToBounds = YES;
    //[_backImageView setContentMode:UIViewContentModeScaleAspectFit];
    [_backImageView setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:_backImageView];
    
    //150+kScreenWidth*2/3
    
    //NSArray *titlesArr = @[@"找顾问",@"我的关注",@"预约安排",@"我的订单",@"账户",@"留学规划",@"任务情况",@"学期报告"];
    NSArray *titlesArr = @[@"任务情况",@"学期报告",@"留学规划"];
    //NSArray *imgsArr=@[@"service_icon_search",@"service_icon_myattention",@"service_icon_schedule",@"service_icon_order",@"service_icon_account",@"service_icon_planning",@"service_icon_tasks",@"service_icon_report"];
    
    NSArray *imgsArr=@[@"service_icon_tasks",@"service_icon_report",@"service_icon_planning"];
    //CGFloat viewX = (index % col ) * (viewW + margin);
    //CGFloat viewY = (index / col ) * (viewH + 10);
    CGFloat kWidth = kScreenWidth/4;
    CGFloat margin = kScreenWidth/8;
    CGFloat kHeight = kScreenWidth/4;
    for (NSInteger i= 0; i<imgsArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=  CGRectMake(i%3 *(kWidth + margin), kScreenHeight * 0.22 + 5 +i/3 *kHeight, kWidth, kScreenHeight * 0.07);
        //button.frame=  CGRectMake(i%3 *(kWidth + margin), 205+i/3 *kHeight, kWidth, kHeight-35);
        [button setImage:[UIImage imageNamed:imgsArr[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setBackgroundColor: [UIColor whiteColor]];
        button.imageView.contentMode=UIViewContentModeScaleAspectFit;
        button.tag = 100+i;
    
   // [self addSubview:button];
    
    
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i%3 *(kWidth + margin),  button.y+button.height +10, kWidth, 12)];
        titleLabel.text = titlesArr[i];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:11];
        titleLabel.textColor = [UIColor colorWithHexString:@"434343"];
        
        titleLabel.userInteractionEnabled = YES;
        //[self addSubview:titleLabel];
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 10+titleLabel.y +titleLabel.height, kScreenWidth, 0.5 )];
        lineView.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        //lineView.backgroundColor = [UIColor colorWithHexString:@"434343"];
        //lineView.backgroundColor = [UIColor redColor];
        //[self addSubview:lineView];
        
    
//    UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(i%3 *kWidth, 200, 0.5, kWidth )];
//    lineLabel1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
//    [self addSubview:lineLabel1];
    }
    
    
}

-(void)buttonAction:(UIButton *)button
{
    _underBlock(button.tag);
}

@end
