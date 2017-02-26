//
//  NewTaskDetialOneCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewTaskDetialOneCell.h"

@implementation NewTaskDetialOneCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"eeeeee"];
        //[self initUI];
    }
    return self;
}

-(void)initUI:(NewTaskInforModel *)model
{
    _backGroundV = [[UIView alloc] init];
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, 290);
    _backGroundV.backgroundColor = [UIColor whiteColor];
    _backGroundV.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.contentView addSubview:_backGroundV];
    
    NSString *titleStr = model.subject;
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(30, 30, kScreenWidth-30*2, 5);
    _title.text = titleStr;
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    _title.font = [UIFont systemFontOfSize:17];
    [_title heightForLableText:titleStr fontOfSize:17 frame:_title.frame];
    [_backGroundV addSubview:_title];
    
    NSString *content = model.taskContent;
    _content = [[UILabel alloc] init];
    _content.frame = CGRectMake(30, _title.bottom+5, kScreenWidth-30*2, 15);
    _content.text = content;
    _content.textColor = [UIColor colorWithHexString:@"999999"];
    _content.font = [UIFont systemFontOfSize:13];
    [_content heightForLableText:content fontOfSize:13 frame:_content.frame];
    [_backGroundV addSubview:_content];
    
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, _content.bottom + 36);
    CGRect frame = self.frame;
    frame.size.height = _content.bottom + 41;
    self.frame = frame;
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
