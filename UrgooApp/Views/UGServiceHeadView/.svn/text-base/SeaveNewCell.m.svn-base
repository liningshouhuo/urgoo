//
//  SeaveNewCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SeaveNewCell.h"

@implementation SeaveNewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self initUI];
    }
    
    return self;
}

-(void)initUI:(PlanTasksModel *)model
{
    _backGroundV = [[UIView alloc] init];
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, 130);
    _backGroundV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backGroundV];
    
    _borderV = [[UIView alloc] init];
    _borderV.frame = CGRectMake(10, 13, 4, 98);
    _borderV.backgroundColor = [UIColor colorWithHexString:model.color];
    [_backGroundV addSubview:_borderV];
    
    UIImageView *moreImageV = [[UIImageView alloc] init];
    moreImageV.frame = CGRectMake(kScreenWidth-15-9, _borderV.y+2, 9, 16);
    moreImageV.image = [UIImage imageNamed:[self getArrowColorStringByTypeString:model.type]];
    [_backGroundV addSubview:moreImageV];
    
    _note = [[UILabel alloc] init];
    _note.frame = CGRectMake(_borderV.rightWith+9, _borderV.y+2, 100, 15);
    _note.font = [UIFont systemFontOfSize:12];
    _note.text = @"下一个任务:";
    _note.textColor = [UIColor colorWithHexString:@"434343"];
    [_backGroundV addSubview:_note];
    
    NSString *titleStr = model.title;
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(_note.x, _note.bottom + 15, kScreenWidth-40, 5);
    _title.font = [UIFont systemFontOfSize:15];
    _title.text = titleStr;
    _title.textColor = [UIColor colorWithHexString:@"434343"];
    [_title heightForLableText:titleStr fontOfSize:15 frame:_title.frame];
    [_backGroundV addSubview:_title];
    
    UIImageView *timeImageV = [[UIImageView alloc] init];
    timeImageV.frame = CGRectMake(_note.x, _title.bottom + 15, 14, 15);
    timeImageV.image = [UIImage imageNamed:[self getTimeColorStringByTypeString:model.type]];
    [_backGroundV addSubview:timeImageV];
    
    _time = [[UILabel alloc] init];
    _time.frame = CGRectMake(timeImageV.rightWith+6, timeImageV.y, kScreenWidth-100, 14);
    _time.font = [UIFont systemFontOfSize:12];
    _time.text = model.deadLine;
    _time.textColor = [UIColor colorWithHexString:@"a5a5a5"];
    [_backGroundV addSubview:_time];
    
    NSString *lastTimeStr = [NSString stringWithFormat:@"剩余 %@ 天",model.deadDay];
    //CGSize size = [StringHelper getSizeByString:lastTimeStr AndFontSize:12];
    _lastTime = [[UILabel alloc] init];
    _lastTime.frame = CGRectMake(kScreenWidth-75, timeImageV.y, 70, 14);
    _lastTime.font = [UIFont systemFontOfSize:12];
    _lastTime.text = lastTimeStr;
    _lastTime.textColor = [UIColor colorWithHexString:@"a5a5a5"];
    [_backGroundV addSubview:_lastTime];
    
    UIImageView *noteImagV = [[UIImageView alloc] init];
    noteImagV.frame = CGRectMake(kScreenWidth-100, timeImageV.y-2, 18, 18);
    noteImagV.image = [UIImage imageNamed:[self getNoteColorStringByTypeString:model.type]];
    [_backGroundV addSubview:noteImagV];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(9, _time.bottom + 19 , _backGroundV.width-18, 0.5)];
    [_backGroundV addSubview:view];
    
    [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"d4d4d4"]];
    
    
    
    _borderV.frame = CGRectMake(10, 13, 4, _time.bottom-7);
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, _time.bottom + 20);
    
    CGRect frame = self.frame;
    frame.size.height = _time.bottom + 20;
    self.frame = frame;
    
    
}

-(NSString *)getTimeColorStringByTypeString:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"1"]) {
        return @"times_icon_green";
    }else if ([typeStr isEqualToString:@"2"]){
        return @"times_icon_blue";
    }else if ([typeStr isEqualToString:@"3"]){
        return @"times_icon_purple";
    }else if ([typeStr isEqualToString:@"4"]){
        return @"times_icon_yellow";
    }else if ([typeStr isEqualToString:@"5"]){
        return @"times_icon_pink";
    }else if ([typeStr isEqualToString:@"6"]){
        return @"times_icon_red";
    }
    return @"";
}

-(NSString *)getArrowColorStringByTypeString:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"1"]) {
        return @"arrow_icon_green";
    }else if ([typeStr isEqualToString:@"2"]){
        return @"arrow_icon_blue";
    }else if ([typeStr isEqualToString:@"3"]){
        return @"arrow_icon_purple";
    }else if ([typeStr isEqualToString:@"4"]){
        return @"arrow_icon_yellow";
    }else if ([typeStr isEqualToString:@"5"]){
        return @"arrow_icon_pink";
    }else if ([typeStr isEqualToString:@"6"]){
        return @"arrow_icon_red";
    }
    return @"";
}

-(NSString *)getNoteColorStringByTypeString:(NSString *)typeStr
{
    if ([typeStr isEqualToString:@"1"]) {
        return @"note_icon_green";
    }else if ([typeStr isEqualToString:@"2"]){
        return @"note_icon_blue";
    }else if ([typeStr isEqualToString:@"3"]){
        return @"note_icon_purple";
    }else if ([typeStr isEqualToString:@"4"]){
        return @"note_icon_yellow";
    }else if ([typeStr isEqualToString:@"5"]){
        return @"note_icon_pink";
    }else if ([typeStr isEqualToString:@"6"]){
        return @"note_icon_red";
    }
    return @"";
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
