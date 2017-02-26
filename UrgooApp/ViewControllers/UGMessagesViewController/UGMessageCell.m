//
//  UGMessageCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMessageCell.h"

@interface UGMessageCell ()
@property(strong,nonatomic)UIImageView *iconImageView; //头像
@property(strong,nonatomic)UIImageView *parentImageView; //parent
@property(strong,nonatomic)UILabel *nameLabel;//Cindy
@property(strong,nonatomic)UILabel *messageLabel; //Hi,This is Jack's mum
@property(strong,nonatomic)UILabel *dateLabel; //2016-02-28

@end


@implementation UGMessageCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)messageTableViewCellWithTableView:(UITableView *)tableView{
    UGMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:ugmessagecellStr];
    if (!cell) {
        cell = [[UGMessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugmessagecellStr];
    }
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //头像
        self.iconImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 45, 45)];
        self.iconImageView.layer.masksToBounds  = YES;
        self.iconImageView.layer.cornerRadius = 22;
//        self.iconImageView.backgroundColor = [UIColor redColor];
        self.iconImageView.image = [UIImage imageNamed:@"me_header_bg"];
        [self.contentView addSubview:self.iconImageView];
        
        
        //parent
        self.parentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconImageView.x+10, self.iconImageView.y+self.iconImageView.height-5, 24, 10)];
        self.parentImageView.image = [UIImage  imageNamed:@"message_tag_parent"];
        [self.contentView addSubview:self.parentImageView];
        
        
        //Cindy
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.parentImageView.x+self.parentImageView.width+30, self.iconImageView.y, 150, 30)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Cindy";
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor colorWithHexString:@"3b3b3b"];
        [self.contentView addSubview:_nameLabel];
        
        //Hi,This is Jack's mum
        _messageLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.parentImageView.x+self.parentImageView.width+30, self.nameLabel.y+self.nameLabel.height+5, 150, 20)];
        _messageLabel.textAlignment = NSTextAlignmentLeft;
        _messageLabel.text = @"Hi,This is Jack's mum";
        _messageLabel.font = [UIFont systemFontOfSize:13];
        _messageLabel.textColor = [UIColor colorWithHexString:@"aea5a5"];
        [self.contentView addSubview:_messageLabel];
        
        
        //2016-02-28
        _dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth-90,_nameLabel.y, 80, 30)];
        _dateLabel.textAlignment = NSTextAlignmentRight;
        _dateLabel.text = @"2016-02-28";
        _dateLabel.font = [UIFont systemFontOfSize:11];
        _dateLabel.textColor = [UIColor colorWithHexString:@"d7d7d7"];
        [self.contentView addSubview:_dateLabel];
        
        
    }
    return self;
}

@end
