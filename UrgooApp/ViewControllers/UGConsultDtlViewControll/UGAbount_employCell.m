//
//  UGAbount_employCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAbount_employCell.h"

static CGFloat heightOne;

@implementation UGAbount_employCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return self;
}
-(NSArray *)employArray{
    
    if (_employArray == nil) {
        _employArray = [NSArray array];
    }
    
    return _employArray;
    
}
-(void)initUI:(NSArray *)employArr CounselorDetailModel:(CounselorDetailssModel *)model

{
    self.employArray = employArr;
    
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 380)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.contentView addSubview:_backGroundView];
    
    //已接收/可接学生数：
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 150, 44)];
    lable.text = @"服务类型:";
    lable.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable.textColor = [UIColor colorWithHexString:@"000000"];
    CGSize lableSize = [StringHelper getSizeByString:@"服务类型:" AndFontSize:15];
    lable.frame = CGRectMake(30, 5, lableSize.width+5, 30);
    [_backGroundView addSubview:lable];
    
    NSString *num = model.serviceCounted;
    UILabel *number = [[UILabel alloc] initWithFrame:CGRectMake(lable.x+lable.width, 5, 10, 44)];
    number.text = num;
    number.font = [UIFont systemFontOfSize:15 weight:0.1];
    number.textColor = [UIColor colorWithHexString:@"0fb7a3"];
    CGSize numberSize = [StringHelper getSizeByString:num AndFontSize:15];
    number.frame = CGRectMake(lable.x+lable.width, 5, numberSize.width, 30);
    //[_backGroundView addSubview:number];
    
    NSString *totalNum = [NSString stringWithFormat:@"/%@",model.serviceTotal];
    UILabel *total = [[UILabel alloc] initWithFrame:CGRectMake(number.x+number.width, 5, 10, 44)];
    total.text = totalNum;
    total.font = [UIFont systemFontOfSize:15];
    total.textColor = [UIColor colorWithHexString:@"666666"];
    CGSize totalSize = [StringHelper getSizeByString:totalNum AndFontSize:15];
    total.frame = CGRectMake(number.x+number.width, 5, totalSize.width+5, 30);
    //[_backGroundView addSubview:total];
    
    NSMutableArray *seaveArr = [NSMutableArray array];
    NSMutableArray *money    = [NSMutableArray array];
    _serviceIdArr            = [NSMutableArray array];
    for (EmployServiceModel *employModel in employArr) {
        [seaveArr addObject:employModel.serviceName];
        NSString *moneyStr = [NSString stringWithFormat:@"RMB %@元",employModel.servicePrice];
        [money addObject:moneyStr];
        [_serviceIdArr addObject:employModel.serviceid];
    }
    //NSArray *seaveTitleArr = @[@"美国本科服务_10年级学生(上)",@"美国本科服务_10年级学生(上)",@"美国本科服务_10年级学生(上)"];
    //NSArray *moneyArr = @[@"RMB 3,000元",@"RMB 3,000元",@"RMB 3,000元"];
    NSArray *seaveTitleArr = seaveArr;
    NSArray *moneyArr = money;
    if (seaveTitleArr.count > 0) {
        
    }else{
        heightOne = lable.bottom + 7;
    }
    
    for (int i = 0; i < seaveTitleArr.count; i ++) {
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, lable.bottom+7+i*80 , _backGroundView.width, 0.5)];
        [_backGroundView addSubview:view];
        [self drawDashLine:view lineLength:6 lineSpacing:4 lineColor:[UIColor colorWithHexString:@"d4d4d4"]];
        
        UILabel *seaveLab = [[UILabel alloc] init];
        //seaveLab.frame = CGRectMake(lable.x, lable.bottom+7+20 + i*80, _backGroundView.width-100, 16);
        seaveLab.frame = CGRectMake(lable.x, lable.bottom+7+10 + i*80, _backGroundView.width-130, 35);
        seaveLab.numberOfLines = 2;
        seaveLab.font = [UIFont systemFontOfSize:14];
        seaveLab.text = seaveTitleArr[i];
        seaveLab.textColor = [UIColor colorWithHexString:@"000000"];
        [_backGroundView addSubview:seaveLab];
        
        UILabel *money = [[UILabel alloc] init];
        money.frame = CGRectMake(seaveLab.x, lable.bottom+7+50 + i*80, seaveLab.width, 13);
        money.font = [UIFont systemFontOfSize:13];
        money.text = moneyArr[i];
        money.textColor = [UIColor colorWithHexString:@"666666"];
        [_backGroundView addSubview:money];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_backGroundView.width-20-80, lable.bottom+7+25 + i*80, 80, 35);
        button.backgroundColor = [UIColor colorWithHexString:@"26BDAB"];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 200 + i;
        button.layer.cornerRadius = 6;
        button.layer.masksToBounds = YES;
        [button setTitle:@"了解详情" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButtonEmploy:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
        
        
        heightOne = money.bottom + 20;
    }
    
    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, heightOne);
    
    CGRect frame = self.frame;
    frame.size.height = heightOne + 20;
    self.frame = frame;
    
}

-(void)clickButtonEmploy:(UIButton *)butn
{
    //NSString *str = [NSString stringWithFormat:@"%ld",butn.tag-200];
    //NSString *str = _serviceIdArr[butn.tag-200];  EmployServiceModel *employServiceModel
    
    NSInteger i = butn.tag - 200;
     EmployServiceModel *employModel =  [EmployServiceModel mj_objectWithKeyValues:self.employArray[i]];
    NSLog(@"%@",employModel.serviceid);
    
    if (_emplyBlock) {
        _emplyBlock(employModel);
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




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
