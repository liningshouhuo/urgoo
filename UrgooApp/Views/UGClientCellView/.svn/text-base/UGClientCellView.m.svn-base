//
//  UGClientCellView.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGClientCellView.h"

@implementation UGClientCellView

-(instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)titleStr
{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor clearColor];
        
        
        UIView *redView =[[UIView alloc]initWithFrame:CGRectMake(5, 7, 6, 6)];
        redView.backgroundColor =[UIColor colorWithHexString:@"ff9148"];
        redView.layer.masksToBounds = YES;
        redView.layer.cornerRadius = 3;
        [self addSubview:redView];
        
        UILabel *label =[[UILabel alloc]initWithFrame:CGRectMake(20, 0, self.width-20, self.height)];
        label.text = titleStr;
        label.font  = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithHexString:@"bababa"];
        [self addSubview:label];
        
    }
    return self;
}
@end
