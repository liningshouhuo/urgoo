//
//  UGAbount_searveCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/11.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAbount_searveCell.h"

static CGFloat heightOne;
static CGFloat heightTwo;

@implementation UGAbount_searveCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return self;
}

-(void)initUI:(CounselorDedailDataModel *)dataModel
{
    _counselorModel = dataModel.counselorDetail;
    
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kScreenWidth-20, 380)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.cornerRadius = 8;
    _backGroundView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    _backGroundView.clipsToBounds = YES;
    [self.contentView addSubview:_backGroundView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _backGroundView.width, 36)];
    title.text = @"服务介绍";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"000000"];
    title.textAlignment = NSTextAlignmentCenter;
    [_backGroundView addSubview:title];
    
    //分割线
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, title.height, _backGroundView.width, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backGroundView addSubview:line];
    
    
    //指导方式
    UILabel *lable1 = [[UILabel alloc] initWithFrame:CGRectMake(20, title.bottom+5, 100, 15)];
    lable1.text = @"指导方式:";
    lable1.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable1.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:lable1];
    
    NSString *guideStr = @"远程指导";
    UILabel *guideLable = [[UILabel alloc] init];
    if (_counselorModel.serviceMode.length > 0) {
        guideStr = [NSString stringWithFormat:@"远程指导\n%@",_counselorModel.serviceMode];
    }
    guideLable.frame = CGRectMake(lable1.x, lable1.bottom , _backGroundView.width-50, 5);
    guideLable.text = guideStr;
    guideLable.font = [UIFont systemFontOfSize:13];
    [guideLable heightForLableText:guideStr fontOfSize:13 frame:guideLable.frame];
    guideLable.textColor = [UIColor colorWithHexString:@"666666"];
    [_backGroundView addSubview:guideLable];
    
    
    
    //服务内容
    NSArray *serviceLongList = dataModel.serviceLongList;
    NSMutableArray *serviceListArr = [NSMutableArray array];
    for (ServiceLongListsModel *model in serviceLongList) {
        if (model.detailed) {
            [serviceListArr addObject:model.detailed];
        }
    }
    
    UILabel *lable2 = [[UILabel alloc] initWithFrame:CGRectMake(20, guideLable.bottom+20, 100, 15)];
    lable2.text = @"服务内容:";
    lable2.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable2.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:lable2];
    
    //NSArray *seaveArr = @[@"服务内容1",@"服务内容2",@"服务内容3",@"服务内容4",@"服务内容5",@"服务内容6"];
    NSArray *seaveArr = serviceListArr;
    _isDownArr = [NSMutableArray array];
    heightOne  = 120;
    if (seaveArr.count >3) {
        NSArray *arr = [seaveArr subarrayWithRange:NSMakeRange(0, 3)];
        [_isDownArr addObjectsFromArray:arr];
        [_isDownArr addObject:@"......"];
    }
    
    if (![User_Default objectForKey:@"isUp"]) {
        //收起状态
        for (int i = 0; i < _isDownArr.count; i ++) {
            
            UIImageView *trueImage = [[UIImageView alloc] init];
            trueImage.frame = CGRectMake( lable2.x, lable2.bottom+12 + i*18, 10, 10);
            trueImage.backgroundColor = [UIColor clearColor];
            trueImage.image = [UIImage imageNamed:@"pay_select"];
            [_backGroundView addSubview:trueImage];
            if (i == _isDownArr.count-1) {
                trueImage.image = [UIImage imageNamed:@""];
            }
            
            UILabel *seaveLable = [[UILabel alloc] init];
            seaveLable.frame = CGRectMake(lable2.x+8+5, lable2.bottom+10 + i*18, _backGroundView.width-50, 13);
            seaveLable.text = _isDownArr[i];
            seaveLable.font = [UIFont systemFontOfSize:13];
            seaveLable.textColor = [UIColor colorWithHexString:@"666666"];
            [_backGroundView addSubview:seaveLable];
            
            heightOne = seaveLable.bottom;
        }
    }else{
        //展开状态
        for (int i = 0; i < seaveArr.count; i ++) {
            
            UIImageView *trueImage = [[UIImageView alloc] init];
            trueImage.frame = CGRectMake( lable2.x, lable2.bottom+12 + i*18, 10, 10);
            trueImage.backgroundColor = [UIColor clearColor];
            trueImage.image = [UIImage imageNamed:@"pay_select"];
            [_backGroundView addSubview:trueImage];
            
            UILabel *seaveLable = [[UILabel alloc] init];
            seaveLable.frame = CGRectMake(lable2.x+8+5, lable2.bottom+10 + i*18, _backGroundView.width-50, 13);
            seaveLable.text = seaveArr[i];
            seaveLable.font = [UIFont systemFontOfSize:13];
            seaveLable.textColor = [UIColor colorWithHexString:@"666666"];
            [_backGroundView addSubview:seaveLable];
            
            heightOne = seaveLable.bottom;
        }
    }
    
    
    //顾问备注
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(20, heightOne + 20, 100, 15)];
    lable3.text = @"顾问提醒:";
    lable3.font = [UIFont systemFontOfSize:15 weight:0.1];
    lable3.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:lable3];
    
    if (_counselorModel.extraService.length > 0) {
        
        NSArray *seaArr = @[_counselorModel.extraService];
        for (int i = 0; i < seaArr.count; i ++) {
            
            UILabel *seaLable = [[UILabel alloc] init];
            seaLable.frame = CGRectMake(lable3.x, lable3.bottom-5 + i*18, _backGroundView.width-50, 13);
            seaLable.text = seaArr[i];
            seaLable.font = [UIFont systemFontOfSize:13];
            seaLable.textColor = [UIColor colorWithHexString:@"666666"];
            [seaLable heightForLableText:seaArr[i] fontOfSize:13 frame:seaLable.frame];
            [_backGroundView addSubview:seaLable];
            
            heightTwo = seaLable.bottom;
        }
    }else{
        lable3.frame = CGRectMake(20, heightOne + 20, 100, 0);
        heightTwo = lable3.bottom - 10;
    }
    
    
    
    
    if (![User_Default objectForKey:@"isUp"]) {
        _isUp = YES;
        firstHeight = 220;
    }else{
        firstHeight = heightTwo;
        _isUp = NO;
    }
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.frame = CGRectMake(0, firstHeight+10, _backGroundView.width, 0.6);
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backGroundView addSubview:bottomLine];
    
    UIView *buttonG = [[UIView alloc] init];
    buttonG.frame = CGRectMake(0, firstHeight+11, _backGroundView.width, 36);
    buttonG.backgroundColor = [UIColor whiteColor];
    [_backGroundView addSubview:buttonG];
    
    _bottomButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomButn.frame = CGRectMake(0, bottomLine.bottom, _backGroundView.width, 36);
    _bottomButn.backgroundColor = [UIColor clearColor];
    if (_isUp) {
        [_bottomButn.layer addAnimation:[self animation] forKey:nil];
        [_bottomButn setImage:[UIImage imageNamed:@"icon_down_arrow"] forState:UIControlStateNormal];
    }else{
        [_bottomButn.layer addAnimation:[self animation] forKey:nil];
        [_bottomButn setImage:[UIImage imageNamed:@"icon_up_arrow"] forState:UIControlStateNormal];
    }
    [_bottomButn addTarget:self action:@selector(clickBottomButn) forControlEvents:UIControlEventTouchUpInside];
    [_backGroundView addSubview:_bottomButn];


    _backGroundView.frame = CGRectMake(10, 10, kScreenWidth-20, _bottomButn.bottom);
    
    CGRect frame = self.frame;
    frame.size.height = _bottomButn.bottom + 20;
    self.frame = frame;
    
}

-(void)clickBottomButn
{
    if (_isUp) {
        [User_Default setObject:@"isUp" forKey:@"isUp"];
        [User_Default synchronize];
    }else{
        [User_Default removeObjectForKey:@"isUp"];
    }
    
    _isUpBlock();
}

-(CABasicAnimation *)animation
{
    CATransform3D rotationTransform = CATransform3DMakeRotation(90, 0, 0, 0.5);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration = 0.2;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.delegate = self;
    return animation;
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
