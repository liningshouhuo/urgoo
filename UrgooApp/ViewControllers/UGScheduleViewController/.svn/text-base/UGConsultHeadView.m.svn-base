//
//  UGConsultHeadView.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGConsultHeadView.h"
#import "Masonry.h"
@interface UGConsultHeadView()
@property (strong,nonatomic)UIImageView * iconImageView;
@property (strong,nonatomic)UILabel * nameText;
@property (strong,nonatomic)UILabel * workYear;
@property (strong,nonatomic)UILabel * skilledFieidi;
@property (strong,nonatomic)UILabel * timeOfmeet;
@property (strong,nonatomic)UILabel * lastmeet;
@property (strong,nonatomic)UIButton * button;
@property (strong,nonatomic) UIImageView * countyTag;
@property (strong,nonatomic) UILabel * countylable;
@property (strong,nonatomic)UILabel * closedTime;
@property (strong,nonatomic)UILabel * advancedTime;
@property (strong,nonatomic)UILabel * ratio;
//@property (strong,nonatomic)UILabel * timeOfmeet;


@end
@implementation UGConsultHeadView
-(instancetype)initWithFrame:(CGRect)frame{
    self= [super initWithFrame:frame];
    [self initUI];
    self.backgroundColor = [UIColor whiteColor];
    return self;
    
}
     //_iconImageView.image =
//    
//    NSString *headImgStr=[NSString stringWithFormat:@"%@%@",UG_HOST,_counselorModel.userIcon];
//    //头像
//    [_imageview sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"default_icon"]];
-(void)setAdvanceInfo:(AdvanceCounselorInfo *)advanceInfo{
    _advanceInfo = advanceInfo;
    
    _nameText.text = _advanceInfo.enName;
   
//    CGSize workYearsize = [workYear_text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:.font,NSFontAttributeName, nil]];
    _advancedTime.text =[NSString stringWithFormat:@"%@人预约过",_advanceInfo.advancedTime];
    _closedTime.text =[NSString stringWithFormat:@"%@人已视频",_advanceInfo.closedTime];
    _ratio.text = [NSString stringWithFormat:@"预约接受率  %@",_advanceInfo.ratio];


    _countylable.text = _advanceInfo.countryName;
   
    
   
//    CGSize skilledFieidiSize = [skilledFieiditext sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_skilledFieidi.font,NSFontAttributeName, nil]];
//    _workYear.text =workYear_text;
//    [_skilledFieidi mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_workYear.mas_bottom).offset(7);
//        make.left.mas_equalTo(_nameText.mas_left);
//        make.size.mas_equalTo(CGSizeMake(skilledFieidiSize.width + 20, 12));
//    }];
//
//    if (_advanceInfo.organization==nil) {
//        [_button removeFromSuperview];
//    }else{
//        
//        NSString * buttontitle = _advanceInfo.organization;
//        CGSize titileSize = [buttontitle sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_button.titleLabel.font,NSFontAttributeName, nil]];
//        [_button setTitle:buttontitle forState:UIControlStateNormal];
//        [_button mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(_iconImageView.mas_top);
//            make.right.mas_equalTo(self.mas_right).offset(-10);
//            make.size.mas_equalTo(CGSizeMake(titileSize.width + 20, 22));
//        }];
//        
//       
//
//        
//    }
    
    
   

    NSString * qingdaostr = _advanceInfo.userIcon;
    if ([qingdaostr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_advanceInfo.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
           } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,_advanceInfo.userIcon];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"default_icon"]  ];
    }
    
   // _iconImageView.layer.cornerRadius = 40;
    [self layoutIfNeeded];

    
}

-(void)initUI{
    //头像
    _iconImageView = [[UIImageView alloc]init];
     _iconImageView.layer.cornerRadius = 30;
       _iconImageView.clipsToBounds = YES;
     
    [self addSubview:_iconImageView];
    //名字
    _nameText = [[UILabel alloc]init];
    _nameText.text = @"ddds";
    _nameText.textAlignment =  NSTextAlignmentLeft;
    _nameText.highlightedTextColor=[UIColor colorWithHexString:@"#252525"];
    _nameText.font = [UIFont systemFontOfSize:15];
    [self addSubview:_nameText];
   //图标
    _button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_button setTitle:@"OACAC会员" forState:UIControlStateNormal];
    _button.backgroundColor = RGB(38, 189, 171);
    //设置边框颜色
    _button.layer.borderColor = [RGB(38, 189, 171) CGColor];
    //设置边框宽度
    _button.layer.borderWidth = 1.0f;
    //给按钮设置角的弧度
   // _button.layer.cornerRadius = 7.0f;
    _button.titleLabel.font =[UIFont systemFontOfSize:13];
    //设置背景颜色
    //button.backgroundColor = [UIColor redColor];
    _button.layer.masksToBounds = YES;
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   // [self addSubview:_button];
   
    _advancedTime =[[UILabel alloc]init];
    _advancedTime.text = @"";
    _advancedTime.font = [UIFont systemFontOfSize:12];
    //_workYear.highlightedTextColor = [UIColor colorWithHexString:@"#252525"];
    [_advancedTime setTextColor:[UIColor colorWithHexString:@"#a5a4a4"]];
    _advancedTime.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_advancedTime];
    //
    
    
    
    _closedTime = [[UILabel alloc]init];
    _closedTime.text = @"";
    _closedTime.font = [UIFont systemFontOfSize:12];
    //_workYear.highlightedTextColor = [UIColor colorWithHexString:@"#252525"];
    [_closedTime setTextColor:[UIColor colorWithHexString:@"#a5a4a4"]];
    _closedTime.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_closedTime];
    _ratio = [[UILabel alloc]init];
    _ratio.text = @"";
    _ratio.font = [UIFont systemFontOfSize:12];
    //_workYear.highlightedTextColor = [UIColor colorWithHexString:@"#252525"];
    
    
    
    
    [_ratio setTextColor:[UIColor colorWithHexString:@"#a5a4a4"]];
    _ratio.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_ratio];
    
//    UIButton * wenhaoBtn = [[UIButton alloc]init];
//    [wenhaoBtn setImage:[UIImage imageNamed:@"wenhao_head"] forState:0];
//    UIImageView * imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"wenhao_head"];
//    
//    UITapGestureRecognizer * recognizeree = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoH5)];
//    
//    [imageView addGestureRecognizer:recognizeree];
    
    //[wenhaoBtn addTarget:self action:@selector(gotoH5) forControlEvents: UIControlEventTouchUpInside ];
    //[self addSubview:wenhaoBtn];
    
    
    
       //图片标志
    _countyTag = [[UIImageView alloc]init];
    _countyTag.image = [UIImage imageNamed:@"county_photo"];
    
    [self addSubview:_countyTag];
    //国家
    _countylable = [[UILabel alloc]init];
    _countylable.text = @"U.S.A";
    _countylable.font = [UIFont systemFontOfSize:10];
    _countylable.textColor = [UIColor colorWithHexString:@"#26bdab"];
    _countylable.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_countylable];
    // 又有
    
    UIButton  *   youyou_button = [[UIButton alloc]init];
    [youyou_button setImage:[UIImage imageNamed:@"you_you"] forState:UIControlStateNormal];
    
    
    [youyou_button addTarget:self action:@selector(cilck_you_you) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:youyou_button];
    
    UIImageView * youyouImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"you_you"]];
    
    UITapGestureRecognizer  * recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cilck_you_you)];
    
    
    [youyouImage addGestureRecognizer:recognizer];
    
    //[self addSubview:youyouImage];
    
    
    //头像
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(14);
        make.left.mas_equalTo(self.mas_left).offset(16);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    //姓名
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_top);
        make.left.mas_equalTo(_iconImageView.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 17));
    }];
    
    //tubiao
//    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_iconImageView.mas_top);
//        make.right.mas_equalTo(self.mas_right).offset(-10);
//        make.size.mas_equalTo(CGSizeMake(71, 22));
//    }];
    //XX人预约过
    [_advancedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameText.mas_bottom).offset(11);
        make.left.mas_equalTo(_nameText.mas_left);
        make.size.mas_equalTo(CGSizeMake(70, 12));
    }];
    //XX人已视频
    [_closedTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_advancedTime.mas_bottom).offset(7);
        make.left.mas_equalTo(_nameText.mas_left);
        make.size.mas_equalTo(CGSizeMake(70, 12));
    }];
    // 预约接受率
    [_ratio mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_closedTime.mas_bottom).offset(7);
        make.left.mas_equalTo(_nameText.mas_left);
        make.size.mas_equalTo(CGSizeMake(110, 12));
    }];
//    [wenhaoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(_ratio.mas_centerY);
//        make.left.mas_equalTo(_ratio.mas_right).offset(20);
//        make.size.mas_equalTo(CGSizeMake(17, 17));
//    }];
//
//    [_lastmeet mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_timeOfmeet.mas_bottom).offset(7);
//        make.left.mas_equalTo(_nameText.mas_left);
//        make.size.mas_equalTo(CGSizeMake(165, 12));
//    }];
    
    [_countyTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_bottom).offset(6);
        make.left.mas_equalTo(_iconImageView.mas_left).offset(5);
        make.size.mas_equalTo(CGSizeMake(7, 10));
    }];
    
    [_countylable mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.mas_equalTo(_countyTag.mas_top).offset(-2);
        make.centerY.mas_equalTo(_countyTag.mas_centerY);
        make.left.mas_equalTo(_countyTag.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(35, 12));
    }];
    [youyou_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(20);
        //make.centerY.mas_equalTo(_countyTag.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(70 ,70 *1.1 ));
    }];

    
}
-(void)cilck_you_you{
    NSLog(@"sadads");
    _clickWenHaoBlock();
    
}
@end
