//
//  UGLIveTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGLIveTableViewCell.h"

@implementation UGLIveTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.contentView.backgroundColor =[UIColor colorWithHexString:@"#f7f7f7"];
    [self initUI];
    return self;
}
-(void)initUI{
    
    UIImageView * imageview = [[UIImageView alloc]init];
    
    imageview.backgroundColor = [UIColor redColor];
    imageview.frame = CGRectMake(0, 0, 50, 50);
    [self.contentView addSubview:imageview];
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
