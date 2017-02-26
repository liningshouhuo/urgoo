//
//  UGMyreportTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMyreportTableViewCell.h"
#import "Masonry.h"

@interface UGMyreportTableViewCell()
@property (strong,nonatomic) UILabel * titleLable;
@property (strong,nonatomic) UILabel * dateLable;

@end



@implementation UGMyreportTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //self.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    [self initUI];
    return self;
}



-(void)initUI{
    
    
    _titleLable = [[UILabel alloc]init];
    _titleLable.font = [UIFont systemFontOfSize:17];
    _titleLable.text = @"wdhkjchdscdhkcjdckjsdhhcdh";
    
    _titleLable.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLable];
    
    
    UIImageView * arrowImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_photo"]];
    
    [self.contentView addSubview:arrowImage];
    
    
    
    
    _dateLable = [[UILabel alloc]init];
    _dateLable.text = @"2016-7-10";
    _dateLable.textAlignment = NSTextAlignmentRight;
    _dateLable.font = [UIFont systemFontOfSize:11];
    _dateLable.textColor = [UIColor colorWithHexString:@"#999999"];
    [self.contentView addSubview:_dateLable];
    
    
    UIView * lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    [self.contentView addSubview:lineView];
    [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(30);
        make.left.mas_equalTo(self.contentView.mas_left).offset(30);
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth * 0.73, 20));
    }];
    
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.contentView.mas_top).offset(30);
        make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        
        make.size.mas_equalTo(CGSizeMake(10, 15));
    }];
    
    [_dateLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-3);
        //make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-25);
        
        make.size.mas_equalTo(CGSizeMake(100, 13));
    }];

    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        //make.centerY.mas_equalTo(_titleLable.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right);
        
        make.size.mas_equalTo(CGSizeMake(kScreenWidth-20, 1));
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
