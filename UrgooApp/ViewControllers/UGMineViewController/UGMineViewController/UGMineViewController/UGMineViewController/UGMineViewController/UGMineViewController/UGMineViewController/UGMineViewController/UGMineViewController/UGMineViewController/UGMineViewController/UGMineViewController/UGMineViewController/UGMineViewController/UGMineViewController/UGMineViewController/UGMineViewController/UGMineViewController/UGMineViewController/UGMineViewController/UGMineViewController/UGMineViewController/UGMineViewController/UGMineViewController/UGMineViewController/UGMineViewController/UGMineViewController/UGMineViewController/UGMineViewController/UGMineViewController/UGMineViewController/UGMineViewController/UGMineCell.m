//
//  UGMineCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMineCell.h"

@interface UGMineCell ()


@end


@implementation UGMineCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)mineTableViewCellWithTableView:(UITableView *)tableView
{
    UGMineCell *cell = [tableView dequeueReusableCellWithIdentifier:ugminecellStr];
    if (!cell) {
        cell = [[UGMineCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugminecellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}

//120
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor whiteColor];

        
        CGFloat kWidth = kScreenWidth/4;
        //3个分区.  120*120
//        NSArray *titleArr = @[@"Follow",@"Clients",@"Profile"];
        NSArray *imgsArr = @[@"counselor_h",@"profile_h"];
        for (NSInteger i= 0; i<imgsArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=  CGRectMake(i*(kWidth*2)+kWidth/2, 0, kWidth, kWidth-0.5);
            [button setImage:[UIImage imageNamed:imgsArr[i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor: [UIColor clearColor]];
            button.tag = i;
            
            [self addSubview:button];
            
            
//            UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(i%4 *kWidth,  button.y+button.height-10, kWidth, 30)];
//            titleLabel.text = titleArr[i];
//            titleLabel.backgroundColor = [UIColor whiteColor];
//            titleLabel.textAlignment = NSTextAlignmentCenter;
//            titleLabel.font = [UIFont systemFontOfSize:11];
//            titleLabel.userInteractionEnabled = YES;
//            [self addSubview:titleLabel];
            
            
            UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(2*i*kWidth, 0, 0.5, kWidth )];
            lineLabel1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            [self addSubview:lineLabel1];
        }
        
        
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kWidth, kScreenWidth, 0.5)];
        lineLabel2.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        [self addSubview:lineLabel2];
        
        

    }
    return self;
}

-(void)buttonAction:(UIButton *)button
{
    _underBlock(button.tag);
}

@end
