//
//  UGTasksTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTasksTableViewCell.h"
#import "Masonry.h"
@interface UGTasksTableViewCell()
@property (strong,nonatomic) UILabel * titleLable;
@property (strong,nonatomic) UILabel * subtitleLable;
@property (strong,nonatomic) UILabel * dataLable;

@end
@implementation UGTasksTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    //self.contentView.backgroundColor = [UIColor redColor];
    [self initUI];
    return self;
}

-(void)setTaskModel:(TaskplanningModel *)taskModel{
    _taskModel = taskModel;
    
    _titleLable.text = _taskModel.subReply;
    _subtitleLable.text = _taskModel.subjectTitle;
    
    _dataLable.text = _taskModel.endTime;
    
}

-(void)initUI{
    UIView * bgView = [[UIView alloc]init];
    
    bgView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
    
    bgView.layer.cornerRadius = 8.0f;
    bgView.layer.borderColor = [[UIColor colorWithHexString:@"#eeeeee"] CGColor];
    bgView.layer.borderWidth = 0.5f;
    bgView.layer.shadowColor = RGB(176, 175, 175).CGColor;
    bgView.layer.shadowOffset = CGSizeMake(0, 1.5);
    bgView.layer.shadowOpacity = 0.5;
    bgView.layer.shadowRadius = 3;
    bgView.clipsToBounds = NO;

   
    [self.contentView addSubview:bgView];
    UIView * circleview = [[UIView alloc]init];
    
    circleview.layer.cornerRadius = 7;
    circleview.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [bgView addSubview:circleview];
    _titleLable = [[UILabel alloc]init];
    _titleLable.textColor = [UIColor colorWithHexString:@"#333333"];

    _titleLable.text = @"stand for University";
    _titleLable.font = [UIFont systemFontOfSize:17];
    
    
    [self.contentView addSubview:_titleLable];
    _subtitleLable = [[UILabel alloc]init];
    _subtitleLable.textColor = [UIColor colorWithHexString:@"#999999"];
    _subtitleLable.text = @"stand for Universityfdsfdsfdsfdsfcdscsdcdsdsfds";
    _subtitleLable.font = [UIFont systemFontOfSize:13];
    
    
    [bgView addSubview:_subtitleLable];
    
    UIView * bgdateView = [[UIView alloc]init];
    
    bgdateView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    bgdateView.layer.cornerRadius = 8;
    [bgView addSubview:bgdateView];
    
    
    UIImageView * timeImage = [[UIImageView alloc]initWithImage:[ UIImage imageNamed:@"time_photo_plan"]];
    
    
    [bgView addSubview:timeImage];
    
    
    _dataLable = [[UILabel alloc]init];
    _dataLable.textColor = [UIColor whiteColor];
    _dataLable.text = @"8-2";
    _dataLable.font = [UIFont systemFontOfSize:11];
    
    
    [bgView addSubview:_dataLable];

    
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(10);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
    
    [circleview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_top).offset(7);
        make.left.mas_equalTo(bgView.mas_left).offset(7);
        make.size.mas_equalTo(CGSizeMake(14, 14));
      }];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(circleview.mas_bottom).offset(-5);
        make.left.mas_equalTo(circleview.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(200, 20));
    }];

    [_subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLable.mas_bottom).offset(5);
        make.left.mas_equalTo(circleview.mas_left).offset(20);
        make.right.mas_equalTo(bgView.mas_right);
        make.height.mas_equalTo( 16);
    }];

    [bgdateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_titleLable.mas_top);
        make.right.mas_equalTo(bgView.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(52, 16));
    }];
    [timeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgdateView.mas_top).offset(2);
        make.left.mas_equalTo(bgdateView.mas_left).offset(3);
        make.size.mas_equalTo(CGSizeMake(10, 12));
    }];
    [_dataLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgdateView.mas_top).offset(2);
        make.left.mas_equalTo(timeImage.mas_right).offset(3);
        make.right.mas_equalTo(bgdateView.mas_right).offset(-3);
        make.height.mas_equalTo( 12);
    }];

    
    
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
