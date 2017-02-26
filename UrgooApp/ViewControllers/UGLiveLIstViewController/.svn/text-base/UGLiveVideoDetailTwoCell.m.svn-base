//
//  UGLiveVideoDetailTwoCell.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/7/18.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLiveVideoDetailTwoCell.h"

@implementation UGLiveVideoDetailTwoCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = RGB(238, 238, 238);
        //[self initUI];
    }
    return  self;
}

-(void)initUI:(NSArray *)imageArr
{
    _backGroundView = [[UIView alloc] init];
    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, 180);
    _backGroundView.backgroundColor = [UIColor whiteColor];
    _backGroundView.userInteractionEnabled = YES;
    [self.contentView addSubview:_backGroundView];
    
    _title = [[UILabel alloc] init];
    _title.frame = CGRectMake(20, 10, _backGroundView.width-60, 16);
    _title.font = [UIFont systemFontOfSize:16];
    _title.text = @"往期回顾:";
    _title.textColor = [UIColor colorWithHexString:@"000000"];
    [_backGroundView addSubview:_title];
    
    _allButn = [UIButton buttonWithType:UIButtonTypeCustom];
    _allButn.frame = CGRectMake(_backGroundView.width-70-10, _title.y, 70, 20);
    //_allButn.layer.borderWidth = 0.6;
    _allButn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_allButn setTitleColor:[UIColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [_allButn setTitle:@"查看全部>" forState:UIControlStateNormal];
    [_allButn addTarget:self action:@selector(clickAllButton) forControlEvents:UIControlEventTouchUpInside];
    //[_backGroundView addSubview:_allButn];
    
    
    //NSArray *arr = @[@"conselor_user_heads",@"conselor_user_heads",@"conselor_user_heads"];
    NSArray *arr = imageArr;
    if (arr.count == 0) {
        
        _hightOne = 20;
        
    }else{
        
        for (int i = 0; i < arr.count; i ++) {
            
            UIImageView *imageV = [[UIImageView alloc] init];
            imageV.frame = CGRectMake(20+((kScreenWidth-80)/3+20)*i, _title.bottom+10, (kScreenWidth-80)/3, 60);
            [imageV sd_setImageWithURL:[NSURL URLWithString:arr[i]] placeholderImage:[UIImage imageNamed:@"imageLoading_icon"]];
            imageV.layer.cornerRadius = 6;
            imageV.clipsToBounds = YES;
            [_backGroundView addSubview:imageV];
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(20+((kScreenWidth-80)/3+20)*i, _title.bottom+10, (kScreenWidth-80)/3, 60);
            button.layer.cornerRadius = 6;
            button.clipsToBounds = YES;
            button.layer.borderWidth = 0.6;
            button.layer.borderColor = [UIColor colorWithHexString:@"f7f7f7"].CGColor;
            button.tag = 100 + i;
            button.backgroundColor = [UIColor clearColor];
            [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            [_backGroundView addSubview:button];
            
            _hightOne = button.bottom;
        }
    }
    
    
    _backGroundView.frame = CGRectMake(0, 10, kScreenWidth, _hightOne + 20);
    CGRect frame = self.frame;
    frame.size.height = _hightOne + 30;
    self.frame = frame;
    
}

-(void)clickButton:(UIButton *)butn
{
    NSString *strNum = [NSString stringWithFormat:@"%ld",butn.tag - 100];
    if (_oneBlock) {
        _oneBlock(strNum);
    }
}


-(void)clickAllButton
{
    if (_allBlock) {
        _allBlock();
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
