//
//  UGTasksCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/10.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTasksCell.h"


@implementation UGTasksCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)tasksTableViewCellWithTableView:(UITableView *)tableView{
    UGTasksCell *cell = [tableView dequeueReusableCellWithIdentifier:ugtaskcellStr];
    if (!cell) {
        cell = [[UGTasksCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugtaskcellStr];
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
        
        //Cindy bought your service(10th grade)
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 30, _backView.width - 30, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Cindy submit tasks summer school";
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.textColor = [UIColor colorWithHexString:@"393939"];
        [_backView addSubview:_nameLabel];
        
        //type
        //时间
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 3, _backView.width/2, 25)];
        //_titleLabel.textAlignment = NSTextAlignmentRight;
        _titleLabel.text = @"04-26 10:30";
        _titleLabel.font = [UIFont systemFontOfSize:13];
        _titleLabel.textColor = [UIColor colorWithHexString:@"c9c9c9"];
        [_backView addSubview:_titleLabel];
        
        //时间
        _dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(_backView.width - 120, 3, 100, 25)];
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
        _redImageView.hidden = YES;
        [_backView addSubview:_redImageView];
        
    }
    return self;
}



@end
