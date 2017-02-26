//
//  UGClientCell.m
//  UrgooApp
//
//  Created by LuoYiJia on 16/3/7.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGClientCell.h"
#import "UGClientCellView.h"

@interface UGClientCell ()

//@property(strong,nonatomic) UIButton *connectionBtn;//我的关注--在Client页面不显示，在我的->我的关注页面显示，可以删除


@property(strong,nonatomic)UIView *backView;
@property(strong,nonatomic)UILabel *gradeLabel;//年级   Grade 10
@property(strong,nonatomic)UIImageView *locationImageView; //地理位置图片
@property(strong,nonatomic)UILabel *locationLabel; //地理位置
@property(strong,nonatomic)UIImageView *iconImageView; //头像
@property(strong,nonatomic)UIImageView *parentImageView; //parent
@property(strong,nonatomic)UILabel *nameLabel;//Cindy
@property(strong,nonatomic)UILabel *schoolLabel; //School :Shanghai Foreign Laungthe School
@property(strong,nonatomic)UILabel *messageLabel; //Hi,This is Jack's mum

@end




@implementation UGClientCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)clientTableViewCellWithTableView:(UITableView *)tableView
{
    UGClientCell *cell = [tableView dequeueReusableCellWithIdentifier:ugclientcellStr];
    if (!cell) {
        cell = [[UGClientCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ugclientcellStr];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return cell;
}


//120
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor =[UIColor colorWithHexString:@"f7f7f7"];
        
//        if (_hasConnection) {
//            //返回
//            _connectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            _connectionBtn.frame = CGRectMake(kScreenWidth-30 ,15 ,20 ,20);
//            [_connectionBtn setImage:[[UIImage imageNamed:@"Connections_edit_icon_delete@3x"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
//            [_connectionBtn addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
//            [self.contentView addSubview:_connectionBtn];
//        }
        
        
//        _backView =[[UIView alloc]initWithFrame:CGRectMake(10, 5, kScreenWidth-20, 110)];

        
        _backView =[[UIView alloc]initWithFrame:CGRectMake(3, 2, kScreenWidth-6, 116)];
        
//        _backView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];

        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 5;
        
        
        [self.contentView addSubview:_backView];
        
        //年级   Grade 10
        _gradeLabel =[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 80, 20)];
        _gradeLabel.textAlignment = NSTextAlignmentCenter;
        _gradeLabel.text = @"Grade 10";
        _gradeLabel.font = [UIFont systemFontOfSize:13];
        _gradeLabel.textColor =RGB(37, 175, 153);
        [_backView addSubview:_gradeLabel];
        
        
        //地理位置图片
        _locationImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(_gradeLabel.x+_gradeLabel.width+5, _gradeLabel.y+5, 8, 10)];
        _locationImageView.image = [UIImage imageNamed:@"tabbar_list_icon_coordinate"];
        [_backView addSubview:_locationImageView];
        
        
        //地理位置
        _locationLabel =[[UILabel alloc]initWithFrame:CGRectMake(_gradeLabel.x+_gradeLabel.width+20, 5, 80, 20)];
        _locationLabel.textAlignment = NSTextAlignmentLeft;
        _locationLabel.text = @"ShangHai";
        _locationLabel.font = [UIFont systemFontOfSize:13];
        _locationLabel.textColor =RGB(37, 175, 153);
        [_backView addSubview:_locationLabel];
        
        
        
        //画虚线
        [self drawPicWithView:_backView];
        
        
        
        
        
        
        //头像
        self.iconImageView  = [[UIImageView alloc]initWithFrame:CGRectMake(10, _locationLabel.y+_locationLabel.height+10, 60, 60)];
        self.iconImageView.layer.masksToBounds  = YES;
        self.iconImageView.layer.cornerRadius = 30;
        self.iconImageView.image = [UIImage imageNamed:@"me_header_bg"];
        [_backView addSubview:self.iconImageView];
        
        
        //parent
        self.parentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.iconImageView.x+16, self.iconImageView.y+self.iconImageView.height-5, 28, 10)];
        self.parentImageView.image = [UIImage  imageNamed:@"message_tag_parent"];
        [_backView addSubview:self.parentImageView];
        
        
        //name Cindy
        _nameLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.parentImageView.x+self.parentImageView.width+30, self.iconImageView.y, 150, 20)];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.text = @"Cindy";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithHexString:@"424242"];
        [_backView addSubview:_nameLabel];
        
        ////School :Shanghai Foreign Laungthe School
        _schoolLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.parentImageView.x+self.parentImageView.width+30, self.nameLabel.y+self.nameLabel.height+5, _backView.width-(self.parentImageView.x+self.parentImageView.width+30), 20)];
        _schoolLabel.textAlignment = NSTextAlignmentLeft;
        _schoolLabel.text = @"School:Shanghai Foreign Laungthe School";
        _schoolLabel.font = [UIFont systemFontOfSize:13];
        _schoolLabel.textColor = [UIColor colorWithHexString:@"424242"];
        [_backView addSubview:_schoolLabel];

        
        
        NSArray *titleArr = @[@"TOEFL",@"SAT",@"AP"];
        for (NSInteger i = 0; i<titleArr.count; i++) {
            UGClientCellView *view = [[UGClientCellView alloc]initWithFrame:CGRectMake(self.parentImageView.x+self.parentImageView.width+30+(60*i), self.schoolLabel.y+self.schoolLabel.height+5, 60, 20) withTitle:titleArr[i]];
            [_backView addSubview:view];
        }
        
    }
    return self;
}

//划虚线  ............
-(void)drawPicWithView:(UIView *)drawView
{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    [shapeLayer setStrokeColor:[[UIColor colorWithHexString:@"d4d4d4"] CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:2],
      [NSNumber numberWithInt:2],nil]];
    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0,_locationLabel.y+_locationLabel.height+3);
    CGPathAddLineToPoint(path, NULL, drawView.width,_locationLabel.y+_locationLabel.height+3);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    [[drawView layer] addSublayer:shapeLayer];
    
}

////有两种情况，可能有删除按钮，也可能没有删除按钮，有没有是根据传入得bool值是不是来自Connection的，如果有的话，传出一个响应事件
//-(void)deleteAction
//{
//    if (_hasConnection) {
//        _deleteBlock();
//    }
//}




//UITableViewCell delete button 上有其它覆盖层
//http://blog.csdn.net/meegomeego/article/details/16961547
//第三种可以
- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.isEditing) {
        [self sendSubviewToBack:self.contentView];
    }
    
}
@end
