//
//  UGCustomerServiceView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCustomerServiceView.h"

@interface UGCustomerServiceView ()
@property(strong,nonatomic)UIImageView *backImageView;//背景
@property(strong,nonatomic)UIImageView *arrowImageView;//>箭头
@property(strong,nonatomic)UILabel *titleLabel;//Customer Service
@property(strong,nonatomic)UILabel *detailLabel;//Hi Joan Watson
//@property(strong,nonatomic)UITextView *detailTextView;//Hi Joan Watson
@end

@implementation UGCustomerServiceView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
       // [self initUI:];
        
    }
    return self;
}
-(void)initUI{
    CGFloat kHeight=(kScreenHeight - 49-64 -180)/3;
//    CGFloat kPadding = 40;

    _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.03, 20, kScreenWidth * 0.94, kScreenHeight * 0.19)];
    _backImageView.image = [UIImage imageNamed:@"客服卡片"];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.layer.masksToBounds = YES;
    _backImageView.layer.cornerRadius = 10;
    [_backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];

    [self addSubview:_backImageView];
    
    //Customer Service
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_backImageView.width/2-75, 5, 150, 18)];
    _titleLabel.text = @"优优";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font =[UIFont systemFontOfSize:15];
    [_backImageView addSubview:_titleLabel];
    
    //>箭头
    //_arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backImageView.width-20, 10, 10,10)];
    _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backImageView.width-20, 10, 10,kScreenHeight * 0.02)];

    _arrowImageView.image = [UIImage imageNamed:@"icon_right_in"];
    _arrowImageView.userInteractionEnabled = YES;
    [_backImageView addSubview:_arrowImageView];
    
    //文本
//    _detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(_backImageView.bounds.size.width *0.2  , _backImageView.bounds.size.height * 0.24, _backImageView.bounds.size.width * 0.80   , _backImageView.bounds.size.height * 0.7)];
     _detailTextView = [[UITextView alloc]initWithFrame:CGRectMake(_backImageView.bounds.size.width *0.2  , _backImageView.bounds.size.height * 0.24, _arrowImageView.x - _backImageView.bounds.size.width *0.2  , _backImageView.bounds.size.height * 0.7)];
//    _detailTextView.text = @"Hi~Joan Watson\nWelcome to Urgoo~\nI’m your customer service repreaentative.\nYou can give me a message ,\nif have any problem.\n";
       
    NSString * str1 = @"你好\n欢迎来到urgoo平台，我是您的专职小秘书,有什么问题都可以问我";
    
    
     _detailTextView.text = str1;
    _detailTextView.backgroundColor = [UIColor clearColor];
//    int number = (int)kScreenWidth;
//    switch (number) {
//        case 320:
//            _detailTextView.font =  [UIFont boldSystemFontOfSize:11];
//            break;
//        case 375:
//            _detailTextView.font =  [UIFont boldSystemFontOfSize:13];
//            break;
//        case 414:
//            _detailTextView.font =  [UIFont boldSystemFontOfSize:13];
//            break;
//            
//        default:
//            break;
//    }
//   
       //_detailTextView.font =  [UIFont boldSystemFontOfSize:13];
    _detailTextView.textColor = [UIColor colorWithHexString:@"#ffffff"];
    [_detailTextView setEditable:NO];
    
    _detailTextView.scrollEnabled=NO;
    NSLog(@"22222222222222222-----------%d,%d",(int)kScreenWidth,(int)kScreenHeight);
    [_backImageView addSubview:_detailTextView];
}
-(void)tapAction
{
    _block();
}
@end
