//
//  UGScheduleTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/5/31.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGScheduleTableViewCell.h"
#import "Masonry.h"
#import "AdanceTimeList.h"
@interface UGScheduleTableViewCell()
@property (strong,nonatomic) UIView * view;
@property (strong,nonatomic) UIImageView * iconImageView;
@property (strong,nonatomic) UILabel * nameText;
@property (strong,nonatomic) UILabel * scheduleTime;
@property (strong,nonatomic) UILabel * scheduleTimeDel1;
@property (strong,nonatomic) UILabel * scheduleTimeDel2;
@property (strong,nonatomic) UILabel * scheduleTimeDel3;
@property (strong,nonatomic) UILabel * scheduleTimeDel4;
@property (strong,nonatomic) UILabel * scheduleTimeDel5;
@property (strong,nonatomic) UILabel * scheduleTimeDel6;
@property (strong,nonatomic) UIImageView * arrowImageView;
@property (strong,nonatomic) NSMutableArray * timeListArray;





@end
@implementation UGScheduleTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor =[UIColor colorWithHexString:@"#f7f7f7"];
    [self initUI];
    return self;
}
-(void)setConfirmeDetailModel:(AdanceTimeList *)confirmeDetailModel{
    
    _confirmeDetailModel = confirmeDetailModel;
     _nameText.text = self.confirmeDetailModel.enName;
   // NSString * userIcon = [NSString stringWithFormat:@"%@%@",UG_HOST,self.confirmeDetailModel.userIcon];
    
   
    
    //头像
    NSString * qingdaostr = self.confirmeDetailModel.userIcon;
    NSLog(@"%@",qingdaostr);
    if ([qingdaostr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:self.confirmeDetailModel.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,self.confirmeDetailModel.userIcon];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"default_icon"]  ];
    }
    

    _iconImageView.layer.cornerRadius = 30.0f;
    _iconImageView.clipsToBounds = YES;

   
    _scheduleTimeDel1.text = [NSString stringWithFormat:@"%@-%@ %@",_confirmeDetailModel.cnStartTime,_confirmeDetailModel.cnEndTime,_confirmeDetailModel.advanceDate];
    _scheduleTimeDel2.text = [NSString stringWithFormat:@"(美国时间%@-%@)",_confirmeDetailModel.otherStartTime,_confirmeDetailModel.otherEndTime];
    _scheduleTimeDel3.hidden = YES;
    _scheduleTimeDel4.hidden = YES;
    _scheduleTimeDel5.hidden = YES;
    _scheduleTimeDel6.hidden = YES;
    
    
}
-(void)setAdvanceListModel:(AdvanceListModel *)advanceListModel{
    _advanceListModel = advanceListModel;
    _nameText.text = _advanceListModel.enName;
    self.timeListArray = [NSMutableArray array];
    NSString * userIcon = [NSString stringWithFormat:@"%@%@",UG_HOST,_advanceListModel.userIcon];
    
    
    
    //头像
    NSString * qingdaostr = _advanceListModel.userIcon;
    NSLog(@"%@",qingdaostr);
    if ([qingdaostr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_advanceListModel.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,_advanceListModel.userIcon];
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"default_icon"]  ];
    }
    

    _iconImageView.layer.cornerRadius = 30.0f;
    _iconImageView.clipsToBounds = YES;
    for (NSDictionary * dict in _advanceListModel.advanceDetailList) {
        AdanceTimeList * model =[AdanceTimeList mj_objectWithKeyValues:dict];
        [self.timeListArray addObject:model];
        NSLog(@"%@",model.cnStartTime);
    
    }
    NSLog(@"%lu",(unsigned long)self.timeListArray.count);
    if (self.timeListArray.count == 0 ) {
        
        
            _scheduleTimeDel1.hidden = YES;
             _scheduleTimeDel2.hidden = YES;
             _scheduleTimeDel3.hidden = YES;
             _scheduleTimeDel4.hidden = YES;
        _scheduleTimeDel5.hidden = YES;
        _scheduleTimeDel6.hidden = YES;
        
    }else if (self.timeListArray.count == 1) {
            
            AdanceTimeList * model1 = self.timeListArray[0];
            
            _scheduleTimeDel1.text = [NSString stringWithFormat:@"%@-%@ %@",model1.cnStartTime,model1.cnEndTime,model1.advanceDate];
            _scheduleTimeDel2.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model1.otherStartTime,model1.otherEndTime];
            _scheduleTimeDel3.hidden = YES;
            _scheduleTimeDel4.hidden = YES;
        _scheduleTimeDel5.hidden = YES;
        _scheduleTimeDel6.hidden = YES;
        }else if (self.timeListArray.count ==2) {
            AdanceTimeList * model = self.timeListArray[0];
            _scheduleTimeDel1.text = [NSString stringWithFormat:@"%@-%@ %@",model.cnStartTime,model.cnEndTime,model.advanceDate];
            _scheduleTimeDel2.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model.otherStartTime,model.otherEndTime];
            AdanceTimeList * model2 = self.timeListArray[1];
            _scheduleTimeDel3.text = [NSString stringWithFormat:@"%@-%@ %@",model2.cnStartTime,model2.cnEndTime,model2.advanceDate];
            _scheduleTimeDel4.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model2.otherStartTime,model2.otherEndTime];
            _scheduleTimeDel5.hidden = YES;
            _scheduleTimeDel6.hidden = YES;
        }else{
            AdanceTimeList * model = self.timeListArray[0];
            _scheduleTimeDel1.text = [NSString stringWithFormat:@"%@-%@ %@",model.cnStartTime,model.cnEndTime,model.advanceDate];
            _scheduleTimeDel2.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model.otherStartTime,model.otherEndTime];
            AdanceTimeList * model2 = self.timeListArray[1];
            _scheduleTimeDel3.text = [NSString stringWithFormat:@"%@-%@ %@",model2.cnStartTime,model2.cnEndTime,model2.advanceDate];
            _scheduleTimeDel4.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model2.otherStartTime,model2.otherEndTime];
            AdanceTimeList * model3 = self.timeListArray[2];
            _scheduleTimeDel5.text = [NSString stringWithFormat:@"%@-%@ %@",model3.cnStartTime,model3.cnEndTime,model3.advanceDate];
            _scheduleTimeDel6.text = [NSString stringWithFormat:@"(美国时间%@-%@)",model3.otherStartTime,model3.otherEndTime];
        }
    

}
-(void)initUI{
    
    _view =[[UIView alloc]init];
    _view.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    [self.contentView addSubview:_view];
    //self.backgroundColor = [UIColor grayColor];
    //头像
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.image = [UIImage imageNamed:@"default_icon"];
    _iconImageView.backgroundColor = [UIColor whiteColor];
    [_view  addSubview:_iconImageView];
    //姓名
    _nameText = [[UILabel alloc]init];
    _nameText.text = @"Petarr";
    _nameText.textAlignment =  NSTextAlignmentLeft;
    _nameText.highlightedTextColor=[UIColor colorWithHexString:@"#252525"];
    _nameText.font = [UIFont systemFontOfSize:15];
//    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:_nameText.text];
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle1.lineSpacing = 5;
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, _nameText.text.length)];
//    //[_nameText setAttributedText:attributedString1];
//    _nameText.attributedText =attributedString1;
//    [_nameText sizeToFit];
    [_view addSubview:_nameText];
    // 箭头
    _arrowImageView = [[UIImageView alloc]init];
    
    _arrowImageView.image = [UIImage imageNamed:@"arrow_image"];
    
    [_view addSubview:_arrowImageView];
    //预约时间
    _scheduleTime = [[UILabel alloc]init];
    _scheduleTime.text = @"预约时间:";
    _scheduleTime.textAlignment =  NSTextAlignmentLeft;
     _scheduleTime.highlightedTextColor=[UIColor colorWithHexString:@"#252525"];
    _scheduleTime.font = [UIFont systemFontOfSize:13];
    [_view  addSubview:_scheduleTime];
    //预约时间详细
    
    _scheduleTimeDel1 = [[UILabel alloc]init];
    _scheduleTimeDel1.text = @"";
    _scheduleTimeDel1.textAlignment =  NSTextAlignmentLeft;
    
    _scheduleTimeDel1.highlightedTextColor = [UIColor colorWithHexString:@"#383838"];
    _scheduleTimeDel1.font = [UIFont systemFontOfSize:11];
    [_view  addSubview:_scheduleTimeDel1];

    _scheduleTimeDel2 = [[UILabel alloc]init];
        _scheduleTimeDel2.textAlignment =  NSTextAlignmentLeft;
    [_scheduleTimeDel2 setTextColor:RGB(190, 190, 190)];
    _scheduleTimeDel2.font = [UIFont systemFontOfSize:11];
  
    [_view  addSubview:_scheduleTimeDel2];
    _scheduleTimeDel3 = [[UILabel alloc]init];
    _scheduleTimeDel3.text = @"08:00 - 09:00 a.m.5月9日";
    _scheduleTimeDel3.textAlignment =  NSTextAlignmentLeft;
    _scheduleTimeDel3.highlightedTextColor = [UIColor colorWithHexString:@"#383838"];
    _scheduleTimeDel3.font = [UIFont systemFontOfSize:11];
    [_view  addSubview:_scheduleTimeDel3];
    
    _scheduleTimeDel4 = [[UILabel alloc]init];
    _scheduleTimeDel4.text = @"(美国时间 09:00-10:00 p.m)";
    _scheduleTimeDel4.textAlignment =  NSTextAlignmentLeft;
    [_scheduleTimeDel4 setTextColor:RGB(190, 190, 190)];
    //_scheduleTimeDel3.highlightedTextColor =
    _scheduleTimeDel4.font = [UIFont systemFontOfSize:11];
    
    [_view  addSubview:_scheduleTimeDel4];
    _scheduleTimeDel5 = [[UILabel alloc]init];
    _scheduleTimeDel5.text = @"08:00 - 09:00 a.m.5月9日";
    _scheduleTimeDel5.textAlignment =  NSTextAlignmentLeft;
    _scheduleTimeDel5.highlightedTextColor = [UIColor colorWithHexString:@"#383838"];
    _scheduleTimeDel5.font = [UIFont systemFontOfSize:11];
    [_view  addSubview:_scheduleTimeDel5];
    
    _scheduleTimeDel6 = [[UILabel alloc]init];
    _scheduleTimeDel6.text = @"(美国时间 09:00-10:00 p.m)";
    _scheduleTimeDel6.textAlignment =  NSTextAlignmentLeft;
    [_scheduleTimeDel6 setTextColor:RGB(190, 190, 190)];
    //_scheduleTimeDel3.highlightedTextColor =
    _scheduleTimeDel6.font = [UIFont systemFontOfSize:11];
    
    [_view  addSubview:_scheduleTimeDel6];

    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right);
    }];

    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_view .mas_top).offset(14);
        make.left.mas_equalTo(_view .mas_left).offset(11);
        make.size.mas_equalTo(CGSizeMake(60, 60));
        
    }];
    [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_top);
        make.left.mas_equalTo(_iconImageView.mas_right).offset(6);
        make.size.mas_equalTo(CGSizeMake(200, 17));
    }];
    [_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImageView.mas_top);
        make.right.mas_equalTo(_view.mas_right).offset(-12);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];

    [_scheduleTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameText.mas_bottom).offset(7);
        make.left.mas_equalTo(_nameText.mas_left);
        make.size.mas_equalTo(CGSizeMake(66, 13));
    }];
//
    [_scheduleTimeDel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTime.mas_top);
        make.left.mas_equalTo(_scheduleTime.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(160, 11));
    }];
    [_scheduleTimeDel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTimeDel1.mas_bottom);
        make.left.mas_equalTo(_scheduleTimeDel1.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 11));
    }];
//
    [_scheduleTimeDel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTimeDel2.mas_bottom).offset(7);
        make.left.mas_equalTo(_scheduleTime.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(150, 11));
    }];
    [_scheduleTimeDel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTimeDel3.mas_bottom);
        make.left.mas_equalTo(_scheduleTimeDel1.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 11));
    }];
    [_scheduleTimeDel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTimeDel4.mas_bottom).offset(7);
        make.left.mas_equalTo(_scheduleTime.mas_right).offset(2);
        make.size.mas_equalTo(CGSizeMake(150, 11));
    }];
    [_scheduleTimeDel6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_scheduleTimeDel5.mas_bottom);
        make.left.mas_equalTo(_scheduleTimeDel1.mas_left);
        make.size.mas_equalTo(CGSizeMake(150, 11));
    }];

    
}
-(void)setLineSpacing:(UILabel*)lable lineSpace:(CGFloat)sapace{
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:lable.text];
    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:sapace];
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [lable.text length])];
    [lable setAttributedText:attributedString1];
    [lable sizeToFit];
    
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
