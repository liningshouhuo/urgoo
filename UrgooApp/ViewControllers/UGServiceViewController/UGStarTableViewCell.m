//
//  UGStarTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/6.
//  Copyright © 2016年 Urgoo. All rights reserved.
//
#define PI 3.1415926535
#import "UGStarTableViewCell.h"
#import "Masonry.h"
//#import "CustomView.h"
@interface UGStarTableViewCell()



@property(strong,nonatomic) UILabel * leftDays;
@property (strong,nonatomic) UILabel * datelable;
@property (strong,nonatomic) UILabel * namelable;
@property (strong,nonatomic) UIView * alretView;
@end
@implementation UGStarTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //self.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    return self;
}
-(void)setTestStr:(NSString *)testStr{
    _testStr = testStr;
    
    NSArray *subViews = self.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    [self initUI:_testStr];



    
    
    
    
    
}
-(void)setTest2Str:(NSString *)test2Str{
    _test2Str = test2Str;
    
    NSArray *subViews = self.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
    
      [self inittest2UI:_test2Str];
    
    
    
    
}
//touxiang
-(void)setTest1Str:(NSString *)test1Str{
    
    _test1Str = test1Str;
    NSArray *subViews = self.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }

    [self setredUI];
}
//未完成
-(void)initUI:(NSString *)testStrrr{
    
    UIView * testView = [[UIView alloc]init];
    //testView.backgroundColor = [UIColor  colorWithHexString:@"#eeeeee"];
    testView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    
    [self.contentView addSubview:testView];
    
    [self.contentView addSubview:testView];
    UIView * testView1 = [[UIView alloc]init];
    //testView1.backgroundColor = [UIColor  colorWithHexString:@"#eeeeee"];
    testView1.frame = CGRectMake(kScreenWidth * 0.377-9, 2, 20, 20);
    
    [self.contentView addSubview:testView1];
    
    CAShapeLayer *solidLine =  [CAShapeLayer layer];
    CGMutablePathRef solidPath =  CGPathCreateMutable();
    solidLine.lineWidth = 2.0f ;
    solidLine.strokeColor = RGB(178, 236, 229).CGColor;
    solidLine.fillColor = [UIColor clearColor].CGColor;
    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(0,  0, testView1.width, testView1.height));
    solidLine.path = solidPath;
    CGPathRelease(solidPath);
    [testView1.layer addSublayer:solidLine];
    
    
    
    
    
    UILabel * testStr = [[UILabel alloc]init];
    testStr.text =testStrrr;
    testStr.font = [UIFont systemFontOfSize:17];
    [self.contentView addSubview:testStr];
    CGSize size = [testStr.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:testStr.font,NSFontAttributeName, nil]];
    testStr.frame = CGRectMake(testView1.origin.x + testView1.width + 25, 12 - 9, size.width , 18);
    
    testStr.textColor = [UIColor whiteColor];
    NSLog(@"%f",size.width);
    CGFloat  widthto = size.width + testView1.origin.x + testView1.width+ 25 ;
    NSLog(@"widthto===%f",widthto);
    
    
    
   
        
        CAShapeLayer *solidShapeLayer = [CAShapeLayer layer];
        CGMutablePathRef solidShapePath =  CGPathCreateMutable();
        [solidShapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [solidShapeLayer setStrokeColor:[[UIColor colorWithHexString:@"#b1ebe4"] CGColor]];
        solidShapeLayer.lineWidth = 2.0f ;
        CGPathMoveToPoint(solidShapePath, NULL, testView1.origin.x + testView1.width/2 +1, testView1.origin.y +testView1.height/2 +1);
        CGPathAddLineToPoint(solidShapePath, NULL,kScreenWidth * 0.377 +17,testStr.origin.y + testStr.height +5);
        CGPathAddLineToPoint(solidShapePath, NULL, widthto,testStr.origin.y + testStr.height +5);
        [solidShapeLayer setPath:solidShapePath];
        CGPathRelease(solidShapePath);
        [testView.layer addSublayer:solidShapeLayer];
   
    
    
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(testView1.origin.x +3,testView1.origin.y +3 , 14, 14)];
    
    view.layer.cornerRadius = 7;
    view.backgroundColor = RGB(0, 189, 189);
    [self.contentView addSubview:view];
    
    
    UIView * lineView = [[UIView alloc]init];
    if ([_lastCell isEqualToString:@"最后一个"]) {
        lineView.backgroundColor = [UIColor clearColor];
    }else{
        
        lineView.backgroundColor =RGB(0, 189, 189);
        
    }
    //lineView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:lineView];
    
    UILabel * subTitleLable = [[UILabel alloc]init];
    subTitleLable.text = @"cdscdscdscscdscdscdscdscdjshbvjdsbvjdfbvdbjvbhjdvbjhdbvjhsbvfbvfvfdfsdfsfsfsdfdsfsdfdkv";
    subTitleLable.textColor = [UIColor colorWithHexString:@"#94f9ff"];
    subTitleLable.font = [UIFont systemFontOfSize:13];
    subTitleLable.numberOfLines = 0;
    CGRect rect = [subTitleLable.text boundingRectWithSize:CGSizeMake(kScreenWidth * 0.62 - 60, 999)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize: 13]}
                                                   context:nil];
    
    
    [self.contentView addSubview:subTitleLable];
    
    _leftDays = [[UILabel alloc]init];
    _leftDays.text = @"还有122天";
    _leftDays.textAlignment = NSTextAlignmentRight;
    _leftDays .font = [UIFont systemFontOfSize:13];
    _leftDays.textColor = [UIColor colorWithHexString:@"#94f9ff"];
    [self.contentView addSubview:_leftDays];
    
    _datelable =[[UILabel alloc]init];
    _datelable.text = @"2016年8月8日";
    _datelable.textAlignment = NSTextAlignmentRight;
    _datelable .font = [UIFont systemFontOfSize:11];
    _datelable.textColor = [UIColor colorWithHexString:@"#00bdc7"];
    [self.contentView addSubview:_datelable];
    
    
    
    
    
    [subTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(testStr.mas_bottom).offset(17);
        make.left.mas_equalTo(testStr.mas_left);
        //        make.width.mas_equalTo(kScreenWidth * 0.62 - 60);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.62 - 60, rect.size.height +10 ));
       // make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        
    }];

    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        //make.left.mas_equalTo(self.mas_left).offset(20);
        make.centerX.mas_equalTo(view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(2, 120 ));
    }];
    

    [_leftDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        //make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.37, 17 ));
    }];

    [_datelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_leftDays.mas_bottom).offset(2);
        //make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.37, 12 ));
    }];
    

    
    
    
    
}



//已完成
-(void)inittest2UI:(NSString *)testStrrr{
    
    UIView * testView = [[UIView alloc]init];
    testView.backgroundColor = [UIColor  colorWithHexString:@"#eeeeee"];
    testView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    
//    [self.contentView addSubview:testView];
//    UIView * testView1 = [[UIView alloc]init];
//    testView1.backgroundColor = [UIColor  colorWithHexString:@"#eeeeee"];
//    testView1.frame = CGRectMake(17, 2, 20, 20);
//    
//    [self.contentView addSubview:testView1];
//
//    CAShapeLayer *solidLine =  [CAShapeLayer layer];
//    CGMutablePathRef solidPath =  CGPathCreateMutable();
//    solidLine.lineWidth = 2.0f ;
//    solidLine.strokeColor = RGB(178, 236, 229).CGColor;
//    solidLine.fillColor = [UIColor clearColor].CGColor;
//    CGPathAddEllipseInRect(solidPath, nil, CGRectMake(0,  0, 20, 20));
//    solidLine.path = solidPath;
//    CGPathRelease(solidPath);
//    [testView1.layer addSublayer:solidLine];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.377-7,5 , 14, 14)];
    
    view.layer.cornerRadius = 7;
    view.backgroundColor = RGB(153, 153, 153);
    [self.contentView addSubview:view];
    
    
    UILabel * testStr = [[UILabel alloc]init];
    testStr.text =testStrrr;
    testStr.font = [UIFont systemFontOfSize:17];
    //testStr.textColor = [UIColor redColor];
 
    [self.contentView addSubview:testStr];
    CGSize size = [testStr.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:testStr.font,NSFontAttributeName, nil]];
    testStr.frame =  CGRectMake(view.origin.x + view.width + 25, 12 - 9, size.width , 18);
    
   
    testStr.textColor = [UIColor colorWithHexString:@"#cccccc"];
   
    UILabel * subTitleLable = [[UILabel alloc]init];
    subTitleLable.text = @"cdscdscdscscdscdscdscdscdjshbvjdsbvjdfbvdbjvbhjdvbjhdbvjhsbvfbvfvfdkv";
    subTitleLable.textColor = [UIColor colorWithHexString:@"#999999"];
    subTitleLable.font = [UIFont systemFontOfSize:13];
    subTitleLable.numberOfLines = 0;
    CGRect rect = [subTitleLable.text boundingRectWithSize:CGSizeMake(kScreenWidth * 0.62 - 60, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize: 13]}
                                        context:nil];
    
    
    [self.contentView addSubview:subTitleLable];
    
    
    _leftDays = [[UILabel alloc]init];
    _leftDays.text = @"已结束";
    _leftDays.textAlignment = NSTextAlignmentRight;
    _leftDays .font = [UIFont systemFontOfSize:13];
    _leftDays.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_leftDays];

    
    
    
    _datelable =[[UILabel alloc]init];
    _datelable.text = @"2016年8月8日";
    _datelable.textAlignment = NSTextAlignmentRight;
    _datelable .font = [UIFont systemFontOfSize:11];
    _datelable.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_datelable];
    

    [subTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(testStr.mas_bottom).offset(17);
        make.left.mas_equalTo(testStr.mas_left);
//        make.width.mas_equalTo(kScreenWidth * 0.62 - 60);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.62 - 60, rect.size.height +10));
           // make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
        
    }];
    
    
    
    
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.frame = CGRectMake(view.origin.x + view.width/2 , 0, 2, 120);
    //lineView.backgroundColor = [UIColor whiteColor];
       [self.contentView addSubview:lineView];
   [self drawDashLine:lineView lineLength:5 lineSpacing:3 lineColor:RGB(153, 153, 153)];
    
    
    
    
    
    [_leftDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        //make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(40, 17 ));
    }];
    
    [_datelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_leftDays.mas_bottom).offset(2);
        //make.left.mas_equalTo(self.mas_left).offset(20);
        make.right.mas_equalTo(lineView.mas_left).offset(-20);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth *0.37, 12 ));
    }];
    if ([_fisrtCell isEqualToString:@"第一个"]) {
        UIButton *  giftImage = [[UIButton alloc]init];
        
        [giftImage setImage:[UIImage imageNamed:@"gift_photo"] forState:UIControlStateNormal];
        //giftImage.image = [UIImage imageNamed:@"gift_photo"];
        [giftImage addTarget:self action:@selector(click_gift) forControlEvents:UIControlEventTouchUpInside];
       [self.contentView addSubview:giftImage];
        
//        
        [giftImage mas_makeConstraints:^(MASConstraintMaker *make) {
            //make.top.mas_equalTo(_leftDays.mas_top).offset(-3);
            //make.left.mas_equalTo(self.mas_left).offset(20);
            make.right.mas_equalTo(_leftDays.mas_left).offset(-2);
            make.size.mas_equalTo(CGSizeMake(30, 30 ));
            make.bottom.mas_equalTo(_leftDays.mas_bottom);
        }];

        
        
    }

    
    
    
}
-(void)setLine{
    UIImageView  * iconview = [[UIImageView alloc]initWithFrame:CGRectMake(100, 50, 50, 2)];
    iconview.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:iconview];
    UIGraphicsBeginImageContextWithOptions(iconview.size, NO, 0.0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGFloat lengths[] = {10,10};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 10.0, 20.0);
    CGContextAddLineToPoint(context, 50,20.0);
    CGContextStrokePath(context);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    iconview.image = image;
    
    
    
}

-(void)setredUI{
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
   // view.backgroundColor = [UIColor redColor];
//    UIView * circleview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.377 -7,5 , 14, 14)];
//    
//    circleview.layer.cornerRadius = 7;
//    circleview.backgroundColor = RGB(153, 153, 153);
//    [self.contentView addSubview:circleview];

    [self.contentView addSubview:view];
    UIView * lineview = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.377, 0, 2, 46)];
    
    [view addSubview:lineview];
    [self drawDashLine:lineview lineLength:5 lineSpacing:3 lineColor:RGB(153, 153, 153)];
    
    UIImageView  * iconView= [[UIImageView alloc]init];
    iconView.frame = CGRectMake(30, 60 - 28, 56, 56);
    iconView.image = [UIImage imageNamed:@"mengcong"];
    iconView.clipsToBounds  = YES;
    iconView.layer.cornerRadius = 28;
    iconView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:iconView];
    
    UIView * cycleView= [[UIView alloc]init];
    
    cycleView.layer.cornerRadius = 31;
    cycleView.backgroundColor = [UIColor colorWithHexString:@"#a1b3c8"];
   
    [self.contentView addSubview:cycleView];
    
    
    
    
    
    
    UIImageView  * imperial_crown= [[UIImageView alloc]init];
     imperial_crown.image = [UIImage imageNamed:@"imperial_crown_photo"];
    
    imperial_crown.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:imperial_crown];

    
    
    
//    
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.centerY).offset(1);
        make.right.mas_equalTo(lineview.mas_left).offset(-20);;
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    
    [cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconView.mas_top).offset(-3);
        make.left.mas_equalTo(iconView.mas_left).offset(-3);
        make.size.mas_equalTo(CGSizeMake(62, 62));
    }];
    [imperial_crown mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cycleView.mas_top).offset(2);
        make.left.mas_equalTo(cycleView.mas_left).offset((62- 62 *0.33)/2);
        make.size.mas_equalTo(CGSizeMake(62 * 0.33, 62 * 0.43));
    }];

    [self.contentView insertSubview:iconView aboveSubview:cycleView];
    
    UIView * todoView = [[UIView alloc]initWithFrame:CGRectMake(iconView.origin.x + iconView.width - 5,60 -14 , 180 , 28)];
    
    todoView.backgroundColor = [UIColor clearColor];
    UIImageView * todoViewimage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 180 , 28)];
    
    todoViewimage.image = [UIImage imageNamed:@"name_bg"];
    [todoView addSubview:todoViewimage];
    [view addSubview:todoView];
    UIView * shiLIneview =[[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * 0.377, todoView.height + todoView.origin.y, 2, 80)];
    
    shiLIneview.backgroundColor = RGB(0, 189, 189);
    [view addSubview:shiLIneview];
    //姓名
    _namelable = [[UILabel alloc]init];
    _namelable.text = @"Jessie Lee";
    _namelable.font = [UIFont systemFontOfSize:16];
    _namelable.textColor = [UIColor blackColor];
    
    [self.contentView addSubview:_namelable];
    
    
    UIImageView * keepGoing = [[UIImageView alloc]init];
    keepGoing.image = [UIImage imageNamed:@"Keep-Going"];
    [self.contentView addSubview:keepGoing];
    
    
    [_namelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(todoView.mas_top).offset(2);
        make.left.mas_equalTo(lineview.mas_right).offset(10);
        make.right.mas_equalTo(todoView.mas_right).offset(-10);
        make.bottom.mas_equalTo(todoView.mas_bottom).offset(-5);
    }];
    
    [keepGoing mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(todoViewimage.mas_right).offset(-5);
        make.size.mas_equalTo(CGSizeMake(60, 14));
        make.bottom.mas_equalTo(todoView.mas_bottom);
    }];

    
    
    
    
}


- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CGFloat hight = lineView.size.height;
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(lineView.width/2 , lineView.height /2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:2.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0,hight);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}
-(void)click_gift{
    
//    _alretView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    _alretView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4f];
//    [[[[UIApplication sharedApplication] windows] firstObject] addSubview:_alretView];

    
    
    
    
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
