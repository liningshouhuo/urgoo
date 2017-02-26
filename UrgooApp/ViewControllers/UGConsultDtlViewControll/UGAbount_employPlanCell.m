//
//  UGAbount_employPlanCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGAbount_employPlanCell.h"

static CGRect frameOne;

@implementation UGAbount_employPlanCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return self;
}

-(void)initUI
{
    _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 380)];
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self.contentView addSubview:_backGroundView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _backGroundView.width, 36)];
    title.text = @"预约说明";
    title.font = [UIFont systemFontOfSize:17];
    title.textColor = [UIColor colorWithHexString:@"000000"];
    title.textAlignment = NSTextAlignmentCenter;
    [_backGroundView addSubview:title];
    
    //分割线
    UILabel *line =[[UILabel alloc]initWithFrame:CGRectMake(0, title.height, _backGroundView.width, 0.5)];
    line.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
    [_backGroundView addSubview:line];

    NSArray *arr = @[@"1、为保障您与顾问有效沟通，顾问提供您首次40分钟免费视频会话。",@"2、提交视频预约后，请您耐心等待，顾问在48小时内予以确认。",@"3、建议学生参与视频会议，以便顾问提供您专业的建议。",@"4、预约外籍顾问，优顾家长助理免费帮助您翻译。",@"5、顾问确认后，请您安排时间准时参加视频会议。",@"6、视频当日，请您提前10分钟做好准备，保持网络畅通并开启优顾APP。"];
    CGFloat heightt = 0;
    for (int i = 0; i < arr.count; i ++) {
        
        NSString *str = [NSString stringWithFormat:@"%@",arr[i]];
        UILabel *note = [[UILabel alloc] init];
        note.textColor = [UIColor colorWithHexString:@"666666"];
        note.frame = CGRectMake(30, line.bottom+10+heightt, line.width-60, 13);
        [note heightForLableText:str fontOfSize:13 frame:note.frame];
        heightt += note.height+10;
        [_backGroundView addSubview:note];

        frameOne = note.frame;
    }
    
    
    
    _chatButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _chatButn.frame = CGRectMake(0, 0, 100, 30);
    _chatButn.center = CGPointMake(_backGroundView.width/2, frameOne.origin.y+80);
    _chatButn.titleLabel.font = [UIFont systemFontOfSize:15];
    _chatButn.layer.cornerRadius = 5;
    _chatButn.layer.masksToBounds = YES;
    _chatButn.layer.borderWidth = 0.6;
    _chatButn.layer.borderColor = [UIColor colorWithHexString:@"26BDAB"].CGColor;
    [_chatButn setTitle:@"需要帮助" forState:UIControlStateNormal];
    [_chatButn setTitleColor:[UIColor colorWithHexString:@"26BDAB"] forState:UIControlStateNormal];
    [_chatButn addTarget:self action:@selector(clickChatButn) forControlEvents:UIControlEventTouchUpInside];
    //[_backGroundView addSubview:_chatButn];
    
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(0, frameOne.origin.y+60, _backGroundView.width, 35)];//Y = _chatButn.bottom+5
    time.numberOfLines = 2;
    time.text = @"服务热线：400-061-2819\n服务时间：每日9:00-18:00";
    time.font = [UIFont systemFontOfSize:11];
    time.textColor = [UIColor colorWithHexString:@"999999"];
    time.textAlignment = NSTextAlignmentCenter;
    [_backGroundView addSubview:time];

    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, time.bottom + 30);
    CGRect frame = self.frame;
    frame.size.height = time.bottom + 30;
    self.frame = frame;
    
}

-(void)clickChatButn
{
    if (_chatUBaoBlock) {
        _chatUBaoBlock();
    }
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
