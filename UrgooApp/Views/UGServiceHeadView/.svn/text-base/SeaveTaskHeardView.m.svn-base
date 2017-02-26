//
//  SeaveTaskHeardView.m
//  UrgooApp
//
//  Created by IOS开发者 on 16/8/23.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "SeaveTaskHeardView.h"

@implementation SeaveTaskHeardView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        //[self initUI];//133
    }
    return self;
}

-(CGRect)initUI:(NewTaskInforModel *)model
{
    _backGroundV = [[UIView alloc] init];
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, 290);
    _backGroundV.backgroundColor = [UIColor whiteColor];
    _backGroundV.layer.borderColor = [UIColor colorWithHexString:@"d4d4d4"].CGColor;
    [self addSubview:_backGroundV];
    
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
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, _content.bottom + 20, kScreenWidth, 0.6);
    line.backgroundColor = [UIColor colorWithHexString:@"999999"];
    [_backGroundV addSubview:line];
    
    UILabel *name = [[UILabel alloc] init];
    name.frame = CGRectMake(30, _content.bottom + 25, kScreenWidth-30*2, 30);
    name.text = @"动态";
    name.textColor = [UIColor colorWithHexString:@"000000"];
    name.font = [UIFont systemFontOfSize:16];
    [_backGroundV addSubview:name];
    
    _backGroundV.frame = CGRectMake(0, 0, kScreenWidth, name.bottom );
    CGRect frame = self.frame;
    frame.size.height = name.bottom ;
    self.frame = frame;
    
    return self.frame;
}




@end
