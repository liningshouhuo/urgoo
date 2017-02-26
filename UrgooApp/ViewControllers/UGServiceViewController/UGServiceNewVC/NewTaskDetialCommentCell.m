//
//  NewTaskDetialCommentCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/9.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "NewTaskDetialCommentCell.h"

static CGFloat heightOne;
@implementation NewTaskDetialCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //[self initUI];
    }
    
    return self;
}

-(void)initUI:(NewTaskCommentModel *)model
{
    
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, 60);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [self.contentView addSubview:_backGroundView];
    
    _headImageV = [[UIImageView alloc] init];
    _headImageV.frame = CGRectMake(20, 5, 35, 35);
    _headImageV.layer.cornerRadius = 35/2;
    _headImageV.clipsToBounds = YES;
    //_headImageV.image = [UIImage imageNamed:@"default_icon"];
   
    if ( [StringHelper isUserIconContainHttp:model.userIcon]) {
        [_headImageV sd_setImageWithURL:[NSURL URLWithString:model.userIcon] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }else{
        NSString *url = [NSString stringWithFormat:@"%@%@",UG_HOST1,model.userIcon];
        [_headImageV sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"default_icon"]];
    }
    
    [_backGroundView addSubview:_headImageV];
    
    _name = [[UILabel alloc] init];
    _name.frame = CGRectMake(_headImageV.x+_headImageV.width+10, _headImageV.bottom-20, kScreenWidth/2, 15);
    _name.text = model.userName;
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
    
    NSString *text = model.replyContent;
    _comment = [[UILabel alloc] init];
    _comment.frame =CGRectMake(_name.x, _name.bottom+5, kScreenWidth-_name.x-40, 10);
    _comment.textColor = [UIColor colorWithHexString:@"666666"];
    [_comment heightForLableText:text fontOfSize:13 frame:_comment.frame];
    [_backGroundView addSubview:_comment];
    
    if (text.length < 1) {
        _comment.frame =CGRectMake(_name.x, _name.bottom+5, kScreenWidth-_name.x-40, 0);
    }
    
    //work
    UIImageView *imageV = [[UIImageView alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (/* DISABLES CODE */ (0)) {
        
        imageV.frame = CGRectMake(_name.x, _comment.bottom + 10, 15, 13);
        imageV.image = [UIImage imageNamed:@"小皇冠"];
        [_backGroundView addSubview:imageV];
        
        button.frame = CGRectMake(imageV.rightWith+5, imageV.y, 145, 15);
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [button setTitle:@"孩子已完成任务,去看看" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"click_arror_more"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(5, 132, 5, 0)];
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [button addTarget:self action:@selector(clickWorkButn) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
        
    }else{
        imageV.frame = CGRectMake(_name.x, _comment.bottom , 15, 0);//10
        button.frame = CGRectMake(imageV.rightWith+5, imageV.y-2, 145, 0);
    }
    
    //word
    UIButton *wordButn = [UIButton buttonWithType:UIButtonTypeCustom];
    //UILabel *note = [[UILabel alloc] init];
    loading = [[UILabel alloc] init];
    if (/* DISABLES CODE */ (model.attachedFileName.length > 0)) {
        
        wordButn.frame = CGRectMake(_name.x, imageV.bottom + 15, 17, 19);
        [wordButn setImage:[UIImage imageNamed:@"report_icon_text"] forState:UIControlStateNormal];
        [wordButn addTarget:self action:@selector(clickWord) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:wordButn];
        
        loading.frame = CGRectMake(wordButn.rightWith+2, wordButn.bottom - 15, kScreenWidth-40-wordButn.rightWith, 12);
        loading.font = [UIFont systemFontOfSize:12];
        loading.text = model.attachedFileName;
        loading.textColor = [UIColor colorWithHexString:@"aeaeae"];
        [_backGroundView addSubview:loading];
        
    }else{
        wordButn.frame = CGRectMake(_name.x, imageV.bottom , 17, 0);//15
    }
    
    heightOne = wordButn.bottom;
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(20, heightOne+19, kScreenWidth-40, 0.6);
    line.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
    [_backGroundView addSubview:line];
    
    _backGroundView.frame = CGRectMake(0, 0, kScreenWidth, heightOne + 20);
    CGRect frame = self.frame;
    frame.size.height =  heightOne + 20;
    self.frame = frame;
    
}

-(void)clickWorkButn
{
    
}

-(void)clickWord
{
    /*
    if (!isLoading) {
        isLoading = YES;
        loading.text = [NSString stringWithFormat:@"下载中...%@%@",@"20",@"%"];
        [self performSelector:@selector(loadingEND) withObject:nil afterDelay:5.0];
    }
     */
}

-(void)loadingEND
{
    /*
    loading.text = @"打开";
    loading.textColor = [UIColor colorWithHexString:@"26BDAB"];
     */
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
