//
//  UGCoustantListView.m
//  UrgooApp
//
//  Created by UrgooDev on 16/7/8.
//  Copyright © 2016年 Urgoo. All rights reserved.
//

#import "UGCoustantListView.h"
#import "Masonry.h"
#import "SKTagView.h"

@interface UGCoustantListView()

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

@implementation UGCoustantListView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    [self initUI];
    self.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
    

    
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
    _ListModel = ListModel;
    _nameLable.text = _ListModel.enName;
     CGSize size = [ _ListModel.enName sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:_nameLable.font,NSFontAttributeName, nil]];
    
    [_nameLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mianPhotoImage.mas_bottom).offset(5);
        make.left.mas_equalTo(_view.mas_left).offset(8);
        make.size.mas_equalTo(CGSizeMake(size.width+ 10, 19));
    }];
    _sloganlable.text = _ListModel.slogan;
   // _countylable.text = _ListModel.habitualResidence;
    
    
    CGRect rect = [_sloganlable.text boundingRectWithSize:CGSizeMake(kScreenWidth -30, 999)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}  context:nil];
    NSLog(@"%f",rect.size.height);
   // CGFloat  sloganhight = rect.size.height;
    [_sloganlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_nameLable.mas_bottom).offset(26);
        make.left.mas_equalTo(_nameLable.mas_left);
        make.right.mas_equalTo(_view.mas_right).offset(-10);
        make.height.mas_equalTo(rect.size.height +10);
        
        
               //
    }];
    //_sloganlable.frame = CGRectMake(10, _nameLable.origin.y +_nameLable.size.height +26,kScreenWidth - 10 , rect.size.height);
    _countylable.text = _ListModel.habitualResidence;
    _universityLable.text = _ListModel.school;
    self.tagArray = _ListModel.tagArray;
    self.serviceTypeArray = _ListModel.serviceTypeArray;
    NSString *headImgStr= _ListModel.userIcon;
    
    if ([headImgStr containsString:@"qingdao"]) {
        NSLog(@"str 包含 qingdao");
        [_mianPhotoImage sd_setImageWithURL:[NSURL URLWithString:headImgStr] placeholderImage:[UIImage imageNamed:@"new_page_card_pls"] ];
    } else {
        NSLog(@"str 不存在 qingdao");
        NSString * imageUrl = [NSString stringWithFormat:@"%@%@",UG_HOST1,headImgStr];
        
        [_mianPhotoImage  sd_setImageWithURL:[NSURL URLWithString:imageUrl ] placeholderImage:[UIImage imageNamed:@"new_page_card_pls"]  ];
    }
    
    
    
    
    
    [self setTagUI];
    [self setServrUI];
    
    [self layoutIfNeeded];
    _viewhight = _sloganlable.origin.y +_sloganlable.size.height +50;
    NSLog(@"%d",_viewhight);
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
    UITapGestureRecognizer * contactRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(click_consult)];
    
    [_view addGestureRecognizer:contactRecognizer];

    [self addSubview: _view];

    _mianPhotoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth - 20, (kScreenWidth - 20) *0.55)];
    

   
  
//
   _mianPhotoImage.image = [UIImage imageNamed:@"mengcong"];
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
        make.top.mas_equalTo(self.mas_top).offset(5);
        make.left.mas_equalTo(self.mas_left).offset(9);
        make.right.mas_equalTo(self.mas_right).offset(-11);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
    }];
   
//    
//    [_view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.mas_top).offset(5);
//        make.bottom.mas_equalTo(self.mas_bottom).offset(-5);
//        make.left.mas_equalTo(self.mas_left).offset(9);
//        make.right.mas_equalTo(self.mas_right).offset(-11);
//    }];

   
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


   
    
    

    
    
    
    
}
-(void)setTagUI{
    
    
    //认证标志
   NSArray * array2 = self.tagArray ;
    
    
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
    

//    for (int i = 0; i< self.tagArray.count; i++) {
//        UILabel *  certifybutton = [[UILabel alloc]init];
//        //btn1.frame = CGRectMake(100, 100, 100, 100);
//        
//        certifybutton.layer.borderColor = [[UIColor  colorWithHexString:@"#26bdab"] CGColor];
//        certifybutton.layer.borderWidth = 1.0f;
//        certifybutton.layer.cornerRadius = 6;
//        certifybutton.clipsToBounds = YES;
//        certifybutton.font = [UIFont systemFontOfSize:10];
//        certifybutton.textAlignment = NSTextAlignmentCenter;
//        certifybutton.backgroundColor = [UIColor clearColor];
//        certifybutton.text = self.tagArray[0];
//        CGSize size = [ self.tagArray[0] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:certifybutton.font,NSFontAttributeName, nil]];
//        certifybutton.frame = CGRectMake(12 + i*70, _viewhight - 40, size.width +20, 12);
//        [certifybutton setTextColor:[UIColor  colorWithHexString:@"#26bdab"]];
//        //[_certifybutton setTintColor:[UIColor redColor]];
//        [_view addSubview:certifybutton];
//        
//    }

}
-(void)setServrUI{
    
    //服务
    for (int i = 0; i<self.serviceTypeArray.count ; i++) {
        
        UILabel * severLable = [[UILabel alloc]init];
        //btn1.frame = CGRectMake(100, 100, 100, 100);
        
        severLable.layer.borderColor = [[UIColor  colorWithHexString:@"#999999"] CGColor];
        severLable.layer.borderWidth = 1.0f;
        severLable.layer.cornerRadius = 6;
        severLable.clipsToBounds = YES;
        severLable.font = [UIFont systemFontOfSize:10];
        severLable.textAlignment = NSTextAlignmentCenter;
        severLable.backgroundColor = [UIColor  colorWithHexString:@"#999999"];
        severLable.text =self.serviceTypeArray[i];
//        CGSize size = [ self.serviceTypeArray[0] sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:severLable.font,NSFontAttributeName, nil]];
        severLable.frame = CGRectMake(kScreenWidth - 50  -(50+10 )* i - 11-12, _mianPhotoImage.bottom + 10, 50, 12);
        [severLable setTextColor:[UIColor whiteColor]];
        //[_certifybutton setTintColor:[UIColor redColor]];
        [_view addSubview:severLable];
    }

    
    
}
-(void)click_consult{
    NSString * counselorId = self.ListModel.counselorId;
    
    _CoustantBlock(counselorId);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
