//
//  UGAccountCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/4/26.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAccountCell.h"


@implementation UGAccountCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)accountTableViewCellWithTableView:(UITableView *)tableView{
    UGAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ugaccountcellStr];
    if (!cell) {
        cell = [[UGAccountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ugaccountcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
        
        _backView =[[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 70)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor =[UIColor colorWithHexString:@"c9c9c9"].CGColor;
        [self.contentView addSubview:_backView];
        
        //Cindy bought your service(10th grade)
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 20, _backView.width - 30, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Bee have pay the service(Grade 9)already";
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorWithHexString:@"393939"];
        [_backView addSubview:_nameLabel];
        
        //时间
        _dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(_backView.width - 110, 3, 100, 30)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.text = @"04-26 10:30";
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textColor = [UIColor colorWithHexString:@"c9c9c9"];
        [_backView addSubview:_dateLabel];
        
        //箭头
        _arrowImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(_backView.width-20,_dateLabel.y+_dateLabel.height-5,20,20)];
        _arrowImageView.image = [UIImage imageNamed:@"message_list_icon_into"];
        [_backView addSubview:_arrowImageView];
        
        
        _redImageView=[[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth-40, 18, 6, 6)];
        _redImageView.center = CGPointMake(_arrowImageView.centerX-10, _arrowImageView.centerY);
        _redImageView.image = [UIImage imageNamed:@"message_new_info"];
        _redImageView.layer.masksToBounds = YES;
        _redImageView.layer.cornerRadius = 3;
        _redImageView.hidden = NO;
        [_backView addSubview:_redImageView];

    }
    return self;
}


@end
