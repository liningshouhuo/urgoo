//
//  UGMineCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/14.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGMineCell.h"
#import "Masonry.h"
@interface UGMineCell ()
{
    UIView * view;
}

@end


@implementation UGMineCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
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

        
        CGFloat kWidth = kScreenWidth/3;
        //CGFloat margin =kScreenWidth * 0.125;
        
        //3个分区.  120*120
//        NSArray *titleArr = @[@"Follow",@"Clients",@"Profile"]; my_schudel_mine
        NSArray *imgsArr = @[@"attention_consultant",@"my_schudel_mine",@"my_order_mine"];
        NSArray *titlesArr = @[@"关注的顾问",@"我的预约",@"订单"];
        NSLog(@"%lu",(unsigned long)imgsArr.count);
        NSLog(@"%f %f",kScreenWidth,kScreenHeight);
        for (NSInteger i= 0; i<imgsArr.count; i++) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame=  CGRectMake(i*(kWidth) + kScreenWidth/6  -20, 10, 40, 40);
            //button.frame=  CGRectMake(((i +1)*2 -1) + margin, 10, 40, 40);
            [button setImage:[UIImage imageNamed:imgsArr[i]] forState:UIControlStateNormal];
//            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button setBackgroundColor: [UIColor clearColor]];
            button.tag = i;
            [self addSubview:button];
            UILabel *titleLabel = [[UILabel alloc]init];
            titleLabel.text = titlesArr[i];
            titleLabel.font = [UIFont systemFontOfSize:12];
            
            titleLabel.backgroundColor = [UIColor whiteColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            CGSize size = [titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:titleLabel.font,NSFontAttributeName, nil]];
            CGFloat titleLabelH = size.height;
            CGFloat titleLabelW = size.width;
            titleLabel.frame = CGRectMake(0, 0, titleLabelW, titleLabelH);
            titleLabel.centerX = button.centerX;
            titleLabel.centerY = button.centerY + 23.0f;
            titleLabel.textColor = [UIColor colorWithHexString:@"434343"];
            titleLabel.userInteractionEnabled = YES;
            [self addSubview:titleLabel];
            
            
            UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(i*kWidth, 0, 0.5, 64 )];
            lineLabel1.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
            [self addSubview:lineLabel1];
            //添加一个透明的view
            UIView * clearView = [[UIView alloc]initWithFrame:CGRectMake(button.x -30,0, button.width +60, 64)];
            clearView.tag = i;
            //[clearView viewWithTag:i];
                       //clearView.backgroundColor = [UIColor clearColor];
            clearView.backgroundColor = [UIColor clearColor];
            [self addSubview:clearView];
            //添加一个点击事件
            UITapGestureRecognizer * singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(auttonAction:)];
            
            
            singleRecognizer.numberOfTapsRequired = 1; // 单击
            [clearView addGestureRecognizer:singleRecognizer];
        }
        
        
        
        UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, kWidth, kScreenWidth, 0.5)];
        lineLabel2.backgroundColor = [UIColor colorWithHexString:@"d4d4d4"];
        //[self addSubview:lineLabel2];
        
        
      //  UIView * redView = [[UIView alloc]init];
        
                    view = [[UIView alloc]init];
                    view.layer.cornerRadius = 3.5;
                    view.backgroundColor = [UIColor redColor];
                    view.hidden = YES;
                    [self.contentView addSubview:view];
        
        
                        [view mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
                            //make.centerY.mas_equalTo(self.contentView.mas_centerY);
                            make.right.mas_equalTo(self.contentView.mas_right).offset(-5 - kScreenWidth/3);
                            make.size.mas_equalTo(CGSizeMake(7, 7));
                        }];
        
        
        

        

    }
    return self;
}
-(void)set_isShow:(NSString *)_isShow{
    _isShow = _isShow;
    
    if ([_isShow isEqualToString:@"1"]) {
         view.hidden = NO;
        
    }else if([_isShow isEqualToString:@"0"]){
         view.hidden = YES;
    }
    
    
    
    
}
-(void)auttonAction:(UITapGestureRecognizer *)sender
{
    
    _underBlock([sender view].tag);
    
}


-(void)buttonAction:(UIButton *)button
{
    _underBlock(button.tag);
}

@end
