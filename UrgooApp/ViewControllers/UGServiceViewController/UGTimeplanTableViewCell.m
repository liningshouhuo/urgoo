//
//  UGTimeplanTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/8/22.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGTimeplanTableViewCell.h"
#import "Masonry.h"
@interface UGTimeplanTableViewCell()
@property (strong,nonatomic) UILabel * lable;
@property (strong,nonatomic) UIView * bgView;
@property (strong,nonatomic) UIImageView * baseImageView;
@property (strong,nonatomic) UIView * cycleView;
@property (strong,nonatomic) UIView * lineView1;
@property (strong,nonatomic) UIView * lineView2;

@end
@implementation UGTimeplanTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    //self.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
//    [self setUI];
    return self;
}
-(void)setUI{
    _baseImageView = [[UIImageView alloc]init];
    
//    UIImage * image = [UIImage imageNamed:@"New_plan_bubble"];
//    NSLog(@"%f %f",image.size.height,image.size.width);
//       [_baseImageView setImage:image];
    [self.contentView addSubview:_baseImageView];
    
    
    
    
    _bgView = [[UIView alloc]init];
    _bgView.layer.cornerRadius = 8;
    _bgView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
    [self.contentView addSubview:_bgView];
    
    _lineView1 = [[UIView alloc]init];
    
    
    
    [self.contentView addSubview:_lineView1];
    
    
    
    
    _lineView2 = [[UIView alloc]init];
    
    
    
    [self.contentView addSubview:_lineView2];
    
    
    
    

    
    
    _lable = [[UILabel alloc]init];
    _lable.text = @"测试数据";
    
    _lable.numberOfLines = 0;
    [self.contentView addSubview:_lable];
    
    
    _cycleView = [[UIView alloc]init];
    
   
   
    
    [self.contentView addSubview:_cycleView];
    
    
    
}




-(void)setTestStr:(NSString *)testStr{
    _testStr = testStr;
    
    NSArray *subViews = self.contentView.subviews;
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }

    
     [self setUI];
    
    if ([_type isEqualToString:@"3"]) {
        
        
        
        
        UIView * lineView =  [[UIView alloc]init];
//        UIView * cycleVuew =  [[UIView alloc]init];
//        cycleVuew.frame = CGRectMake(kScreenWidth * 0.16 - 30  - 18, 10, 18, 18);
//        cycleVuew.centerX = kScreenWidth * 0.16 - 44;
//        cycleVuew.centerY = 10;
//        cycleVuew.size = CGSizeMake(18, 18);
//        cycleVuew.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
//        cycleVuew.layer.cornerRadius = 9;
        
        lineView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        
        
        [self.contentView addSubview:lineView];
//        [self.contentView addSubview:cycleVuew];
        
        
//        [cycleVuew mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.contentView);
//            make.centerX.mas_equalTo(self.contentView.mas_left).offset(kScreenWidth * 0.16 - 36);
//            make.size.mas_equalTo(CGSizeMake(18, 18));
//        }];
        
 
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).offset(10);
        make.centerX.mas_equalTo(self.contentView.mas_left).offset(kScreenWidth * 0.16 - 36);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(2);
    }];
    

    
    
    }else{
        
        
        
        
     
        
   
    _cycleView.layer.cornerRadius = 6;
    _lable.text = _testStr;

    _lable.font = [UIFont systemFontOfSize:13];
    _lable.numberOfLines = 0;
    CGRect rect = [_lable.text boundingRectWithSize:CGSizeMake(kScreenWidth *0.75, 999)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:@{NSFontAttributeName:[UIFont systemFontOfSize: 13]}
                                                   context:nil];
    
    _lable.frame = CGRectMake(kScreenWidth *0.16, 20,  kScreenWidth *0.75, rect.size.height);
    UIImage * image = [[UIImage alloc]init];
    if ([_type isEqualToString:@"2"]) {
        
        _lable.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
        if ([_type1 isEqualToString:@"1"]) {
             _lineView1.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
        }else{
            
            _lineView1.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
            
        }
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
         _cycleView.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
        image = [UIImage imageNamed:@"New_plan_bubble1"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 10,50) resizingMode:UIImageResizingModeTile];
    }else{
        if ([_type1 isEqualToString:@"1"]) {
            _lineView2.backgroundColor = [UIColor colorWithHexString:@"#cfcfcf"];
        }else{
            _lineView2.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
            
        }
        _lable.textColor = [UIColor colorWithHexString:@"#6a6a6a"];
        _lineView1.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
        _cycleView.backgroundColor = [UIColor colorWithHexString:@"#26bdab"];
      image = [UIImage imageNamed:@"finish_planing"];
        image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(30, 50, 10,50) resizingMode:UIImageResizingModeTile];
    }
    
   
    
    //
    
  
    
    [_baseImageView setImage:image];
    }
//
//    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_lable.mas_top).offset(-15);
//        make.left.mas_equalTo(_lable.mas_left).offset(-10);
//        make.right.mas_equalTo(_lable.mas_right).offset(10);
//        make.bottom.mas_equalTo(_lable.mas_bottom).offset(15);
//    }];
    
    [_baseImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_lable.mas_top).offset(-15);
                make.left.mas_equalTo(_lable.mas_left).offset(-20);
                make.right.mas_equalTo(_lable.mas_right).offset(10);
                make.bottom.mas_equalTo(_lable.mas_bottom).offset(15);

    }];
    [_cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_lable.mas_top).offset(-15);
        make.centerY.mas_equalTo(_baseImageView.mas_top).offset(23);
        make.right.mas_equalTo(_baseImageView.mas_left).offset(-10);
        //make.right.mas_equalTo(_lable.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(12, 12));
        
    }];
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top);
        make.centerX.mas_equalTo(_cycleView.mas_centerX);
        //make.right.mas_equalTo(_baseImageView.mas_left).offset(-10);
        make.bottom.mas_equalTo(_cycleView.mas_top).offset(-2);
        //make.right.mas_equalTo(_lable.mas_right).offset(10);
        make.width.mas_equalTo(2);
        
    }];
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_cycleView.mas_bottom).offset(2);
        make.centerX.mas_equalTo(_cycleView.mas_centerX);
        //make.right.mas_equalTo(_baseImageView.mas_left).offset(-10);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        //make.right.mas_equalTo(_lable.mas_right).offset(10);
        make.width.mas_equalTo(2);
        
    }];
    

    
    
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
