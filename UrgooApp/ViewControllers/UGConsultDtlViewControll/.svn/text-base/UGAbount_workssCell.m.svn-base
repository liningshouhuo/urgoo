//
//  UGAbount_workssCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/27.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAbount_workssCell.h"

@implementation UGAbount_workssCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //[self initUI];
    }
    
    return self;
}

-(void)initUI:(WorkssModel *)model
{
    _backGroundV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 75)];
    _backGroundV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_backGroundV];
    
    NSString *titleStr = model.title;
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(20, 10, kScreenWidth-50, 10);
    _title.font  = [UIFont systemFontOfSize:17];
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    [_title heightForLableText:titleStr fontOfSize:17 frame:_title.frame];
    [_backGroundV addSubview:_title];
    
    _time = [[UILabel alloc] init];
    _time.frame = CGRectMake(kScreenWidth/2-40, _title.bottom+5, kScreenWidth/2, 12);
    _time.font  = [UIFont systemFontOfSize:11];
    _time.textColor = [UIColor colorWithHexString:@"cccccc"];
    _time.text = model.insertDateTime;
    _time.textAlignment = NSTextAlignmentRight;
    [_backGroundV addSubview:_time];
    
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, _time.bottom + 5);
    CGRect frame = self.frame;
    frame.size.height = _time.bottom + 5;
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
