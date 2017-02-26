//
//  VideoDetailCommentCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "VideoDetailCommentCell.h"

@implementation VideoDetailCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //[self initUI];
    }
    
    return self;
}

-(void)initUI:(LiveVideoCommentModel *)model
{
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [self.contentView addSubview:_backGroundView];
    
    _headImageV = [[UIImageView alloc] init];
    _headImageV.frame = CGRectMake(20, 5, 30, 30);
    _headImageV.layer.cornerRadius = 15;
    _headImageV.clipsToBounds = YES;
    if ( [StringHelper isUserIconContainHttp:model.userIcon]) {
        [_headImageV sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",UG_HOST1,model.userIcon];
        [_headImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }
    [_backGroundView addSubview:_headImageV];
    
    _name = [[UILabel alloc] init];
    _name.frame = CGRectMake(_headImageV.x+_headImageV.width+10, _headImageV.bottom-15, kScreenWidth/2, 15);
    _name.text = model.nickName;
    _name.textColor = [UIColor colorWithHexString:@"000000"];
    _name.font = [UIFont systemFontOfSize:13];
    [_backGroundView addSubview:_name];
    
    _time = [[UILabel alloc] init];
    _time.frame = CGRectMake(kScreenWidth/2-40, _name.bottom-15, kScreenWidth/2, 12);
    _time.text = model.insertDatetime;
    _time.textColor = [UIColor colorWithHexString:@"999999"];
    _time.font = [UIFont systemFontOfSize:11];
    _time.textAlignment = NSTextAlignmentRight;
    [_backGroundView addSubview:_time];
    
    NSString *text = model.content;
    _comment = [[UILabel alloc] init];
    
    _comment.frame =CGRectMake(_name.x, _headImageV.bottom-5, kScreenWidth-_name.x-40, 10);
    _comment.textColor = [UIColor colorWithHexString:@"666666"];
    [_comment heightForLableText:text fontOfSize:13 frame:_comment.frame];
    [_backGroundView addSubview:_comment];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(20, _comment.bottom+4, kScreenWidth-40, 0.6);
    line.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [_backGroundView addSubview:line];
    
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, _comment.bottom + 5);
    CGRect frame = self.frame;
    frame.size.height =  _comment.bottom + 5;
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
