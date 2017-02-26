//
//  UGNewPageConTableViewCell.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/19.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGNewPageConTableViewCell.h"
#import "UGCoustantListView.h"
#import "Masonry.h"
#import "SKTagView.h"
@interface UGNewPageConTableViewCell()
@property (copy,nonatomic) UIImageView * mianPhotoImage;
@property (copy,nonatomic) UILabel * nameLable;
@property (strong,nonatomic) UILabel * sloganlable;
@property (strong,nonatomic) UILabel * countylable;
@property (strong,nonatomic) UIImageView * countyTag;
@property (strong,nonatomic) UILabel * certifybutton;
@property (strong,nonatomic) UILabel * severLable;
@property (strong,nonatomic) UIView * view;
@property (strong,nonatomic) UILabel * universityLable;
@property (strong,nonatomic) NSArray * serviceTypeArray;
@property (strong,nonatomic) NSArray * tagArray;
@property (nonatomic,strong) SKTagView *tagView;



@end
@implementation UGNewPageConTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self initUI];
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    
    return self;
}
-(NSArray *)tagArray{
    if (_tagArray == nil) {
        _tagArray = [NSArray array];
        
    }
    return _tagArray;
    
    
}
-(NSArray *)serviceTypeArray{
    if (_serviceTypeArray == nil) {
        _serviceTypeArray = [NSArray array];
    }
    
    return _serviceTypeArray;
    
    
    
}
-(void)setListModel:(CounselorListModel *)ListModel{
    //self initUI];
    
    _ListModel = ListModel;
    _nameLable.text = _ListModel.enName;
    CGSize size = [ _ListModel.enName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nameLable.font,NSFontAttributeName, nil]];
    
    [_nameLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mianPhotoImage.mas_bottom).offset(5);
        make.left.mas_equalTo(_view.mas_left).offset(8);
        make.size.mas_equalTo(CGSizeMake(size.width+ 10, 19));
    }];
    _sloganlable.text = _ListModel.slogan;
   
    CGRect rect = [_sloganlable.text boundingRectWithSize:CGSizeMake(kScreenWidth -30, 999)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}  context:nil];
    
    NSLog(@"rect.size.height======%f",rect.size.height);
   // CGSize sloganSize = [_sloganlable.text boundingRectWithSize:CGSizeMake(320, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil];
    
   //CGSize sizewde = [_sloganlable boundingRectWithSize:CGSizeMake(320, 0)];
    //CGSize sloganSize =  boundingRectWit
    //    CGSize sloganSize = [_sloganlable.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_sloganlable.font,NSFontAttributeName, nil]];
    //NSLog(@"sloganSize.height=========%f",sloganSize.height);
    [_sloganlable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLable.mas_bottom).offset(26);
        make.left.mas_equalTo(_nameLable.mas_left);
        make.right.mas_equalTo(_view.mas_right).offset(-10);
        make.height.mas_equalTo(rect.size.height +10);
        ///make.bottom.mas_equalTo(CGSizeMake(size.width+ 10, 19));
    }];

    
    _countylable.text = _ListModel.habitualResidence;
    _universityLable.text = _ListModel.school;
    self.tagArray = _ListModel.tagArray;
    self.serviceTypeArray = _ListModel.serviceTypeArray;
    
   // NSString * str = [NSString stringWithFormat:@"%@%@",UG_HOST1,_ListModel.userIcon];
   // NSLog(@"str=====%@",str);
    
    NSString *headImgStr= ListModel.userIcon;
    
    if ([headImgStr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [_mianPhotoImage sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"new_page_card_pls"] ];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,headImgStr];
        
        [_mianPhotoImage  sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"new_page_card_pls"]  ];
    }
    

    
    
    //[_mianPhotoImage sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"mengcong"]];
    //_mianPhotoImage.image = [UIImage imageNamed:@"mengcong"];
    //[self setTagUI];
    //[self setServrUI];
    
    NSArray * array1 = self.serviceTypeArray;

    for (NSInteger i = 998; i<1001; i++) {
        UILabel * lable = (UILabel* )[self.contentView viewWithTag:i];
       lable.hidden = YES;
        if (array1.count==3) {
            lable.text = array1[i -998];
            lable.hidden = NO;
        }else if (array1.count==2){
            if (i<1000) {
                lable.text = array1[i -998];
                lable.hidden = NO;
            }
        }else if (array1.count==1){
            if (i==998) {
                lable.text = array1[i -998];
                lable.hidden = NO;
            }
        }
               
    }
    for (NSInteger i = 13; i<18; i++) {
        UILabel * lable = (UILabel* )[self.contentView viewWithTag:i];
        [lable removeFromSuperview];
        
        
    }

   
     [self setTagUI];
    
    [self layoutIfNeeded];
    self.totleHight = _sloganlable.origin.y +_sloganlable.size.height +50;
}

-(void)initUI{
    
    
    _view = [[UIView alloc]init];
    _view.backgroundColor = [UIColor whiteColor];
    _view.layer.cornerRadius = 10;
    _view.layer.borderColor = [[UIColor colorWithHexString:@"#eeeeee"] CGColor];
    _view.layer.borderWidth = 0.5f;
    _view.layer.shadowColor = RGB(176, 175, 175).CGColor;
    _view.layer.shadowOffset = CGSizeMake(0, 1.5);
    _view.layer.shadowOpacity = 0.5;
    _view.layer.shadowRadius = 3;
    _view.clipsToBounds = NO;
    [self.contentView addSubview: _view];
    
    _mianPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, (kScreenWidth -20)* 0.56)];
    
    
    
    
    //
   
    
    
    
    //_mianPhotoImage.image = [UIImage imageNamed:@"new_page_card_pls"];
    // _mianPhotoImage.backgroundColor = [UIColor redColor];
    [_view  addSubview:_mianPhotoImage];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_mianPhotoImage.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _mianPhotoImage.bounds;
    maskLayer.path = maskPath.CGPath;
    _mianPhotoImage.layer.mask = maskLayer;
    _mianPhotoImage.layer.masksToBounds = YES;
    _mianPhotoImage.userInteractionEnabled = YES;
    _mianPhotoImage.contentMode = UIViewContentModeScaleAspectFill;
    //国家标签
    _countyTag = [[UIImageView alloc]init];
    
    _countyTag.image = [UIImage imageNamed:@"loca_newhome"];
    
    
    [_view  addSubview:_countyTag];
    
    //国家
    _countylable = [[UILabel alloc]init];
    _countylable.text = @"小猪快跑";
    _countylable.font = [UIFont systemFontOfSize:13];
    _countylable.textColor = [UIColor whiteColor];
    [_view addSubview:_countylable];
    //姓名
    _nameLable = [[UILabel alloc]init];
    _nameLable.text = @"猪猪侠";
    //_nameLable.font = [UIFont systemFontOfSize:17];
    [_nameLable setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    _nameLable.textColor = [UIColor colorWithHexString:@"#343434"];
    [_view addSubview:_nameLable];
    //口号
    _sloganlable = [[UILabel alloc]init];
    _sloganlable.text = @"程度才上课 第很合适是上啦 v 好客户";
    _sloganlable.numberOfLines = 0;
    _sloganlable.font = [UIFont systemFontOfSize:14];
    _sloganlable.textColor = [UIColor colorWithHexString:@"#999999"];
    [_view addSubview:_sloganlable];
    _universityLable = [[UILabel alloc]init];
    
    _universityLable.text = @"家里蹲国际大学";
    _universityLable.highlightedTextColor = [UIColor colorWithHexString:@"#5e5e5e"] ;
    _universityLable.font = [UIFont systemFontOfSize:12];
    //_universityLable.textColor = [UIColor colorWithHexString:@"#5e5e5e"];
    [_view addSubview:_universityLable];
    
    
    
    
    
    
    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(5);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-5);
        make.left.mas_equalTo(self.contentView.mas_left).offset(9);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-11);
    }];
    
    
    [_countyTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mianPhotoImage.mas_bottom).offset(-17);
        make.left.mas_equalTo(_mianPhotoImage.mas_left).offset(7);
        make.size.mas_equalTo(CGSizeMake(7,10));
    }];
    [_countylable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_countyTag.mas_top).offset(-3);
        make.left.mas_equalTo(_countyTag.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 16));
    }];
    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mianPhotoImage.mas_bottom).offset(5);
        make.left.mas_equalTo(_view.mas_left).offset(8);
        make.size.mas_equalTo(CGSizeMake(60, 19));
    }];
    [_universityLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLable.mas_bottom).offset(7);
        make.left.mas_equalTo(_nameLable.mas_left);
        make.size.mas_equalTo(CGSizeMake(300, 14));
    }];
    
    
//    [_sloganlable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(_nameLable.mas_bottom).offset(26);
//        make.left.mas_equalTo(_nameLable.mas_left);
//        make.right.mas_equalTo(_view.mas_right).offset(-10);
//        make.height.mas_equalTo(16);
//        
//    }];
    
    
    
    
//   [self setTagUI];
  [self setServrUI];
    
    
    
    
}


-(void)setTagUI{
    
    
    //认证标志
    //_certifybutton =
   
    NSArray * array2 = _ListModel.tagArray  ;
    [self.tagView removeAllTags];
    self.tagView = [[SKTagView alloc] init];
    // 整个tagView对应其SuperView的上左下右距离
    //self.tagView.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    // 上下行之间的距离
    self.tagView.lineSpacing = 10;
    self.tagView.clipsToBounds = YES;
    // item之间的距离
    self.tagView.interitemSpacing = 5;
    // 最大宽度
    self.tagView.preferredMaxLayoutWidth = 200;
    // 开始加载
    [array2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 初始化标签
        SKTag *tag = [[SKTag alloc] initWithText:array2[idx]];
        // 标签相对于自己容器的上左下右的距离
        tag.padding = UIEdgeInsetsMake(1, 4, 2, 4);
        // 弧度
        tag.cornerRadius = 8.0f;
        // 字体
        //tag.font = [UIFont boldSystemFontOfSize:10];
        tag.font = [UIFont fontWithName:@"Helvetica" size:10];
        // 边框宽度
        tag.borderWidth = 0.5f;
        // 背景
        //tag.bgColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
        tag.bgColor = [UIColor clearColor];
        // 边框颜色
        //tag.borderColor = [UIColor colorWithRed:191/255.0 green:191/255.0 blue:191/255.0 alpha:1];
        tag.borderColor = [UIColor colorWithHexString:@"#26bdab"];
        // 字体颜色
        //tag.textColor = [UIColor colorWithRed:53/255.0 green:53/255.0 blue:53/255.0 alpha:1];
        tag.textColor = [UIColor colorWithHexString:@"#26bdab"];
        // 是否可点击
        tag.enable = YES;
        // 加入到tagView
        [self.tagView addTag:tag];
    }];

    //self.tagView.frame = CGRectMake(0, 56+69, kScreenWidth, tagHeight);
    [self.tagView layoutSubviews];
    [_view addSubview:self.tagView];
    
    [self.tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_sloganlable.mas_bottom).offset(10);
        make.left.mas_equalTo(_view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - 50, 16));
    }];

    
    
    
    
    
//    for (int i = 0; i< array2.count; i++) {
//     _certifybutton = [[UILabel alloc]init];
//        //btn1.frame = CGRectMake(100, 100, 100, 100);
//        
//        _certifybutton.layer.borderColor = [[UIColor  colorWithHexString:@"#26bdab"] CGColor];
//        _certifybutton.layer.borderWidth = 1.0f;
//        _certifybutton.layer.cornerRadius = 6;
//        _certifybutton.tag = 13 + i;
//        _certifybutton.clipsToBounds = YES;
//        _certifybutton.font = [UIFont systemFontOfSize:10];
//        _certifybutton.textAlignment = NSTextAlignmentCenter;
//        //certifybutton.backgroundColor = [UIColor clearColor];
//        _certifybutton.text = array2[i];
//        CGSize size = [ array2[i] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_certifybutton.font,NSFontAttributeName, nil]];
//        //certifybutton.frame = CGRectMake(12 + i*70, , size.width +20, 12);
//        
//        [_certifybutton setTextColor:[UIColor  colorWithHexString:@"#26bdab"]];
//        //[_certifybutton setTintColor:[UIColor redColor]];
//        [_view addSubview:_certifybutton];
//        [_certifybutton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(_view.mas_bottom).offset(-15);
//            make.left.mas_equalTo(12 + i*70);
//            make.size.mas_equalTo(CGSizeMake(size.width +20, 12));
//        }];
//        
//    }
    
}
-(void)setServrUI{
    NSArray * array1 = @[@"美高服务",@"美本服务",@"美研服务"];
    //服务
    for (int i = 0; i<array1.count ; i++) {
        
        UILabel * severLable = [[UILabel alloc]init];
        //btn1.frame = CGRectMake(100, 100, 100, 100);
        
        severLable.layer.borderColor = [[UIColor  colorWithHexString:@"#999999"] CGColor];
        severLable.tag = 998+ i;
        severLable.layer.borderWidth = 1.0f;
        severLable.layer.cornerRadius = 6;
        severLable.clipsToBounds = YES;
        severLable.font = [UIFont systemFontOfSize:10];
        severLable.textAlignment = NSTextAlignmentCenter;
        severLable.backgroundColor = [UIColor  colorWithHexString:@"#999999"];
        severLable.text =array1[i];
        //        CGSize size = [ self.serviceTypeArray[0] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:severLable.font,NSFontAttributeName, nil]];
        severLable.frame = CGRectMake(kScreenWidth - 50  -(50+10 )* i - 11-12, _mianPhotoImage.bottom +10 , 50, 12);
       // severLable.frame = CGRectMake( 100 + 50 *i,  _mianPhotoImage.bottom +10, 50, 12);
        [severLable setTextColor:[UIColor whiteColor]];
        //[_certifybutton setTintColor:[UIColor redColor]];
        [_view addSubview:severLable];
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
