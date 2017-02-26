//
//  UGOrderView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGOrderView.h"

@interface UGOrderView ()
@property(strong,nonatomic)UIImageView *backImageView;//背景
@property(strong,nonatomic)UIImageView *arrowImageView;//>箭头
@property(strong,nonatomic)UILabel *titleLabel;//Customer Service
@property(strong,nonatomic)UILabel *detailLabel;//Hi Joan Watson

@end

@implementation UGOrderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        //[self initUI];
        
    }
    return self;
}
-(void)initUI{
    CGFloat kHeight=(kScreenHeight - 49-64 -180)/3;
    //    CGFloat kPadding = 40;
    
    _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.03, 20, kScreenWidth * 0.94, kScreenHeight * 0.19)];
    _backImageView.image = [UIImage imageNamed:@"订单卡片"];
    _backImageView.userInteractionEnabled = YES;
    _backImageView.layer.masksToBounds = YES;
    _backImageView.layer.cornerRadius = 10;
    [_backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)]];
    
    [self addSubview:_backImageView];
    
    //Customer Service
     _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_backImageView.width * 0.4, 5, _backImageView.frame.size.width * 0.25, _backImageView.frame.size.height * 0.13)];
    //_titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_backImageView.width/2-75, 5, 150, 18)];
    _titleLabel.text = @"留学规划";
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font =[UIFont systemFontOfSize:15];
    [_backImageView addSubview:_titleLabel];
    
    //>箭头
     _arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backImageView.width-20, 10, 10,kScreenHeight * 0.02)];
   //_arrowImageView = [[UIImageView alloc]initWithFrame:CGRectMake(_backImageView.width-20, 10, 10,10)];
    _arrowImageView.image = [UIImage imageNamed:@"icon_right_in"];
    _arrowImageView.userInteractionEnabled = YES;
    [_backImageView addSubview:_arrowImageView];
    
    
    
    //    kHeight-5-18
   // NSArray *titleArrs = @[@"Cindy buy your service (Grade 10)",@"Bee have pay already"];
     //_titleArrs = @[@"Tom 更新了留学规划",@"当前规划"];
    //CGFloat kTitleHeight   = (kHeight-5-18 -40)/3;
    for (NSInteger i=0; i<_titleArrs.count; i++) {
//        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, _arrowImageView.y+_arrowImageView.height+10+5+(kTitleHeight+5)*i + i * 5, kScreenWidth-40-60,kScreenHeight * 0.2 * 0.125)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-40) * 0.22, _arrowImageView.y+  _arrowImageView.height + kScreenHeight * 0.01 +(kScreenHeight * 0.2 * 0.125 +10) *i  , kScreenWidth-40-60,  kScreenHeight * 0.2 * 0.125)];
        

        titleLabel.text = _titleArrs[i];
        //_titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
        titleLabel.font =[UIFont systemFontOfSize:13];
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y + titleLabel.bounds.size.height + 5, titleLabel.bounds.size.width, 0.5)];
        [_backImageView addSubview:view];
        [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor whiteColor]];

        [_backImageView addSubview:titleLabel];
    }
    
}
//绘制虚线的方法

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

-(void)tapAction
{
    _block();
}
@end
