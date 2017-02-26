//
//  UGSystemCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGSystemCell.h"


//@interface UGSystemCell ()
//
//@property(strong,nonatomic)UIView *backView;
//@property(strong,nonatomic)UIImageView *arrowImageView; //箭头
//@property(strong,nonatomic)UILabel *nameLabel;//Urgoo2.0 online
//@property(strong,nonatomic)UILabel *detailLable;
//@property(strong,nonatomic)UILabel *dateLabel; //2016-03-03
//
//@end

@implementation UGSystemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)systemTableViewCellWithTableView:(UITableView *)tableView{
    UGSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:ugsystemcellStr];
    if (!cell) {
        cell = [[UGSystemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugsystemcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
        
        _backView =[[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 70)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 8;
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor =[UIColor colorWithHexString:@"c9c9c9"].CGColor;
        [self.contentView addSubview:_backView];
        
        //Urgoo2.0 online
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 150, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Urgoo2.0 online~";
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"393939"];
        [_backView addSubview:_nameLabel];
        
        //副标题
        _detailLable = [[UILabel alloc] initWithFrame:CGRectMake(5, self.nameLabel.y+self.nameLabel.height+0, kScreenWidth-30, 30)];
        _detailLable.textAlignment = NSTextAlignmentLeft;
        _detailLable.text = @"Urgoo2.0 online~";
        _detailLable.font = [UIFont systemFontOfSize:15];
        _detailLable.textColor = [UIColor grayColor];
        [_backView addSubview:_detailLable];
        
        //时间
        _dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(_backView.width - 110, 3, 100, 30)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.text = @"04-26 10:30";
        _dateLabel.font = [UIFont systemFontOfSize:13];
        _dateLabel.textColor = [UIColor colorWithHexString:@"d7d7d7"];
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
        _redImageView.hidden = YES;
        [_backView addSubview:_redImageView];
        
    }
    return self;
}


@end
