//
//  SeaveNewHeadView.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SeaveNewHeadView.h"

@implementation SeaveNewHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //[self initUI];//133
    }
    return self;
}

-(void)initUI:(PlanDataModel *)planDataModel
{
    _typeArr = [NSMutableArray array];
    _reportId = planDataModel.reportId;
    
    NSArray *planArr = [NSArray arrayWithArray:planDataModel.listType];
    NSMutableArray *doneArr = [NSMutableArray array];
    for (PlanHeaderModel *model in planArr) {
        NSString *doneStr = [NSString stringWithFormat:@"已完成%@项",model.done];
        [doneArr addObject:doneStr];
        [_typeArr addObject:model.type];
    }
    
    _backGroundV = [[UIView alloc] init];
    _backGroundV.frame =CGRectMake(0, 0, kScreenWidth, 133);
    _backGroundV.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [self addSubview:_backGroundV];
    
    titles = [NSArray array];
    titles = @[@"语言能力",@"学术能力",@"批判思维",@"领导力",@"自我认知",@"创造力"];
    //NSArray *subTitle = @[@"已完成0项",@"已完成0项",@"已完成0项",@"已完成0项",@"已完成0项",@"已完成0项"];
    NSArray *subTitle = doneArr;
    NSArray *color = @[@"26bdab",@"43a5ed",@"b578ff",@"ffbb40",@"fa86ff",@"ff7878"];
    for (int i = 0; i < 6; i ++) {
        
        UILabel *subLable = [[UILabel alloc] init];
        subLable.frame = CGRectMake(0, 27, (kScreenWidth-12*4)/3, 15);
        subLable.text = subTitle[i];
        subLable.font = [UIFont systemFontOfSize:11];
        subLable.textColor = [UIColor colorWithHexString:color[i]];
        subLable.textAlignment = NSTextAlignmentCenter;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(12 + i *((kScreenWidth-12*4)/3+11), 13, (kScreenWidth-12*4)/3 , 48);
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.titleLabel.numberOfLines = 2;
        button.tag = 100 + i;
        button.layer.borderWidth = 0.2;
        button.layer.borderColor = RGBAlpha(130, 130, 130, 0.5).CGColor;
        button.layer.cornerRadius = 4;
        button.layer.shadowRadius = 4;
        button.layer.shadowColor = RGBAlpha(130, 130, 130, 0.5).CGColor;
        button.layer.shadowOffset = CGSizeMake(0, 1.5);
        button.layer.shadowOpacity = 0.5;
        
        if (i > 2) {
            button.frame = CGRectMake(12 + (i-3) *((kScreenWidth-12*4)/3+11), 72, (kScreenWidth-12*4)/3, 48);
        }
        [button setTitle:[NSString stringWithFormat:@"%@\n",titles[i]]  forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:color[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [button addSubview:subLable];
        [_backGroundV addSubview:button];
        
    }
    
    NSString *titleStr = [NSString stringWithFormat:@"距离下一次的视频见面还有%@天",planDataModel.nextTime];
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(11, _backGroundV.bottom, kScreenWidth, 43);
    _title.text = titleStr;
    _title.font = [UIFont systemFontOfSize:12 weight:0.1];
    _title.textColor = [UIColor colorWithHexString:@"434343"];
    [self addSubview:_title];
    
    _reportButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _reportButn.frame = CGRectMake(kScreenWidth-92, _backGroundV.bottom+14, 80, 14);
    _reportButn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_reportButn setImage:[UIImage imageNamed:@"report_icon_text"] forState:UIControlStateNormal];
    [_reportButn setImageEdgeInsets:UIEdgeInsetsMake(2, -2, 2, 2)];
    [_reportButn setTitle:@"顾问的报告" forState:UIControlStateNormal];
    [_reportButn setTitleColor:[UIColor colorWithHexString:@"434343"] forState:UIControlStateNormal];
    [_reportButn addTarget:self action:@selector(clickReportButn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_reportButn];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(9, _title.bottom - 0.5 , _backGroundV.width-18, 0.5)];
    [self addSubview:view];
    
    [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"d4d4d4"]];
    
}




-(void)clickButton:(UIButton *)button
{
    NSInteger index = button.tag - 100;
    NSString *typeStr = _typeArr[index];
    NSString *titltStr = titles[index];
    if (_typeBlock) {
        _typeBlock(typeStr,titltStr);
    }
}

-(void)clickReportButn
{
    if (_reportBlock) {
        _reportBlock(_reportId);
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


@end
