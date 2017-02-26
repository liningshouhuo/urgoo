//
//  UGMessageHeadView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMessageHeadView.h"

@interface UGMessageHeadView ()
@property(strong,nonatomic)UIView *backView; //背景
@property(strong,nonatomic)UIImageView *messageImageView; //消息图片
@property(strong,nonatomic)UILabel *assistantLabel;//Assistant
@property(strong,nonatomic)UILabel *messageLabel; //New message(6)

@property(strong,nonatomic)UIImageView *redImageView;//小圆点
@property(strong,nonatomic)UIImageView *rightArrowImageView;//右侧小箭头

@property(strong,nonatomic) UILabel *recentLabel;//Recent Contact
@end


//75+10+28 = 113
@implementation UGMessageHeadView

-(void)is_hideMark:(BOOL)isOr{
    if (isOr) {
         _redImageView.hidden = YES;
    }else{
        _redImageView.hidden = NO;
        [_backView addSubview:_redImageView];
    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        
        self.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
        //背景
        _backView =[[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 75)];
        _backView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backView];
        
        //消息图片
        _messageImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 50 , 50)];
        _messageImageView.image = [UIImage imageNamed:@"message_icon_info"];
        _messageImageView.layer.masksToBounds = YES;
        _messageImageView.layer.cornerRadius = 25;
        _messageImageView.userInteractionEnabled = YES;
        [_backView addSubview:_messageImageView];
        
        
        //Assistant
        _assistantLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.messageImageView.x+self.messageImageView.width+20, self.messageImageView.y+10, 150, 30)];
        _assistantLabel.textAlignment = NSTextAlignmentLeft;
        _assistantLabel.text = @"通知";
        _assistantLabel.font = [UIFont systemFontOfSize:17];
        _assistantLabel.textColor = [UIColor colorWithHexString:@"3b3b3b"];
        [_backView addSubview:_assistantLabel];
        
        
        //New message(6)
        _messageLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.messageImageView.x+self.messageImageView.width+20, self.assistantLabel.y+self.assistantLabel.height+5, 150, 20)];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.text = @"New message(6)";
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor colorWithHexString:@"aea5a5"];
        //[_backView addSubview:_messageLabel];
        
        
        //右侧小箭头
        _rightArrowImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-30, 27, 20, 20)];
        _rightArrowImageView.image = [UIImage imageNamed:@"message_list_icon_into"];
        _rightArrowImageView.userInteractionEnabled = YES;
        [_backView addSubview:_rightArrowImageView];
        
        
        //小圆点
        _redImageView=[[UIImageView alloc]initWithFrame:CGRectMake(_rightArrowImageView.x-15, 34, 6 , 6)];
        _redImageView.image = [UIImage imageNamed:@"message_new_info"];
        _redImageView.layer.masksToBounds = YES;
        _redImageView.layer.cornerRadius = 3;
        _redImageView.userInteractionEnabled = YES;
//        [_backView addSubview:_redImageView];
        
        
        
        [_backView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
        
        
        //Recent contact
        _recentLabel =[[UILabel alloc]initWithFrame:CGRectMake(10,self.height-8-10, 150, 15)];
        _recentLabel.textAlignment = NSTextAlignmentLeft;
        _recentLabel.text = @"Recent contact";
        _recentLabel.font = [UIFont systemFontOfSize:11];
        _recentLabel.textColor = [UIColor colorWithHexString:@"7f7f7f"];
        [self addSubview:_recentLabel];
        
        for (NSInteger i =0; i<2; i++) {
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 74*i, kScreenWidth, 0.5)];
            line1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            [_backView addSubview:line1];
        }
        
        
        UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 112, kScreenWidth, 0.5)];
        line2.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [self addSubview:line2];
        
    }
    return self;
}

-(void)tapAction
{
    _block();
}
@end
