//
//  UGCloseCollectionViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/13.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCloseCollectionViewCell.h"
#import "Masonry.h"
@implementation UGCloseCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
   self = [super initWithFrame:frame];
    [self setUI];
    return self;
}
-(void)setUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"close_schedule_icon"];
    [self.contentView addSubview:imageView];
    UILabel * lable = [[UILabel alloc]init];
    lable.text = @"顾问今天没有开放预约,换一天试试吧~";
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = [UIColor colorWithHexString:@"#b1b1b1"];
    lable.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lable];
    
    
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(25);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(55, 55));
    }];
   
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(250, 16));
    }];


}
@end
